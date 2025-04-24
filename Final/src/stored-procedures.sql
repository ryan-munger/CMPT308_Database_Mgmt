-- Items in a user's inventory
CREATE OR REPLACE FUNCTION get_user_items (steam_id INT)
RETURNS TABLE (
    ItemName TEXT,
    FloatVal DOUBLE PRECISION,
	Wear TEXT,
    IsStatTrak BOOLEAN,
    IsSouvenir BOOLEAN,
    GivenName  TEXT
) AS 
$$
BEGIN
    RETURN QUERY
    SELECT
        si.ItemName,
		si.Float,
        si.Wear,
        si.IsStatTrak,
        si.IsSouvenir,
		si.GivenName
    FROM Inventories i
        INNER JOIN SkinItems si ON i.SkinItemID = si.SkinItemID
    WHERE i.SteamID = steam_id
    ORDER BY si.ItemName;
END;
$$ 
LANGUAGE plpgsql;

SELECT * FROM get_user_items(803); 


-- Case opening stats - shows most common weapons and wear ratings for a specific case
CREATE OR REPLACE FUNCTION case_opening_stats(case_name TEXT)
RETURNS TABLE (
    weapon_name TEXT,
    skin_name TEXT,
    wear_condition TEXT,
    drop_count BIGINT,
    drop_percentage NUMERIC(5,2)
) AS 
$$
DECLARE
    total_drops BIGINT;
BEGIN
    -- get num of drops from case
    SELECT COUNT(*) INTO total_drops
    FROM Cases c
    	INNER JOIN SkinItems s ON c.CaseID = s.CaseID
    WHERE c.CaseName = case_name;
    
    -- get stats
    RETURN QUERY
    SELECT 
        w.WeaponName,
        s.ItemName,
        s.Wear,
        COUNT(*) AS drop_count,
        ROUND((COUNT(*) * 100.0 / total_drops), 2) AS drop_percentage
    FROM Cases c
    	INNER JOIN SkinItems s ON c.CaseID = s.CaseID
    	INNER JOIN Weapons w ON s.ItemID = w.ItemID
    WHERE c.CaseName = case_name
    GROUP BY w.WeaponName, s.ItemName, s.Wear
    ORDER BY drop_count DESC;
END;
$$ 
LANGUAGE plpgsql;

SELECT * FROM case_opening_stats('Breakout Case');


-- Souvenir items for a major by name
CREATE OR REPLACE FUNCTION souvenir_items_by_major(major_name_param TEXT)
RETURNS TABLE (
    major_name TEXT,
    major_location TEXT,
    match_description TEXT,
    weapon_name TEXT,
    skin_name TEXT,
    wear_condition TEXT,
    float_value DOUBLE PRECISION,
    owner_name TEXT,
    last_sold_price DOUBLE PRECISION,
    estimated_value DOUBLE PRECISION
) AS 
$$
DECLARE
    major_id_var INT;
BEGIN
    -- get the major id
    SELECT MajorID INTO major_id_var
    FROM Majors
    WHERE MajorName = major_name_param;
    
    -- get souvenir items, their owners, price history, etc
    RETURN QUERY
    SELECT 
        m.MajorName,
        m.Location,
        match.HomeTeam || ' vs ' || match.AwayTeam AS match_description,
        w.WeaponName,
        si.ItemName,
        si.Wear,
        si.Float,
        COALESCE(u.UserName, 'Unknown') AS owner_name,
        MAX(mt.PriceUSD) AS last_sold_price,
        COALESCE(AVG(mt.PriceUSD), 0) AS estimated_value
    FROM Majors m
    	INNER JOIN Matches match ON m.MajorID = match.MajorID
    	INNER JOIN SkinItems si ON match.MatchID = si.MatchID AND si.IsSouvenir = TRUE
    	INNER JOIN Weapons w ON si.ItemID = w.ItemID
    	LEFT JOIN Inventories inv ON si.SkinItemID = inv.SkinItemID
    	LEFT JOIN SteamUsers u ON inv.SteamID = u.SteamID
    	LEFT JOIN MarketTransactions mt ON si.SkinItemID = mt.ItemID
    WHERE m.MajorID = major_id_var
    GROUP BY 
        m.MajorName, m.Location, match_description, w.WeaponName, 
        si.ItemName, si.Wear, si.Float, owner_name
    ORDER BY estimated_value DESC;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM souvenir_items_by_major('EMS One Katowice 2014');


-- Get all market transactions for a skin with a specific wear
CREATE OR REPLACE FUNCTION get_market_transactions(
 	item_name_param TEXT,
    wear_param TEXT
)
RETURNS TABLE (
	ItemName TEXT,
	Wear TEXT,
    TransID INT,
    PriceUSD DOUBLE PRECISION,
    SoldAtDate DATE
) AS 
$$
BEGIN
    RETURN QUERY
    SELECT
		item_name_param AS ItemName,
		wear_param AS Wear,
        mt.TransID,
        mt.PriceUSD,
        DATE_TRUNC('day', mt.SoldAt)::DATE
    FROM
        MarketTransactions mt
    INNER JOIN
        SkinItems si ON mt.ItemID = si.SkinItemID
    WHERE
        si.ItemName = item_name_param
        AND si.Wear = wear_param
    ORDER BY DATE_TRUNC('day', mt.SoldAt)::DATE DESC
    LIMIT 20;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM get_market_transactions('AK-47 | Redline', 'Field-Tested');


-- User Inventory Value - returns market value of user's inventory
-- Hard to do properly without a ton of market history for different items, wears, etc

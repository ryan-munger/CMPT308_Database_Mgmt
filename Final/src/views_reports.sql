-- Useful views for CS database
DROP VIEW IF EXISTS popular_skins;
DROP VIEW IF EXISTS top_market_users;
DROP VIEW IF EXISTS common_sticker_skin_combos;
DROP VIEW IF EXISTS avg_stattrak_kills_by_weapon;

-- Popular skins by market volume
CREATE VIEW popular_skins AS
SELECT 
    s.SkinItemID,
    s.ItemName,
    w.WeaponName,
    s.Wear,
    COUNT(mt.TransID) AS transaction_count,
    AVG(mt.PriceUSD) AS average_price,
    SUM(mt.PriceUSD) AS total_volume
FROM SkinItems s
    INNER JOIN Weapons w ON s.ItemID = w.ItemID
    INNER JOIN MarketTransactions mt ON s.SkinItemID = mt.ItemID
GROUP BY s.SkinItemID, s.ItemName, w.WeaponName, s.Wear
ORDER BY transaction_count DESC;

SELECT * FROM popular_skins;

-- Top sellers and buyers
CREATE VIEW top_market_users AS
SELECT 
    'Seller' AS UserType,
    s.SellerID AS UserID,
    u.UserName,
    s.TotalEarnedUSD AS TotalEarnedUSD,
    NULL AS TotalSpentUSD -- NULL col for buyers
FROM Sellers s
	INNER JOIN SteamUsers u ON s.SellerID = u.SteamID
UNION ALL
SELECT 
    'Buyer' AS UserType,
    b.BuyerID AS UserID,
    u.UserName,
    NULL AS TotalEarnedUSD, -- NULL for buyers
    b.TotalSpentUSD AS TotalSpentUSD
FROM Buyers b
	INNER JOIN SteamUsers u ON b.BuyerID = u.SteamID
LIMIT 10;

SELECT * FROM top_market_users;

-- Sticker combinations popularity
CREATE VIEW common_sticker_skin_combos AS
SELECT 
    s.StickerName,
    si.ItemName AS SkinName,
    COUNT(*) AS CombinationCount
FROM SkinItemStickers sis
	INNER JOIN Stickers s ON sis.StickerID = s.StickerID
	INNER JOIN SkinItems si ON sis.SkinItemID = si.SkinItemID
GROUP BY s.StickerName, si.ItemName
ORDER BY CombinationCount DESC
LIMIT 10;

SELECT * FROM common_sticker_skin_combos;


-- Average StatTrak weapon performance
CREATE VIEW avg_stattrak_kills_by_weapon AS
SELECT 
    w.WeaponName,
    AVG(s.Kills) AS AverageKills
FROM  Weapons w
    INNER JOIN  SkinItems s ON w.ItemID = s.ItemID
WHERE s.IsStatTrak = TRUE
GROUP BY w.WeaponName;

SELECT * FROM avg_stattrak_kills_by_weapon;


-- daily trans value -- credit: claude helped with the date truncation
CREATE VIEW daily_transactions AS
SELECT 
    DATE_TRUNC('day', mt.SoldAt)::DATE AS sale_date,
    COUNT(*) AS daily_trans,
    SUM(mt.PriceUSD) AS daily_vol,
    AVG(mt.PriceUSD) AS avg_price,
    MAX(mt.PriceUSD) AS highest_sale,
    COUNT(DISTINCT mt.BuyerID) AS unique_buyers,
    COUNT(DISTINCT mt.SellerID) AS unique_sellers
FROM MarketTransactions mt
WHERE mt.SoldAt >= CURRENT_DATE - INTERVAL '30 days' -- cool!!
GROUP BY DATE_TRUNC('day', mt.SoldAt)::DATE
ORDER BY sale_date DESC;

SELECT * FROM daily_transactions;


-- shows how many skins each weapon has avail for it
CREATE VIEW count_weapon_skins AS
SELECT 
    w.WeaponName,
    COUNT(si.SkinItemID) AS skin_count
FROM Weapons w
    INNER JOIN SkinItems si ON w.ItemID = si.ItemID
GROUP BY  w.WeaponName
ORDER BY skin_count DESC;

SELECT * FROM count_weapon_skins;


-- avg price per case item
CREATE VIEW avg_case_values AS
SELECT 
    c.CaseName,
    COUNT(si.SkinItemID) AS items_in_case,
    AVG(mt.PriceUSD) AS avg_price
FROM Cases c
	INNER JOIN SkinItems si ON c.CaseID = si.CaseID
	INNER JOIN MarketTransactions mt ON si.SkinItemID = mt.ItemID
GROUP BY c.CaseName
ORDER BY avg_price DESC;

SELECT * FROM avg_case_values;

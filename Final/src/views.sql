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
    s.TotalEarnedUSD AS TotalUSD,
    NULL AS TotalSpentUSD -- NULL col for buyers
FROM Sellers s
	INNER JOIN SteamUsers u ON s.SellerID = u.SteamID
UNION ALL
SELECT 
    'Buyer' AS UserType,
    b.BuyerID AS UserID,
    u.UserName,
    NULL AS TotalEarnedUSD, -- Add a NULL column for sellers
    b.TotalSpentUSD AS TotalUSD
FROM Buyers b
	INNER JOIN SteamUsers u ON b.BuyerID = u.SteamID
ORDER BY TotalUSD DESC
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

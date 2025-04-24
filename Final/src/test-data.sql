-- Credit: Google Gemini generated this data, and then it was fixed + improved by me.

INSERT INTO Operations (OperationID, OperationName, DateReleased, DateEnded) VALUES
(1, 'Operation Breakout', '2014-07-01', '2014-10-02'),
(2, 'Operation Vanguard', '2014-11-11', '2015-03-31'),
(3, 'Operation Bloodhound', '2015-05-26', '2015-09-30'),
(4, 'Operation Wildfire', '2016-02-17', '2016-07-15'),
(5, 'Operation Hydra', '2017-05-23', '2017-11-13'),
(6, 'Operation Shattered Web', '2019-11-18', '2020-03-31'),
(7, 'Operation Broken Fang', '2020-12-03', '2021-05-03'),
(8, 'Operation Riptide', '2021-09-21', '2022-02-22'),
(9, 'Operation Recoil', '2022-07-01', '2022-11-16'),
(10, 'Operation Anubis', '2023-04-25', '2023-10-02');

-- Cases table
INSERT INTO Cases (CaseID, CaseName, OperationID) VALUES
(101, 'Breakout Case', 1),
(102, 'Vanguard Case', 2),
(103, 'Bloodhound Case', 3),
(104, 'Wildfire Case', 4),
(105, 'Hydra Case', 5),
(106, 'Shattered Web Case', 6),
(107, 'Broken Fang Case', 7),
(108, 'Riptide Case', 8),
(109, 'Recoil Case', 9),
(110, 'Anubis Collection Package', 10),
(111, 'Operation Phoenix Weapon Case', NULL), -- some cases are not part of an operation
(112, 'Chroma Case', NULL),
(113, 'Shadow Case', NULL);

INSERT INTO Capsules (CapsuleID, CapsuleName, OperationID) VALUES
(201, 'Breakout Capsule', 1),
(202, 'Vanguard Capsule', 2),
(203, 'Bloodhound Capsule', 3),
(204, 'Wildfire Capsule', 4),
(205, 'Hydra Capsule', 5),
(206, 'Shattered Web Sticker Capsule', 6),
(207, 'Broken Fang Sticker Capsule', 7),
(208, 'Riptide Sticker Capsule', 8),
(209, 'Recoil Sticker Capsule', 9),
(210, 'Anubis Sticker Capsule', 10),
(211, 'Katowice 2014 Challengers', NULL), -- tied to majors, won't overcomplicate with FK here 
(212, 'Cologne 2014 Legends', NULL);

-- Stickers table
INSERT INTO Stickers (StickerID, StickerName, Rarity, Film, CapsuleID) VALUES
(301, 'IBP Holo', 'Extraordinary', 'Holo', 211),
(302, 'Titan Holo', 'Extraordinary', 'Holo', 211),
(303, 'Virtus.pro Foil', 'Remarkable', 'Foil', 212),
(304, 'NaVi Paper', 'Base Grade', 'Paper', 206),
(305, 'Astralis Gold', 'Exotic', 'Gold', 207),
(306, 'MOUZ Glitter', 'High Grade', 'Glitter', 208),
(307, '9INE Holo', 'Remarkable', 'Holo', 210),
(308, 'Complexity Gaming Paper', 'Medium Grade', 'Paper', 209),
(309, 'G2 Esports Foil', 'High Grade', 'Foil', 207),
(310, 'ENCE Holo', 'Remarkable', 'Holo', 208),
(311, 'FURIA Esports Gold', 'Exotic', 'Gold', 209),
(312, 'Spirit Paper', 'Base Grade', 'Paper', 210);

-- Majors table
INSERT INTO Majors (MajorID, MajorName, Location, StartDate, EndDate) VALUES
(401, 'EMS One Katowice 2014', 'Katowice, Poland', '2014-03-13', '2014-03-16'),
(402, 'ESL One Cologne 2014', 'Cologne, Germany', '2014-08-14', '2014-08-17'),
(403, 'DreamHack Winter 2014', 'Jönköping, Sweden', '2014-11-26', '2014-11-29'),
(404, 'IEM Katowice 2015', 'Katowice, Poland', '2015-03-12', '2015-03-15'),
(405, 'ESL One Cologne 2015', 'Cologne, Germany', '2015-08-20', '2015-08-23');

-- Matches table
INSERT INTO Matches (MatchID, MajorID, HomeTeam, AwayTeam, MatchDate, HomeScore, AwayScore) VALUES
(501, 401, 'Virtus.pro', 'Ninjas in Pyjamas', '2014-03-16 15:00:00+00', 2, 1),
(502, 402, 'Ninjas in Pyjamas', 'Fnatic', '2014-08-17 17:30:00+00', 0, 2),
(503, 403, 'LDLC', 'Ninjas in Pyjamas', '2014-11-29 19:00:00+00', 2, 1),
(504, 404, 'Fnatic', 'Ninjas in Pyjamas', '2015-03-15 16:45:00+00', 2, 0),
(505, 405, 'Fnatic', 'EnvyUs', '2015-08-23 18:15:00+00', 2, 0),
(506, 405, 'Astralis', 'G2 Esports', '2015-08-22 14:00:00+00', 1, 2);

-- Weapons table
INSERT INTO Weapons (ItemID, WeaponName, WeaponType, PriceInGame, FireRate, ArmorPen, AccRange, MagCapacity, ReserveAmmo, RunSpeed, ReloadSd) VALUES
(123, 'Compiler Tyrant', 'Shotgun', 9999, 10, 100, 100, 25, 50, 250, 2.3),
(601, 'AK-47', 'Rifle', 2700, 600, 80, 26, 30, 90, 215, 2.5),
(602, 'M4A4', 'Rifle', 3100, 667, 80, 27, 30, 90, 225, 3.1),
(603, 'AWP', 'Sniper', 4750, 41, 97.5, 69, 10, 20, 200, 3.6),
(604, 'Glock-18', 'Pistol', 200, 400, 0, 22, 20, 120, 245, 2.2),
(605, 'USP-S', 'Pistol', 200, 353, 20, 28, 12, 24, 230, 2.2),
(606, 'Desert Eagle', 'Pistol', 700, 267, 90, 16, 7, 35, 230, 2.2),
(607, 'MP9', 'SMG', 1250, 857, 57, 17, 30, 120, 235, 2.1),
(608, 'AWP', 'Sniper', 4750, 41, 97.5, 69, 10, 20, 200, 3.6), 
(609, 'M4A1-S', 'Rifle', 2900, 600, 80, 29, 20, 40, 225, 2.8),
(610, 'Gut Knife', 'Knife', 0, NULL, 100, 0, 1, 0, 250, 1.0),
(611, 'Sport Gloves', 'Gloves', 0, NULL, 0, 0, 1, 0, 250, 1.0);

INSERT INTO SkinItems (SkinItemID, CaseID, ItemID, ItemName, Wear, Float, Pattern, IsSouvenir, MatchID, IsStatTrak, Kills, IsNamed, GivenName) VALUES
(2112, 101, 123, 'Compiler Tyrant | Labouseur', 'Factory New', 0.01, 007, FALSE, NULL, TRUE, 900, TRUE, 'The Alanator'),
(701, 101, 601, 'AK-47 | Redline', 'Field-Tested', 0.28, 42, FALSE, NULL, FALSE, 0, FALSE, NULL),
(702, 101, 607, 'MP9 | Hypnotic', 'Minimal Wear', 0.11, 17, FALSE, NULL, TRUE, 15, FALSE, NULL),
(703, 111, 603, 'AWP | Lightning Strike', 'Factory New', 0.05, 88, FALSE, NULL, FALSE, 0, True, 'Zapatron'),
(704, 112, 602, 'M4A4 | Asiimov', 'Well-Worn', 0.41, 12, FALSE, NULL, TRUE, 55, TRUE, 'Orion'),
(705, 106, 605, 'USP-S | Kill Confirmed', 'Minimal Wear', 0.18, 5, FALSE, NULL, FALSE, 0, FALSE, NULL),
(706, 107, 609, 'M4A1-S | Printstream', 'Factory New', 0.03, 163, FALSE, NULL, FALSE, 0, FALSE, NULL),
(707, 108, 606, 'Desert Eagle | Ocean Drive', 'Field-Tested', 0.35, 22, FALSE, NULL, TRUE, 28, FALSE, NULL),
(708, 104, 610, 'Gut Knife | Doppler', 'Factory New', 0.01, 999, FALSE, NULL, FALSE, 0, FALSE, NULL),
(709, 105, 611, 'Hydra Gloves | Case Hardened', 'Minimal Wear', 0.14, NULL, FALSE, NULL, FALSE, 0, TRUE, 'Retirement'),
(710, 102, 601, 'AK-47 | Wasteland Rebel', 'Battle-Scarred', 0.78, 10, TRUE, 501, FALSE, 0, FALSE, NULL),
(711, 103, 603, 'AWP | Man-o-war', 'Minimal Wear', 0.15, 33, TRUE, 502, TRUE, 112, TRUE, 'Long Shot'),
(712, 104, 602, 'M4A4 | Griffin', 'Field-Tested', 0.31, 7, FALSE, NULL, FALSE, 0, FALSE, NULL),
(713, 105, 607, 'MP9 | Wild Lily', 'Factory New', 0.07, 2, FALSE, NULL, FALSE, 0, FALSE, NULL),
(714, 109, 605, 'USP-S | Cortex', 'Minimal Wear', 0.12, 18, FALSE, NULL, TRUE, 41, FALSE, NULL),
(715, 110, 609, 'M4A1-S | Welcome to the Jungle', 'Field-Tested', 0.25, 55, FALSE, NULL, FALSE, 0, FALSE, NULL);

INSERT INTO SkinItemStickers (StickerID, SkinItemID, Slot, ScrapeWear) VALUES
(301, 703, 0, 'Pristine'),
(302, 703, 1, 'Scratched'),
(304, 701, 0, 'Worn'),
(305, 704, 2, 'Pristine'),
(303, 711, 0, 'Pristine'),
(306, 702, 1, 'Scratched'),
(307, 715, 0, 'Pristine'),
(308, 712, 3, 'Worn'),
(309, 706, 0, 'Pristine'),
(310, 707, 2, 'Scratched'),
(311, 710, 1, 'Worn'),
(312, 714, 4, 'Pristine');

INSERT INTO SteamUsers (SteamID, UserName, CSHrsPlayed, CSLastPlayed, CSFirstPlayed, BalanceUSD) VALUES
(007, 'database_god', 2112, '2025-04-3', '2015-03-29', 99999999.00),
(801, 'gabenfan123', 5421.7, '2025-04-23', '2012-08-15', 125.50),
(802, 'counterstrike_pro', 12876.3, '2025-04-24', '2013-01-20', 55.20),
(803, 'skin_collector', 2345.9, '2025-04-22', '2016-05-01', 1003.85),
(804, 'noob_player', 150.2, '2025-04-20', '2024-11-10', 5.99),
(805, 'trader_joe', 876.5, '2025-04-23', '2019-03-01', 2500.00),
(806, 'major_fan', 3000.1, '2025-04-21', '2017-07-01', 78.90);

INSERT INTO Inventories (SteamID, SkinItemID, AcquiredAt) VALUES
(803, 706, '2025-03-22 19:00:00+00'),
(803, 707, '2025-04-05 13:20:00+00'),
(801, 714, '2025-04-15 21:00:00+00'),
(802, 715, '2025-04-20 16:45:00+00');

-- Friendships table
INSERT INTO Friendships (FriendA, FriendB, DateFriended) VALUES
(801, 802, '2018-06-01 11:30:00+00'),
(801, 803, '2020-01-10 15:45:00+00'),
(802, 803, '2021-05-22 09:00:00+00'),
(804, 801, '2024-12-25 18:00:00+00'),
(805, 803, '2022-08-01 14:00:00+00');

-- Buyers table
INSERT INTO Buyers (BuyerID, TotalSpentUSD) VALUES
(801, 350.75),
(803, 5200.10),
(804, 15.50),
(806, 112.99);

-- Sellers table
INSERT INTO Sellers (SellerID, TotalEarnedUSD) VALUES
(802, 1200.50),
(803, 4850.00),
(805, 2875.25);

-- MarketTransactions table
INSERT INTO MarketTransactions (TransID, ItemID, BuyerID, SellerID, PriceUSD, ListedAt, SoldAt) VALUES
(901, 701, 801, 802, 45.50, '2025-04-10 18:00:00+00', '2025-04-11 10:30:00+00'),
(902, 702, 801, 805, 120.00, '2025-04-12 09:15:00+00', '2025-04-12 16:45:00+00'),
(903, 704, 803, 802, 850.25, '2025-04-15 14:00:00+00', '2025-04-16 11:00:00+00'),
(904, 710, 803, 805, 675.00, '2025-04-18 20:30:00+00', '2025-04-19 09:00:00+00'),
(905, 705, 804, 802, 12.75, '2025-04-20 11:45:00+00', '2025-04-21 13:15:00+00'),
(906, 711, 803, 805, 1550.00, '2025-04-21 16:00:00+00', '2025-04-22 10:00:00+00'),
(907, 707, 806, 805, 65.99, '2025-04-22 19:30:00+00', '2025-04-23 08:45:00+00'),
(908, 703, 803, 802, 2100.00, '2025-04-23 10:00:00+00', NULL);

-- Test
SELECT * 
FROM Operations;

SELECT * 
FROM Cases;

SELECT * 
FROM Capsules;

SELECT * 
FROM Stickers;

SELECT * 
FROM Majors;

SELECT * 
FROM Matches;

SELECT * 
FROM Weapons;

SELECT * 
FROM SkinItems;

SELECT * 
FROM SkinItemStickers;

SELECT * 
FROM SteamUsers;

SELECT * 
FROM Inventories;

SELECT * 
FROM Friendships;

SELECT * 
FROM Buyers;

SELECT * 
FROM Sellers;

SELECT * 
FROM MarketTransactions;

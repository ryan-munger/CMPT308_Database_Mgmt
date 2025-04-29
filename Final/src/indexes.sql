-- Operations
CREATE INDEX idx_operations_date_released ON Operations(DateReleased);

-- Cases
CREATE INDEX idx_cases_operation_id ON Cases(OperationID);

-- Capsules
CREATE INDEX idx_capsules_operation_id ON Capsules(OperationID);

-- Stickers
CREATE INDEX idx_stickers_capsule_id ON Stickers(CapsuleID);
CREATE INDEX idx_stickers_rarity ON Stickers(Rarity);
CREATE INDEX idx_stickers_film ON Stickers(Film);

-- Majors
CREATE INDEX idx_majors_start_date ON Majors(StartDate);
CREATE INDEX idx_majors_end_date ON Majors(EndDate);

-- Matches
CREATE INDEX idx_matches_major_id ON Matches(MajorID);
CREATE INDEX idx_matches_match_date ON Matches(MatchDate);

-- Weapons
CREATE INDEX idx_weapons_weapon_type ON Weapons(WeaponType);

-- SkinItems
CREATE INDEX idx_skinitems_case_id ON SkinItems(CaseID);
CREATE INDEX idx_skinitems_item_id ON SkinItems(ItemID);
CREATE INDEX idx_skinitems_match_id ON SkinItems(MatchID);
CREATE INDEX idx_skinitems_float ON SkinItems(Float);
CREATE INDEX idx_skinitems_wear ON SkinItems(Wear);

-- SkinItemStickers
CREATE INDEX idx_skinitemstickers_skinitem_id ON SkinItemStickers(SkinItemID);
CREATE INDEX idx_skinitemstickers_slot ON SkinItemStickers(Slot);

-- Inventories
CREATE INDEX idx_inventories_steamid ON Inventories(SteamID);
CREATE INDEX idx_inventozries_acquiredat ON Inventories(AcquiredAt);

-- Friendships
CREATE INDEX idx_friendships_friendb ON Friendships(FriendB);
CREATE INDEX idx_friendships_datefriended ON Friendships(DateFriended);

-- Buyers & Sellers
CREATE INDEX idx_buyers_total_spent ON Buyers(TotalSpentUSD);
CREATE INDEX idx_sellers_total_earned ON Sellers(TotalEarnedUSD);

-- MarketTransactions
CREATE INDEX idx_markettransactions_buyerid ON MarketTransactions(BuyerID);
CREATE INDEX idx_markettransactions_sellerid ON MarketTransactions(SellerID);
CREATE INDEX idx_markettransactions_itemid ON MarketTransactions(ItemID);
CREATE INDEX idx_markettransactions_listedat ON MarketTransactions(ListedAt);
CREATE INDEX idx_markettransactions_soldat ON MarketTransactions(SoldAt);


SELECT *
FROM pg_indexes
WHERE schemaname = 'public';

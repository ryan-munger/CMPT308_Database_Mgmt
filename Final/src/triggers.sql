-- Make sure user has item to list on market
CREATE OR REPLACE FUNCTION ensure_ownership_before_listing()
RETURNS TRIGGER AS 
$$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Inventories
        WHERE SteamID = NEW.SellerID AND SkinItemID = NEW.ItemID
    ) THEN
        RAISE EXCEPTION 'Item % is not in the inventory of Seller %.', NEW.ItemID, NEW.SellerID;
    END IF;
    RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER check_ownership
BEFORE INSERT ON MarketTransactions
FOR EACH ROW
EXECUTE FUNCTION ensure_ownership_before_listing();

-- Test !! Will Fail !!
INSERT INTO MarketTransactions (TransID, ItemID, BuyerID, SellerID, PriceUSD, ListedAt, SoldAt) VALUES
(901, 701, NULL, 802, 45.50, '2025-04-10 18:00:00+00', NULL);

-- Transfer item ownership on purchase
CREATE OR REPLACE FUNCTION transfer_ownership()
RETURNS TRIGGER AS 
$$
BEGIN
    IF NEW.BuyerID IS NOT NULL AND NEW.SoldAt IS NOT NULL THEN
        -- Remove item from seller's inventory
        DELETE FROM Inventories
        WHERE SteamID = OLD.SellerID AND SkinItemID = OLD.ItemID;

        -- Add item to buyer's inventory
        INSERT INTO Inventories (SteamID, SkinItemID, AcquiredAt)
        VALUES (NEW.BuyerID, NEW.ItemID, NEW.SoldAt);
    END IF;
    RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER update_inventories_trigger
AFTER UPDATE ON MarketTransactions
FOR EACH ROW
WHEN (OLD.BuyerID IS NULL AND NEW.BuyerID IS NOT NULL AND OLD.SoldAt IS NULL AND NEW.SoldAt IS NOT NULL)
EXECUTE FUNCTION transfer_ownership();

-- Test
SELECT * FROM Inventories; -- check state before

UPDATE MarketTransactions
SET BuyerID = 007,  
    SoldAt = CURRENT_TIMESTAMP 
WHERE TransID = 908;

SELECT * FROM Inventories; -- check state after


-- Friends cannot create A B and B A friendship for no reason
CREATE OR REPLACE FUNCTION prevent_duplicate_friendships()
RETURNS TRIGGER AS 
$$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Friendships
        WHERE (FriendA = NEW.FriendB AND FriendB = NEW.FriendA)
    ) THEN
        RAISE EXCEPTION 'Friendship already exists in the opposite direction.';
    END IF;
    RETURN NEW;
END;
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER check_duplicate_friendships
BEFORE INSERT ON Friendships
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_friendships();

-- Test !! This will Fail as 801 to 802 already exists !!
INSERT INTO Friendships (FriendA, FriendB, DateFriended) VALUES
(802, 801, '2015-08-22 14:00:00+00');
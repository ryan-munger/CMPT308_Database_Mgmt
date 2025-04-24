DROP TABLE IF EXISTS SkinItemStickers CASCADE;
DROP TABLE IF EXISTS Stickers;
DROP TABLE IF EXISTS Capsules;
DROP TABLE IF EXISTS Inventories;
DROP TABLE IF EXISTS MarketTransactions CASCADE;
DROP TABLE IF EXISTS SkinItems CASCADE; 
DROP TABLE IF EXISTS Weapons;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Majors;
DROP TABLE IF EXISTS Cases;
DROP TABLE IF EXISTS Operations;
DROP TABLE IF EXISTS Friendships;
DROP TABLE IF EXISTS Buyers CASCADE;
DROP TABLE IF EXISTS Sellers CASCADE;
DROP TABLE IF EXISTS SteamUsers;

-- Operations table
CREATE TABLE Operations (
    OperationID INT PRIMARY KEY,
    OperationName TEXT NOT NULL,
    DateReleased DATE NOT NULL,
    DateEnded DATE
);

-- Cases table
CREATE TABLE Cases (
    CaseID INT PRIMARY KEY,
    CaseName TEXT NOT NULL,
    OperationID INT,
    FOREIGN KEY (OperationID) REFERENCES Operations(OperationID)
);

-- Capsules table
CREATE TABLE Capsules (
    CapsuleID INT PRIMARY KEY,
    CapsuleName TEXT NOT NULL,
    OperationID INT,
    FOREIGN KEY (OperationID) REFERENCES Operations(OperationID)
);

-- Stickers table
CREATE TABLE Stickers (
    StickerID INT PRIMARY KEY,
    StickerName TEXT NOT NULL,
    Rarity TEXT NOT NULL CHECK (Rarity IN ('Base Grade', 'Medium Grade', 'High Grade', 'Remarkable', 'Exotic', 'Extraordinary', 'Contraband')),
    Film TEXT NOT NULL CHECK (Film IN ('Foil', 'Glitter', 'Gold', 'Holo', 'Lenticular', 'Paper')),
    CapsuleID INT,
    FOREIGN KEY (CapsuleID) REFERENCES Capsules(CapsuleID)
);

-- Majors table
CREATE TABLE Majors (
    MajorID INT PRIMARY KEY,
    MajorName TEXT NOT NULL,
    Location TEXT,
    StartDate DATE CHECK (StartDate >= '2012-01-01'), -- game release
    EndDate DATE,
    CHECK (EndDate >= StartDate)
);

-- Matches table
CREATE TABLE Matches (
    MatchID INT PRIMARY KEY,
    MajorID INT NOT NULL,
    HomeTeam TEXT NOT NULL,
    AwayTeam TEXT NOT NULL,
    MatchDate TIMESTAMP WITH TIME ZONE,
    HomeScore INT DEFAULT 0 CHECK (HomeScore >= 0),
    AwayScore INT DEFAULT 0 CHECK (AwayScore >= 0),
    FOREIGN KEY (MajorID) REFERENCES Majors(MajorID)
);

-- Weapons table
CREATE TABLE Weapons (
    ItemID INT PRIMARY KEY,
    WeaponName TEXT NOT NULL,
    WeaponType TEXT NOT NULL CHECK (WeaponType IN ('Pistol', 'SMG', 'Rifle', 'Sniper', 'Shotgun', 'Machinegun', 'Knife', 'Gloves')),
    PriceInGame INT CHECK (PriceInGame >= 0),
    FireRate DOUBLE PRECISION CHECK (FireRate > 0),
    ArmorPen DOUBLE PRECISION CHECK (ArmorPen BETWEEN 0 AND 100), -- percentage
    AccRange INT CHECK (AccRange >= 0),
    MagCapacity INT CHECK (MagCapacity >= 0),
    ReserveAmmo INT CHECK (ReserveAmmo >= 0),
    RunSpeed DOUBLE PRECISION CHECK (RunSpeed > 0),
    ReloadSd DOUBLE PRECISION CHECK (ReloadSd > 0)
);

-- SkinItems table
CREATE TABLE SkinItems (
    SkinItemID INT PRIMARY KEY,
    CaseID INT NOT NULL,
    ItemID INT NOT NULL,
    ItemName TEXT NOT NULL,
    Wear TEXT NOT NULL CHECK (Wear IN ('Factory New', 'Minimal Wear', 'Field-Tested', 'Well-Worn', 'Battle-Scarred')),
    Float DOUBLE PRECISION NOT NULL CHECK (Float BETWEEN 0 AND 1),
    Pattern INT CHECK (Pattern >= 0),
    IsSouvenir BOOLEAN NOT NULL DEFAULT FALSE,
    MatchID INT,
    IsStatTrak BOOLEAN NOT NULL DEFAULT FALSE,
    Kills INT DEFAULT 0 CHECK (Kills >= 0),
    IsNamed BOOLEAN NOT NULL DEFAULT FALSE,
    GivenName TEXT,
    FOREIGN KEY (CaseID) REFERENCES Cases(CaseID),
    FOREIGN KEY (ItemID) REFERENCES Weapons(ItemID),
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID)
);

-- SkinItemStickers table
CREATE TABLE SkinItemStickers (
    StickerID INT,
    SkinItemID INT,
    Slot INT CHECK (Slot BETWEEN 0 AND 4),
    ScrapeWear TEXT CHECK (ScrapeWear IN ('Pristine', 'Scratched', 'Worn', 'Damaged')),
    PRIMARY KEY (StickerID, SkinItemID),
    FOREIGN KEY (SkinItemID) REFERENCES SkinItems(SkinItemID),
    FOREIGN KEY (StickerID) REFERENCES Stickers(StickerID)
);

-- SteamUsers table
CREATE TABLE SteamUsers (
    SteamID INT PRIMARY KEY,
    UserName TEXT NOT NULL,
    CSHrsPlayed DOUBLE PRECISION DEFAULT 0 CHECK (CSHrsPlayed >= 0),
    CSLastPlayed DATE,
    CSFirstPlayed DATE,
    BalanceUSD DOUBLE PRECISION DEFAULT 0
);

-- Inventories table
CREATE TABLE Inventories (
    SteamID INT,
    SkinItemID INT UNIQUE, -- Only one person can own an item at a time
    AcquiredAt TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (SteamID, SkinItemID),
    FOREIGN KEY (SteamID) REFERENCES SteamUsers(SteamID),
    FOREIGN KEY (SkinItemID) REFERENCES SkinItems(SkinItemID)
);

-- Friendships table
CREATE TABLE Friendships (
    FriendA INT,
    FriendB INT,
    DateFriended TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (FriendA, FriendB),
    FOREIGN KEY (FriendA) REFERENCES SteamUsers(SteamID),
    FOREIGN KEY (FriendB) REFERENCES SteamUsers(SteamID),
    CHECK (FriendA != FriendB)
);

-- Buyers table
CREATE TABLE Buyers (
    BuyerID INT PRIMARY KEY,
    TotalSpentUSD DOUBLE PRECISION DEFAULT 0 CHECK (TotalSpentUSD >= 0),
    FOREIGN KEY (BuyerID) REFERENCES SteamUsers(SteamID)
);

-- Sellers table
CREATE TABLE Sellers (
    SellerID INT PRIMARY KEY,
    TotalEarnedUSD DOUBLE PRECISION DEFAULT 0 CHECK (TotalEarnedUSD >= 0),
    FOREIGN KEY (SellerID) REFERENCES SteamUsers(SteamID)
);

-- MarketTransactions table
CREATE TABLE MarketTransactions (
    TransID INT PRIMARY KEY,
    ItemID INT NOT NULL,
    BuyerID INT NOT NULL,
    SellerID INT NOT NULL,
    PriceUSD DOUBLE PRECISION NOT NULL CHECK (PriceUSD > 0),
    ListedAt TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    SoldAt TIMESTAMP WITH TIME ZONE CHECK (SoldAt >= ListedAt),
    FOREIGN KEY (ItemID) REFERENCES SkinItems(SkinItemID),
    FOREIGN KEY (BuyerID) REFERENCES Buyers(BuyerID),
    FOREIGN KEY (SellerID) REFERENCES Sellers(SellerID),
    CHECK (BuyerID != SellerID) -- selling to yourself? 
);
DROP TABLE IF EXISTS People CASCADE;
DROP TABLE IF EXISTS Actors CASCADE;
DROP TABLE IF EXISTS Directors CASCADE;
DROP TABLE IF EXISTS Movies CASCADE;
DROP TABLE IF EXISTS MovieDirectors;
DROP TABLE IF EXISTS MovieActors;

CREATE TABLE People (
    PID INT NOT NULL,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    SpouseFirst TEXT,
    SpouseLast TEXT,
    Street TEXT,
    Apt_PO TEXT,
    City TEXT,
    StateProv TEXT,
    PostalCode TEXT,
    Country TEXT,
  PRIMARY KEY (PID)
);

CREATE TABLE Actors (
    PID INT NOT NULL REFERENCES People(PID) ON DELETE CASCADE,
    DOB DATE,
    HairColor TEXT,
    EyeColor TEXT,
    Height_in DOUBLE PRECISION CHECK (Height_in > 0),
    Weight_lbs DOUBLE PRECISION CHECK (Weight_lbs > 0),
    FavColor TEXT,
    SAG_Anniversary DATE,
  PRIMARY KEY (PID)
);

CREATE TABLE Directors (
    PID INT NOT NULL REFERENCES People(PID) ON DELETE CASCADE,
    FilmSchool TEXT,
    DG_Anniversary DATE,
    FavLensMaker TEXT,
  PRIMARY KEY (PID) 
);

CREATE TABLE Movies (
    MovieID INT NOT NULL,
    Title TEXT NOT NULL,
    ReleaseYr INT CHECK (ReleaseYr >= 1888), -- first ever movie
    MPAA_Num INT NOT NULL,
    DomesticSalesUSD DOUBLE PRECISION CHECK (DomesticSalesUSD >= 0),
    ForeignSalesUSD DOUBLE PRECISION CHECK (ForeignSalesUSD >= 0),
    DVDSalesUSD DOUBLE PRECISION CHECK (DVDSalesUSD >= 0),
  PRIMARY KEY(MovieID)
);

CREATE TABLE MovieActors (
    MovieID INT NOT NULL REFERENCES Movies(MovieID) ON DELETE CASCADE,
    PID INT NOT NULL REFERENCES Actors(PID) ON DELETE CASCADE,
    PRIMARY KEY (MovieID, PID)
);

CREATE TABLE MovieDirectors (
    MovieID INT NOT NULL REFERENCES Movies(MovieID) ON DELETE CASCADE,
    PID INT NOT NULL REFERENCES Directors(PID) ON DELETE CASCADE,
    PRIMARY KEY (MovieID, PID)
);


-- Test data courtesy of Google Gemini and some repeated prompting
-- Inserting data into the People table with TEXT PostalCode
INSERT INTO People (PID, FirstName, LastName, SpouseFirst, SpouseLast, Street, Apt_PO, City, StateProv, PostalCode, Country) VALUES
(101, 'Sean', 'Connery', 'Diane', 'Cilento', '123 Bond Street', NULL, 'London', NULL, '12345', 'UK'),
(102, 'George', 'Lazenby', 'Melinda', 'Knightsbridge', '456 Secret Ave', NULL, 'Sydney', 'NSW', '2000', 'Australia'),
(103, 'Roger', 'Moore', 'Luisa', 'Mattioli', '789 Spy Lane', NULL, 'Monaco', NULL, '98765', 'Monaco'),
(104, 'Timothy', 'Dalton', 'Oksana', 'Grigorieva', '321 Licence Rd', NULL, 'Cardiff', NULL, 'CF10', 'UK'),
(105, 'Pierce', 'Brosnan', 'Keely', 'Shaye Smith', '654 GoldenEye Blvd', NULL, 'Dublin', NULL, '1234', 'Ireland'),
(106, 'Daniel', 'Craig', 'Rachel', 'Weisz', '987 Casino Way', NULL, 'London', NULL, 'SW1A', 'UK'),
(201, 'Terence', 'Young', NULL, NULL, '111 Film Row', 'Apt 2B', 'Los Angeles', 'CA', '90001', 'USA'),
(202, 'Guy', 'Hamilton', NULL, NULL, '222 Action Ave', NULL, 'London', NULL, 'W1T', 'UK'),
(301, 'Ursula', 'Andress', NULL, NULL, '444 Beach Rd', NULL, 'Bern', NULL, '3000', 'Switzerland'),
(302, 'Honor', 'Blackman', NULL, NULL, '555 Martial Arts Dr', NULL, 'London', NULL, 'NW3', 'UK'),
(303, 'Judi', 'Dench', NULL, NULL, '777 MI6 Hq', NULL, 'London', NULL, 'SW1V', 'UK');

-- Inserting data into the Actors table
INSERT INTO Actors (PID, DOB, HairColor, EyeColor, Height_in, Weight_lbs, FavColor, SAG_Anniversary) VALUES
(101, '1930-08-25', 'Grey', 'Blue', 74.0, 200.0, 'Navy', '1962-01-01'),
(102, '1939-09-05', 'Brown', 'Brown', 73.0, 190.0, 'Green', '1969-01-01'),
(103, '1927-10-14', 'Blonde', 'Blue', 74.0, 185.0, 'White', '1973-01-01'),
(104, '1946-03-21', 'Brown', 'Blue', 74.0, 175.0, 'Black', '1987-01-01'),
(105, '1953-05-16', 'Brown', 'Blue', 74.0, 195.0, 'Blue', '1995-01-01'),
(106, '1968-03-02', 'Blonde', 'Blue', 70.0, 178.0, 'Grey', '2006-01-01'),
(301, '1936-03-19', 'Blonde', 'Blue', 65.0, 130.0, 'Yellow', NULL),
(302, '1925-08-22', 'Black', 'Brown', 66.0, 140.0, 'Purple', NULL),
(303, '1934-12-09', 'Grey', 'Brown', 62.0, 120.0, 'Red', NULL);

-- Inserting data into the Directors table
INSERT INTO Directors (PID, FilmSchool, DG_Anniversary, FavLensMaker) VALUES
(201, 'National Film School', '1950-01-01', 'Panavision'),
(202, 'Ealing Studios', '1952-01-01', 'Arri');

-- Inserting data into the Movies table
INSERT INTO Movies (MovieID, Title, ReleaseYr, MPAA_Num, DomesticSalesUSD, ForeignSalesUSD, DVDSalesUSD) VALUES
(007, 'Dr. No', 1962, 1, 59567035.00, 0.00, 15000000.00),
(008, 'Goldfinger', 1964, 1, 124900000.00, 0.00, 25000000.00),
(009, 'On Her Majestys Secret Service', 1969, 1, 64600000.00, 0.00, 18000000.00),
(010, 'The Living Daylights', 1987, 2, 191200000.00, 0.00, 30000000.00),
(011, 'GoldenEye', 1995, 2, 356400000.00, 0.00, 50000000.00),
(012, 'Casino Royale', 2006, 3, 599000000.00, 0.00, 80000000.00);

-- Inserting data into the MovieActors table
INSERT INTO MovieActors (MovieID, PID) VALUES
(007, 101),
(007, 301),
(008, 101),
(008, 302),
(009, 102),
(010, 104),
(011, 105),
(011, 303),
(012, 106),
(012, 303);

-- Inserting data into the MovieDirectors table
INSERT INTO MovieDirectors (MovieID, PID) VALUES
(007, 201),
(008, 202),
(009, 202),
(010, 201),
(011, 201),
(012, 201);

-- Check for success
SELECT * 
FROM People;

SELECT * 
FROM Actors;

SELECT * 
FROM Directors;

SELECT * 
FROM Movies;

SELECT * 
FROM MovieActors;

SELECT * 
FROM MovieDirectors;

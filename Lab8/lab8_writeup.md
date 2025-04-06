# Database Lab Report 8

**Course:** Database Management\
**Lab Number:** *Lab #8*\
**Date:** *2025-4-15*\
**Name:** *Ryan Munger*

---

## 1. Objective

*To continue developing your facility with the art and science of normalization*

## 2. Lab Setup

*A normalized brain*

## 3. Procedure

### Prompt: 

*You have been hired as a database consultant by EON productions to work in the casting department for the next James Bond film. They finally need a new Bond (thank Codd!) and want a database of actors, the movies in which they have appeared, and the director of those movies. They have collected the following data for your use:*

**Actor Data:** \
name, address, birth date, hair color, eye color, height in inches, weight, spouse name, 
favorite color, screen actors guild anniversary date

**Movie Data** \
name, year released, MPAA number, domestic box office sales, foreign box office sales, 
DVD/Blu-ray sales

**Director Data** \
name, address, spouse name, film school attended, directors guild anniversary date, 
favorite lens maker

### Part 1:
*Build this database. You may add or rename any fields you like. You must create a relational database in Boyce-Codd normal form (BCNF).* 



​1.  **Create a	fully decorated	and	aesthetically beautiful	E/R	diagram**
![ER Diagram](ER-Diagram.png)


\
2. **Write SQL create statements	for	each table**


\
3. **List the functional dependencies for each table.** \
We need to ensure that the computer model is the same for all instances of a specific TagNumber and that PackageName is the same for all instances of a specific PackageID.

| PackageID | TagNumber | InstallDate | SoftwareCostUSD | PackageName | ComputerModel |
|-----------|----------|-------------|-----------|---------|--------|
| AC01      | 32808    | 09-13-2005   | 754.95   | Alab    | Apple  |
| DB32      | 32808    | 12-03-2005   | 380.00   | Gopiler | Apple  |
| DB32      | 37691    | 06-15-2005   | 380.00   | Gopiler | Lenovo |
| DB33      | 57772    | 05-27-2005   | 412.77   | Solitaire | Dell |
| WP08      | 32808    | 01-12-2006   | 185.00   | Tsiram  | Apple  | 
| WP08      | 37691    | 06-15-2005   | 227.50   | Tsiram  | Lenovo |
| WP08      | 57222    | 05-27-2005   | 170.24   | Tsiram  | MSI   |
| WP09      | 59836    | 10-30-2005   | 35.00    | Snake  | Acer   |
| WP09      | 77740    | 05-27-2005   | 35.00    | Snake  | HP     | 

\
5. **Identify and document all functional dependencies.**

PackageID → PackageName

    Each PackageID uniquely determines a PackageName.

    A PackageID will always correspond to one and only one PackageName.

TagNumber → ComputerModel

    Each TagNumber is related to a single ComputerModel.

    If we know the TagNumber, we know the model of the computer.

(PackageID, TagNumber) → InstallDate, SoftwareCostUSD

    The combination of PackageID and TagNumber is the primary key.

PackageName !→ PackageID 

    Multiple PackageIDs can have the same PackageName.

ComputerModel !→ TagNumber 

    Multiple TagNumbers can share the same ComputerModel.
\
6. **Explain why this new table is not in third normal form.**

To qualify for 3NF:
1. Must be in 2NF (No Partial Dependencies - all non-key attributes depend on PK)
2. No transitive dependencies (all non-key attributes depend ONLY on PK)

This table is not in 2NF. While it is 1NF (atomic, unique fields, PK), it has partial dependencies (ComputerModel and PackageName only depend on part of the PK). We will examine transitive dependencies once we get this table into at least 2NF. This can be done by building better relations with a Packages Table, Computers Table, and Installation Table. 

### Part 3:
*Decompose your 1NF table into a set of tables that are in at least third
normal form. (BCNF would be better.) Remember that it’s wrong to add artificial keys to associative entities. Actually, as I said before, do not add any additional columns!*

\
7. **Identify all primary keys (determinants) for all tables.**

Table → Primary Key \
Packages → PackageID \
Computers → TagNumber \
Installations → (PackageID, TagNumber) 

\
8. **Identify all functional dependencies for all tables.**

<u>Packages</u> \
PackageID → PackageName

<u>Computers</u> \
TagNumber → ComputerModel

<u>Installations</u>\
(PackageID, TagNumber) → InstallDate \
(PackageID, TagNumber) → SoftwareCostUSD

\
9. **Explain why the new tables are in third normal form.**

It is 3NF because:
1. In the Packages, PackageName depends only on PackageID. (No transitive dependency)

2. In the Computers, ComputerModel depends only on TagNumber. (No transitive dependency)

3. In the Installations, InstallDate and SoftwareCostUSD depend only on the PK (PackageID, TagNumber) and not on a non-key attribute. (No transitive dependency) 
 
It is BCNF because all functional dependencies originate from a superkey.

\
10.  **Draw a beautiful E/R diagram using LucidChart.** \
We made a many-many relationship (many computers to many packages) via the installations table!

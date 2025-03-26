# Database Lab Report 6

**Course:** Database Management\
**Lab Number:** *Lab #7*\
**Date:** *2025-25-25*\
**Name:** *Ryan Munger*

---

## 1. Objective

*To begin delving into the art and science of relational database normalization.*

## 2. Lab Setup

*A normalized brain*

## 3. Procedure

### Prompt: 

*You have been hired as a database consultant by Tycho Manufacturing. They wish to
track the software packages installed on their station computers. Each computer is
identified by an asset tag number. Each software package has a package ID. They would
also like to track the installation date of each package on each computer, as well as the
cost of that software for that computer at install time.*

### Part 1:
*Tycho CEO Fred Johnson has put together a spreadsheet of all the data he has
so far, which he personally collected.*

1. As he shows you the spreadsheet, having just signed your consulting agreement, he
asks what you think of it. How do you reply?
2. Put his data in 1NF and display it. (Show me the table; no SQL.)
3. What is the primary key?

### Part 2:
*Add two columns of new data: one column for software package name (e.g.,
Zork, Portal, etc.) and one for computer model (e.g., IBM, Apple, etc.). Be sure that your
new data is consistent with the original data. Do not add any additional columns.*

4. Display the new table.
5. Identify and document all functional dependencies.
6. Explain why this new table is not in third normal form.


### Part 3:
*Decompose your 1NF table into a set of tables that are in at least third
normal form. (BCNF would be better.) Remember that it’s wrong to add artiEicial keys to
associative entities. Actually, as I said before, do not add any additional columns.*

7. Identify all primary keys (determinants) for all tables.
8. Identify all functional dependencies for all tables.
9. Explain why the new tables are in third normal form.
10. Draw a beautiful E/R diagram using LucidChart. (Students can get free accounts.)
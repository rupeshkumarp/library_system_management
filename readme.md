# Library Management System (SQL)

A MySQL database project that models how a library runs day to day, with SQL queries for common operations and reporting.

## Overview

The project covers the full book lifecycle: books are added to the catalog, issued to members by employees at a branch, and later returned. The schema is built around that flow, and the queries show how to manage records and pull useful reports from the data.

## Repository Contents

| File / Folder | Description |
|---|---|
| `library_DB.sql` | Database schema, CRUD operations, analysis queries and a stored procedure |
| `ER diagram.mwb` | Entity-relationship diagram (MySQL Workbench) |
| `data/` | Sample data used to populate the tables |

## Database Design

Six core tables:

- **branch**: library branches and their managers
- **employees**: staff assigned to branches
- **books**: catalog with category, rental price and availability status
- **members**: registered library members
- **issued_status**: records of books issued to members
- **return_status**: records of returned books

Tables are linked through primary and foreign keys (members, employees and books to issued records, and issued records to returns).

## What the Queries Cover

- **CRUD operations**: add, update and delete book, member and issue records
- **Summary tables (CTAS)**: issue counts per book, high-priced books, branch performance
- **Reports**: rental income by category, employees with the most issues, overdue books, books not yet returned, new and active members
- **Stored procedure**: updates book status when a book is returned

## Tech Stack

- MySQL
- MySQL Workbench

## Getting Started

1. Clone the repository
   ```bash
   git clone https://github.com/rupeshkumarp/library_system_management.git
   ```
2. Run `library_DB.sql` in MySQL Workbench or the MySQL CLI to create the database and tables.
3. Load the sample data from the `data/` folder.
4. Run the queries to explore the results.

## Author

**Rupesh Kumar P**
MSDA student | [GitHub](https://github.com/rupeshkumarp)
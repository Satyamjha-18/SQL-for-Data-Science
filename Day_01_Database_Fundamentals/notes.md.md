# Day 01 - Database Fundamentals

## 1. What is SQL?

SQL stands for **Structured Query Language**.

SQL is used to interact with and manage data in relational databases.

SQL can be used to:

- Create databases and tables
- Insert data
- Read data
- Update data
- Delete data
- Filter data
- Aggregate data
- Join data from multiple tables

---

## 2. What is a Database?

A database is a collection of data that is organized so that it can be easily:

- Accessed
- Managed
- Updated

A database generally contains tables, and tables contain rows and columns.

### Example

| CustomerID | Name  | City   |
|------------|-------|--------|
| 101        | Rahul | Delhi  |
| 102        | Aman  | Mumbai |
| 103        | Priya | Pune   |

---

## 3. What is a Table?

A table stores data in the form of **rows and columns**.

### Row

A row represents one complete record.

### Column

A column represents an attribute or field.

### Example

| CustomerID | Name  | City   |
|------------|-------|--------|
| 101        | Rahul | Delhi  |
| 102        | Aman  | Mumbai |

---

## 4. DBMS

**DBMS = Database Management System**

A DBMS is software used to create, store, manage, and retrieve data from databases.

### Main Functions

- Create databases
- Store data
- Retrieve data
- Update data
- Delete data
- Manage database objects
- Provide data security

### Examples

- MySQL
- Oracle
- PostgreSQL
- Microsoft SQL Server

---

## 5. RDBMS

**RDBMS = Relational Database Management System**

An RDBMS stores data in the form of tables.

Tables can be related to each other using keys.

### Examples

- MySQL
- Oracle
- PostgreSQL
- Microsoft SQL Server

---

## 6. Relational vs Non-Relational Database

### Relational Database

In a relational database:

- Data is stored in tables.
- Tables contain rows and columns.
- Tables can be related to each other.
- Relationships are created using keys.

### Examples

- MySQL
- Oracle
- PostgreSQL
- SQL Server

### Non-Relational Database

Non-relational databases do not store data in the traditional table-based relational structure.

### Example

- MongoDB

---

## 7. CRUD Operations

CRUD stands for:

| Operation | Meaning |
|-----------|---------|
| C | Create |
| R | Read |
| U | Update |
| D | Delete |

### Create

```sql
CREATE DATABASE sql_ml;
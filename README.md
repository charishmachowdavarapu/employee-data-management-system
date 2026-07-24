# Employee Data Management System

A normalised (3NF) employee database system built with **MySQL** and **Python**, with **Excel/Power BI** dashboards for department-wise reporting and trend analysis.

## Overview

This project simulates a company's employee management workflow — from database design to CRUD operations to reporting. It was built to practice structured data modelling, SQL query writing, and turning raw data into business-ready insights.

## Tech Stack

- **Database:** MySQL (3-table normalised schema, 3NF)
- **Backend:** Python (mysql-connector, CRUD operations)
- **Reporting:** MS Excel (Pivot Tables, Dashboards), Power BI

## Database Design

Three normalised tables:

- `departments` — department name and location
- `salaries` — base salary, bonus, pay grade
- `employees` — links to departments and salaries via foreign keys

This structure avoids data duplication and keeps salary/department info easy to update independently of employee records.

## Key SQL Queries

The `employee_schema.sql` file includes:
- A **JOIN** query combining employee, department, and salary data
- A **GROUP BY** query calculating average salary per department
- A **HAVING** query filtering departments with above-average pay
- A subquery identifying the highest-paid employee per department

## Python CRUD Operations

`employee_crud.py` implements:
- `add_employee()` — Create
- `get_all_employees()` / `get_employee_by_id()` — Read
- `update_employee_department()` — Update
- `delete_employee()` — Delete

## Reporting & Dashboard

An Excel dashboard with pivot charts was built on top of this dataset to automate department-wise and salary-based reporting, reducing manual reporting effort.

## How to Run

1. Create the database and tables:
   ```
   mysql -u root -p < employee_schema.sql
   ```
2. Install Python dependencies:
   ```
   pip install mysql-connector-python
   ```
3. Update the database password in `employee_crud.py`, then run:
   ```
   python employee_crud.py
   ```

## Author

Chowdavarapu Charishma — Data Analyst
[LinkedIn](https://linkedin.com/in/chowdavarapucharishma)

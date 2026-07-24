"""
Employee Data Management System
Python CRUD Operations using MySQL Connector

Requirements:
    pip install mysql-connector-python
"""

import mysql.connector
from mysql.connector import Error


def get_connection():
    """Create and return a database connection."""
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="your_password",   # replace with your actual password
        database="employee_db"
    )


# ---------------------------------------
# CREATE
# ---------------------------------------
def add_employee(name, department_id, salary_id, join_date):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        query = """INSERT INTO employees (name, department_id, salary_id, join_date)
                   VALUES (%s, %s, %s, %s)"""
        cursor.execute(query, (name, department_id, salary_id, join_date))
        conn.commit()
        print(f"Employee '{name}' added successfully. ID: {cursor.lastrowid}")
    except Error as e:
        print(f"Error adding employee: {e}")
    finally:
        cursor.close()
        conn.close()


# ---------------------------------------
# READ
# ---------------------------------------
def get_all_employees():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        query = """
            SELECT e.emp_id, e.name, d.dept_name, s.base_salary, s.pay_grade
            FROM employees e
            JOIN departments d ON e.department_id = d.dept_id
            JOIN salaries s ON e.salary_id = s.salary_id
        """
        cursor.execute(query)
        results = cursor.fetchall()
        for row in results:
            print(row)
        return results
    except Error as e:
        print(f"Error fetching employees: {e}")
    finally:
        cursor.close()
        conn.close()


def get_employee_by_id(emp_id):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM employees WHERE emp_id = %s", (emp_id,))
        return cursor.fetchone()
    except Error as e:
        print(f"Error fetching employee: {e}")
    finally:
        cursor.close()
        conn.close()


# ---------------------------------------
# UPDATE
# ---------------------------------------
def update_employee_department(emp_id, new_department_id):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        query = "UPDATE employees SET department_id = %s WHERE emp_id = %s"
        cursor.execute(query, (new_department_id, emp_id))
        conn.commit()
        print(f"Employee {emp_id} moved to department {new_department_id}.")
    except Error as e:
        print(f"Error updating employee: {e}")
    finally:
        cursor.close()
        conn.close()


# ---------------------------------------
# DELETE
# ---------------------------------------
def delete_employee(emp_id):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM employees WHERE emp_id = %s", (emp_id,))
        conn.commit()
        print(f"Employee {emp_id} deleted.")
    except Error as e:
        print(f"Error deleting employee: {e}")
    finally:
        cursor.close()
        conn.close()


# ---------------------------------------
# Example usage
# ---------------------------------------
if __name__ == "__main__":
    print("All employees:")
    get_all_employees()

    print("\nAdding a new employee:")
    add_employee("Meera Pillai", 1, 1, "2024-04-01")

    print("\nUpdating employee department:")
    update_employee_department(2, 3)

    print("\nFetching employee by ID:")
    print(get_employee_by_id(1))

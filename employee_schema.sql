-- ============================================
-- Employee Data Management System
-- Normalized Schema (3NF)
-- ============================================

CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

-- ----------------------------
-- Table: departments
-- ----------------------------
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50)
);

-- ----------------------------
-- Table: salaries
-- ----------------------------
CREATE TABLE salaries (
    salary_id INT PRIMARY KEY AUTO_INCREMENT,
    base_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    pay_grade VARCHAR(10)
);

-- ----------------------------
-- Table: employees
-- ----------------------------
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    salary_id INT,
    join_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(dept_id),
    FOREIGN KEY (salary_id) REFERENCES salaries(salary_id)
);

-- ============================================
-- Sample Data
-- ============================================

INSERT INTO departments (dept_name, location) VALUES
('Engineering', 'Hyderabad'),
('Sales', 'Bangalore'),
('HR', 'Hyderabad'),
('Finance', 'Mumbai'),
('Marketing', 'Delhi');

INSERT INTO salaries (base_salary, bonus, pay_grade) VALUES
(45000, 5000, 'G1'),
(55000, 7000, 'G2'),
(38000, 3000, 'G1'),
(62000, 9000, 'G3'),
(48000, 4000, 'G2'),
(70000, 10000, 'G3'),
(40000, 3500, 'G1'),
(58000, 6000, 'G2');

INSERT INTO employees (name, department_id, salary_id, join_date) VALUES
('Ananya Rao', 1, 1, '2022-01-15'),
('Vikram Singh', 2, 2, '2021-11-03'),
('Priya Menon', 3, 3, '2023-02-20'),
('Rahul Verma', 1, 4, '2020-06-10'),
('Sneha Reddy', 4, 5, '2022-09-01'),
('Arjun Nair', 2, 6, '2019-03-12'),
('Kavya Iyer', 5, 7, '2023-07-05'),
('Rohit Sharma', 1, 8, '2021-01-25');

-- ============================================
-- Key Queries (JOIN, GROUP BY, HAVING)
-- ============================================

-- 1. JOIN: Full employee details with department and salary info
SELECT e.name, d.dept_name, d.location, s.base_salary, s.bonus, s.pay_grade
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
JOIN salaries s ON e.salary_id = s.salary_id;

-- 2. GROUP BY: Average base salary per department
SELECT d.dept_name, ROUND(AVG(s.base_salary), 2) AS avg_salary, COUNT(e.emp_id) AS headcount
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
JOIN salaries s ON e.salary_id = s.salary_id
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

-- 3. HAVING: Departments where average salary exceeds 50,000
SELECT d.dept_name, ROUND(AVG(s.base_salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
JOIN salaries s ON e.salary_id = s.salary_id
GROUP BY d.dept_name
HAVING AVG(s.base_salary) > 50000;

-- 4. LEFT JOIN: All departments with employee count, including departments with zero employees
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.department_id
GROUP BY d.dept_name
ORDER BY employee_count ASC;

-- 5. Highest paid employee per department (window-style using subquery)
SELECT d.dept_name, e.name, s.base_salary
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
JOIN salaries s ON e.salary_id = s.salary_id
WHERE s.base_salary = (
    SELECT MAX(s2.base_salary)
    FROM employees e2
    JOIN salaries s2 ON e2.salary_id = s2.salary_id
    WHERE e2.department_id = e.department_id
);

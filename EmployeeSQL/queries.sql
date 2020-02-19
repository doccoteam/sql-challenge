CREATE TABLE departments(
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR NOT NULL
);

CREATE TABLE employees(
	emp_no SERIAL PRIMARY KEY,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hire_date DATE NOT NULL
);

CREATE TABLE dept_emp(
	id SERIAL PRIMARY KEY,
	emp_no INT,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

CREATE TABLE dept_manager(
	id SERIAL PRIMARY KEY,
	dept_no VARCHAR NOT NULL,
	emp_no INT,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);


CREATE TABLE salaries(
	id SERIAL PRIMARY KEY,
	emp_no INT,
	salary INT,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles(
	id SERIAL PRIMARY KEY,
	emp_no INT,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

--1. List the following details of each employee: 
-- employee number, last name, first name, gender, and salary
CREATE VIEW employees_details AS
SELECT e.emp_no as "Employee Number", e.last_name as "Last Name", 
	e.first_name as "First Name", e.gender as "Gender", s.salary as "Salary"
FROM employees AS e
	JOIN salaries AS s
	ON e.emp_no = s.emp_no;


-- 2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE EXTRACT(year FROM "hire_date") = 1986;

-- 3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, 
-- first name, and start and end employment dates.
SELECT * FROM employees
SELECT * FROM departments
SELECT * FROM dept_manager

SELECT dm.dept_no as "Department Number", dp.dept_name as "Department Name",
	dm.emp_no as "Managers Employee Number", e.last_name as "Last Name", 
	e.first_name as "First Name", dm.from_date as "Start Employment Date", 
	dm.to_date as "End Employment Date"
FROM dept_manager as dm
	JOIN departments as dp
	ON dm.dept_no = dp.dept_no
	JOIN employees as e
	ON dm.emp_no = e.emp_no;
	
-- 4. List the department of each employee 
-- with the following information: employee number, last name, 
-- first name, and department name.
SELECT * FROM employees
SELECT * FROM departments
SELECT * FROM dept_emp

SELECT de.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name",
	dp.dept_name AS "Department Name"
FROM dept_emp AS de
	JOIN departments AS dp
	ON de.dept_no = dp.dept_no
	JOIN employees AS e
	ON de.emp_no = e.emp_no;
	
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%'

-- 6. List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.

SELECT e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name",
dp.dept_name as "Department Name"
FROM employees AS e
	JOIN dept_emp as dpe
	ON e.emp_no = dpe.emp_no
	JOIN departments as dp
	ON dpe.dept_no = dp.dept_no
	WHERE dept_name = 'Sales';
	

-- 7. List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name",
dp.dept_name as "Department Name"
FROM employees AS e
	JOIN dept_emp as dpe
	ON e.emp_no = dpe.emp_no
	JOIN departments as dp
	ON dpe.dept_no = dp.dept_no
	WHERE dept_name = 'Sales' or dept_name = 'Development';
	
-- 8. In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

SELECT COUNT(emp_no) AS "Frequency Count Of Employee Last Names", last_name AS "Last Name"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Count Of Employee Last Names" DESC;
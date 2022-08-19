-- Create a retirement_titles.csv
SELECT employees.emp_no,
	employees.first_name,
    employees.last_name,
	titles.title,
    titles.from_date,
    titles.to_date
INTO retirement_titles
FROM employees
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY employees.emp_no
--SELECT * FROM retirement_titles

-- Create a unique_titles.csv using sample code
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
	retirement_titles.first_name,
    retirement_titles.last_name,
	retirement_titles.title
INTO unique_titles
FROM retirement_titles
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;
-- SELECT * FROM unique_titles

-- Create a retiring_titles.csv to retrieve the number of employees 
-- by their most recent job title who are about to retire.
SELECT title, COUNT(*)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY 2 DESC
-- SELECT * FROM retiring_titles

-- Create a mentorship_eligibilty.csv that holds the employees who 
-- are eligible to participate in a mentorship program
SELECT DISTINCT ON (employees.emp_no) employees.emp_no,
	employees.first_name,
	employees.last_name,
	employees.birth_date,
	dept_emp.from_date,
	dept_emp.to_date,
	titles.title
INTO mentorship_eligibility
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
LEFT JOIN titles
ON titles.emp_no = employees.emp_no
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
    AND (dept_emp.to_date BETWEEN '9998-01-01' AND '9999-01-01')
ORDER BY employees.emp_no
-- SELECT * FROM mentorship_eligibility
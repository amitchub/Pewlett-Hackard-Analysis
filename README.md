# Pewlett-Hackard-Analysis

## Overview of the Pewlett Hackard Analysis

### Purpose
The purpose of this analysis is to establish:
- The number of retiring employees per title.
- The employees who are candidates to participate in a mentorship program to prepare for the 'silver tsumnami'.

## Results of the Analysis

### Retiring Employees by Title

To determine the number of retiring employees per title, a Retirement Titles table which contains a collection of titles of employees that are nearing retirement age (employees born between January 1, 1952 and December 31, 1955.) was created.  The code snippet is below:

```
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
```

After the creation of the previous table, duplicate rows were removed using the DISTINCT ON statement.  Only the most recent title of each employee was returned, as employees have had multiple titles during their tenure at Pewlett Hackard.  The code snippet is below:

```
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
	retirement_titles.first_name,
    retirement_titles.last_name,
	retirement_titles.title
INTO unique_titles
FROM retirement_titles
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;
```

Finally, a Retiring Titles table was created, showing the number of retirement age employees by job title.  The SQL COUNT function was used to populate the column.  The code snippet is below:

```
SELECT title, COUNT(*)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY 2 DESC
```

The results of the preceeding query are displayed in the following table:

![Retiring Titles](./Resources/retiring_titles_table.PNG)

### Employees Eligible for Mentorship Program

A Mentorship Eligibilty table was created to identify the employees who are eligible to participate in a mentorship program.  These are employees who were born between January 1, 1965 and December 31, 1965.  The code snippet is below:

```
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
```

The results of the preceeding query are displayed in the following table:

![Mentorship Eligibility](./Resources/mentorship_eligibility_table.PNG)

### Summary of Analysis Results
- A total of 90,398 employees are of retirement-age.
- Half of the retirees have "Engineer" in their title, making up 50.2% of the retiring population. Retirees with "Staff" in their title make up another 44.8%. The remaining 5% includes Technique Leaders and Managers.
- A total of 1,940 employees are eligible to be mentors in the mentorship program.
- There are roughly 2 mentors for every 90 vacancies.


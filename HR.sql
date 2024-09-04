CREATE DATABASE hrdata;
USE hrdata;
SELECT * FROM employees;
-- Total Employees
SELECT COUNT(*) AS Total_Employees
FROM employees;

-- Total Old Employees
SELECT COUNT(*) AS Total_Old_Employees
FROM employees
WHERE DateofTermination!="";

-- Total Current Employees
SELECT COUNT(*) AS Total_Current_Employees
FROM employees
WHERE DateofTermination="";

-- Average Salary
SELECT AVG(Salary) AS Avg_Salary
FROM employees;

-- Average Age
SELECT AVG(TIMESTAMPDIFF(YEAR,STR_TO_DATE(DOB,'%d-%m-%Y'), CURDATE())) AS Avg_Age
FROM employees;

-- Average Years in Company
SELECT AVG(TIMESTAMPDIFF(YEAR,STR_TO_DATE(DateofHire,'%d-%m-%Y'), CURDATE())) AS Avg_years_in_Company
FROM employees;

-- Adding New Column for Employee Current Status
ALTER TABLE employees
ADD EmployeeCurrentStatus INT;

-- Updating values for new column
SET SQL_SAFE_UPDATES=0;
UPDATE employees
SET EmployeeCurrentStatus=CASE
    WHEN DateofTermination=''THEN 1
    ELSE 0
END;

-- Calculate attrition rate based on custom EmpStatusId values
SELECT
      (CAST(COUNT(CASE WHEN EmployeeCurrentStatus=0 THEN 1 END) AS FLOAT)/COUNT(*))*100 AS Attrition_Rate
FROM employees;

-- get column names and data types
DESCRIBE employees;
-- or
SHOW COLUMNS FROM employees;


-- Print 1st 5 rows
SELECT *
FROM employees
LIMIT 5;

-- Print last 5 rows
SELECT * 
FROM employees
ORDER BY EmpId DESC
LIMIT 5;

-- Changing Data Types of Salary
ALTER TABLE employees
MODIFY COLUMN Salary DECIMAL(10,2);

-- Convert all dates columns in proper dates
UPDATE employees
SET DOB=STR_TO_DATE(DOB,'%d-%m-%Y');
UPDATE employees
SET DateofHire=STR_TO_DATE(DateofHire,'%d-%m-%Y');
UPDATE employees
SET LastPerformanceReview_Date=STR_TO_DATE(LastPerformanceReview_Date,'%d-%m-%Y');

ALTER TABLE employees
MODIFY COLUMN DOB DATE,
MODIFY COLUMN DateofHire DATE,
MODIFY COLUMN LastPerformanceReview_Date DATE;

SELECT DOB,DateofHire,DateofTermination,LastPerformanceReview_Date
FROM employees;
DESCRIBE employees;

UPDATE employees
SET DateofTermination='CurrebtlyWorking'
WHERE DateofTermination IS NULL OR DateofTermination='';

-- count of each unique value in the maritalDesc
SELECT MaritalDesc,COUNT(*) AS Count
FROM employees
GROUP BY MaritalDesc
ORDER BY Count DESC;

-- count of each unique value in the department
SELECT Department,COUNT(*) AS Count
FROM employees
GROUP BY Department
ORDER BY Count DESC;

-- count of each unique value in the Position
SELECT Position,COUNT(*) AS Count
FROM employees
GROUP BY Position
ORDER BY Count DESC;

-- count of each unique value in the manager
SELECT ManagerName,COUNT(*) AS COUNT
FROM employees
GROUP BY ManagerName
ORDER BY Count DESC;

-- Salary distribution by employees
SELECT 
CASE
WHEN Salary<3000 THEN'30k'
WHEN Salary BETWEEN 30000 AND 49999 THEN '30k-49k'
WHEN Salary BETWEEN 50000 AND 69999 THEN '50k-69k'
WHEN Salary BETWEEN 70000 AND 89999 THEN '70k-89k'
WHEN Salary >=90000 THEN '90k and above'
END AS Salary_Range,
COUNT(*) AS Frequency
FROM employees GROUP BY Salary_Range ORDER BY Salary_Range;

-- Performance Score
SELECT 
     PerformanceScore,
     COUNT(*) AS Count
FROM employees
GROUP BY PerformanceScore
ORDER BY PerformanceScore;

-- Average salary by department
SELECT 
      Department,
      AVG(Salary) AS AverageSalary
FROM employees
GROUP BY Department
ORDER BY Department;      

-- count termination by cause
SELECT
      TermReason,
      COUNT(*) AS Count
FROM employees
WHERE TermReason IS NOT NULL
GROUP BY TermReason
ORDER BY Count DESC;

-- employee count by state
SELECT 
      State,
      COUNT(*) AS COUNT
FROM employees
GROUP BY State
ORDER BY Count DESC;

-- GENDER DISTRIBUTION
SELECT 
      Sex,
      COUNT(*) AS COUNT
FROM employees
GROUP BY Sex
ORDER BY Count DESC;

-- GETTING AGE DISTRIBUTION
ALTER TABLE employees
ADD COLUMN Age INT;

-- Update the age column with calculated agE
SET SQL_SAFE_UPDATES=0;
UPDATE employees
SET Age=TIMESTAMPDIFF(YEAR,DOB,CURDATE());

-- AGE DISTRIBUTION
SELECT 
CASE 
WHEN Age<20 THEN '<20'
WHEN AGE BETWEEN 20 AND 29 THEN '20-29'
WHEN AGE BETWEEN 30 AND 39 THEN '30-39'
WHEN AGE BETWEEN 40 AND 49 THEN '40-49'
WHEN AGE BETWEEN 50 AND 59 THEN '50-59'
WHEN Age>=60 THEN '60 and above'
END AS Age_Range,
COUNT(*) AS COUNT
FROM employees
GROUP BY Age_Range;

-- ABSENCES BY DEPARTMENT
SELECT 
      Department,
      SUM(Absences) AS TotalAbsences
FROM employees
GROUP BY Department
ORDER BY TotalAbsences DESC;

-- SALARY DISTRIBUTION BY GENDER
SELECT 
      SEX,
      SUM(Salary) AS TotalSalary
FROM employees
GROUP BY Sex
ORDER BY TotalSalary DESC;

-- COUNT OF EMPLOYEES TERMINATED AS PER MARITAL STATUS
SELECT
      MaritalDesc,
      COUNT(*) AS TerminatedCount
FROM employees
WHERE Termd=1
GROUP BY MaritalDesc
ORDER BY TerminatedCount DESC;

-- AVERAGE ABSENCES BY PERFORMANCE SCORE
SELECT 
      PerformanceScore,
      AVG(Absences) AS AverageAbsences
FROM employees
GROUP BY PerformanceScore
ORDER BY  PerformanceScore;    

-- EMPLOYEE COUNT BY RECRUITMENT SCORE
SELECT
      RecruitmentSource,
      COUNT(*) AS EmployeeCount
FROM employees
GROUP BY RecruitmentSource
ORDER BY EmployeeCount DESC;      




      
    




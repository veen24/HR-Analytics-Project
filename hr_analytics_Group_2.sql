USE hr_analytics;

-- Calculation of attrition rate
SELECT
    (SELECT COUNT(*) FROM hr1 WHERE attrition = 'yes') * 100.0 / (SELECT COUNT(*) FROM hr2) AS attrition_rate;


-- Average working years for each department
SELECT 
	hr1.department, 
    avg(hr2.yearsatcompany) as Avg_Working_Years
FROM 
	hr1
INNER JOIN 
	hr2
ON 
	hr1.EmployeeNumber=hr2.employeeid
GROUP BY 
	hr1.department;


-- Average Attrition rate for all Departments
SELECT
    department,
    SUM(CASE WHEN attrition = 'yes' THEN 1 ELSE 0 END) / CAST(COUNT(*) AS FLOAT) * 100 AS attrition_rate
FROM
    hr1
GROUP BY
    department;
    
    
-- Average Hourly rate of Male Research Scientist
SELECT 
	AVG(hourlyrate) 
FROM 
	hr1
WHERE
	gender="Male" and
    jobrole="Research Scientist";


-- Attrition rate Vs Monthly income stats
SELECT 
	Department, 
	FORMAT (AVG(CASE WHEN Attrition = 'Yes' THEN MonthlyIncome END), 2)
	AS Avg_Monthly_Income,
	CONCAT(FORMAT(COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) / COUNT(*) *100, 2), '%')
	AS Attrition_Rate
FROM 
	hr1
INNER JOIN 
	hr2 on hr1.employeenumber = hr2.employeeid
GROUP BY
	department;



-- Job Role Vs Work life balance
SELECT 
	hr1.jobrole,
    AVG(hr2.worklifebalance) AS Work_Life_Balance
FROM 
	hr1
JOIN
	hr2 ON hr1.employeenumber = hr2.employeeid
GROUP BY 
	hr1.jobrole;


-- Attrition rate Vs Year since last promotion relation
SELECT
	joblevel,
    SUM(CASE WHEN hr1.attrition = 'yes' THEN 1 ELSE 0 END) / CAST(COUNT(*) AS FLOAT) * 100 AS attrition_rate,
    AVG(hr2.yearssincelastpromotion) AS avg_years_since_last_promotion
FROM
    hr1
JOIN
    hr2 ON hr1.employeenumber = hr2.employeeid
GROUP BY
	joblevel
ORDER BY 
	joblevel ASC;
    

-- Job satisfaction by age group
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '55+'
    END AS age_group,
    COUNT(*) AS count,
    JobSatisfaction
FROM
    hr1
GROUP BY
	age_group, JobSatisfaction 
ORDER BY 
	age_group ASC;


-- Average Hourly rate by Job Role
SELECT jobrole, AVG(hourlyrate)
FROM
	hr1
GROUP BY 
	jobrole;

-- count of female employees
SELECT COUNT(employeenumber) from hr1
WHERE
	gender="Female";

-- count of male employees
SELECT COUNT(employeenumber) from hr1
WHERE
	gender="Male";
    
-- count of active employees
SELECT COUNT(employeenumber) from hr1
WHERE
	attrition="No";
    
-- count of employees left
SELECT COUNT(employeenumber) from hr1
WHERE
	attrition="Yes";
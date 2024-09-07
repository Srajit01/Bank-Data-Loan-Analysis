1) Retrieve all active loans

sql
Copy code
SELECT *
FROM Loans
WHERE loan_status = 'active';

2) List all customers who have defaulted on a loan

sql
Copy code
SELECT c.customer_id, c.first_name, c.last_name, l.loan_id, l.principal_amount
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
WHERE l.loan_status = 'defaulted';

3) Find all loans with an interest rate higher than a certain threshold (e.g., 7%)

sql
Copy code
SELECT *
FROM Loans
WHERE interest_rate > 7.00;

4) Intermediate Queries
a. Calculate the total outstanding principal across all active loans
sql
Copy code
SELECT SUM(principal_amount) AS total_outstanding_principal
FROM Loans
WHERE loan_status = 'active';

5) Identify customers with multiple active loans and their total debt

sql
Copy code
SELECT c.customer_id, c.first_name, c.last_name, COUNT(l.loan_id) AS number_of_loans, SUM(l.principal_amount) AS total_debt
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
WHERE l.loan_status = 'active'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(l.loan_id) > 1;

6) Generate a list of loans that are nearing their due date (e.g., within 30 days)
sql
Copy code
SELECT l.loan_id, c.customer_id, c.first_name, c.last_name, l.end_date
FROM Loans l
JOIN Customers c ON l.customer_id = c.customer_id
WHERE l.loan_status = 'active'
AND l.end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

Advanced Queries

** Analyze the average loan amount by loan type and customer income bracket
sql
Copy code
SELECT l.loan_type, 
       CASE 
           WHEN c.income < 50000 THEN 'Low Income'
           WHEN c.income BETWEEN 50000 AND 100000 THEN 'Middle Income'
           ELSE 'High Income'
       END AS income_bracket, 
       AVG(l.principal_amount) AS avg_loan_amount
FROM Loans l
JOIN Customers c ON l.customer_id = c.customer_id
GROUP BY l.loan_type, income_bracket;

7) Determine the correlation between credit score and loan approval rate
sql
Copy code
SELECT c.credit_score, 
       COUNT(CASE WHEN la.approval_status = 'approved' THEN 1 END) * 100.0 / COUNT(*) AS approval_rate
FROM Loan_Applications la
JOIN Customers c ON la.customer_id = c.customer_id
GROUP BY c.credit_score
ORDER BY c.credit_score;

8) Identify trends in loan defaults based on customer demographics and loan characteristics
sql
Copy code
SELECT 
    CASE 
        WHEN c.age < 30 THEN 'Under 30'
        WHEN c.age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END AS age_group,
    c.gender, 
    l.loan_type, 
    COUNT(*) AS total_defaults
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
WHERE l.loan_status = 'defaulted'
GROUP BY age_group, c.gender, l.loan_type
ORDER BY total_defaults DESC;

9) Repayment Analysis
a. Calculate the total amount repaid for each loan
sql
Copy code
SELECT l.loan_id, SUM(r.amount_paid) AS total_repaid
FROM Loans l
JOIN Repayments r ON l.loan_id = r.loan_id
GROUP BY l.loan_id;
b. Identify loans with late repayments
sql
Copy code
SELECT r.repayment_id, r.loan_id, r.payment_date, r.amount_paid, r.payment_status
FROM Repayments r
WHERE r.payment_status = 'late';
c. Calculate the remaining balance for each active loan
sql
Copy code
SELECT l.loan_id, 
       l.principal_amount - IFNULL(SUM(r.amount_paid), 0) AS remaining_balance
FROM Loans l
LEFT JOIN Repayments r ON l.loan_id = r.loan_id
WHERE l.loan_status = 'active'
GROUP BY l.loan_id;

10) Risk Assessment Queries
a. Identify high-risk loans based on risk score
sql
Copy code
SELECT l.loan_id, l.customer_id, dr.risk_score, dr.risk_level
FROM Loans l
JOIN Default_Risk dr ON l.loan_id = dr.loan_id
WHERE dr.risk_level = 'high';
b. Calculate the average risk score by loan type
sql
Copy code
SELECT l.loan_type, AVG(dr.risk_score) AS avg_risk_score
FROM Loans l
JOIN Default_Risk dr ON l.loan_id = dr.loan_id
GROUP BY l.loan_type;

11) Loan Performance Analysis

a. Compare the performance of different loan types in terms of repayment rates
sql
Copy code
SELECT l.loan_type, 
       COUNT(CASE WHEN r.payment_status = 'on-time' THEN 1 END) * 100.0 / COUNT(r.repayment_id) AS on_time_payment_rate
FROM Loans l
JOIN Repayments r ON l.loan_id = r.loan_id
GROUP BY l.loan_type;
b. Analyze the average time taken to repay different types of loans
sql
Copy code
SELECT l.loan_type, 
       AVG(DATEDIFF(l.end_date, l.start_date)) AS avg_repayment_time
FROM Loans l
WHERE l.loan_status = 'repaid'
GROUP BY l.loan_type;
c. Identify the top 10 customers with the highest total loan amounts
sql
Copy code
SELECT c.customer_id, c.first_name, c.last_name, SUM(l.principal_amount) AS total_loan_amount
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_loan_amount DESC
LIMIT 10;

12) Loan Officer Performance

a. Identify the loan officers managing the highest number of loans
sql
Copy code
SELECT lo.officer_id, lo.first_name, lo.last_name, COUNT(l.loan_id) AS total_loans_managed
FROM Loan_Officers lo
JOIN Loans l ON lo.officer_id = l.loan_officer_id
GROUP BY lo.officer_id, lo.first_name, lo.last_name
ORDER BY total_loans_managed DESC;
b. Analyze the default rate for loans managed by each loan officer
sql
Copy code
SELECT lo.officer_id, lo.first_name, lo.last_name, 
       COUNT(CASE WHEN l.loan_status = 'defaulted' THEN 1 END) * 100.0 / COUNT(l.loan_id) AS default_rate
FROM Loan_Officers lo
JOIN Loans l ON lo.officer_id = l.loan_officer_id
GROUP BY lo.officer_id, lo.first_name, lo.last_name;
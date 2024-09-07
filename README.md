# Bank-Data-Loan-Analysis

1. Project Overview
   
   Objective: Analyze loan data to uncover patterns, trends, and insights that can help in understanding loan performance, customer behavior, and risk assessment.
   Data Source: You can use public datasets (e.g., from Kaggle) or create a synthetic dataset that includes various aspects of loans such as customer demographics, loan details, repayment history, etc.

2. Database Schema Design
   
    Tables:
    Customers: customer_id, first_name, last_name, age, gender, marital_status, income, employment_status, credit_score, etc.
    Loans: loan_id, customer_id, loan_type, principal_amount, interest_rate, loan_term, start_date, end_date, loan_status (e.g., active, repaid, defaulted), etc.
    Repayments: repayment_id, loan_id, payment_date, amount_paid, payment_status (e.g., on-time, late), etc.
    Loan_Applications: application_id, customer_id, loan_type, application_date, approval_status, approved_amount, application_reason, etc.

3. Data Ingestion
   
   Populate the tables with sample data using SQL INSERT INTO commands. Ensure the data includes a mix of loan types (e.g., personal, auto, mortgage), various customer demographics, and different loan 
   statuses.

4. SQL Queries
   Basic Queries:
   Retrieve all active loans.
   List all customers who have defaulted on a loan.
   Find all loans with an interest rate higher than a certain threshold.
   Intermediate Queries:
   Calculate the total outstanding principal across all loans.
   Identify customers with multiple active loans and their total debt.
   Generate a list of loans that are nearing their due date.
   Advanced Queries:
   Analyze the average loan amount by loan type and customer income bracket.
   Determine the correlation between credit score and loan approval rate.
   Identify trends in loan defaults based on customer demographics and loan characteristics.

5. Data Analysis
   
   Loan Performance: Analyze the performance of different loan types in terms of repayment rates, defaults, and average interest rates.
   Customer Risk Assessment: Segment customers based on credit score, income, and employment status to identify high-risk groups.
   Repayment Behavior: Examine repayment patterns to identify trends such as late payments and early repayments.

6. Visualization
   
   Use tools like Tableau, Power BI, or Python (Matplotlib, Seaborn) to create visualizations such as:
   Loan Distribution: Bar chart showing the distribution of loans by type.
   Default Rate: Line graph showing the trend of loan defaults over time.
   Repayment Analysis: Heatmap of repayment behavior across different customer segments.

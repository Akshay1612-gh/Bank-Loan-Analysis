select * from financial_loan;

--What is the average loan_amount and interest_rate for each verification_status?--
SELECT verification_status, 
AVG(loan_amount) AS avg_loan_amount, 
AVG(int_rate) AS avg_interest_rate
FROM financial_loan 
GROUP BY verification_status;


--What is the median annual_income of borrowers in each loan_status category?--
SELECT loan_status, 
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY annual_income) AS median_income
FROM financial_loan
GROUP BY loan_status;


--How has the total loan issuance (loan_amount) changed by year?--
SELECT issue_date AS year, SUM(loan_amount) AS total_loan_amount 
FROM financial_loan
GROUP BY issue_date
ORDER BY year;


--Which state (address_state) has the highest average annual_income for defaulted loans?--
SELECT address_state, 
AVG(annual_income) AS avg_income_for_defaults
FROM loans 
WHERE loan_status = 'Default'
GROUP BY address_state
ORDER BY avg_income_for_defaults DESC;


--What is the distribution of loan_status by term (e.g., 36 months, 60 months)?--
SELECT term, loan_status, COUNT(*) AS loan_count 
FROM financial_loan 
GROUP BY term, loan_status 
ORDER BY term, loan_status;



--Identify the top 3 sub-grades with the highest default rates.--
SELECT sub_grade, 
COUNT(*) AS total_loans, 
SUM(CASE WHEN loan_status = 'Default' THEN 1 ELSE 0 END) AS default_count, 
(SUM(CASE WHEN loan_status = 'Default' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS default_rate
FROM financial_loan
GROUP BY sub_grade
ORDER BY default_rate DESC;



--What is the total expected interest income for each loan grade?--
SELECT grade, 
SUM(loan_amount * (int_rate / 100)) AS total_interest_income
FROM financial_loan 
GROUP BY grade;



--What is the average dti and annual_income for borrowers with the most common emp_title (job title)?--
SELECT emp_title, 
COUNT(*) AS emp_count, 
AVG(dti) AS avg_dti, 
AVG(annual_income) AS avg_income
FROM financial_loan 
GROUP BY emp_title
ORDER BY emp_count DESC;



--How many loans have a next_payment_date in the past (indicating they are overdue)?--
SELECT COUNT(*) AS overdue_loans 
FROM financial_loan
WHERE next_payment_date < CURRENT_DATE;
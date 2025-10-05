-- 1. Overall Churn Rate
SELECT 
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent
FROM telco_churn;
-- 2. Churn by Contract Type
SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(churn) AS churned_customers,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent
FROM telco_churn
GROUP BY contract
ORDER BY churn_rate_percent DESC;
-- 3. Churn by Internet Service
SELECT 
    internetservice,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent,
    COUNT(*) AS total_customers
FROM telco_churn
GROUP BY internetservice
ORDER BY churn_rate_percent DESC;
-- 4. Churn by Payment Method
SELECT 
    paymentmethod,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent
FROM telco_churn
GROUP BY paymentmethod
ORDER BY churn_rate_percent DESC;
-- 5. Avg Monthly/Total Charges for Churned vs Non-Churned
SELECT 
    churn,
    ROUND(AVG(monthlycharges), 2) AS avg_monthly_charges,
    ROUND(AVG(totalcharges), 2) AS avg_total_charges,
    ROUND(AVG(tenure), 2) AS avg_tenure
FROM telco_churn
GROUP BY churn
ORDER BY churn DESC;
-- 6. Churn by Tenure Range
SELECT 
    CASE 
        WHEN tenure < 12 THEN '0–1 year'
        WHEN tenure BETWEEN 12 AND 24 THEN '1–2 years'
        WHEN tenure BETWEEN 25 AND 48 THEN '2–4 years'
        ELSE '4+ years'
    END AS tenure_group,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent,
    COUNT(*) AS total_customers
FROM telco_churn
GROUP BY tenure_group
ORDER BY churn_rate_percent DESC;
-- 7. Churn by Senior Citizen Status
SELECT 
    seniorcitizen,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent,
    COUNT(*) AS total_customers
FROM telco_churn
GROUP BY seniorcitizen
ORDER BY churn_rate_percent DESC;
-- 8. Churn vs Paperless Billing
SELECT 
    paperlessbilling,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent
FROM telco_churn
GROUP BY paperlessbilling
ORDER BY churn_rate_percent DESC;
-- 9. Churn by Partner and Dependents
SELECT 
    partner,
    dependents,
    ROUND(AVG(churn::numeric) * 100, 2) AS churn_rate_percent
FROM telco_churn
GROUP BY partner, dependents
ORDER BY churn_rate_percent DESC;

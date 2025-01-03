SELECT *
FROM telco_eda.customer_info;

SELECT *
FROM telco_eda.location_data;

SELECT *
FROM telco_eda.online_services;

SELECT *
FROM telco_eda.payment_info;

SELECT *
FROM telco_eda.service_options;

SELECT *
FROM telco_eda.status_analysis;

-- Let's first calculate how many customers churned

SELECT *
FROM telco_eda.status_analysis
ORDER BY churn_value DESC;

SELECT COUNT(*)
FROM telco_eda.status_analysis
WHERE churn_value = 0;

-- 1869 customers have churned this quarter, as opposed to 5174 who either stayed or joined.

SELECT COUNT(*)
FROM telco_eda.status_analysis
WHERE customer_status = 'Joined';
-- The number of new customers is 454, which is much less than 1869 customers who left, pointing to a major warning sign--

-- What is the main reason for customers leaving?

SELECT COUNT(*)
FROM telco_eda.status_analysis
WHERE churn_value = 1 AND churn_category = 'Price';
-- THe number of customers who cited 'price' as their reason for leaving was 211.

SELECT COUNT(*)
FROM telco_eda.status_analysis
WHERE churn_value = 1 AND churn_category = 'Competitor';
-- THe number of customers who cited 'competitor' as their reason for leaving was 841.

SELECT COUNT(*)
FROM telco_eda.status_analysis
WHERE churn_value = 1 AND churn_category = 'Attitude';
-- THe number of customers who cited 'attitude' as their reason for leaving was 314.

SELECT COUNT(*)
FROM telco_eda.status_analysis
WHERE churn_value = 1 AND churn_category = 'Dissatisfaction';
-- THe number of customers who cited 'dissatisfaction' as their reason for leaving was 303.

SELECT COUNT(*)
FROM telco_eda.status_analysis
WHERE churn_value = 1 AND churn_category = 'Other';
-- The number of customers who cited 'other' as their reason for leaving was 200.  Clearly, the most major reason for customers leaving is because of 'competitors.'

-- Now, can we use satisfaction score and churn score to predict whether customers will leave?

SELECT AVG(satisfaction_score)
FROM telco_eda.status_analysis
WHERE customer_status = 'Joined';

SELECT AVG(satisfaction_score)
FROM telco_eda.status_analysis
WHERE customer_status = 'Churned';

SELECT AVG(satisfaction_score)
FROM telco_eda.status_analysis
WHERE customer_status = 'Stayed';

-- Satisfaction of those who just joined are the greatest followed by those who stayed. Those who churned approve the least.

SELECT AVG(churn_score)
FROM telco_eda.status_analysis
WHERE customer_status = 'Joined';

SELECT AVG(churn_score)
FROM telco_eda.status_analysis
WHERE customer_status = 'Churned';

SELECT AVG(churn_score)
FROM telco_eda.status_analysis
WHERE customer_status = 'Stayed';

-- A similar trend emerges as before when looking at churn_scores

select gender, AVG(statID.churn_score)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY gender
ORDER BY AVG(statID.churn_score) DESC;

select gender, COUNT(CASE WHEN statID.churn_value = 0 THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY gender
ORDER BY AVG(statID.churn_score) DESC;

-- Churn scores of men and women are roughly identical.

select customer_status, AVG(custominfo.age)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY customer_status;

-- Though the average ages of all three groups are roughly the same, it does appear that those who joined are younger, compared to those who stayed and churned.

select dependents, COUNT(CASE WHEN statID.churn_value = 0 THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY dependents;

select dependents, COUNT(CASE WHEN statID.churn_value = 1 THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY dependents;

-- Those who live without dependents churn at a greater rate(0.326) versus those who do live with dependents(0.07).

SELECT churn_value, AVG(age)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY churn_value;

-- The average age of those who churn and do not church is roughly identical (45 for not churning, 49 for churning).

SELECT churn_value, COUNT(CASE WHEN senior_citizen = 'Yes' THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY churn_value;

SELECT churn_value, COUNT(CASE WHEN senior_citizen = 'No' THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.customer_info custominfo ON statID.customer_id = custominfo.customer_id
GROUP BY churn_value;

-- The churn rate of those who are senior citizens is greater than those who are not (0.42 versus 0.24).

SELECT churn_value, AVG(tenure)
FROM telco_eda.status_analysis statID
JOIN telco_eda.service_options servop ON statID.customer_id = servop.customer_id
GROUP BY churn_value;

-- The average tenure of those who stay is 38 months, while the average of those who have churned is 18, meaning that typically those who stayed have been longer customers.

SELECT churn_value, COUNT(CASE WHEN phone_service = 'No' THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.service_options servop ON statID.customer_id = servop.customer_id
GROUP BY churn_value;

SELECT churn_value, COUNT(CASE WHEN phone_service = 'Yes' THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.service_options servop ON statID.customer_id = servop.customer_id
GROUP BY churn_value;

-- The churn rate of those who have and don't have phone service is rather similar (0.25 for no phone service, 0.27 for phone service).

SELECT churn_value, COUNT(CASE WHEN multiple_lines = 'No' THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.service_options servop ON statID.customer_id = servop.customer_id
GROUP BY churn_value;

SELECT churn_value, COUNT(CASE WHEN multiple_lines = 'Yes' THEN 1 END)
FROM telco_eda.status_analysis statID
JOIN telco_eda.service_options servop ON statID.customer_id = servop.customer_id
GROUP BY churn_value;
-- The churn rate of those who have and don't have multiple lines of service is rather similar (0.25 for single line, 0.29 for multiple lines).
-- Now, let's determine if increased extra charges result in higher churning rates.

SELECT churn_value, AVG(total_extra_data_charges)
FROM telco_eda.status_analysis statID
JOIN telco_eda.payment_info payinfo ON statID.customer_id = payinfo.customer_id
GROUP BY churn_value;


-- The extra charges for those who churned was higher than those who did not churn by roughly (6.75 versus 7.16).




















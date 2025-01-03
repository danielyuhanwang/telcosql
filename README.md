# telcosql

In this project, I performed exploratory data analysis in SQL with CRUD, sorting, filtering, aggregate, and join functions on a Telco customer churn dataset in derive data-driven insight to answer the question: "Why are customers leaving this Telco company?" Then, I visualized interesting insights by creating a Tableau dashboard to present business insights and suggestions in a visually-appealing manner.

# Description of each file

Customer_Info.csv -> contains information about customer demographics.
Location_Data.csv -> contains information about location of customers.
Online_Services.csv -> contains information about which services customers use.
Payment_Info.csv -> contains information about charges and payment.
Service_Options.csv -> contains information related to tenure in months, referral information, monthly download volume, status of marketing offers, phone service, etc.
Status_Analysis.csv -> contains information related to satisfaction, whether customer churned or not, whether customer joined, and churn score(Value from 0-100 indicating likelihood to churn based on predictive IBM SPSS modeler).
a_IBM Telco Customers Churn Datasets.xlsx -> Excel file containing entire dataset.
Telco_Analysis.sql -> My SQL data analysis code.

#  Summary of Findings

My analysis found that while 1869 customers left this quarter, only 454 customers joined. A plurality of those who churned cited 'competitor' as their reason for leaving. While the churn rate of men and women are roughly identical, those who recently joined are typically younger, and the churn rate of senior citizens(65 +) is higher than those who are not senior citizens. In addition, those who live without dependents churn at a greater rate than those who do, and those who have a longer tenure at the company have a lower churn rate.

# Acknowledgements

Data was taken from Hassan El Fattmi's Kaggle notebook "Why do customers leave? Can you spot the churners?": https://www.kaggle.com/datasets/hassanelfattmi/why-do-customers-leave-can-you-spot-the-churners/data?select=Service_Options.csv



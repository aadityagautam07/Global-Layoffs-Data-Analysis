📊 Global Layoffs Data Analysis (2020-2023)
A comprehensive SQL-based data analysis project exploring global workforce layoff trends across industries, companies, and geographic regions. This project demonstrates end-to-end data analysis skills including data cleaning, exploratory data analysis (EDA), and deriving actionable business insights.
🎯 Project Objective
Analyze global layoff data from 2020-2023 to identify:

Industries and companies most affected by workforce reductions
Geographic patterns and temporal trends in layoffs
Correlation between company funding stages and layoff decisions
Monthly and yearly layoff trends with rolling totals

📁 Dataset
Source: Kaggle - Layoffs Dataset
Dataset Details:

Records: 2,000+ entries
Time Period: 2020 - 2023
Columns: Company, Location, Industry, Total Laid Off, Percentage Laid Off, Date, Stage, Country, Funds Raised (Millions)

🛠️ Technologies Used

Database: MySQL
Language: SQL
Techniques:

Window Functions (ROW_NUMBER, DENSE_RANK, SUM OVER)
Common Table Expressions (CTEs)
Self Joins
Aggregate Functions
Date Functions & String Manipulation



📋 Project Workflow
1️⃣ Data Cleaning (01_data_cleaning.sql)
Steps Performed:

✅ Duplicate Removal: Used ROW_NUMBER() with PARTITION BY to identify and remove duplicate records
✅ Data Standardization:

Trimmed whitespace from company names
Standardized industry names (e.g., 'Crypto Currency' → 'Crypto')
Cleaned country names (removed trailing periods)


✅ Date Formatting: Converted text dates to proper DATE format using STR_TO_DATE()
✅ Null Value Handling:

Used self-joins to populate missing industry values
Removed records with null values in critical fields


✅ Schema Optimization: Created staging tables for safe data manipulation

2️⃣ Exploratory Data Analysis (02_exploratory_analysis.sql)
Key Analyses:
📈 Aggregate Insights

Maximum layoffs and percentage by company
Total layoffs by industry, country, and year
Companies with 100% workforce reduction

📅 Temporal Analysis

Monthly layoff trends using SUBSTRING and GROUP BY
Rolling totals calculated with window functions
Year-over-year comparison

🏆 Ranking Analysis

Top 5 companies with highest layoffs per year
Used DENSE_RANK() partitioned by year
Nested CTEs for complex ranking logic

🔍 Key Findings
Industry Impact

Most Affected Industry: [Add your finding - e.g., "Consumer with 45,000+ layoffs"]
Tech Sector: Significant workforce reductions across multiple sub-industries
Crypto Industry: Standardized analysis revealed concentrated impact

Geographic Distribution

Top Countries: United States, India, Netherlands (based on total layoffs)
Regional Patterns: [Add specific insights from your analysis]

Temporal Trends

Peak Period: [Add your finding - e.g., "Q1 2023 saw highest monthly layoffs"]
Rolling Total Analysis: Demonstrated cumulative impact over 36+ months
Year-over-Year: [Add comparison between 2020, 2021, 2022, 2023]

Company-Specific Insights

100% Layoffs: Multiple well-funded startups closed completely
Top Layoff Companies: Amazon, Google, Meta led in absolute numbers
Funding Correlation: Companies with higher funding rounds also had larger layoffs

📊 SQL Techniques Demonstrated
Window Functions
sql-- Rolling total calculation
SUM(total_off) OVER(ORDER BY `month`) as rolling_total

-- Ranking companies by year
DENSE_RANK() OVER (PARTITION BY Years ORDER BY Total_laid_off DESC) as Ranking
Common Table Expressions (CTEs)
sqlWITH Rolling_Total AS (
    SELECT SUBSTRING(`date`,1,7) as `month`, SUM(total_laid_off) as total_off
    FROM layoffs_staging2
    WHERE `date` IS NOT NULL
    GROUP BY `month`
)
SELECT `month`, total_off, 
       SUM(total_off) OVER(ORDER BY `month`) as rolling_total
FROM Rolling_Total;
Self-Joins for Data Imputation
sqlUPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

🚀 How to Use This Project
Prerequisites

MySQL Server (8.0 or higher recommended)
MySQL Workbench or any SQL client

Steps to Run

Clone the repository

bash   git clone https://github.com/yourusername/layoffs-data-analysis.git
   cd layoffs-data-analysis

Import the dataset

Create a new database in MySQL
Import layoffs.csv into a table named layoffs


Execute SQL scripts

sql   -- Run data cleaning first
   SOURCE sql/01_data_cleaning.sql;
   
   -- Then run EDA
   SOURCE sql/02_exploratory_analysis.sql;

Explore the results

Review query outputs
Modify queries for custom analysis



💡 Key Learnings

Data Quality Matters: Spent significant time cleaning and standardizing data before analysis
Window Functions Power: Rolling totals and rankings provided deeper insights than simple aggregations
Staging Tables: Using staging tables prevented data loss and allowed iterative cleaning
Business Context: Raw numbers gain meaning when analyzed across dimensions (time, geography, industry)

🎓 Skills Demonstrated

✅ SQL Query Optimization
✅ Data Cleaning & Transformation
✅ Exploratory Data Analysis (EDA)
✅ Statistical Analysis
✅ Business Intelligence
✅ Data Storytelling

📈 Future Enhancements

 Create interactive dashboard using Tableau/Power BI
 Add Python analysis with Pandas for advanced statistics
 Implement predictive modeling for layoff trends
 Incorporate additional datasets (stock prices, funding rounds)
 Automate data pipeline with scheduled updates

👨‍💻 Author
Aaditya Gautam

📧 Email: Aadityagautam06@gmail.com
💼 LinkedIn: Your LinkedIn Profile
🐙 GitHub: @yourusername

📄 License
This project is open source and available under the MIT License.
🙏 Acknowledgments

Dataset provided by Kaggle Community
Inspired by real-world data analysis challenges in HR analytics


⭐ If you found this project helpful, please consider giving it a star!
📫 Questions or suggestions? Feel free to open an issue or reach out!

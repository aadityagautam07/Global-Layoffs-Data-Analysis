-- Data Cleaning

show tables;

select *
from layoffs;


-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values pr blank Values
-- 4. Remove Any columns


Create table layoffs_staging
like layoffs;

insert layoffs_staging
select * 
from layoffs;

select *
from layoffs;

select *,
row_number() over(
partition by company, industry, total_laid_off, percentage_laid_off,`Date`) as row_num
from layoffs_staging;

select * 
from layoffs_staging
where company = "Casper"
;

		-- Writing a CTE to find all duplicates

with duplicate_cte as
(
select *,
row_number() over(
partition by company, industry, total_laid_off, 
percentage_laid_off,`Date`,stage
,country,funds_raised_millions) as row_num
from layoffs_staging
)
select * from duplicate_cte
where row_num > 1;



	-- Creating another Staging Table with a extra column row_num to perform operation
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from layoffs_staging2
where row_num >1
;
	-- inserting entries into new table with partitioning over all field to number duplicate enties
insert into layoffs_staging2
select *,
row_number() over(
partition by company, industry, total_laid_off, 
percentage_laid_off,`Date`,stage
,country,funds_raised_millions) as row_num
from layoffs_staging
;

delete
from layoffs_staging2
where row_num >1
;

select *
from layoffs_staging2
where row_num >1
;

select *
from layoffs_staging2
;

-- Standardizing Data
		
        -- Removing extra spaces in company col
select company ,trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

	-- removing like names from industry
Select distinct industry
from layoffs_staging2
order by 1;

Select *
from layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

	-- -- removing like names from country
select distinct country
from layoffs_staging2
order by 1;


		-- Trim attribute for removing last character.
select distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;
		
update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%'
;

	-- For time series updations (Changing text to DATETIME)
select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y')
;

Select `date`
from layoffs_staging2;

	-- we got the input in datetime format now we'll change in datetime format
  Alter table laydatedateoffs_staging2
  modify column `date` date;
  
  -- Removing NULL Values
  
  select *
  from layoffs_staging2;
  
  Select *
  from layoffs_staging2
  where total_laid_off is null
  and percentage_laid_off is null;
  
  Select *
  from layoffs_staging2
  where industry is null
  or industry = '';
  
  update layoffs_staging2
  set industry = null
  where industry = '';
  
  select *
  from layoffs_staging2
  where company = 'Airbnb';
  
		-- populating the null values with the same identities
  select *
  from layoffs_staging2 t1
  join layoffs_staging2 t2
	on t1.company = t2.company
	and t1.location = t2.location
  where t1.industry is null 
  and t2.industry is not null;

	-- Simplified what we were searching for
select t1.company,t1.industry,t2.industry
  from layoffs_staging2 t1
  join layoffs_staging2 t2
	on t1.company = t2.company
	and t1.location = t2.location
  where t1.industry is null
  and t2.industry is not null;
  
		-- Now we will update the null values
        
update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
	and t1.location = t2.location
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;
  
  
Select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

Delete 
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select *
from layoffs_staging2;

alter table layoffs_staging2
drop column row_num;
		-- here is our whole cleaned data
-- Exploratory Data Analysis

select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

	-- company with most funds raised did all layoff
select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

	-- which company did most layoff
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

	-- layoff started from to till
select min(`date`), max(`date`)
from layoffs_staging2;

	-- what industry was most hit with layoff
select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;
	
	-- which country did most layoffs
select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

	-- on which year most layoffs were done
select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

	-- substring(column_name,starting_from,how_many_character)
select substring(`date`,1,7) as `month`, sum(total_laid_off)  
from layoffs_staging2
where `date` is not null
group by `month`
order by 1 asc;

	-- find the rolling total for the same
with Rolling_Total as
(
	select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off 
	from layoffs_staging2
	where `date` is not null
	group by `month`
	order by 1 asc
)
select `month` , total_off,
sum(total_off) over(order by `month`) as rolling_total
from Rolling_Total;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

	-- year by year layoff by companies
select company,year(`date`),sum(total_laid_off) 
from layoffs_staging2
group by company,year(`date`)
order by 1 asc;

	-- let's rank them based on layoff
with Ranking_layoff (Company, Years,Total_laid_off) as
(
	select company,year(`date`),sum(total_laid_off)
	from layoffs_staging2
	group by company,year(`date`)
), Company_year_rank as
(select * ,dense_rank() over (partition by Years order by Total_laid_off desc) as Ranking
from Ranking_layoff
where Years is not null
)
select *
from Company_year_rank
where Ranking <=5;
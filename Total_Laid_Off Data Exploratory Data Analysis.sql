-- Exploratory Data Analysis

select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1;

select COUNT(percentage_laid_off)
from layoffs_staging2
where percentage_laid_off = 1;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off DESC;

select company, sum(total_laid_off)
from layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- When was the time frame of this report of layoffs

SELECT min(`date`), max(`date`)
from layoffs_staging2;

SELECT company, count(*) as occurrences
from layoffs_staging2
GROUP BY 1;

-- How many in total people were laid off in each Industry

select industry, sum(total_laid_off)
from layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

select *
from layoffs_staging2;

select country, sum(total_laid_off)
from layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

select `date`, sum(total_laid_off)
from layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;


select stage, sum(total_laid_off)
from layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC;

select company, sum(total_laid_off)
from layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT substring(`date`,1,7) as `month`, sum(total_laid_off) total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
GROUP BY `month`
order by 1 asc;

with Rolling_Total as
(
SELECT substring(`date`,1,7) as `month`, sum(total_laid_off) total_off
from layoffs_staging2
where substring(`date`,1,7) is not null
GROUP BY `month`
order by 1 asc
)
select `month`, total_off, sum(total_off) over(ORDER BY `month`) as rolling_total
from Rolling_Total;

select company, Year(`date`), sum(total_laid_off)
from layoffs_staging2
GROUP BY company, year(`date`)
ORDER BY 3 DESC;

with Company_Year (company, years, total_laid_off) as
(
select company, Year(`date`), sum(total_laid_off)
from layoffs_staging2
GROUP BY company, year(`date`)
), Company_Year_Rank as
(Select *, DENSE_RANK() over (PARTITION BY years ORDER BY total_laid_off DESC) as Ranking
from Company_Year
where years is not null
)
select *
from Company_Year_Rank
where Ranking <= 5
order by years;








































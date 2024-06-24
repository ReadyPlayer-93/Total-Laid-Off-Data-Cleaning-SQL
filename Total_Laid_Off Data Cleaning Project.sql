-- DATA CLEANING PROJECT

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove Any Columns

CREATE TABLE layoffs_staging
LIKE layoffs;


CREATE TABLE layoffs_staging
LIKE layoffs_staging;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

SELECT *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;


with duplicate_cte as
(
SELECT *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
select *
from duplicate_cte
where row_num > 1;

SELECT *
FROM layoffs_staging
where company = 'Casper';


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
from layoffs_staging2;

insert into layoffs_staging2
SELECT *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;

select *
from layoffs_staging2
where row_num > 1;

delete
from layoffs_staging2
where row_num > 1;


select *
from layoffs_staging2;

-- Standardizing data

select company, trim(company)
from layoffs_staging2;


UPDATE layoffs_staging2
set company = trim(company);

select *
from layoffs_staging2
where industry like 'Crypto%';

UPDATE layoffs_staging2
set company = trim(company);

select DISTINCT country
from layoffs_staging2
order by 1;

select DISTINCT country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y');

Select *
From layoffs_staging2;

alter table layoffs_staging2
modify COLUMN `date` date; 

Select *
From layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

Select *
From layoffs_staging2
where industry is null
or industry = '';

Select *
From layoffs_staging2
where company = 'Airbnb';

select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;

UPDATE layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';

select *
from layoffs_staging2;

Select *
From layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

DELETE
From layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

Select *
From layoffs_staging2;

alter table layoffs_staging2
drop COLUMN row_num;
























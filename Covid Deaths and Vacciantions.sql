select *
from Portfolio..[Covid Deaths]
where continent is not null
order by 3,4

--select *
--from Portfolio.. [covid vaccinations]
--order by 3,4


select location, date, total_cases, new_cases, total_deaths, population
from Portfolio..[Covid Deaths]
order by 1,2

-- total cases vs total deaths
-- shows the likihood of dying if you contract covid in your country

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from Portfolio..[Covid Deaths]
where location like '%states%'
order by 1,2

-- looking at the total cases vs population
-- shows the percentage of the population got covid
select location, date, total_cases, population, (total_cases/population)*100 as infectionpercentage
from Portfolio..[Covid Deaths]
where location like '%states%'
order by 1,2

-- looking at countries with highest infection rate
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as infectionpop
from Portfolio..[Covid Deaths]
--where location like '%states%'
group by location, population
order by infectionpop desc

-- showing countries with highest death count per population

select location, population, max(total_deaths) as HighestDeathCount, max((total_deaths/population))*100 as Deathsperpop
from Portfolio..[Covid Deaths]
--where location like '%states%'
group by location, population
order by Deathsperpop desc

-- total deaths
select location, max(cast(total_deaths as int)) as TotalDeathCount
from Portfolio..[Covid Deaths]
--where location like '%states%'
where continent is not null
group by location
order by TotalDeathCount desc

-- BY CONTINENT
select continent, max(cast(total_deaths as int)) as TotalDeathCount
from Portfolio..[Covid Deaths]
--where location like '%states%'
where continent is not null
group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS
select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) as deathpercentage
from Portfolio..[Covid Deaths]
--where location like '%states%'
where continent is not null
group by date
order by 1,2



-- GLOBAL DEATHS

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) as deathpercentage
from Portfolio..[Covid Deaths]
--where location like '%states%'
where continent is not null
--group by date
order by 1,2


--looking at total population vs vaccination

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from Portfolio..[Covid Deaths] dea
join Portfolio .. [covid vaccinations] vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

--total vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.date) as vacpeople
from Portfolio ..[Covid Deaths] dea
join Portfolio .. [covid vaccinations] vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3
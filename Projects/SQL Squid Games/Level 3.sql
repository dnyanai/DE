-- we need data from past 20 years and the temp is available only in months 
-- so we need the different shape's hottest (max temp) and coldest (min temp) avg completion time

-- we will join these two tables using month 

with monthly_temp as (
  (select
	  month,
	  avg_temperature, 
	  'hottest' as weather
	from monthly_temperatures
	order by avg_temperature desc
	limit 1)
  union all
	(select
	  month, 
	  avg_temperature as temp,
	  'coldest' as weather
	from monthly_temperatures
	order by avg_temperature asc
	limit 1)),
filtered_data as (
	select 
  		shape, 
  		average_completion_time, 
  		date, 
--  		extract("year" from date) - 20 as yyyy, 	
--  		extract("year" from date) as yr,
  		extract ("month" from date) as mnth
  	from honeycomb_game)
select 
	 fdata.shape, 
	 extract("month" from fdata.date) as mnth, 
	round(avg(fdata.average_completion_time),2)
	from filtered_data as fdata
	 	join monthly_temp mtemp 
	 		on mtemp.month = fdata.mnth
	 where fdata.date >= current_date - interval '20 year'
	group by 1, 2
	 order by 2
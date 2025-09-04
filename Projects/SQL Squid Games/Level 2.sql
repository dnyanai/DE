-- Lets find out how many alive non insider players are there? and they need to be rounded?
-- 399, 90% of 399 = 90/100 x 399 = 90 / 100 x 400 = 36 so for 399 
-- => 90/100 x 399 =  35.91 rounded to 36

With staging_data as (
select 
  	distinct *, 
  	(select * from rations) as available_rations
from player p 
where status = 'alive' 
and isInsider = false)


select 
	*, 
	row_number() OVER(),
	floor(0.9 * available_rations), 
	case
		when row_number() OVER()  <= floor(0.9 * available_rations) 
			  then true else false end as IsSupplySufficient
from staging_data;
              
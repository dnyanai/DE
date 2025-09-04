
with supp_w_mstFailures as (
  	select 
	  e.supplier_id, 
  	  s.name, 
	  e.game_type
	from failure_incidents f 
		join equipment e
			on f.failed_equipment_id = e.id 
  		join suppliers s 
  			on s.id = e.supplier_id
	where 
		e.installation_date < f.failure_date
	group by 1,2,3
	order by count(f.failure_date) desc
	limit 1),
first_failures as (
    select 
  		e.id,
  		min(f.failure_date) as first_failure
  	from equipment e
  		join failure_incidents f
  			on f.failed_equipment_id = e.id
	where 
		e.supplier_id = (select supplier_id from supp_w_mstFailures)
	group by 1)
select floor(avg((f.first_failure - e.installation_date)/ 365.2425)) as avg_
from first_failures f
  		join equipment e 
  				on e.id = f.id 
-- teams of 10 players?
With avg_age as (
  select 
	team_id, 
	round(avg(age),2) as avg_age,
  	case
  		when 	round(avg(age),2) < 40 then 'Fit' 
  		when	round(avg(age),2) >= 40 and	round(avg(age),2) <= 50 then 'Grizzled'
		else 	'Elderly'
  	end as age_group
from player
where status = 'alive'
group by team_id)
select 
	*,
	dense_rank() OVER(order by avg_age desc) AS team_rank
from avg_age
              
with deets_plyr456 as (
select 
  	t.id, 
  	t.player_id, 
  	count(*) as num_convs
  from 
  	(select 
  		player1_id as id, 
  		player2_id as player_id
	from daily_interactions
	where
	  player1_id = 456

	union all 

	select 
		  player2_id as id, 
		  player1_id as player_id
	from daily_interactions
	where
	  player2_id = 456) as t
  group by 1,2
	order by 3 desc
	limit 1)
select  p.first_name as player1_name, p2.first_name as player2_name, d.num_convs
from deets_plyr456 d
	join player p
		on p.id = d.id
	join player p2 
		on p2.id = d.player_id 
	where 
		p2.status = 'alive'

	
		
		
  



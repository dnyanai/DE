with highest_avg_game as (
  select 
		game_id,
  		avg(coalesce(last_moved_time_seconds, 0.00)) as game_hesitation_time
  from player p 
  where 
  		lower(p.death_description) like '%pushed%'
  		and p.survived = false
  group by 1
	order by game_hesitation_time desc
  limit 1)
  select
		p.id,
		p.first_name, 
		p.last_name, 
		p.last_moved_time_seconds as hesitation_time
  from player p
	join highest_avg_game g 
			on g.game_id = p.game_id
  where 
		lower(p.death_description) like '%pushed%'
  order by hesitation_time  desc
  limit 1
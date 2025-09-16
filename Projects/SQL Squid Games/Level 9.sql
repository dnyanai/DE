with latest_game as (
  select 
	date, 
	start_time, 
	end_time 
  from game_schedule
  where 
  	lower(type) = 'squid game'
  order by date desc
  limit 1),
culprit as (
	select 
  	g.id as guard_id, 
  	g.assigned_post,
  	g.shift_start, 
  	g.shift_end, 
  	l.access_time, 
  	l.door_location as trespassed_location
  from guard g
  		join latest_game s
  			on g.shift_start < s.end_time and g.shift_end > s.start_time
  left join daily_door_access_logs l
  			on l.guard_id = g.id 
	where 
  		l.access_time between g.shift_start and g.shift_end
		and g.assigned_post != l.door_location),
culprit_associates as(
  select 
		g.id as guard_id, 
		l.access_time 
  from daily_door_access_logs l
		join guard g
			on l.guard_id = g.id 
		 join culprit c
			on l.door_location = c.trespassed_location 
				and g.id != c.guard_id
  		 join latest_game s
			on l.access_time between  s.start_time and s.end_time)
select *
from culprit_associates

		

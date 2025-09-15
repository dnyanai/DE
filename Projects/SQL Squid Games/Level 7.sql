select 
	g.id as guard_num,   
	g.code_name, 
	g.status, 
	r.last_check_time as LastSeenInRoom, 
	c.movement_detected_time as SpottedOutsideRoomTime, 
	c.location as SpottedOutsideRoomLocation, 
	(c.movement_detected_time - r.last_check_time) as TimeBtwRoomOutside,
	(select max(c2.movement_detected_time) - min(c2.movement_detected_time) 
	 			from camera c2
		  		where c2.guard_spotted_id is not null) as TimeRange
  from room r 
	  join guard g
		  on g.assigned_room_id = r.id 
	  left join camera c
		  on c.guard_spotted_id = g.id
  where 
	  r.isvacant = true
	  and c.movement_detected = true
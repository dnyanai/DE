select * 
from player
where status = 'alive' 
	  and debt > 400000000
      and ( age > 65 OR (lower(vice) like '%gambling'  and has_close_family = false))
              
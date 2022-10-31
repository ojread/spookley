--utils

--print outlined text
function outline(s,x,y,c1,c2)
	for i=0,2 do
	 for j=0,2 do
	  if not(i==1 and j==1) then
	   print(s,x+i,y+j,c1)
	  end
	 end
	end
	print(s,x+1,y+1,c2)
end

--change the current state
function switch_state(s)
 state=s
 state:init()
end

--rand int between a and b
function rint(a,b) 
 return flr(rnd(b-a)+a)
end

--does the map file have the flag set?
function map_flag(x,y,flag)
 return fget(mget(x,y),flag)
end

--does the table contain the value?
function contains(tbl,val)
 for item in all(tbl) do
  if item==val then
   return true
  end
 end
 return false
end

--get the entities bounding box
function abs_box(e)
 local box = {}
 box.x1 = flr(e.pos.x+e.offset.x)
 box.y1 = flr(e.pos.y+e.offset.y)
 box.x2 = flr(box.x1+e.size.x)
 box.y2 = flr(box.y1+e.size.y)
 return box
end

--are two entities colliding?
function coll(a,b)
 box_a = abs_box(a)
 box_b = abs_box(b)
 if box_a.x1 >= box_b.x2 or
  box_a.y1 >= box_b.y2 or
  box_b.x1 >= box_a.x2 or
  box_b.y1 >= box_a.y2 then
  return false
 end
 return true
end

function handle_collsion(a,b)
 if a.type=="player" and b.type=="pill" then
  game.score+=1
  sfx(0)
  tag(b,"destroy",true)
 end
 if a.type=="player" and b.type=="enemy" then
  sfx(0)
  tag(a,"destroy",true)
  tag(b,"destroy",true)
  game.lives-=1
  if game.lives>0 then
   level:spawn()
  else
   game:over()
  end
 end
end
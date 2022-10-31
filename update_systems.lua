--update systems

player_input=system({"player","vel"},function(e)
 --is player trying to turn?
 local d
 if btn(0) then d={x=-1,y=0} end
 if btn(1) then d={x=1,y=0} end
 if btn(2) then d={x=0,y=-1} end
 if btn(3) then d={x=0,y=1} end
 if d then tag(e,"turn",d) end
end)

--change direction if not blocked
turn=system({"pos","vel","turn"},function(e)
 if (e.turn.x and e.vel.x+e.turn.x==0) or (e.turn.y and e.vel.y+e.turn.y==0) then
  --u-turns are always allowed
  e.vel=e.turn
 elseif (e.pos.x%8==0 and e.pos.y%8==0) then
  --l/r turns on the grid
  local mx=e.pos.x/8+e.turn.x
  local my=e.pos.y/8+e.turn.y
  local is_solid=fget(mget(mx,my),solid)
  if (not is_solid) then
   e.vel=e.turn
  end
 end
end)

--tag entity if it hits a flagged tile
map_collisions=system({"pos", "mcoll"},function(e)
 local left=flr(e.pos.x/8)
 local top=flr(e.pos.y/8)
 local right=flr((e.pos.x+7)/8)
 local bottom=flr((e.pos.y+7)/8)
 local t0=mget(left,top)
 local t1=mget(right,top)
 local t2=mget(right,bottom)
 local t3=mget(left,bottom)
 local f0=fget(t0)
 local f1=fget(t1)
 local f2=fget(t2)
 local f3=fget(t3)
 for i=1,#e.mcoll.flags do
  local f=e.mcoll.flags[i]
  if contains({f0,f1,f2,f3},f) then
   if e.mcoll.on then
       tag(e,e.mcoll.on[i],true)
   end
   return
  else
   if e.mcoll.on then
       untag(e,e.mcoll.on[i])
   end
  end
 end
end)

--collisions between entities
ent_collisions = system({"ecoll"},function(e)
 for ecoll in all(e.ecoll) do
  local es=filter(world,"type",ecoll.type)
  for other in all(es) do
   if other!=e and coll(e,other) then
    if ecoll.on then
     tag(e,ecoll.on,true)
    else
     handle_collsion(e,other)
    end
    return
   end
  end
 end
end)

--nudge entity back to previous map pos
stop=system({"pos","vel","stop"},function(e)
 if e.vel.x>0 then
  e.pos.x=flr(e.pos.x/8)*8
 elseif e.vel.x<0 then
  e.pos.x=8+flr(e.pos.x/8)*8
 end
 if e.vel.y>0 then
  e.pos.y=flr(e.pos.y/8)*8
 elseif e.vel.y<0 then
  e.pos.y=8+flr(e.pos.y/8)*8
 end
 e.vel={x=0,y=0}
end)

--move entities with velocity
movement=system({"pos","vel"},function(e)
 e.pos.x+=e.vel.x
 e.pos.y+=e.vel.y
end)

--remove entity from the world
destroy=system({"destroy"},function(e)
 del(world,e)
end)

-- update_score=system({"player"},function(e)
--  local ui=find(world,"type","score")
--  -- printh(ui)
--  if ui then
--   ui.text="score "..e.score
--  end
-- end)

--enemy input
enemy_input=system({"enemy","vel"},function(e)
 if e.vel.x==0 and e.vel.y==0 then
  local d=rnd{{x=-0.5,y=0},{x=0.5,y=0},{x=0,y=-0.5},{x=0,y=0.5}}
  if d then tag(e,"turn",d) end
 end
end)
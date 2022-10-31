--level

level={
 w=15,
 h=15,
 min_tiles=50,
 max_tiles=80,
 max_enemies=5,
}

function level:init()
 --clear map
 for x=0,self.w do
  for y=0,self.h do
   mset(x,y,0)
  end
 end

 --prep vars
 self.pos={x=rint(1,15),y=rint(1,15)}
 self.target=nil
 self.delta=nil
 self.tiles=rint(self.min_tiles,self.max_tiles)
 self.enemies=0
end

--generate level one tile at a time until complete
function level:gen(iterations)
 if (self.target==nil) then
  --choose a new random target tile in the same row or column
  self.target={x=self.pos.x,y=self.pos.y}
  self.delta={x=0,y=0}
  if (rnd()<0.5) then
   --move in x
   self.target.x=rint(1,15)
   if self.target.x>self.pos.x then
    self.delta.x=1
   elseif self.target.x<self.pos.x then
    self.delta.x=-1
   end
  else
   --move in y
   self.target.y=rint(1,15)
   if self.target.y>self.pos.y then
    self.delta.y=1
   elseif self.target.y<self.pos.y then
    self.delta.y=-1
   end
  end
 end

 --dig out the next tile, skipping previously dug tiles
 local done=false
 repeat
  self.pos.x+=self.delta.x
  self.pos.y+=self.delta.y
  if (mget(self.pos.x,self.pos.y)~=1) then
   mset(self.pos.x,self.pos.y,1)
   --play a note based on the inverse y pos
   local offset=15-self.pos.y
   sfx(1,-1,offset,1)
   self.tiles-=1
   done=true

   --are there more tiles to be placed?
   if self.tiles>0 then
    --add a pill or enemy entity
    if rnd()<0.04 and self.enemies<self.max_enemies then
     add(world,make_enemy(self.pos.x,self.pos.y))
     self.enemies+=1
    else
     add(world,make_pill(self.pos.x,self.pos.y))
    end
    -- return false
   else
    --add the player entity on the last tile
    -- add(world,make_player(self.pos.x,self.pos.y))
    -- return true
   end

   --add walls around it
   for dx=-1,1 do
    for dy=-1,1 do
     local x=self.pos.x+dx
     local y=self.pos.y+dy
     if mget(x,y)==0 then mset(x,y,3) end
    end
   end
  end

  --reset target if reached
  if (self.pos.x==self.target.x and self.pos.y==self.target.y) then
   self.target=nil
   done=true
  end
 until (done)

 --have all tiles been placed?
 return self.tiles<1
end

function level:spawn()
 add(world,make_player(self.pos.x,self.pos.y))
end
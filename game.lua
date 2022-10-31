--game state

game={}

function game:init()
 self.level_no=0
 self.score=0
 self.lives=3
 self.state="init"
 self:next_level()
end

function game:update()
 if self.state=="generate" then
  --generate level each frame until it returns true
  if level:gen() then
   level:spawn()
   self.state="play"
  end
 elseif self.state=="play" then
  player_input(world)
  enemy_input(world)
  turn(world)
  movement(world)
  map_collisions(world)
  ent_collisions(world)
  stop(world)
  destroy(world)

  local pills=filter(world,"type","pill")
  if #pills<1 then self:next_level() end

 elseif self.state=="over" then
  turn(world)
  movement(world)
  map_collisions(world)
  ent_collisions(world)
  stop(world)
  destroy(world)

  if btnp(❎) or btnp(🅾️) then
   switch_state(intro)
  end
 end
end

function game:draw()
 cls()
 map(0,0,0,0,16,16)
 draw_sprites(world)
 draw_ui(world)

 outline("level "..self.level_no,0,0,0,7)
 outline("lives "..self.lives,43,0,0,7)

 local score=tostr(self.score)
 for i=0,4-#score do
  score="0"..score
 end

 outline("score "..score,83,0,0,7)

 if self.state=="over" then
  outline("game over!",48,52,0,7)
  outline("press z or x",48,62,0,7)
 end
end

function game:next_level()
 self.state="generate"
 self.level_no+=1
 world={}
 level:init()
end

function game:over()
 self.state="over"
end
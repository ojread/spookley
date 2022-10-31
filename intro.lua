--intro state
intro={}

function intro:init()
 print("init_title")
end

function intro:update()
 if btnp(❎) or btnp(🅾️) then
  switch_state(game)
 end
end

function intro:draw()
 cls()
 spr(43,60,20)
 print("spookley the square pumpkin",10,40,9)
 print("by thomas and ollie")
 print("")
 print("")
 print("eat all the sweets")
 print("avoid the monsters")
 print("")
 print("")
 print("press z or x to start")
end
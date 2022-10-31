--render systems

--draw sprites at pos
draw_sprites=system({"pos","sprite"},function(e)
 if _has(e,{"vel","player"}) then
  local s=e.sprite
  local fx=false
  local fy=false
  if (e.vel.x==-1) fx=true
  if (e.vel.y==-1) fy=true
  if (e.vel.x~=0) s+=1
  spr(s,e.pos.x,e.pos.y,1,1,fx,fy)
 else
  spr(e.sprite,e.pos.x,e.pos.y)
 end
end)

draw_ui=system({"ui","pos","text"},function(e)
 printh("draw_ui")
 outline(e.text,e.pos.x,e.pos.y,7,0,7)
end)

-- draw_score=system({"score","pos","state"},function(e)
--  outline("score"..e.state.score,e.pos.x,e.pos.y,7,0,7)
-- end)
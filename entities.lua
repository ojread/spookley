--entities

function make_player(x,y)
 return{
  player=true,
  type="player",
  score=0,
  pos={x=x*8,y=y*8},
  start_pos={x=x*8,y=y*8},
  size={x=8,y=8},
  offset={x=0,y=0},
  vel={x=0,y=0},
  sprite=42,
  mcoll={flags={1},on={"stop"}},
  ecoll={{type="pill"},{type="enemy"}},
 }
end

function make_pill(x,y)
 return{
  type="pill",
  pos={x=x*8,y=y*8},
  size={x=2,y=2},
  offset={x=3,y=3},
  sprite=2,
  -- ecoll={{type="player",on="destroy"}}
 }
end

function make_enemy(x,y)
 enemy_sprites={33,36,37,39,40,41,46,49,50}
 return{
  enemy=true,
  type="enemy",
  pos={x=x*8,y=y*8},
  size={x=8,y=8},
  offset={x=0,y=0},
  sprite=rnd(enemy_sprites),
  vel={x=0,y=0},
  mcoll={flags={1},on={"stop"}},
 }
end
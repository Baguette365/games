pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--main
function _init()
	px=60
	py=90
	pspeed=4
	bullet={}
	enemies={}
	create_stars()
	spawn_enemies()
end

function _update60()
 if (btn(➡️)) px+=1
 if (btn(⬅️)) px-=1
 if (btn(⬆️)) py-=1
 if (btn(⬇️)) py+=1
 if (btn(❎)) shoot()
	update_bullet()
 update_stars()
 if #enemies==0 then
 	spawn_enemies()
 end
 update_enemies()
end

function _draw()
 cls()
 --etoiles
 for s in all(stars) do
 	pset(s.x,s.y,s.col)
 end
 --joueur
 spr(1,px,py)
 --enemies
 for e in all(enemies) do
 	spr(3,e.x,e.y)
 end
 --balles
 for b in all(bullet) do
 	spr(2,b.x,b.y)
 end
end
-->8
--bullets

function shoot()
	local new_bullet={
		x=px,
		y=py,
		speed=4
	}
	add(bullet, new_bullet)
	sfx(0)
end

function update_bullet()
	for b in all(bullet) do
		b.y-=b.speed
		if (b.y<-8) del(bullet, b)
	end
end
-->8
--stars
function create_stars()
	stars={}
	for i=1,20 do
		local new_star={
			x=rnd(128),
			y=rnd(128),
			col=7,
			speed=4
		}
		add(stars, new_star)
	end
end

function update_stars()
	for s in all(stars) do
		s.y+=s.speed
		if s.y>=128 then
			s.y=0
		end
	end
end
-->8
--enemies

function spawn_enemies()
	new_enemy={
		x=60,
		y=-8,
		life=4
	}
	add(enemies, new_enemy)
end

function update_enemies()
	for e in all(enemies) do
		e.y+=0.5
		if e.y > 128 then
			del(enemies,e)
		end
		--collision
		for b in all(bullet) do
			if collision(e,b) then
				del(enemies,e)
			end
		end
	end
end
-->8
--colision
function collision(a,b)
	return not (a.x>b.x+8
													or a.y>b.y+8
													or	a.x+8>b.x
													or a.y+8>b.y)
end
__gfx__
000000000000000000a00a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000060060000a00a000bb00bb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700006006000090090000b33b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000066c76600000000003bbbb30000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000066cc66000900900034bb430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700d666666d00000000003bb300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d666666d0000000002033020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000090dd0900000000000e00e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100002d0502f0502f0502e0502d0502804021030160200e0100801005010040100401034000340003400034000340003400020000210001c7001f0001e0001e0001e20022000220001f1001c3002200023000
000200002c6502b6402a6302763026630216201f61018650106500c65000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

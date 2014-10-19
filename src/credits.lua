size = 200
zMax = 5
speed = 0.1

width = 480
height = 272

starfield = {}
math.randomseed(os.time())

function createStar(i)
  starfield[i] = {}
  starfield[i].x = math.random(2*width) - width
  starfield[i].y = math.random(2*height) - height
  starfield[i].z = zMax
end

for i = 1, size do
  createStar(i)
  starfield[i].z = math.random(zMax)
end


white = Color.new(255, 255, 0)
black = Color.new(0, 0, 0)
red= Color.new(255,0,0)

t1=275
t2 = 320
t3 = 340
t4 = 360
t5 = 380
t6 = 400
t7 = 420
t8 = 440

Text = {}
Text[1] = "Remerciements"
Text[2] = "TacticalPenguin Pour le Code MsExplorer"
Text[3] = "EvilMana Pour Ses Snippets"
Text[4] = "J3r3mie Pour les GFX "
Text[5] = "MediumGauge Pour PSPFiler"
Text[6] = "QJForums,DCEmu Forums,PSPBrew Forums"
Text[7] = "Devsgen,Xtreamlua Forums"
Text[8] = "QJNet,Gx-Mod,PSPGen,UltimatePSP,PlanetePSP,PSPGround"

while true do
  screen:clear(black)
  for i = 1, size do
    starfield[i].z = starfield[i].z - speed
    if starfield[i].z < speed then createStar(i) end
    x = width / 2 + starfield[i].x / starfield[i].z
    y = height / 2 + starfield[i].y / starfield[i].z
    if x < 0 or y < 0 or x >= width or y >= height then
      createStar(i)
    else
      screen:pixel(x, y, white)
    end
  end
  
  t1 = t1-0.8
  t2 = t2-0.8
  t3 = t3-0.8
  t4 = t4-0.8
  t5 = t5-0.8
  t6 = t6-0.8
  t7 = t7-0.8
  t8 = t8-0.8
       
  screen:print(120,t1,Text[1],red)
  screen:print(120,t2,Text[2],red)
  screen:print(120,t3,Text[3],red)
  screen:print(120,t4,Text[4],red)
  screen:print(120,t5,Text[5],red)
  screen:print(120,t6,Text[6],red)
  screen:print(120,t7,Text[7],red)
  screen:print(120,t8,Text[8],red)

  screen:print(10,262,"O: Menu",white)
  screen.waitVblankStart()
  screen.flip()

  if t6 <= -5 then dofile("menu.lua") end

  if Controls.read():circle() then
    dofile("menu.lua")
    file:close()
  end
end

boot_fond = Image.createEmpty(480,272)
boot_fond:clear(Color.new(0,0,0))

font = Font.createProportional()
font:setPixelSizes(0,13)

x = 0

--Functions
function printCenteredfont(y,text,color) 
  local length = string.len(text) 
  local x = 240 - ((length*8)/2) 
  screen:fontPrint(font,x,y,text,color) 
end 
-----------

while true do
  screen:clear()
  pad = Controls.read()

  x = x+0.53

  if x >= 100 then
    System.sleep(200)
    x = 100
    dofile("logon.lua")
  end

  if pad:cross() then dofile("ms0:/PSP/GAME/LUASYSVF/bios.lua") end

  screen:blit(0,0,boot_fond)
  screen:fillRect(190,200,x,12,Color.new(255,255,0,200))
  screen:fontPrint(font,200,225,"Chargement..."..(x) .." %" , Color.new(255,0,0))
  printCenteredfont(250,"Appuyez X Pour Passer en BIOS Mode", Color.new(255,0,0))

  screen.waitVblankStart()
  screen.flip()
end

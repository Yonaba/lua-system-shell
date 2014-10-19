macadd = Adhoc.getMac()
nickname = System.nickName()
System.sleep(100)
sysver = System.playerVer()
cfwver = System.cfwVersion()
model = System.getModel(0)
devid = "ms0:"
mssize = System.getDevSize(devid)
mssize = (mssize/1024)
mssize = (mssize/1024)

fond=Image.load("IMG/infosys.png")

temp = System.powerGetBatteryTemp() --Returns the temp of the battery
lfetime = System.powerGetBatteryLifeTime() --Returns the time left on the battery

font = Font.createProportional()
font:setPixelSizes(0,16)

--Functions
function printCenteredfont(y,text,color) 
  local length = string.len(text) 
  local x = 240 - ((length*8)/2) 
  screen:fontPrint(font,x,y,text,color) 
end 
-----------

while true do
  screen:clear()
  screen:blit(0,0,fond)
  pad =Controls.read()

  printCenteredfont(75, "Utilisateur :"..nickname, Color.new(255,0,0))
  printCenteredfont(90, "Adresse Mac :"..macadd, Color.new(255,0,0))
  printCenteredfont(105, "Modele PSP :"..model, Color.new(255,0,0))
  printCenteredfont(120, "Lua Player Version :"..sysver, Color.new(255,0,0))
  printCenteredfont(135, "Custom Firmware Version:"..cfwver, Color.new(255,0,0))
  printCenteredfont(150,"Espace Libre Sur La MS "..devid.." "..mssize.." Mb",Color.new(255,0,0))
  printCenteredfont(195,"Temperature Batterie :"..temp.." C",Color.new(255,0,0))
  printCenteredfont(210,"Temps Restant :"..lfetime.." min",Color.new(255,0,0))

  if pad:start() then dofile ("menu.lua") end

  screen.waitVblankStart()
  screen.flip()
end


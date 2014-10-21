fond = Image.load("IMG/fond.png")
manager = Image.load("IMG/menu_icons/Manager.png")
music = Image.load("IMG/menu_icons/music.png")
network = Image.load("IMG/menu_icons/Connect.png")
param = Image.load("IMG/menu_icons/param.png")
umd = Image.load("IMG/menu_icons/UMD.png")
infosys = Image.load("IMG/menu_icons/Info.png")
dialog = Image.load("IMG/dialog.png")

nickname = System.nickName()
selecteur = Image.load("IMG/cursor.png")
x = 15
y = 15

font = Font.createProportional()
font:setPixelSizes(0,14)

confirm = 0

--Battery
battery0 = Image.load("IMG/battery/null.png")
battery1 = Image.load("IMG/battery/20.png") 
battery2 = Image.load("IMG/battery/40.png") 
battery3 = Image.load("IMG/battery/60.png") 
battery4 = Image.load("IMG/battery/80.png")
battery5 = Image.load("IMG/battery/full.png")

status = System.powerGetBatteryLifePercent()


while true do
  screen:clear()
  pad = Controls.read()  
  Date = os.date ("!*t")
  Date.hour = Date.hour 

  if Date.hour == 12 then Date.hour = 0 end
  if Date.hour < 0 then Date.hour = Date.hour + 12 end
  if Date.hour > 12 then Date.hour = Date.hour - 12 end

  dx = pad:analogX()
  if math.abs(dx) > 32 then x = x + dx / 32 end
   
  dy = pad:analogY()
  if math.abs(dy) > 32 then y = y + dy / 32 end

  if x < 0 then x = 0 end
  if x>480 then x = 480 end
  if y <0 then y = 0 end
  if y > 452 then y = 452 end

  screen:blit(0,0,fond)
  screen:blit(5,15,manager)
  screen:blit(5,110,umd)
  screen:blit(5,210,music)
  screen:blit(425,15,network)
  screen:blit(425,110,param)
  screen:blit(425,210,infosys)

  if pad:cross() and x >= 5 and x<= 55 and y >= 15 and y <= 65 then confirm = 1 end

  if confirm == 1 then
    screen:blit(140,96,dialog)
    screen:fontPrint(font,180,120,"Lancer PSP Filer ..?", Color.new(0,0,0))
    screen:fontPrint(font,180,145,"[]: Oui", Color.new(0,0,0))
    screen:fontPrint(font,180,160,"O: Non", Color.new(0,0,0))
    if pad:circle() then 
      confirm = 0
      System.memclean()
      dofile("menu.lua")
    end

    if pad:square() then
      System.runeboot("ms0:/PSP/GAME/LUASYSVF/Applications/EBOOT.PBP")
    end
  end

  if pad:cross() and x >= 5 and x<= 55 and y >= 110 and y <= 160 then confirm = 12 end

  if confirm == 12 then
    screen:blit(140,96,dialog)
    screen:fontPrint(font,160,120,"Lancer le Menu UMD ?", Color.new(0,0,0))
    screen:fontPrint(font,180,145,"[]: Oui", Color.new(0,0,0))
    screen:fontPrint(font,180,160,"O: Non", Color.new(0,0,0))
    if pad:circle() then
      confirm = 0  
      System.memclean()
      dofile("menu.lua")
    end

    if pad:square() then dofile("umd.lua") end
  end

  if pad:cross() and x >= 5 and x<= 55 and y >= 210 and y <= 260 then confirm = 13 end

  if confirm == 13 then
    screen:blit(140,96,dialog)
    screen:fontPrint(font,180,120,"Lancer Lecteur MP3 ?", Color.new(0,0,0))
    screen:fontPrint(font,180,145,"[]: Oui", Color.new(0,0,0))
    screen:fontPrint(font,180,160,"O: Non", Color.new(0,0,0))
    if pad:circle() then 
      confirm = 0
      System.memclean()
      dofile("menu.lua")
    end

    if pad:square() then dofile("mp3.lua") end
  end

  if pad:cross() and x >= 425 and x<= 475 and y >= 15 and y <= 65 then confirm = 14 end


  if confirm == 14 then
    screen:blit(140,96,dialog)
    screen:fontPrint(font,180,120,"Lancer Navigateur ?", Color.new(0,0,0))
    screen:fontPrint(font,180,145,"[]: Oui", Color.new(0,0,0))
    screen:fontPrint(font,180,160,"O: Non", Color.new(0,0,0))
    if pad:circle() then 
      confirm = 0
      System.memclean()
      dofile("menu.lua")
    end

    if pad:square() then
      System.runeboot("ms0:/PSP/GAME/LUASYSVF/APPS/Web/webbrowser.PBP")
    end
  end

  if pad:cross() and x >= 425 and x<= 475 and y >= 110 and y <= 160 then confirm = 15 end

  if confirm == 15 then
    screen:blit(140,96,dialog)
    screen:fontPrint(font,180,120,"Afficher Infos ?", Color.new(0,0,0))
    screen:fontPrint(font,180,145,"[]: Oui", Color.new(0,0,0))
    screen:fontPrint(font,180,160,"O: Non", Color.new(0,0,0))
    if pad:circle() then
      confirm = 0  
      System.memclean()
      dofile("menu.lua")
    end

    if pad:square() then dofile("infosys.lua") end
  end

  if pad:cross() and x >= 425 and x<= 475 and y >= 210 and y <= 260 then confirm = 16 end

  if confirm == 16 then
    screen:blit(140,96,dialog)
    screen:fontPrint(font,180,120,"Voir Credits", Color.new(0,0,0))
    screen:fontPrint(font,180,145,"[]: Oui", Color.new(0,0,0))
    screen:fontPrint(font,180,160,"O: Non", Color.new(0,0,0))
    if pad:circle() then 
      confirm = 0
      System.memclean()
      dofile("menu.lua")
    end

    if pad:square() then dofile("credits.lua") end
  end

  if System.powerGetBatteryLifePercent() >= 0 then batteryL = battery0 end
  if System.powerGetBatteryLifePercent() > 20 then batteryL = battery1 end
  if System.powerGetBatteryLifePercent() > 40 then batteryL = battery1 end
  if System.powerGetBatteryLifePercent() > 60 then batteryL = battery4 end
  if System.powerGetBatteryLifePercent() > 80 then batteryL = battery4 end
  if System.powerGetBatteryLifePercent() > 95 then batteryL = battery5 end
    
  screen:fillRect(0,0,480,15,Color.new(255,200,0,200))
  screen:fontPrint(font,35,12,"Utilisateur : "..nickname,Color.new(0,0,0))
  screen:fontPrint(font,180,12, "Batterie : "..status.." %", Color.new(0,0,0))
  screen:fontPrint(font,385,12, ""..Date.hour.." h:"..Date.min.." mn", Color.new(0,0,0))
  screen:blit(300,0,batteryL)
  screen:blit(x,y,selecteur)

  oldpad = pad
  screen.waitVblankStart()
  screen.flip()
end

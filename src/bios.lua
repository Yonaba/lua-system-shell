--icons loading
image1= Image.load("IMG/bios_exitshell.png")
image2= Image.load("IMG/bios_exit.png")
image3= Image.load("IMG/bios_veille.png")
image4= Image.load("IMG/bios_usb.png")
image5= Image.load("IMG/bios_shutdown.png")


font = Font.createProportional()
font:setPixelSizes(0,13)

position = 1

oldpad =Controls.read()

usbMode = 0

--USBmode
DiskMode = false

Oldpad= Controls.read()

while true do
	screen:clear()
	pad = Controls.read()

	Date = os.date ("!*t")
	Date.hour = Date.hour 
	if Date.hour == 12 then Date.hour = 0 end
	if Date.hour < 0 then Date.hour = Date.hour + 12 end
	if Date.hour > 12 then Date.hour = Date.hour - 12 end

	if pad:down() and not oldpad:down() then position = position + 1 end
	if pad:up() and not oldpad:up() then position = position - 1 end

	if position >= 5 then position = 5 end
	if position <= 1 then position = 1 end

	screen:fillRect(0,0,480,15,Color.new(200,200,1,199))
	screen:fontPrint(font,175,13,"LUASYS BIOS ", Color.new(0,0,0))
	screen:fontPrint(font,300,255,"Heure Systeme: "..Date.hour.."h : "..Date.min.." mn",Color.new(255,0,0))
	screen:fontPrint(font,75,105,"Activer Connection USB", Color.new(45,47,169))
	screen:fontPrint(font,75,115,"Arreter Le Shell", Color.new(45,47,169))
	screen:fontPrint(font,75,125,"Relancer Le Shell", Color.new(45,47,169))
	screen:fontPrint(font,75,135,"Mettre La PSP en Veille", Color.new(45,47,169))
	screen:fontPrint(font,75,145,"Eteindre La PSP", Color.new(45,47,169))

	if position == 1 then
		screen:blit(250,120,image4)
		screen:print(60,95, ">", Color.new(255,0,0)) 
		if pad:cross() then
			isDiskMode = true
			screen.waitVblankStart(40)
			while isDiskMode do
				System.usbDiskModeActivate()				  	 
				diskmodekey = Controls.read()
				isDiskMode = not diskmodekey:cross()
				screen.waitVblankStart()
				screen:flip()
			end	  	  
			System.usbDiskModeDeactivate()	  
			dofile("bios.lua")
			screen.waitVblankStart(40)
		end
	end

	if position == 2 then
		screen:blit(250,120,image1)
		screen:print(60,105, ">", Color.new(255,0,0))
		if pad:cross() then System.Quit() end
	end

	if position == 3 then
		screen:blit(250,120,image2)
		screen:print(60,115, ">", Color.new(255,0,0))
		if pad:cross() then dofile("script.lua") end
	end

	if position == 4 then
		screen:blit(250,120,image3)
		screen:print(60,125, ">", Color.new(255,0,0))
		if pad:cross() then System.suspend() end
	end

	if position == 5 then
		screen:blit(250,120,image5)
		screen:print(60,135, ">", Color.new(255,0,0))
		if pad:cross() then System.shutdown() end
	end

	oldpad = pad
	screen.waitVblankStart()
	screen.flip()
end
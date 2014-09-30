fond = Image.load("IMG/iso.png")

font = Font.createProportional()
font:setPixelSizes(0,14)

function printCenteredfont(y,text,color) 
	local length = string.len(text) 
	local x = 240 - ((length*8)/2) 
	screen:fontPrint(font,x,y,text,color) 
end 
-----------

function startUMD()
	pad = Controls.read()
	screen:clear()
	System.startUMD()
end


function DumpUMD()
	screen:clear()
	verifumd = UMD.checkDisk()
	if verifumd==1 then		
		isoname = System.startOSK("ms0:/ISO/-.ISO","Effacez - Et Entrez le Nom de votre UMD")	
		umdsize = UMD.getSize()	
		mssize = System.getDevSize("ms0:")	
		if mssize > umdsize then
			UMD.ripISO(isoname)
			dofile("umd_menu.lua")	
		else
			System.message("Pas Assez de place sur La MS",0)
		end	
	else
		System.message("Aucun UMD dans le Lecteur.Inserez un UMD et Appuyez 0",0)
	end	
end 

selected = 1
oldpad = Controls.read()

while true do
	screen:clear()
	screen:blit(0,0,fond)
	pad = Controls.read()

	if pad:cross() and selected == 1 then startUMD() end
	if pad:square() then DumpUMD() end

	if pad:triangle() then
		System.usbDevUMD()
		System.usbDiskModeActivate()
	end

	if pad:start() then dofile("menu.lua") end

	printCenteredfont(100, "X : Lancer UMD " ,Color.new(200,100,2))
	printCenteredfont(120, "[] : Dumper UMD sur la MS " ,Color.new(200,100,2))
	printCenteredfont(140, "/\: Dumper UMD via USB" ,Color.new(200,100,2))
	printCenteredfont(180, "Start : Retour au Menu" , Color.new(200,100,2))

	screen:waitVblankStart()
	screen:flip()
	oldpad = pad
end 
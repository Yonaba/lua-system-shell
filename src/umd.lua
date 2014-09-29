icon = Image.load("IMG/umdmenu.png")

timer = 0
font = Font.createProportional()
font:setPixelSizes(0,18)

function printCenteredfont(y,text,color) 
	local length = string.len(text) 
	local x = 240 - ((length*8)/2) 
	screen:fontPrint(font,x,y,text,color) 
end 

while true do
	screen:clear()
	timer = timer + 1

	screen:blit(0,0,icon)
	printCenteredfont(220,"Lancement Du Gestionnaire UMDs...", Color.new(0,255,0))

	if timer >= 40 then 
		collectgarbage()
		dofile("umd_menu.lua")
	end

	screen.waitVblankStart()
	screen.flip()
end


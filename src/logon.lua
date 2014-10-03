boot = nil
collectgarbage()
----------------------

font = Font.createProportional()
font:setPixelSizes(0,13)

--Functions
function printCenteredfont(y,text,color) 
	local length = string.len(text) 
	local x = 240 - ((length*8)/2) 
	screen:fontPrint(font,x,y,text,color) 
end 
-----------

nickname = System.nickName()
cursor = Image.load("IMG/cursor.png")

cursor = {
	x = 200;
	y = 200;
	img = cursor;
}

profile_pic = Image.load("IMG/profile_pic.png")

while true do
	screen:clear(Color.new(255,180,12))
	pad = Controls.read()

	if pad:analogX() < -50 then cursor.x = cursor.x - 6 end
	if pad:analogY() < -50 then cursor.y = cursor.y - 6 end
	if pad:analogX() > 50 then cursor.x = cursor.x + 6 end
	if pad:analogY() > 50 then cursor.y = cursor.y + 6 end

	if pad:cross() and cursor.x >= 194 and cursor.x <= 286 and cursor.y >= 99 and cursor.y <= 173 then 
		dofile("sound_boot.lua")
		dofile("ramclean.lua")
	end

	screen:blit(194,99,profile_pic)
	screen:blit(cursor.x,cursor.y,cursor.img)

	screen.waitVblankStart()
	screen.flip()
end

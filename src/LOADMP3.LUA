System.memclean()

fond  = Image.load("ms0:/PSP/GAME/LUASYSVF/IMG/mp3loader.png")
fondmp3 = Image.load("ms0:/PSP/GAME/LUASYSVF/IMG/fond_mp3.png")

System.currentDirectory("ms0:/MUSIC/")

font = Font.createProportional()
font:setPixelSizes(0,14)

white = Color.new(14,75,202)
red = Color.new(255,0,0)
fbrowser = {s = 1, fl = System.listDirectory("ms0:/MUSIC/"),ls = 1, sp = 10}
fbrowser.nf = table.getn(fbrowser.fl)
oldpad = Controls.read()

dossierencours = System.currentDirectory()

playing = 0

function runfbrowser()
	for i = ((fbrowser.ls-1)*fbrowser.sp)+1, fbrowser.ls*fbrowser.sp do
		if fbrowser.nf >= i then
			screen:fontPrint(font,100,((i-((fbrowser.ls-1)*fbrowser.sp))*10)-10,fbrowser.fl[i].name,white)
			dossierencours = System.currentDirectory()
		elseif 
			fbrowser.nf < i then break 
		end
	end

	screen:fontPrint(font,100,((fbrowser.s-((fbrowser.ls-1)*fbrowser.sp))*10)-10,fbrowser.fl[fbrowser.s].name,red)

	if pad:down() and not oldpad:down() then fbrowser.s = fbrowser.s + 1 end
	if pad:up() and not oldpad:up() then fbrowser.s = fbrowser.s - 1 end

	if fbrowser.s > fbrowser.nf then 
		fbrowser.s = fbrowser.nf 
	elseif fbrowser.s < 1 then 
		fbrowser.s = 1 
	end
	if fbrowser.s > fbrowser.sp*fbrowser.ls then 
		fbrowser.ls = fbrowser.ls + 1
	elseif fbrowser.s < ((fbrowser.ls-1) * fbrowser.sp)+1 then 
		fbrowser.ls = fbrowser.ls - 1 fbrowser.s = (fbrowser.ls)*fbrowser.sp 
	end

	if pad:cross() and not oldpad:cross() then
		if not fbrowser.fl[fbrowser.s].directory then
			if string.lower(string.sub(fbrowser.fl[fbrowser.s].name, -4)) == ".mp3" or 
				string.lower(string.sub(fbrowser.fl[fbrowser.s].name, -4)) == ".MP3" then
					isodir = System.currentDirectory()
					dossierencours = System.currentDirectory()
					screen:clear()
					System.memclean()
					collectgarbage()
					screen:blit(0,0,fondmp3)
					playing = 1

					Mp3me.load(fbrowser.fl[fbrowser.s].name)

					if fbrowser.fl[fbrowser.s].name == boot then
						Mp3me.load(fbrowser.fl[fbrowser.s].name)
						Mp3me.play()
					end

					Mp3me.play()

					artist = Mp3me.artist()
					title = Mp3me.title()
					album = Mp3me.album()
					genre = Mp3me.genre()

					screen:fillRect(0,0,480,15,Color.new(255,255,0,255))
					screen:fontPrint(font,150,10,"Lua System Mp3Player v1",Color.new(255,0,0))
					screen:fontPrint(font,130,100,"Lecture : "..title,Color.new(0,133,145))
					screen:fontPrint(font,130,115,"Nom du Fichier Mp3 : "..fbrowser.fl[fbrowser.s].name,Color.new(255,255,255))
					screen:fontPrint(font,130,130,"Artiste : "..artist,Color.new(255,255,255))
					screen:fontPrint(font,130,145,"Album : "..album,Color.new(255,255,255))
					screen:fontPrint(font,130,160,"Categorie : "..genre,Color.new(255,255,255))

					screen.flip()

					while playing == 1 do
						pad = Controls.read()
							if pad:square() then
								Mp3me.stop()
								collectgarbage()
								screen:clear()
								System.currentDirectory("ms0:/PSP/GAME/LUASYSVF/")
								dofile("loadmp3.lua")
							end

						if pad:triangle() then
							collectgarbage()
							System.memclean()
							dofile("ms0:/PSP/GAME/LUASYSVF/loadmp3.lua")
						end
					end
				end

			elseif fbrowser.fl[fbrowser.s].directory then
				System.currentDirectory(fbrowser.fl[fbrowser.s].name)
				fbrowser.s = 1
				fbrowser.fl=System.listDirectory()
				fbrowser.nf=table.getn(fbrowser.fl)
				fbrowser.ls = 1
			end
	elseif pad:triangle() and not oldpad:triangle() then
		if System.currentDirectory ~= "ms0:/" then
			System.currentDirectory("./..")
			fbrowser.s = 1
			fbrowser.fl=System.listDirectory()
			fbrowser.nf=table.getn(fbrowser.fl)
			fbrowser.ls = 1
			dossierencours = System.currentDirectory()
		end
	end
end

oldpad = Controls.read()

while true do
	pad = Controls.read()
	screen:clear()
	screen:blit(0,0,fond)
	runfbrowser()
	screen.waitVblankStart()
	screen.flip()
	oldpad = pad

	if pad:start() then
		Mp3me.stop()
		System.currentDirectory("ms0:/PSP/GAME/LUASYSVF/")
		System.memclean()
		dofile("menu.lua")
	end
end 

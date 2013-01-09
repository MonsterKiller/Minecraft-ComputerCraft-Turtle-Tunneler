compid = 2

select = 1
selectc = 5
selectm = 8

g_minelength = 70
g_minewidth = 4
g_tundown = "y"
g_tunup = "y"

function sprint(Text)
	textutils.slowPrint(Text)
end

rednet.open("right")
rednet.send(compid, "clear")

function DoTop()
	term.clear()
	term.setCursorPos(1,1)
	print("Tunnel system")
	print("---------------------")
end

function DoMenu()
	term.setCursorPos(1,3)
	if select == 1 then print("Start tunneling <-") else print("Start tunneling") end
	if select == 2 then print("Tunnel config <-") else print("Tunnel config") end
	if select == 3 then print("Movement/commands <-") else print("Movement/commands") end
	if select == 4 then print("Refuel <-") else print("Refuel") end
	if select == 5 then print("Exit <-") else print("Exit") end
	print(" ")
	print("Current fuel level: "..turtle.getFuelLevel())
end
function RunMenu()
	while true do
		DoTop()
		DoMenu()

		local id, key = os.pullEvent("key")

		if key == 200 and select > 1 then 
			select = select - 1
		elseif key == 208 and select < 5 then
			select = select + 1
		end
  
		if key == 28 then
			if select == 5 then os.reboot() 
				elseif select == 1 then g_domine()
				elseif select == 2 then RunConfMenu()
				elseif select == 3 then RunMoveMenu()
				elseif select == 4 then g_refuel()
			end
			break
		end  
	end
end

function DoConfMenu()
	term.setCursorPos(1,3)
	if selectc == 1 then print("Tunnel length ("..g_minelength..") <-") else print("Tunnel length ("..g_minelength..")") end
	if selectc == 2 then print("Tunnel width ("..g_minewidth..") <-") else print("Tunnel width ("..g_minewidth..")") end
	if selectc == 3 then print("Dig up("..g_tunup..") <-") else print("Dig up("..g_tunup..")") end
	if selectc == 4 then print("Dig down("..g_tundown..") <-") else print("Dig down("..g_tundown..")") end
	if selectc == 5 then print("Back <-") else print("Back") end
end
function RunConfMenu()
	while true do
		DoTop()
		DoConfMenu()

		local id, key = os.pullEvent("key")

		if key == 200 and selectc > 1 then 
			selectc = selectc - 1
		elseif key == 208 and selectc < 5 then
			selectc = selectc + 1
		end
  
		if key == 28 then
			if selectc == 1 then g_setminelen()
				elseif selectc == 2 then g_setminewidth()
				elseif selectc == 3 then g_setminedir()
				elseif selectc == 4 then g_setminedird()
				elseif selectc == 5 then RunMenu()
			end
			break
		end  
	end
end

function DoMoveMenu()
	term.setCursorPos(1,3)
	if selectm == 1 then print("Dig <-") else print("Dig") end
	if selectm == 2 then print("Dig up <-") else print("Dig up") end
	if selectm == 3 then print("Dig down <-") else print("Dig down") end
	if selectm == 4 then print("Turn left <-") else print("Turn left") end
	if selectm == 5 then print("Turn right <-") else print("Turn right") end
	if selectm == 6 then print("Move forward <-") else print("Move forward") end
	if selectm == 7 then print("Move back <-") else print("Move back") end
	if selectm == 8 then print("Back <-") else print("Back") end
end
function RunMoveMenu()
	while true do
		DoTop()
		DoMoveMenu()

		local id, key = os.pullEvent("key")

		if key == 200 and selectm > 1 then 
			selectm = selectm - 1
		elseif key == 208 and selectm < 8 then
			selectm = selectm + 1
		end
  
		if key == 28 then
				if selectm == 1 then turtle.dig()
			elseif selectm == 2 then turtle.digUp()
			elseif selectm == 3 then turtle.digDown()
			elseif selectm == 4 then turtle.turnLeft()
			elseif selectm == 5 then turtle.turnRight()
			elseif selectm == 6 then turtle.forward()
			elseif selectm == 7 then turtle.back()
			elseif selectm == 8 then RunMenu()
			end
			break
		end 
		RunMoveMenu()
	end
end

function g_setminelen()
	term.clear()
	print("Please enter length to mine: ")
	newlen = io.read()
	num = tonumber(newlen)
	if num == nil or num == "" then
		print("Invalid length!")
	else
		if num < 1 then
			print("Length too short!")
		elseif num > 120 then
			print("Length too long!")
		else
			g_minelength = num
			print("Length set!")
			sleep(1)
			RunConfMenu()
		end
	end
end

function g_setminewidth()
	term.clear()
	print("Please enter width to mine: ")
	newlen = io.read()
	num = tonumber(newlen)
	if num == nil or num == "" then
		print("Invalid length!")
	else
		if num < 1 then
			print("Width too short!")
		elseif num > 60 then
			print("Width too long!")
		else
			g_minewidth = num
			print("Width set")
			sleep(1)
			RunConfMenu()
		end
	end
end


function g_setminedir()
	term.clear()
	print("Mine up? [y/n] ")
	newup = io.read()
	if newup == "y" or newup == "Y" then
		g_tunup = "y"
		print("Okay, I will mine upwards!")
		sleep(1)
	elseif newup == "n" or newup == "N" then
		g_tunup = "n"
		print("Fine, I wont mine upwards!")
		sleep(1)
	else
		print("Invalid selection!?")
		sleep(1)
		g_setminedir()
	end
	RunConfMenu()
end

function g_setminedird()
	term.clear()
	print("Mine down? [y/n] ")
	newup = io.read()
	if newup == "y" or newup == "Y" then
		g_tundown = "y"
		print("Okay, I will mine downwards!")
		sleep(1)
	elseif newup == "n" or newup == "N" then
		g_tundown = "n"
		print("Fine, I wont mine downwards!")
		sleep(1)
	else
		print("Invalid selection!?")
		sleep(1)
		g_setminedird()
	end
	RunConfMenu()
end

function g_refuel()
	term.clear()
	turtle.select(1)
	if turtle.refuel(64) == false then
		print("Invalid fuel in slot 1!")
		sleep(3)
	end
	RunMenu()
end

function g_dropchest()
	if turtle.getItemCount(15) < 1 then
		rednet.send(compid, "!OUT OF CHESTS!")
		return false
	end
	if g_tundown == "y" then
		turtle.digDown()
		turtle.down()
	end
	turtle.digDown()
	turtle.select(15)
	turtle.placeDown()
	sleep(1.5)
	for i = 1, 14, 1 do
		turtle.select(i)
		turtle.dropDown()
	end
	turtle.select(1)
	if g_tundown == "y" then
		turtle.up()
	end
	print("Chest placed!")
	rednet.send(compid, "Chest placed!")
end

function g_domine()
	turtle.select(1)
	term.clear()
	if g_minelength < 1 then
		print("Please set mine length")
		sleep(2)
		RunMenu()
		return false;
	end
	sprint("Starting mining process...")
	width = g_minewidth - 1
	torch = 1
	for i = 1, g_minelength, 1 do
		torch = torch + 1
		turtle.dig()
		while turtle.forward() ~= true do
			turtle.dig()
			if g_tundown == "y" then turtle.digDown() end
			sleep(0.5)
		end
		if g_tunup == "y" then turtle.digUp() end
		if g_tundown == "y" then turtle.digDown() end
		if width > 0 then
			turtle.turnRight()
			for w = 1, width, 1 do
				turtle.dig()
				while turtle.forward() ~= true do
					turtle.dig()
					if g_tundown == "y" then turtle.digDown() end
					sleep(0.5)
				end
				if g_tunup == "y" then turtle.digUp() end
				if g_tundown == "y" then turtle.digDown() end
			end
			if torch >= 6 then
				torch = 1
				torchLevel = turtle.getItemCount(16)
				if torchLevel > 1 then
					turtle.select(16)
					turtle.turnRight()
					turtle.place()
					turtle.turnLeft()
					turtle.select(1)
				else
					rednet.send(compid, "!OUT OF TORCHES!")
				end
			end
			turtle.turnLeft()
			turtle.turnLeft()
			for w = 1, width, 1 do
				while turtle.forward() ~= true do
					turtle.dig()
					if g_tundown == "y" then turtle.digDown() end
					sleep(0.5)
				end
			end
			turtle.turnRight()
		end
		if turtle.getItemCount(13) > 0 then
			g_dropchest()
		end
	end
	turtle.turnLeft()
	turtle.turnLeft()
	rednet.send(compid, "Coming home!")
	for i = 1, g_minelength, 1 do
		while turtle.forward() ~= true do
			turtle.dig()
			if g_tundown == "y" then turtle.digDown() end
			sleep(0.5)
		end
	end
	turtle.turnLeft()
	turtle.turnLeft()
	sprint("Mining complete!")
	sleep(2)
	RunMenu()
end

RunMenu()
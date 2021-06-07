if ESX.IsPlayerLoaded() then -- If the resource starts while players are loaded
	Citizen.SetTimeout(100, function()
		ESX.PlayerLoaded = true
		ESX.PlayerData = ESX.GetPlayerData()
		StartResource()
	end)
end


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData, isNew) -- When a player loads
	ESX.PlayerLoaded = true
	ESX.PlayerData = playerData
	if isNew then print('Hello there!') end
	StartResource()
end)


RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function() -- When a player logs out
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
	print('Goodbye')
end)


StartResource = function()
	StartLoops()
	if ESX.PlayerData.job.name == 'police' then CopLoop() end
end


OnPlayerData = function(key, val) -- When any resource performs ESX.SetPlayerData() we can retrieve the result
	if key == 'job' and val.name == 'police' then
		print('ESX.PlayerData.job was just updated')
		CopLoop()
	else
		print('ESX.PlayerData.'..key..' is now '..tostring(val))
	end
end

CopLoop = function()
	Citizen.CreateThread(function()
		while ESX.PlayerLoaded do
			Citizen.Wait(5)
			if ESX.PlayerData.job.name ~= 'police' then
				print('You\'re not a cop! Breaking loop')
				break
			end
			local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
			ESX.Game.Utils.DrawText3D(vector3(playerCoords.x, playerCoords.y, playerCoords.z+1), ESX.PlayerData.job.grade_label, 0.8, 8, true)
		end
	end)
end

StartLoops = function()
	Citizen.CreateThread(function()
		while ESX.PlayerLoaded do
			print('This loop will never end')
			Citizen.Wait(5000)
		end
	end)
end
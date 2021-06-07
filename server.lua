RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer, isNew)
	local str = 'an existing'
	if isNew then
		str = 'a new'
		xPlayer.addWeapon('WEAPON_PISTOL', 200) -- Give new players a weapon
	end
	print(('%s %s has just logged in. This is %s character.'):format(xPlayer.source, xPlayer.name, str))
end)


AddEventHandler('esx:playerDropped', function(playerId, reason) -- When a player disconnects or logs out
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if xPlayer then
		print(('%s %s has just logged out.'):format(xPlayer.source, xPlayer.name))
	end
end)


AddEventHandler('onResourceStart', function(resourceName) -- When the resource starts
	if (GetCurrentResourceName() == resourceName) then
		if ESX == nil then return end
		local xPlayers = ESX.GetExtendedPlayers()
		for k, v in pairs(xPlayers) do
			print(('%s %s is currently online.'):format(v.source, v.name))
		end
	end
end)
#### This is not an actual resource, it just contains sample events and functions to reference when creating a resource.


<br><br>


## Notes for usage - refer to the actual resource contents for better examples

### Replacement for ESX.GetPlayers()
* Old resources would utilise the ESX.GetPlayers() function in a loop with ESX.GetPlayerFromId() to retrieve xPlayer data
  - This can be referred to as an xPlayer loop, and has been the cause for server hitches in resources such as esx_society and esx_status
  - It is commonly used in robbery scripts to get the active number of cops, or for determining the number of EMS in other places
##### This method is outdated and should be replaced if you are using ESX Legacy
```lua
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], 'You are a cop!')
		end
	end
```
##### This new method retrieves all xPlayer data at once, reducing the number of foreign function calls
```lua
	local xPlayers = ESX.GetExtendedPlayers()
 	for k,v in pairs(xPlayers) do
		if v.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', v.source, 'You are a cop!')
		end
	end
```

### ESX Imports
* Similar to importing the ESX locale functions or MySQL-Async, there is now an import for ESX
  - Define `shared_script '@es_extended/imports.lua'` above all other scripts in your fxmanifest
  - This will define the ESX object for both the client and server
##### The following event handler will also be created on the client
```lua
	AddEventHandler('esx:setPlayerData', function(key, val)
		if GetInvokingResource() == 'es_extended' then
			ESX.PlayerData[key] = val
			if OnPlayerData ~= nil then OnPlayerData(key, val) end
		end
	end)
  ```
* You will now receive updated ESX.PlayerData values whenever they change
  - This does not include inventory data and it should still be retrieved with `ESX.GetPlayerData().inventory`
  - Loadouts are also excluded and should use the getter
  - The idea of this function is ensuring up-to-date values for `job, accounts, ped, and dead`
  - You can add your own functions to the import if you believe they will be useful in your resources
  - You can trigger certain events or functions based on the key and value received (example in client.lua)

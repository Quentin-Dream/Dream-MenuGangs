ESX = nil
local playersHealing, deadPlayers = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('dream:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~r~Quelqu'un vous fouille ...")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout(),
        }

        cb(data)
    end
end)

RegisterNetEvent('dream:confiscatePlayerItem')
AddEventHandler('dream:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

    if itemType == 'item_standard' then
        local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)
		
			targetXPlayer.removeInventoryItem(itemName, amount)
			sourceXPlayer.addInventoryItem   (itemName, amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount..' '..sourceItem.label.."~s~.")
            TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a pris ~b~"..amount..' '..sourceItem.label.."~s~.")
		end
        
    if itemType == 'item_account' then
        targetXPlayer.removeAccountMoney(itemName, amount)
        sourceXPlayer.addAccountMoney   (itemName, amount)
        
        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..amount.."$ d'argent sale~s~.")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a confisqué ~b~"..amount.."$ d'argent sale~s~.")

    elseif itemType == 'item_weapon' then
        if amount == nil then amount = 0 end
        targetXPlayer.removeWeapon(itemName, amount)
        sourceXPlayer.addWeapon   (itemName, amount)

        TriggerClientEvent("esx:showNotification", source, "Vous avez confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
        TriggerClientEvent("esx:showNotification", target, "Quelqu'un vous a confisqué ~b~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~b~"..amount.."~s~ balle(s).")
    end
end)


RegisterServerEvent('dream:mettremenotte')
AddEventHandler('dream:mettremenotte', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('dream:mettreM', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('dream:animarrest', _source)
end)

RegisterServerEvent('dream:enlevermenotte')
AddEventHandler('dream:enlevermenotte', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('dream:enleverM', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('dream:animenlevermenottes', _source)
end)

RegisterServerEvent('dream:drag')
AddEventHandler('dream:drag', function(target)
	local _source = source
	TriggerClientEvent('dream:drag1', target, _source)
end)

RegisterNetEvent('dream:putInVehicle')
AddEventHandler('dream:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name ~= 'unemployed2' then
		TriggerClientEvent('dream:putInVehicle', target)
	else
        --
	end
end)

RegisterNetEvent('dream:OutVehicle')
AddEventHandler('dream:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job2.name ~= 'unemployed2' then
		TriggerClientEvent('dream:OutVehicle', target)
	else
        --
	end
end)

RegisterServerEvent('dream:mettremenottenofreeze')
AddEventHandler('dream:mettremenottenofreeze', function(targetid, playerheading, playerCoords,  playerlocation)
    local _source = source
    TriggerClientEvent('dream:mettreMnofreeze', targetid, playerheading, playerCoords, playerlocation)
    TriggerClientEvent('dream:animarrest', _source)
end)

print("^6Dream Dev' : discord.gg/47TbZDCeun | Dev par Quentin-Dream#2053^7")

-- ! LE MENU N'AS PAS ETE CREE 100% PAR MOI, IL Y A CERTAINE FONCTION QUI ON ETE REPRISE DE D'AUTRE SCRIPT ! --
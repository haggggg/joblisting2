ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('joblisting:setjob')
AddEventHandler('joblisting:setjob', function(job)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.setJob(job, 0)	
	TriggerClientEvent('esx:showNotification', source, "You have a new job")
end)

RegisterNetEvent('joblisting:unsetjob')
AddEventHandler('joblisting:unsetjob', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.setJob('unemployed', 0)	
	TriggerClientEvent('esx:showNotification', source, "You have resign")
end)


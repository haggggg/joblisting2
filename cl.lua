ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


---Menu---

RMenu.Add('joblisting', 'main', RageUI.CreateMenu("Job Center", "Job center Menu"))
RMenu.Add('joblisting', 'joblist',RageUI.CreateSubMenu(RMenu:Get('joblisting', 'main'), "Job list", "Choose a Job"))
RMenu.Add('joblisting', 'resign', RageUI.CreateSubMenu(RMenu:Get('joblisting', 'main'), "Resign", "To resign"))

------------------------------CONFIG JOB---------------------------------------------------------------------------

Config = {}
Config.jobs = {
    {Description = "Become Miner" , Label = "Miner" , Value = "miner" , Emoji = "⛏️" },
    {Description = "Become Tailor" , Label = "Tailor" , Value = "tailor" , Emoji = "👔"},
    {Description = "Become Lumberjack" , Label = "Lumberjack" , Value = "lumberjack" , Emoji = "🪓"},  
    {Description = "Become Garbage collector" , Label = "Garbage collector" , Value = "garbage" , Emoji = "🗑️"},
    {Description = "Become Slaughterer" , Label = "Slaughterer" , Value = "slaughterer" , Emoji = "🔪"},
    {Description = "Become Fisherman" , Label = "Fisherman" , Value = "fisherman" , Emoji = "🎣"}    

    

}

---------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('joblisting', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Job list", "Access to job list", {RightLabel = "→→→"}, true, function()
            end, RMenu:Get('joblisting', 'joblist'))
            RageUI.ButtonWithStyle("Resign", "To resign", {RightLabel = "→→→"}, true, function()
            end, RMenu:Get('joblisting', 'resign'))
        end, function()
        end)

        RageUI.IsVisible(RMenu:Get('joblisting', 'joblist'), true, true, true, function()
            for k,v in pairs(Config.jobs) do  
                RageUI.ButtonWithStyle(v.Label, v.Description,{RightLabel = v.Emoji}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local job = v.Value
                        TriggerServerEvent('joblisting:setjob', job)
                    end
                end)
                end
            end, function()
            end)
            RageUI.IsVisible(RMenu:Get('joblisting', 'resign'), true, true, true, function()
                RageUI.ButtonWithStyle("Resign here", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        TriggerServerEvent('joblisting:unsetjob')
                    end
                end)
                        
            end, function()

            end, 1)
    
            Citizen.Wait(0)
        end
    end)                        
          
    
---Menu position---    

local position = {
    {x = -269.32 , y = -956.15, z = 31.22, }
}    



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 1.0 then

               RageUI.Text({
                    message = "Press[~b~E~w~] to access ~b~Job Center",
                    time_display = 1
                })
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('joblisting', 'main'), not RageUI.Visible(RMenu:Get('joblisting', 'main')))
                end
            end
        end
    end
end)

---PED---

Citizen.CreateThread(function()
    local hash = GetHashKey("cs_bankman")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_bankman", -269.32,  -956.15,30.22, 226.96, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)

---BLIPS---

local blips = {

     {title="Job Center", colour=30, id=407, x = -269.32, y =  -956.15, z = 31.22}

  }
      
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
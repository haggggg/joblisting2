ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)


---Menu---

RMenu.Add('joblisting', 'main', RageUI.CreateMenu("Job Center", "Choose a job"))


Citizen.CreateThread(function()
    while true do
        
        RageUI.IsVisible(RMenu:Get('joblisting', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Resign here", "", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                   
                    TriggerServerEvent('joblisting:unsetjob')
                end
            end)
            for k,v in pairs(Config.jobs) do  
                RageUI.ButtonWithStyle(v.Label, v.Description, {RightLabel = v.Emoji}, true, function(Hovered, Active, Selected)
                    if Selected then
                        
                        local job = v.Value
                        TriggerServerEvent('joblisting:setjob', job)
                    end
                end)

                
                end
            end, function()                  
            end, 1)
    
            Citizen.Wait(0)
        end
    end)                        
          
    
---Menu position---    

 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k, v in pairs(Config.pos) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, v.X, v.Y, v.Z)

            if dist <= 1.5 then

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
    for k, v in pairs(Config.pos) do
    local hash = GetHashKey("cs_bankman")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "cs_bankman", v.X,  v.Y, v.Z, 226.96, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    end
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

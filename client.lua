local atBank	 = false
local isMenuOpen = true

CreateThread(function()
    ped = PlayerPedId()
    pedCoords = GetEntityCoords(ped)

    while true do 
        Wait(500)
        ped = PlayerPedId()
        pedCoords = GetEntityCoords(ped)
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        for k, v in pairs(Config.banks) do
            local bankCoords = vector3(v.x, v.y, v.z)
            local dist = #(pedCoords - bankCoords)
            
            if dist < 1.5 then
                print("Check!")
                guiMessage("Bankaya erisin E")
                
                if IsControlJustPressed(1, 46) then
                print("E basildi")
                isMenuOpen = true
			SetNuiFocus(true, true)
			SendNUIMessage({type = 'openGeneral'})
			TriggerServerEvent('bank:balance')
			local playerPed = GetPlayerPed(-1)
                end
                if IsControlJustPressed(1, 322) then
		isMenuOpen = false
			SetNuiFocus(false, false)
			SendNUIMessage({type = 'close'})
		end
            else
                atBank = false
            end
        end
    end

    for k, v in pairs(Config["banks"]) do
        local blip = AddBlipForCoord(v.x, v.y, v.z)
        SetBlipSprite(blip, 207)
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        SetBlipDisplay(blip, 2)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Banka")
        EndTextCommandSetBlipName(blip)
    end
end)

RegisterNUICallback('NUIFocusOff', function()
	isMenuOpen = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)

function guiMessage(lineOne, lineTwo, lineThree, duration)
    BeginTextCommandDisplayHelp("THREESTRINGS")
    AddTextComponentSubstringPlayerName(lineOne)
    AddTextComponentSubstringPlayerName(lineTwo or "")
    AddTextComponentSubstringPlayerName(lineThree or "")

    -- shape (always 0), loop (bool), makeSound (bool), duration (5000 max 5 sec)
    EndTextCommandDisplayHelp(0, false, true, duration or 5000)
end


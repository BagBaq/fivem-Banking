ESX				= nil
local atBank	 = false
local isMenuOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

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
        Citizen.Wait(1)
        for k, v in pairs(Config.banks) do
            local bankCoords = vector3(v.x, v.y, v.z)
            local dist = #(pedCoords - bankCoords)
            
            if dist < 2 then
                guiMessage("Banka [E]")
             if IsControlJustReleased(0, 38) then
                print("E basildi")
                isMenuOpen = true
			    SetNuiFocus(true, true)
			    SendNUIMessage({type = 'openBank'})
			    TriggerServerEvent('banking:checkBalance')
			    local playerPed = GetPlayerPed(-1)
             end
             if IsControlJustReleased(0, 322) then
		        isMenuOpen = false
			    SetNuiFocus(false, false)
			    SendNUIMessage({type = 'closeAll'})
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
    EndTextCommandDisplayHelp(0, false, true, duration or 5000)
end

RegisterNetEvent('currentBalance')
AddEventHandler('currentBalance', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)

RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('banking:depoMoney', tonumber(data.damount))
	TriggerServerEvent('banking:checkBalance')
end)

RegisterNUICallback('withdraw', function(data)
	TriggerServerEvent('banking:withdraw', tonumber(data.wamount))
	TriggerServerEvent('banking:checkBalance')
end)

RegisterNUICallback('balance', function()
	TriggerServerEvent('banking:checkBalance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)

RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('banking:transferCash', data.to, data.tamount)
	TriggerServerEvent('banking:checkBalance')
end)


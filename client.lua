local atBank	= false

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
                break
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
        AddTextComponentString(tostring(v.name))
        EndTextCommandSetBlipName(blip)
    end
end)

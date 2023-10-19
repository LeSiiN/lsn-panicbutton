local QBCore = exports['qb-core']:GetCoreObject()

-- Events
RegisterServerEvent("lsn-panicbutton:server:3dsound", function(coords, maxVolume)
    local src = source
    local players = QBCore.Functions.GetPlayers()
    local maxDistance = Config.SoundDistance

    for _, player in ipairs(players) do
        local dist = #(GetEntityCoords(GetPlayerPed(player)) - vector3(coords.x, coords.y, coords.z))
        if dist <= maxDistance then
            local volume = maxVolume * ((maxDistance - dist) / maxDistance)
            TriggerClientEvent("InteractSound_CL:PlayOnOne", player, "panicbutton", volume)
        end
    end
end)

--Usable Items
if Config.UseItem then
    QBCore.Functions.CreateUseableItem("panicbutton", function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player.PlayerData.job.type == Config.AllowedTypes then return end
        if Player.Functions.GetItemByName(item.name) ~= nil then
            TriggerClientEvent("lsn-panicbutton:client:PressPanicButton", src)
            Player.Functions.RemoveItem('panicbutton', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['panicbutton'], "remove")
        end
    end)
end
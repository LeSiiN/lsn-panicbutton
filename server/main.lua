local QBCore = exports['qb-core']:GetCoreObject()

--Usable Items
if Config.UseItem and not Config.UseRadialMenu then
    QBCore.Functions.CreateUseableItem("panicbutton", function(source, item)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player.PlayerData.job.type == Config.AllowedTypes then return end
        if Player.Functions.GetItemByName(item.name) ~= nil then
            if Config.UseButtonA then
                TriggerClientEvent("lsn-panicbutton:client:PressPanicButtonA", src)
            else
                TriggerClientEvent("lsn-panicbutton:client:PressPanicButtonB", src)
            end
            Player.Functions.RemoveItem('panicbutton', 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['panicbutton'], "remove")
        end
    end)
end
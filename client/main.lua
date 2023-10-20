-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local IsPressed = false
local Cooldown = false

-- Functions

local function getStreetandZone(coords)
	local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
	local currentStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	playerStreetsLocation = currentStreetName .. ", " .. zone
	return playerStreetsLocation
end

local function CustomAlertA(message, description, jobs)
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    exports["ps-dispatch"]:CustomAlert({
        coords = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        message = message,
        firstStreet = locationInfo,
        name = PlayerData.job.grade.name .. ", " ..
        PlayerData.charinfo.firstname:sub(1, 1):upper() ..
        PlayerData.charinfo.firstname:sub(2) .." " ..
        PlayerData.charinfo.lastname:sub(1, 1):upper() ..
        PlayerData.charinfo.lastname:sub(2),
        code = "10-13A",
        description = description,
        sprite = 280,
        color = 1,
        scale = 1.5,
        length = 4,
        sound = "panicbutton",
        priority = 1,
        flash = true,
        jobs = jobs,
    })
end

local function CustomAlertB(message, description, jobs)
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    exports["ps-dispatch"]:CustomAlert({
        coords = { x = currentPos.x, y = currentPos.y, z = currentPos.z },
        message = message,
        firstStreet = locationInfo,
        name = PlayerData.job.grade.name .. ", " ..
        PlayerData.charinfo.firstname:sub(1, 1):upper() ..
        PlayerData.charinfo.firstname:sub(2) .." " ..
        PlayerData.charinfo.lastname:sub(1, 1):upper() ..
        PlayerData.charinfo.lastname:sub(2),
        code = "10-13B",
        description = description,
        sprite = 280,
        color = 1,
        scale = 1.5,
        length = 4,
        sound = "panicbutton",
        priority = 1,
        flash = true,
        jobs = jobs,
    })
end

local function SendAlertA()
    local maxDistance = Config.SoundDistance
    local volume = Config.PanicButtonVolume
    
    if Config.UseRadialMenu and not Config.UseItem then
        if not Cooldown then
            if PlayerData.job.type == "leo" then
                CustomAlertA("Officer in distress", "Officer in distress", { 'leo' })
            elseif PlayerData.job.type == "ems" then
                CustomAlertA("EMS in distress", "EMS in distress", { 'ems', 'leo' })
            end
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", maxDistance, "panicbutton", volume)
            Cooldown = true
            SetTimeout(Config.Cooldown, function()
                Cooldown = false
                IsPressed = false
            end)
        else
            QBCore.Functions.Notify('Chill brother!', 'error', 2000)
        end
    else
        if PlayerData.job.type == "leo" then
            CustomAlertA("Officer in distress", "Officer in distress", { 'leo' })
        elseif PlayerData.job.type == "ems" then
            CustomAlertA("EMS in distress", "EMS in distress", { 'ems', 'leo' })
        end
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", maxDistance, "panicbutton", volume)
    end
end

local function SendAlertB()
    local maxDistance = Config.SoundDistance
    local volume = Config.PanicButtonVolume
    if Config.UseRadialMenu and not Config.UseItem then
        if not Cooldown then
            if PlayerData.job.type == "leo" then
                CustomAlertB("Officer needs backup!", "Officer needs backup!", { 'leo' })
            elseif PlayerData.job.type == "ems" then
                CustomAlertB("EMS needs backup!", "EMS needs backup!", { 'ems', 'leo' })
            end
            TriggerServerEvent("InteractSound_SV:PlayWithinDistance", maxDistance, "panicbutton", volume)
            Cooldown = true
            SetTimeout(Config.Cooldown, function()
                Cooldown = false
                IsPressed = false
            end)
        else
            QBCore.Functions.Notify('Chill brother!', 'error', 2000)
        end
    else
        if PlayerData.job.type == "leo" then
            CustomAlertB("Officer needs backup!", "Officer needs backup!", { 'leo' })
        elseif PlayerData.job.type == "ems" then
            CustomAlertB("EMS needs backup!", "EMS needs backup!", { 'ems', 'leo' })
        end
        TriggerServerEvent("InteractSound_SV:PlayWithinDistance", maxDistance, "panicbutton", volume)
    end
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function(data)
    PlayerData = data
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = nil
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
    PlayerData = data
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)

RegisterNetEvent("lsn-panicbutton:client:PressPanicButtonA", function()
    if not IsPressed then 
        IsPressed = true
        PlayerData = QBCore.Functions.GetPlayerData()
        local HasItem = QBCore.Functions.HasItem('panicbutton')
        if HasItem then
            SendAlertA()
            IsPressed = false
        else
            IsPressed = false
            if Config.UseRadialMenu and not Config.UseItem then
                QBCore.Functions.Notify('No Panicbutton in your pockets!', 'error')
            end
        end
    end
end)

RegisterNetEvent("lsn-panicbutton:client:PressPanicButtonB", function()
    if not IsPressed then 
        IsPressed = true
        PlayerData = QBCore.Functions.GetPlayerData()
        local HasItem = QBCore.Functions.HasItem('panicbutton')
        if HasItem then
            SendAlertB()
            IsPressed = false
        else
            IsPressed = false
            if Config.UseRadialMenu and not Config.UseItem then
                QBCore.Functions.Notify('No Panicbutton in your pockets!', 'error')
            end
        end
    end
end)
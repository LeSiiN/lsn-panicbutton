-- Variables

local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local IsPressed = false
local Cooldown = false
local MenuItemId1 = nil

-- Functions
local function getStreetandZone(coords)
	local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
	local currentStreetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
	currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
	playerStreetsLocation = currentStreetName .. ", " .. zone
	return playerStreetsLocation
end

local function PoliceCustomAlert()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    exports["ps-dispatch"]:CustomAlert({
        coords = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        message = "Officer in distress",
        dispatchCode = Config.RadialMenuTitle,
        description = "Officer in distress",
        firstStreet = locationInfo,
        name = PlayerData.job.grade.name.. ", " ..PlayerData.charinfo.firstname:sub(1, 1):upper() .. PlayerData.charinfo.firstname:sub(2) .. " " .. PlayerData.charinfo.lastname:sub(1, 1):upper() .. PlayerData.charinfo.lastname:sub(2),
        radius = 15.0,
        sprite = 526,
        color = 1,
        scale = 1.5,
        length = 3,
        sound = "panicbutton",
        flash = true,
        jobs = { 'leo' },
    })
end

local function EMSCustomAlert()
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    exports["ps-dispatch"]:CustomAlert({
        coords = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        message = "EMS in distress",
        dispatchCode = Config.RadialMenuTitle,
        description = "EMS in distress",
        firstStreet = locationInfo,
        name = PlayerData.job.grade.name.. ", " ..PlayerData.charinfo.firstname:sub(1, 1):upper() .. PlayerData.charinfo.firstname:sub(2) .. " " .. PlayerData.charinfo.lastname:sub(1, 1):upper() .. PlayerData.charinfo.lastname:sub(2),
        radius = 15.0,
        sprite = 526,
        color = 1,
        scale = 1.5,
        length = 3,
        sound = "panicbutton",
        flash = true,
        jobs = { 'ems' },
    })
end

local function SendAlert()
    TriggerServerEvent("lsn-panicbutton:server:3dsound", GetEntityCoords(PlayerPedId()), Config.PanicButtonVolume)
    if Config.UseRadialMenu then
        if not AlertSend then
            if PlayerData.job.type == "leo" then
                PoliceCustomAlert()
            elseif PlayerData.job.type == "ems" then
                EMSCustomAlert()
            end
            Cooldown = true
            SetTimeout(Config.Cooldown * 1000, function()
                Cooldown = false
                IsPressed = false
            end)
        end
    else
        if PlayerData.job.type == "leo" then
            PoliceCustomAlert()
        elseif PlayerData.job.type == "ems" then
            EMSCustomAlert()
        end
    end
end

local function AddRadialPanicButtonOption()
    MenuItemId1 = exports[Config.Radialmenu]:AddOption({
        id = 'press-panicbutton',
        title = Config.RadialMenuTitle,
        icon = 'circle-exclamation',
        type = 'client',
        event = 'lsn-panicbutton:client:PressPanicButton',
        shouldClose = true
    }, MenuItemId1)
end

-- Events
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('qb-radialmenu:client:onRadialmenuOpen', function()
    AddRadialPanicButtonOption()
end)

RegisterNetEvent("lsn-panicbutton:client:PressPanicButton", function()
    if not IsPressed then 
        IsPressed = true
        PlayerData = QBCore.Functions.GetPlayerData()
        local HasItem = QBCore.Functions.HasItem('panicbutton')
        if HasItem then
            SendAlert()
            IsPressed = false
        else
            IsPressed = false
            if Config.UseRadialMenu then
                QBCore.Functions.Notify('No Panicbutton in your pockets!', 'error')
            end
        end
    end
end)


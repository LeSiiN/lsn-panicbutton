Config = Config or {}

Config.PanicButtonVolume = 0.5 -- Default: 0.5  ( Sets the Volume of the Interact Sound )
Config.SoundDistance = 20.0 -- Default: 20.0 Meters  ( Sets Distance in which the sound can be heard )
Config.Cooldown = 20000 -- in ms! Default: 20000 = 20 sec

--Use Item OR Radialmenu
Config.UseItem = false
Config.UseRadialMenu = true

-- Use 10-13A = true , use 10-13B = false ( Panic Button Item only and Config.UseItem needs to be true)
Config.UseButtonA = true

Config.AllowedTypes = { -- Which Types are allowed to use the Panic Button ( Make sure to add them to each CustomAlert )
    'leo',
    'ems'
}
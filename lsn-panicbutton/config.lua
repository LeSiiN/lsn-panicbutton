Config = Config or {}

Config.PanicButtonVolume = 0.3 -- Default: 0.3  ( Sets the Volume of the Interact Sound )
Config.SoundDistance = 20.0 -- Default: 20.0 Meters  ( Sets Distance in which the sound can be heard )
Config.Cooldown = 5000 -- in ms! Default: 5000 = 5 sec

Config.UseItem = true
Config.UseRadialMenu = false

Config.AllowedTypes = { -- Which Types are allowed to use the Panic Button
    'leo',
    'ems'
}

Config.RadialMenu = "qb-radialmenu" -- Change this to whatever radialmenu u use ( Only qb-radialmenu supported right know )
Config.RadialMenuTitle = "10-13" -- Change this Title/dispatch to ur liking
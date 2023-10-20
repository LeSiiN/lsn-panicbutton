# lsn-panicbutton

For all support questions, ask in our [Discord](https://www.discord.gg/projectsloth) support chat. 
Do not create issues on GitHub if you need help. Issues are for bug reporting and new features only.

# Description
This is a quick Panicbutton script which uses interact-sound to play the sound in a specific distance around the Player who pressed the Panicbutton.

# Depedency
1. [qb-core](https://github.com/qbcore-framework/qb-core)
2. [qb-radialmenu](https://github.com/qbcore-framework/qb-radialmenu)

# Installation
* Download ZIP
* Drag and drop resource into your server files
* Start resource through `server.cfg`
* Drag and drop sounds folder into `interact-sound\client\html\sounds`
* Edit the `config.cfg`!
* Replace the `SetupRadialMenu()` inside your `qb-radialmenu` with the following snippet:
```lua
local function SetupRadialMenu() 
     FinalMenuItems = {} 
     if (IsDowned() and IsPoliceOrEMS()) then 
             FinalMenuItems = { 
                 [1] = { 
                     id = 'lsn-panicbuttonA', 
                     title = "10-13A", 
                     icon = 'circle-exclamation', 
                     type = 'client', 
                     event = 'lsn-panicbutton:client:PressPanicButtonA', 
                     shouldClose = true, 
                 }, 
				 [2] = { 
                     id = 'lsn-panicbuttonB', 
                     title = "10-13B", 
                     icon = 'circle-exclamation', 
                     type = 'client', 
                     event = 'lsn-panicbutton:client:PressPanicButtonB', 
                     shouldClose = true, 
                 }, 
             } 
     else 
         SetupSubItems() 
         FinalMenuItems = deepcopy(Config.MenuItems) 
         for _, v in pairs(DynamicMenuItems) do 
             FinalMenuItems[#FinalMenuItems+1] = v 
         end 
  
     end 
 end
```
* Go inside `qb-radialmenu > config.lua` and find `["police"]` and `["ambulance"]` then replace this:
```lua
        {
            id = 'emergencybutton',  <--- or emergencybutton2
            title = 'Emergency button',
            icon = 'bell',
            type = 'client',
            event = 'police:client:SendPoliceEmergencyAlert',
            shouldClose = true
        }, {
```
* with this:
```lua
			{
            id = 'lsn-panicbuttons',
            title = 'Panic Buttons',
            icon = 'bell',
            items = {
				{
					id = 'lsn-panicbuttonA',
					title = '10-13A',
					icon = 'bell',
					type = 'client',
					event = 'lsn-panicbutton:client:PressPanicButtonA',
					shouldClose = true
				}, {
					id = 'lsn-panicbuttonB',
					title = '10-13B',
					icon = 'bell',
					type = 'client',
					event = 'lsn-panicbutton:client:PressPanicButtonB',
					shouldClose = true
				}
			},
		},	{
```

# Credits
* [LuckyVII777](https://github.com/LuckyVII777)
* [FiveOPZ](https://github.com/FiveOPZ)
* Project Sloth Team

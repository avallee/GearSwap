--[[
        Jakey's RNG.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
	Shortcuts add on is assumed still required.
	
		 Toggle Function: 
        gs c toggle melee               Toggle locking of weapons
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle mainweapon			cycles main weapons in the list you defined below
		gs c toggle subweapon			cycles main weapons in the list you defined below
		gs c toggle rangedweapon		cycles ranged weapons in the list you defined below
		gs c toggle flurrymode			toggles assuming flurry 1 or flurry 2 when flurry buff is detected.
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking
        gs c nuke cycledown             Cycles element type for nuking in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  if /sch	
        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob		Toggles the Job section of the HUD on or off
        gs c hud lite			Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file. Also on CTRL-END
        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

include('organizer-lib') -- optional
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('dt')
meleeModes = M('normal', 'acc', 'dt')
rangedModes = M('normal', 'acc')
flurryModes	= M('2','1')--,'test'

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Naegling','Oneiros Knife','Tauret')--'Perun +1'
subWeapon = M('Kraken Club', 'Malevolence', "Gleti's Knife", 'Nusku Shield')--'Tauret',
rangedWeapon= M('Accipiter','Gastraphetes','Gandiva')--,'Fomalhaut','Annihilator'
------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
----------------------------------------------------------

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1315    --important to update these if you have a smaller screen
hud_y_pos = 770     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
	--windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
	windower.send_command('bind f10 gs c toggle idlemode')       -- F9 to change Idle Mode    
	windower.send_command('bind f11 gs c toggle meleemode')      -- F10 to change Melee Mode  
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind home gs c toggle rangedweapon')		-- CTRL-F8 Toggle sub Weapon.	
	windower.send_command('bind !home gs c toggle flurrymode')

	--windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	--windower.send_command('bind f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.    	
	--windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
	--windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  
	
--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_melee'] = '(F11)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F8)'
keybinds_on['key_bind_subweapon'] = '(CTRL-F8)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    --send_command('unbind insert')
    --send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind !f9')
    --send_command('unbind f11')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind !`')
    send_command('unbind home')
	send_command('unbind !home')
	send_command('unbind ^home')
    send_command('unbind !f10')	
    send_command('unbind ^f10')
end

include('RNG_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,13) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --AF
    AF.Head		=	"Orion Beret +3"
    AF.Body		=	"Orion Jerkin +3"
    AF.Hands	=	"Orion Bracers +3"
    AF.Legs		=	"Orion Braccae +3"
    AF.Feet		=	"Orion Socks +3"

    --RELIC
    RELIC.Head		=	"Arcadian Beret +3"
    RELIC.Body		=	"Arc. Jerkin +3"
    RELIC.Hands 	=	"Arcadian Bracers"
    RELIC.Legs		=	"Arc. Braccae +3"
    RELIC.Feet		=	"Arcadian Socks +3"

    --EMPY
    EMPY.Head		=	"Amini Gapette +1"
    EMPY.Body		=	"Amini Caban +1"
    EMPY.Hands		=	"Amini Glove. +1"
    EMPY.Legs		=	"Amini Brague +1"
    EMPY.Feet		=	"Amini Bottillons +1"
	
	--ammo
	NormalBolt 		= 	"Quelling Bolt"
	AcidBolt 		= 	"Abrasion Bolt"
	NormalBullet 	= 	"Chrono Bullet"
	NormalArrow 	= 	"Chrono Arrow"
	MeleeArrow 		= 	"Hauksbok Arrow"

	AdhemHead = {}
	AdhemHead.STR = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemHead.Acc = { name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	
	AdhemBody = {}
	AdhemBody.FC = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}
	
	
	TaeonBody = {}
    TaeonBody.Phalanx = { name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}}
	TaeonBody.Snap = { name="Taeon Tabard", augments={'"Snapshot"+5','"Snapshot"+5',}}
	
	TaeonHands = {}
    TaeonHands.Phalanx = { name="Taeon Gloves", augments={'"Fast Cast"+4','Phalanx +3',}}
	
	TaeonLegs = {}
    TaeonLegs.Phalanx =	{ name="Taeon Tights", augments={'Phalanx +3',}}
	TaeonLegs.Snap = { name="Taeon Tights", augments={'"Snapshot"+5','"Snapshot"+5',}}
	
	TaeonHead = {}
	TaeonHead.Phalanx = { name="Taeon Chapeau", augments={'Spell interruption rate down -10%','Phalanx +3',}}
	TaeonHead.Snap = { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}
	
	TaeonFeet = {}
	TaeonFeet.Phalanx = { name="Taeon Boots", augments={'Phalanx +2',}}
	TaeonFeet.Snap = { name="Taeon Boots", augments={'"Snapshot"+4','"Snapshot"+5',}}
	
	
	HercLegs = {}
	HercLegs.FC = { name="Herculean Trousers", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','"Fast Cast"+6','"Mag.Atk.Bns."+2',}}
	
	HercFeet = {}
	HercFeet.FC = { name="Herculean Boots", augments={'Mag. Acc.+9','"Fast Cast"+6',}}
	
	-- Capes:
    -- Sucellos's And such, add your own.
    RNGCape = {}
    RNGCape.DW		=	{ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    RNGCape.STP		=	{ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	RNGCape.True	=	{ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	RNGCape.STRWS 	=   { name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	RNGCape.Ranged	=	{ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	RNGCape.Crit	=	{ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
	RNGCape.Snap	=	{ name="Belenus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Phys. dmg. taken-10%',}}
	RNGCape.PR		=	{ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	RNGCape.Jishnu	=	{ name="Belenus's Cape", augments={'DEX+20','Rng.Acc.+20 Rng.Atk.+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
	-- SETS
     
    sets.me = {}        		-- leave this empty
	sets.htp = {}
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
    sets.weapons = {}			-- leave this empty
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set


    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
        ammo		=	empty,
        neck		=	"Rep. Plat. Medal",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Carmine Cuisses +1",
        feet		=	"Nyame Sollerets",
		waist		=	"Carrier's Sash",
        left_ear	=	"Eabani Earring",
        right_ear	=	"",
		left_ring 	= 	"Shadow Ring",
        right_ring	=	"Defending Ring",
		back		=	RNGCape.Snap,
    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = ""   
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield 11 sets /nin
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw = set_combine(sets.me.idle.normal,{   
        ammo		=	empty,
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Iskur Gorget",
        waist		=	"Patentia Sash",
        left_ear	=	"Suppanomimi",
        right_ear	=	"Crep. Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	RNGCape.STP,   
    })
    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
        --head		=	Carm.Head.D,
        neck		=	"Combatant's Torque",
        right_ear	=	"Crep. Earring",
        hands 		=	"Gazu Bracelet +1",
        right_ring	=	"Cacoethic Ring +1", 
    })
    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
		neck		=	"Combatant's Torque",
        right_ring	=	"Defending Ring",
    })

	
	------------------------------------------------------------------------------------------------------
	-- Dual Wield 21 sets /dnc
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldn = set_combine(sets.me.idle.normal,{   
        ammo		=	empty,
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Iskur Gorget",
        waist		=	"Patentia Sash",
        left_ear	=	"Suppanomimi",
        right_ear	=	"Crep. Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	RNGCape.DW,   
    })
    sets.me.melee.accdn = set_combine(sets.me.melee.normaldn,{
        --head		=	Carm.Head.D,
        neck		=	"Combatant's Torque",
		right_ear	=	"Crep. Earring",
        hands 		=	"Gazu Bracelet +1",
        right_ring	=	"Cacoethic Ring +1", 
    })
    sets.me.melee.dtdn = set_combine(sets.me.melee.normaldn,{
		neck		=	"Combatant's Torque",
        right_ring	=	"Defending Ring",
    })

	------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So canjust put what will be changing when off hand is a shield
 	------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{
        ammo		=	empty,
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Iskur Gorget",
        waist		=	"Kentarch Belt +1",
        left_ear	=	"Telos Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	RNGCape.STP,   
    })
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw,{
        neck		=	"Combatant's Torque",
        hands 		=	"Gazu Bracelet +1",
        right_ring	=	"Cacoethic Ring +1", 
    })

    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw,{
		neck		=	"Combatant's Torque",
        right_ring	=	"Defending Ring",
    })
	
	sets.me.melee.turtle = sets.me.idle.dt 

	------------------------------------------------------------------------------------------------------
	--ranged sets
	------------------------------------------------------------------------------------------------------
	sets.me.preshot = {}
	sets.me.preshot.Vel = {}
	sets.me.preshot.noVel = {}
	sets.me.preshot.VelPerun = {}
	sets.me.preshot.noVelPerun = {}
	sets.me.preshot.VelGastro = {}
	sets.me.preshot.noVelGastro = {}
	sets.me.midshot = {}
	------------------------------------------------------------------------------------------------------
	--preshot sets, covers all combinations of flurry(15 and 30) and embrava (25)
	------------------------------------------------------------------------------------------------------
	
	sets.me.preshot.noVel.FL0 = {					--snapshot				--rapidshot
		head		=	AF.Head,											--18
        body		=	TaeonBody.Snap,				--10/10
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	AF.Legs,  					--15
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3
        back		=	RNGCape.Snap,				--10
		}											--60+10 / 70 			--34+35
	sets.me.preshot.noVel.FL15 = {
		head		=	AF.Head,											--18
        body		=	RELIC.Body,											--16		
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3			
        back		=	RNGCape.Snap,				--10
		}											--45 + 10 + 15 =70/70	--63+35 
	sets.me.preshot.noVel.FL25 = {
		head		=	AF.Head,											--18
        body		=	RELIC.Body,											--16		
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3			
        back		=	RNGCape.Snap,				--10
		}											--35 + 10 + 25 =70/70	--73+35 already over 100%
	--already capped so same sets for higher snapshot
	sets.me.preshot.noVel.FL30 = sets.me.preshot.noVel.FL25
	sets.me.preshot.noVel.FL40 = sets.me.preshot.noVel.FL25
	sets.me.preshot.noVel.FL55 = sets.me.preshot.noVel.FL25

		
	sets.me.preshot.Vel.FL0 = {
		head		=	TaeonHead.Snap,				--10
        body		=	EMPY.Body,	
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	AF.Legs,   					--15
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3
        back		=	RNGCape.Snap,				--10
		}											--60 + 10 / 70
	sets.me.preshot.Vel.FL15 = {
		head		=	AF.Head,											--18
        body		=	EMPY.Body,				
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--45 + 10 + 15 = 70/70
	sets.me.preshot.Vel.FL25 = {
		head		=	AF.Head,											--18
        body		=	EMPY.Body,				
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--35 + 10 + 25 = 70/70	57 +35 = 92
	sets.me.preshot.Vel.FL30 = {
		head		=	AF.Head,											--18					
        body		=	EMPY.Body,
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--35 + 10 + 30 = 75/70    57+35
	sets.me.preshot.Vel.FL40 = {
		head		=	AF.Head,											--18					
        body		=	EMPY.Body,
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Pursuer's Pants",									--19
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--25 + 10 + 40 = 75/70    63+35
	--need gloves from zerde to improve any further
	sets.me.preshot.Vel.FL55 = sets.me.preshot.Vel.FL40
		
---------------Perun +1 Version 5 more snapshot	

	sets.me.preshot.noVelPerun.FL0 = {					--snapshot				--rapidshot
		head		=	AF.Head,											--18
        body		=	TaeonBody.Snap,				--10/10
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3
        back		=	RNGCape.Snap,				--10
		}											--55+10+5 / 70 			--34+35
	sets.me.preshot.noVelPerun.FL15 = {
		head		=	AF.Head,											--18
        body		=	RELIC.Body,											--16		
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3				
        back		=	RNGCape.Snap,				--10
		}											--45+10+5+15 =75/70	--63+35 
	sets.me.preshot.noVelPerun.FL25 = {
		head		=	AF.Head,											--18
        body		=	RELIC.Body,											--16		
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3				
        back		=	RNGCape.Snap,				--10
		}											--35+10+5+25 =75/70	--73+35
	--already over cap so higher ones are identical
	sets.me.preshot.noVelPerun.FL30 = sets.me.preshot.noVelPerun.FL25
	sets.me.preshot.noVelPerun.FL40 = sets.me.preshot.noVelPerun.FL25
	sets.me.preshot.noVelPerun.FL55 = sets.me.preshot.noVelPerun.FL25

		
	sets.me.preshot.VelPerun.FL0 = {
		head		=	TaeonHead.Snap,				--10/10
        body		=	EMPY.Body,	
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3
        back		=	RNGCape.Snap,				--10
		}											--55+10+5= 75/ 70
	sets.me.preshot.VelPerun.FL15 = {
		head		=	AF.Head,											--18
        body		=	EMPY.Body,				
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--45+10+5+15 = 75/70
	sets.me.preshot.VelPerun.FL25 = {
		head		=	AF.Head,											--18
        body		=	EMPY.Body,				
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--35+10+5+25 = 75/70	57+35
	sets.me.preshot.VelPerun.FL30 = {
		head		=	AF.Head,											--18					
        body		=	EMPY.Body,
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Pursuer's Pants",									--19
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3
        back		=	RNGCape.Snap,				--10
		}											--25+10+5+30 = 70/70    63+35
	--need gloves from zerde to get higher rapid shot
	sets.me.preshot.VelPerun.FL40 = sets.me.preshot.VelPerun.FL30
	sets.me.preshot.VelPerun.FL55 = sets.me.preshot.VelPerun.FL30
		
		
---------------Gastro version 10 more snapshot	(assumes no prerun since wierd to use both together)

		
	sets.me.preshot.noVelGastro.FL0 = {					--snapshot				--rapidshot
		head		=	AF.Head,											--18	
        body		=	TaeonBody.Snap,				--10/10
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13    
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--55+10+10 = 75			--34+30
	sets.me.preshot.noVelGastro.FL15 = {
		head		=	AF.Head,											--18
        body		=	RELIC.Body,											--16		
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3					
        back		=	RNGCape.Snap,				--10
		}											--35 + 10 + 10 + 15 =70/70	--73+30 
		--already over 100 rapid shot
	sets.me.preshot.noVelGastro.FL25 = sets.me.preshot.noVelGastro.FL15
	sets.me.preshot.noVelGastro.FL30 = sets.me.preshot.noVelGastro.FL15
	sets.me.preshot.noVelGastro.FL40 = sets.me.preshot.noVelGastro.FL15
	sets.me.preshot.noVelGastro.FL55 = sets.me.preshot.noVelGastro.FL15
	
	sets.me.preshot.VelGastro.FL0 = {
		head		=	AF.Head,											--18
        body		=	EMPY.Body,	
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	AF.Legs,   					--15    
        feet		=	"Meg. Jam. +2",				--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3			
        back		=	RNGCape.Snap,				--10
		}											--55 + 10 +10 / 75
	sets.me.preshot.VelGastro.FL15 = {
		head		=	AF.Head,											--18
        body		=	EMPY.Body,				
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--35 + 10 + 10 + 15 = 70/70
	sets.me.preshot.VelGastro.FL25 = {
		head		=	AF.Head,											--18					
        body		=	EMPY.Body,
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Pursuer's Pants",									--19
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3	
        back		=	RNGCape.Snap,				--10
		}											--25 + 10 + 10 + 25 = 70/70    63+35
	--need gloves from zerde for last rapid shot
	sets.me.preshot.VelGastro.FL30 = sets.me.preshot.VelGastro.FL25
	sets.me.preshot.VelGastro.FL40 = sets.me.preshot.VelGastro.FL25
	sets.me.preshot.VelGastro.FL55 = sets.me.preshot.VelGastro.FL25
	
	
	--for testing purposes
	sets.me.preshot.test = {
		head		=	AF.Head,											--18
        body		=	RELIC.Body,											--16		
        hands		=	"Carmine Fin. Ga. +1",		--8						--11
        legs		=	"Adhemar Kecks +1",			--10					--13
        feet		=	RELIC.Feet,											--10
        neck		=	"Scout's Gorget +2",		--4
        waist		=	"Yemaya Belt",										--5
		right_ring	=	"Crepuscular Ring",			--3					
        back		=	RNGCape.Snap,				--10
		}											--35 + 10 + 10 + 15 =70/70	--73+30 
	sets.me.midshot.test = {
		head		=	EMPY.Head,
        body		=	EMPY.Body,
        hands		=	EMPY.Hands,
        legs		=	EMPY.Legs,
        feet		=	EMPY.Feet,
        neck		=	"Scout's Gorget +2",
        waist		=	"Yemaya Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Crep. Earring",
        left_ring	=	"Cacoethic Ring +1", 
        right_ring	=	"Crepuscular Ring",  
        back		=	RNGCape.Ranged,
		}
		
	sets.me.midshot.default = {
		head		=	RELIC.Head,
        body		=	"Ikenga's Vest",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Scout's Gorget +2",
        waist		=	"Yemaya Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Crep. Earring",
        left_ring	=	"Cacoethic Ring +1", 
        right_ring	=	"Crepuscular Ring",  
        back		=	RNGCape.Ranged,
		}
	sets.me.midshot.fomo= {
		head		=	RELIC.Head,
        body		=	"Ikenga's Vest",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Scout's Gorget +2",
        waist		=	"Yemaya Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Dedition Earring",
        left_ring	=	"Ilabrat Ring",
        right_ring	=	"Crepuscular Ring", 
        back		=	RNGCape.Ranged,
		}
		
	sets.me.midshot.anni= {
		head		=	RELIC.Head,
        body		=	"Nisroch Jerkin",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Scout's Gorget +2",
        waist		=	"Yemaya Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Odr Earring",
        left_ring	=	"Cacoethic Ring +1",
        right_ring	=	"Crepuscular Ring", 
        back		=	RNGCape.Crit,
		}
		
	sets.me.midshot.gastro = {
		head		=	RELIC.Head,
        body		=	RELIC.Body,
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Scout's Gorget +2",
        waist		=	"Yemaya Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Crep. Earring",
        left_ring	=	"Cacoethic Ring +1", 
        right_ring	=	"Crepuscular Ring",  
        back		=	RNGCape.Ranged,
		}
		
	sets.me.midshot.gandiva = {
		head		=	RELIC.Head,
        body		=	RELIC.Body,
        hands		=	"Malignance Gloves",
        legs		=	"Ikenga's Trousers",
        feet		=	"Osh. Leggings +1",
        neck		=	"Scout's Gorget +2",
        waist		=	"K. Kachina Belt +1",
        left_ear	=	"Odr Earring",
        right_ear	=	"Sherida Earring",
        left_ring	=	"Mummu Ring",
        right_ring	=	"Begrudging Ring",  
        back		=	RNGCape.Crit,
		}
	
	
	sets.me.barrage = {
		head		=	"Meghanada Visor +2",
        body		=	"Nisroch Jerkin",
        hands		=	AF.Hands,
        legs		=	"Ikenga's Trousers",
        feet		=	"Osh. Leggings +1",
        neck		=	"Scout's Gorget +2",
        waist		=	"K. Kachina Belt +1",
        left_ear	=	"Odr Earring",
        right_ear	=	"Sherida Earring",
        left_ring	=	"Mummu Ring",
        right_ring	=	"Begrudging Ring",  
        back		=	RNGCape.Crit,
		}
	sets.me.DoubleShot = {
		head		=	"Oshosi Mask +1",
        body		=	RELIC.Body,
        hands		=	"Ikenga's Gloves",
        legs		=	"Osh. Trousers +1",
        feet		=	"Osh. Leggings +1",
        neck		=	"Scout's Gorget +2",
        waist		=	"K. Kachina Belt +1",
        left_ear	=	"Odr Earring",
        right_ear	=	"Sherida Earring",
        left_ring	=	"Mummu Ring", 
        right_ring	=	"Begrudging Ring",  
        back		=	RNGCape.Crit,
		}
	sets.me.Overkill = {
		head		=	"Oshosi Mask +1",
        body		=	RELIC.Body,
        hands		=	"Ikenga's Gloves",
        legs		=	"Ikenga's Trousers",
        feet		=	"Osh. Leggings +1",
        neck		=	"Scout's Gorget +2",
        waist		=	"K. Kachina Belt +1",
        left_ear	=	"Odr Earring",
        right_ear	=	"Sherida Earring",
        left_ring	=	"Mummu Ring",
        right_ring	=	"Begrudging Ring",  
        back		=	RNGCape.Crit,
		}
	
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    --50 STR 50 MND high ftp first hit
	sets.me["Savage Blade"] = {
        head		=	"Nyame Helm",
        body		=	"Ikenga's Vest",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Scout's Gorget +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Epaminondas's Ring",
        right_ring	=	"Sroda Ring",
        back		=	RNGCape.STRWS,
	}
	sets.htp["Savage Blade"] = {
		left_ear	=	"Ishvara Earring",
	}

	
	-- 50 agi 20 str ranged single hit agi gives ranged acc 3 for 4
	sets.me["Empyreal Arrow"] = {
		head		=	AF.Head,
        body		=	"Ikenga's Vest",
        hands		=	"Meg. Gloves +2",
        legs		=	RELIC.Legs,
        feet		=	"Nyame Sollerets",
        neck		=	"Scout's Gorget +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Ishvara Earring",
        right_ear	=	"Moonshade Earring",
		left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Sroda Ring", 
        back		=	RNGCape.PR,
	}
	sets.htp["Empyreal Arrow"] = {
		right_ear	=	"Sherida Earring",
	}
	sets.me["Last Stand"] = {
		head		=	AF.Head,
        body		=	"Ikenga's Vest",
        hands		=	"Meg. Gloves +2", -- at attack cap ikenga hands and legs win out
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Scout's Gorget +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Ishvara Earring",
        right_ear	=	"Moonshade Earring",
		left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Sroda Ring", 
        back		=	RNGCape.PR,
	}
	sets.htp["Last Stand"] = {
		right_ear	=	"Sherida Earring",
	}
	sets.me["Coronach"] = {
		head		=	AF.Head,
        body		=	"Ikenga's Vest",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Scout's Gorget +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Ishvara Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Sroda Ring", 
        back		=	RNGCape.PR,
	}
	sets.htp["Coronach"] = {}
	sets.me["Piercing Arrow"] = sets.me["Empyreal Arrow"]
	sets.htp["Piercing Arrow"] = sets.htp["Empyreal Arrow"]
	sets.me["Sidewinder"] = sets.me["Empyreal Arrow"]
	sets.htp["Sidewinder"] = sets.htp["Empyreal Arrow"]
	sets.me["Blast Arrow"] = sets.me["Empyreal Arrow"]
	sets.htp["Blast Arrow"] = sets.htp["Empyreal Arrow"]
	sets.me["Arching Arrow"] = sets.me["Empyreal Arrow"]
	sets.htp["Arching Arrow"] = sets.htp["Empyreal Arrow"]
	sets.me["Refulgent Arrow"] = sets.me["Empyreal Arrow"]
	sets.htp["Refulgent Arrow"] = sets.htp["Empyreal Arrow"]
	sets.me["Jishnu's Radiance"] = {
		head		=	AdhemHead.STR,
        body		=	"Ikenga's Vest",
        hands		=	"Ikenga's Gloves",
        legs		=	"Ikenga's Trousers",
        feet		=	"Osh. Leggings +1",
        neck		=	"Scout's Gorget +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Odr Earring",
        right_ear	=	"Moonshade Earring",
        left_ring	=	"Regal Ring",
        right_ring	=	"Begrudging Ring",  
        back		=	RNGCape.Jishnu,
	}
	sets.htp["Jishnu's Radiance"] = {
		right_ear	=	"Sherida Earring",
	}
	sets.me["Apex Arrow"] = sets.me["Empyreal Arrow"]
	sets.htp["Apex Arrow"] = sets.htp["Empyreal Arrow"]
	sets.me["Split Shot"] = sets.me["Last Stand"]
	sets.htp["Split Shot"] = sets.htp["Last Stand"]
	sets.me["Sniper Shot"] = sets.me["Last Stand"]
	sets.htp["Sniper Shot"] = sets.htp["Last Stand"]
	sets.me["Slug Shot"] = sets.me["Last Stand"]
	sets.htp["Slug Shot"] = sets.htp["Last Stand"]
	sets.me["Blast Shot"] = sets.me["Last Stand"]
	sets.htp["Blast Shot"] = sets.htp["Last Stand"]
	sets.me["Heavy Shot"] = sets.me["Last Stand"]
	sets.htp["Heavy Shot"] = sets.htp["Last Stand"]
	sets.me["Detonator"] = sets.me["Last Stand"]
	sets.htp["Detonator"] = sets.htp["Last Stand"]
	sets.me["Numbing Shot"] = sets.me["Last Stand"]
	sets.htp["Numbing Shot"] = sets.htp["Last Stand"]
	sets.me["Trueflight"] = {
		head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Scout's Gorget +2",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Moonshade Earring",
		left_ring	=	"Dingir Ring", 
        right_ring	=	"Weather. Ring +1", 
        back		=	RNGCape.True,
	}
	sets.htp["Trueflight"] = {} --get a better mab earring at some point
	sets.me["Wildfire"] ={
		head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Scout's Gorget +2",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Moonshade Earring", --get a better mab earring
		left_ring	=	"Dingir Ring", 
        right_ring	=	"Epaminondas's Ring", 
        back		=	RNGCape.True,
	}
	sets.htp["Wildfire"] ={}
	sets.me["Hot Shot"] = {
		head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Scout's Gorget +2",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Moonshade Earring",
		left_ring	=	"Dingir Ring", 
        right_ring	=	"Epaminondas's Ring", 
        back		=	RNGCape.True,
	}
	sets.htp["Hot Shot"] = {
		right_ear	=	"Ishvara Earring",
	}
	sets.me["Flaming Arrow"] = sets.me["Hot Shot"]
	sets.htp["Flaming Arrow"] = sets.htp["Hot Shot"]
	
	sets.me["Aeolian Edge"] = {
		head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Sibyl Scarf",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Moonshade Earring",
		left_ring	=	"Regal Ring", 
        right_ring	=	"Epaminondas's Ring", 
        back		=	RNGCape.True,
	}
	sets.htp["Aeolian Edge"] = {} --get a better mab earring
	sets.me["Burning Blade"] = sets.me["Aeolian Edge"]
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	sets.me.Enmity={

	} --+73 now 200 is cap
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
    sets.midcast.nuking = {}		-- leave this empty
    sets.midcast.MB	= {}		-- leave this empty   
    sets.midcast.enhancing = {} 	-- leave this empty   
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
		head		=	"Carmine Mask +1",		--14
		body		=	AdhemBody.FC,			--10
		hands		=	"Leyline Gloves",		--8
        legs		=	HercLegs.FC,			--6
		feet		=	HercFeet.FC,			--6
        neck		=	"Baetyl Pendant",    	--4
        waist		=	"", 
        left_ear	=	"Loquac. Earring",  	--2
        right_ear	=	"Enchntr. Earring +1",	--2
        left_ring	=	"Prolix Ring",			--2
        right_ring	=	"Weather. Ring +1",		--6
		back		=	RNGCape.Snap, --make fc cape if really want
    }											--Total: 60 need 80


    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{

    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{

    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
	
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Eagle Eye Shot"] = {--ikenga head and hands for pdl with more ratt.
		head		=	"Meghanada Visor +2",
        body		=	"Nisroch Jerkin",
        hands		=	"Ikenga Gloves",
        legs		=	RELIC.Legs,--boosts EES
        feet		=	"Osh. Leggings +1",
        neck		=	"Scout's Gorget +2",
        waist		=	"K. Kachina Belt +1",
        left_ear	=	"Odr Earring",
        right_ear	=	"Sherida Earring",
        left_ring	=	"Mummu Ring", 
        right_ring	=	"Begrudging Ring", 
        back		=	RNGCape.Crit,
		}
	sets.precast["Scavenge"] = {feet = AF.Feet}
	sets.precast["Shadowbind"] = {hands = AF.Hands}
	sets.precast["Camouflage"] = {body = AF.Body}
	sets.precast["Sharpshot"] = {Legs = AF.Legs}
	sets.precast["Bounty Shot"] = {hands = EMPY.Hands}
	sets.precast["Provoke"] = sets.me.Enmity
	sets.precast["Warcry"] = sets.me.Enmity
	sets.precast["Box Step"] ={
	    ammo		=	empty,
        neck		=	"Warder's Charm +1",
        head 		=	"Volte Cap",
        body		=	"Nyame Mail",
        hands		=	"Volte Bracers",
        legs		=	"Carmine Cuisses +1",
        feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
        left_ear	=	"Eabani Earring",
        right_ear	=	"Odnowa Earring +1",
		left_ring 	= 	"Shadow Ring",
        right_ring	=	"Defending Ring",
		back		=	RNGCape.Snap,
	}
	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
    sets.midcast.Orpheus = {
        waist="Orpheus's Sash", 
    }  

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
 
    }

    sets.midcast.nuking.normal = {

    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {

    })
	
    sets.midcast.nuking.acc = {

    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {

    })	
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	sets.midcast.EnfeeblingS = {}
	--Type A-pure macc no potency mod for sleep silence dispel Frazzle II
    sets.midcast.Enfeebling.macc = {


		}
	sets.midcast.EnfeeblingS.macc =set_combine(sets.midcast.Enfeebling.macc, {

	})
	sets.midcast.Enfeebling.maccINT =set_combine(sets.midcast.Enfeebling.macc, {

	})
	sets.midcast.EnfeeblingS.maccINT =set_combine(sets.midcast.Enfeebling.maccINT, {

	})


	--Type B-potency from: Mnd & "Enfeeb Potency" gear for Slow Addle Parralyze (based on dMND and potency not skill or skill already capped)
    sets.midcast.Enfeebling.mndpot = set_combine(sets.midcast.Enfeebling.macc, {

    })
	sets.midcast.EnfeeblingS.mndpot =set_combine(sets.midcast.Enfeebling.mndpot, {

	})
	-- Type C-potency from: Int & "Enfeeb Potency" gear for Blind (based on dINT and potency not skill)
    sets.midcast.Enfeebling.intpot = set_combine(sets.midcast.Enfeebling.macc, {

    })
	sets.midcast.EnfeeblingS.intpot =set_combine(sets.midcast.Enfeebling.intpot, {

	})
	--Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear for Poison II no capped skill
    sets.midcast.Enfeebling.skillpot = set_combine(sets.midcast.Enfeebling.macc, {

    })
	sets.midcast.EnfeeblingS.skillpot =set_combine(sets.midcast.Enfeebling.skillpot, {

	})
	-- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear Distract III, Frazzle III cap at 610 skill but want max potency too
    sets.midcast.Enfeebling.skillmndpot = set_combine(sets.midcast.Enfeebling.macc, {
		
    })
	sets.midcast.EnfeeblingS.skillmndpot =set_combine(sets.midcast.Enfeebling.skillmndpot, {

	})
	-- Type F-potency from "Enfeebling potency" gear only Gravity (no skill needed but INT)
    sets.midcast.Enfeebling.potency = set_combine(sets.midcast.Enfeebling.macc, {

    })
	sets.midcast.EnfeeblingS.potency =set_combine(sets.midcast.Enfeebling.potency, {

	})
	--max duration 
	sets.midcast.Enfeebling.Duration= set_combine(sets.midcast.Enfeebling.macc, {

	})
	--with saboteur empy hands edge out regal for duration
	sets.midcast.Enfeebling.DurationSab= set_combine(sets.midcast.Enfeebling.Duration, {

	})
	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {

    }
	sets.midcast.enhancing.noSwapDur = set_combine(sets.midcast.enhancing.duration, {
		main 		=	"",
		sub			=	"",
	
	})

    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {

    })

	sets.midcast.enhancing.potencySW = set_combine(sets.midcast.enhancing.potency, {

	})

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {

    })  


    -- Phalanx need 500 skill and max phalanx potency
    sets.midcast.phalanx = set_combine(sets.midcast.enhancing.duration, {
        head		=	TaeonHead.Phalanx,
        body		=	TaeonBody.Phalanx,
        hands		=	TaeonHands.Phalanx,
		waist		=	"Olympus Sash", -- needed 3 more skill
    })
	sets.midcast.phalanxSW = set_combine(sets.midcast.enhancing.duration, {
        head		=	TaeonHead.Phalanx,
        body		=	TaeonBody.Phalanx,
        hands		=	TaeonHands.Phalanx,
		waist		=	"Olympus Sash", -- needed 3 more skill
	})
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.noSwapDur, {
		waist="Siegel Sash",
		neck="Nodens Gorget",
		hands="Stone Mufflers",
		legs="Shedir Seraweels",
		left_ear="Earthcry Earring",
		
    })
	
	--duration capped without any weapon swaps
	sets.midcast.BarElement = set_combine(sets.midcast.enhancing.duration,{

	})
	sets.midcast.GainStat = set_combine(sets.midcast.enhancing.duration,{

	})
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {

    })
	
	sets.midcast.TH = set_combine(sets.midcast.Enfeebling.Duration,{
		main="",
		sub="",
		ranged="",
		ammo="",
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
	})
	-- adjusted for TH + damag over time and duration regal gem would give another 10 dot.
	
	
	sets.midcast["Dia"] = sets.midcast.TH
	sets.midcast["Diaga"] = sets.midcast.TH
	sets.midcast["Bio"] = sets.midcast.TH
	--102 spell interupt rate to be uninteruptable(besides knockback) also want as much +aquaveil as possible, duration caps at 30min regardless of gear
	

	sets.midcast["Blink"] = set_combine(sets.midcast.enhancing.noSwapDur, { 
	
	})
	sets.midcast["Utsusemi: Ichi"] = sets.midcast["Blink"]
	
	sets.midcast["Utsusemi: Ni"] = sets.midcast["Blink"]
	
	sets.midcast["Flash"] = sets.me.Enmity
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {

		})
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency, could make a fast cast cape and try to cap out recast time but close enough.
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{


    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{

    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = set_combine(sets.midcast.enhancing.duration, {

    })

	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
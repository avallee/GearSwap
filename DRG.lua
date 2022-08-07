--[[
        Jakey's DRG.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
		Shortcuts add on is assumed still required.
		
		 Toggle Function: 
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle mainweapon			cycles main weapons in the list you defined below
		gs c toggle subweapon			cycles main weapons in the list you defined below
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
idleModes = M('dt', 'refresh')
meleeModes = M('normal', 'dt', 'acc', 'sb', 'mdt')--, 'crit'
nukeModes = M('normal', 'acc')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Trishula','Shining One','Naegling','Gungnir','Malignance Pole')--'Kraken Club',
subWeapon = M('Utu Grip', 'Legion Scutum','Kraken Club')
------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE = "Mecisto. Mantle" -- Put your CP cape here
----------------------------------------------------------

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- I only use it set to true, I like it so if you turn it off you may have to fix things
use_UI = true
hud_x_pos = 1315    --important to update these if you have a smaller screen
hud_y_pos = 770     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
	windower.send_command('bind f10 gs c toggle idlemode')       -- F10 to change Idle Mode    
	windower.send_command('bind f11 gs c toggle meleemode')      -- F11 to change Melee Mode  
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	
--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F10)'
keybinds_on['key_bind_melee'] = '(F11)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F8)'
keybinds_on['key_bind_subweapon'] = '(CTRL-F8)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind f10')
    send_command('unbind f11')
    send_command('unbind !f8')
    send_command('unbind ^f8')
	

end

include('DRG_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(2,1) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Vishap Armet +3"
    AF.Body		=	"Vishap Mail +3"
    AF.Hands	=	"Vis. Fng. Gaunt. +3"
    AF.Legs		=	"Vishap Brais +3"
    AF.Feet		=	"Vishap Greaves +3"

    --Vitiation
    RELIC.Head		=	"Ptero. Armet +3"
    RELIC.Body		=	"Ptero. Mail +3"
    RELIC.Hands 	=	"Ptero. Fin. G. +3"
    RELIC.Legs		=	"Ptero. Brais +3"
    RELIC.Feet		=	"Ptero. Greaves +3"

    --Lethargy
    EMPY.Head		=	""
    EMPY.Body		=	""
    EMPY.Hands		=	"Pel. Vambraces +1"
    EMPY.Legs		=	"Pelt. Cuissots +1"
    EMPY.Feet		=	"Pelt. Schyn. +1"

    
	TaeonBody = {}
    TaeonBody.Phalanx = { name="Taeon Tabard", augments={'"Fast Cast"+4','Phalanx +3',}}
	
	TaeonHands = {}
    TaeonHands.Phalanx = { name="Taeon Gloves", augments={'"Fast Cast"+4','Phalanx +3',}}
	
	TaeonLegs = {}
    TaeonLegs.Phalanx =	{ name="Taeon Tights", augments={'Phalanx +3',}}
	
	TaeonHead = {}
	TaeonHead.Phalanx = { name="Taeon Chapeau", augments={'Phalanx +3',}}
	
	TaeonFeet = {}
	TaeonFeet.Phalanx = { name="Taeon Boots", augments={'Phalanx +2',}}
	
	
	-- Capes:
    -- Sucellos's And such, add your own.
    DRGCape = {}
	DRGCape.AccDA = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	DRGCape.DEXWS = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	DRGCape.DEXSTP= { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	DRGCape.STRDA = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Magic dmg. taken-10%',}}
	DRGCape.STRWS = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	DRGCape.STRCR = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
	DRGCape.INTWS = { name="Brigantia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%',}}
	DRGCape.FC    = { name="Brigantia's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Damage taken-5%',}}
	DRGCape.Breath=	"Updraft Mantle"
	-- SETS
     
    sets.me = {}        		-- leave this empty
	sets.htp = {}
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
    sets.weapons = {}			-- leave this empty
	sets.me.acc = {}
	sets.me.Shining = {}
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set with refresh for mage subs
    sets.me.idle.refresh = {
		ammo		=	"Crepuscular Pebble",	
		head		=	"Jumalik Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Carmine Cuisses +1",
		feet		=	"Gleti's Boots",
		neck		=	"Loricate Torque +1",
		waist		=	"Carrier's Sash",
		left_ear	=	"Handler's Earring +1",
		right_ear	=	"Odnowa Earring +1",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	DRGCape.FC,
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
		ammo		=	"Crepuscular Pebble",	
		head		=	"Gleti's Mask",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Carmine Cuisses +1",
		feet		=	"Gleti's Boots",
		neck		=	"Dragoon's Collar +2",
		waist		=	"Carrier's Sash",
		left_ear	=	"Handler's Earring +1",
		right_ear	=	"Enmerkar Earring",
		left_ring	=	"Defending Ring",
		right_ring	=	"Moonlight Ring",
		back		=	DRGCape.FC,
    })  

	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist=""}     
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Default sets, used when no Trishula or Shining one, since they have fine tuned builds, needs 25% gear haste, tuning it for naegling /war since main other option
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normalDefault ={
		ammo		=	"Coiste Bodhar",		--3
		head		=	"Flam. Zucchetto +2",	--6
		body		=	"Gleti's Cuirass",	
		hands		=	"Gleti's Gauntlets",	--6 eventually 7
		legs		=	RELIC.Legs,				--10
		feet		=	"Flam. Gambieras +2",	--6
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",		
		right_ear	=	"Sherida Earring",		--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"}, --6
		right_ring	=	"Niqmaddu Ring",
		back		=	DRGCape.AccDA
    }											--
	
    sets.me.melee.accDefault = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Aurgelmir Orb +1",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	AF.Hands,
		legs		=	RELIC.Legs,
		feet		=	AF.Feet,
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Mache Earring +1",
		left_ring	=	"Regal Ring",
        right_ring	=	"Cacoethic Ring +1", 
		back		=	DRGCape.AccDA
    })
    sets.me.melee.dtDefault = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",						--7
		body		=	"Gleti's Cuirass",					--12
		hands		=	"Gleti's Gauntlets",				--7
		legs		=	RELIC.Legs,
		feet		=	"Nyame Sollerets",				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",					--10
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA						--10
    })
	sets.me.melee.mdtDefault = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",						--7
		body		=	"Gleti's Cuirass",					--12
		hands		=	"Gleti's Gauntlets",				--7
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA						--10
    })
	--for getting crit procs
	sets.me.melee.critDefault = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Aurgelmir Orb +1",
		head		=	"Blistering Sallet +1",
		body		=	"Hjarrandi Breast.",
		hands		=	"Flam. Manopolas +2",
		legs		=	"Gleti's Breeches",
		feet		=	"Gleti's Boots",
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Mache Earring +1",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Hetairoi Ring",
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.STRCR
    })
	sets.me.melee.sbDefault = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",
		body		=	"Dagon Breast.",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Digni. Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA
	})
	
	
	------------------------------------------------------------------------------------------------------
	-- Trishula Sets
	-- only used when Trishula equiped
 	------------------------------------------------------------------------------------------------------  
	sets.me.melee.normalTrish = set_combine(sets.me.melee.normalDefault,{   
		ammo		=	"Coiste Bodhar",		--3
		head		=	"Flam. Zucchetto +2",	--6
		body		=	"Gleti's Cuirass",	
		hands		=	"Gleti's Gauntlets",	--6 eventually 7
		legs		=	RELIC.Legs,				--10
		feet		=	"Flam. Gambieras +2",	--6
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",		
		right_ear	=	"Sherida Earring",		--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"}, --6
		right_ring	=	"Niqmaddu Ring",
		back		=	DRGCape.AccDA
    })											--42 +10+20 = 72 stp
    sets.me.melee.accTrish = set_combine(sets.me.melee.accDefault,{
		ammo		=	"Aurgelmir Orb +1",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	AF.Hands,
		legs		=	RELIC.Legs,
		feet		=	AF.Feet,
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Mache Earring +1",
		left_ring	=	"Regal Ring",
        right_ring	=	"Cacoethic Ring +1", 
		back		=	DRGCape.AccDA
    })
    sets.me.melee.dtTrish = set_combine(sets.me.melee.dtDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",						--7
		body		=	"Gleti's Cuirass",					--12
		hands		=	"Gleti's Gauntlets",				--7
		legs		=	RELIC.Legs,
		feet		=	"Nyame Sollerets",				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",					--10
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA						--10
    })
	sets.me.melee.mdtTrish = set_combine(sets.me.melee.dtDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",						--7
		body		=	"Gleti's Cuirass",					--12
		hands		=	"Gleti's Gauntlets",				--7
		legs		=	RELIC.Legs,
		feet		=	"Nyame Sollerets",				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",					--10
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA						--10
    })
	sets.me.melee.critTrish = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Aurgelmir Orb +1",
		head		=	"Blistering Sallet +1",
		body		=	"Hjarrandi Breast.",
		hands		=	"Flam. Manopolas +2",
		legs		=	"Gleti's Breeches",
		feet		=	"Gleti's Boots",
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Mache Earring +1",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Hetairoi Ring",
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.STRCR
    })
	sets.me.melee.sbTrish = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",
		body		=	"Dagon Breast.",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Digni. Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA
	})
	------------------------------------------------------------------------------------------------------
	-- Shining One Sets
	-- only used when Shining one equiped
 	------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalShining = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Coiste Bodhar",			--3
		head		=	"Flam. Zucchetto +2",		--6
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",		--6 eventually 7
		legs		=	RELIC.Legs,					--10
		feet		=	"Flam. Gambieras +2",		--6
		neck		=	"Dgn. Collar +2",		
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",			
		right_ear	=	"Sherida Earring",			--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	"Niqmaddu Ring",
		back		=	DRGCape.AccDA
    })												--42 STP +20 = 62
    sets.me.melee.accShining = set_combine(sets.me.melee.accDefault,{
		ammo		=	"Aurgelmir Orb +1",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	AF.Hands,
		legs		=	RELIC.Legs,
		feet		=	AF.Feet,
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Mache Earring +1",
		left_ring	=	"Regal Ring",
        right_ring	=	"Cacoethic Ring +1", 
		back		=	DRGCape.AccDA

    })
    sets.me.melee.dtShining = set_combine(sets.me.melee.dtDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",						--7
		body		=	"Gleti's Cuirass",					--9
		hands		=	"Gleti's Gauntlets",				--7
		legs		=	RELIC.Legs,
		feet		=	"Nyame Sollerets",					--7
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",					--10
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA						--10
    })
	sets.me.melee.mdtShining = set_combine(sets.me.melee.dtDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",						--7
		body		=	"Gleti's Cuirass",					--9
		hands		=	"Gleti's Gauntlets",				--7
		legs		=	RELIC.Legs,
		feet		=	"Nyame Sollerets",					--7
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",					--10
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA						--10
    })
	sets.me.melee.critShining = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Aurgelmir Orb +1",
		head		=	"Blistering Sallet +1",
		body		=	"Hjarrandi Breast.",
		hands		=	"Flam. Manopolas +2",
		legs		=	"Gleti's Breeches",
		feet		=	"Gleti's Boots",
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Mache Earring +1",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Hetairoi Ring",
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.STRCR
    })
	
	sets.me.melee.sbShining = set_combine(sets.me.melee.normalDefault,{
		ammo		=	"Coiste Bodhar",
		head		=	"Nyame Helm",
		body		=	"Dagon Breast.",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Digni. Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Defending Ring",
		right_ring	=	"Niqmaddu Ring",
		back		= 	DRGCape.AccDA
    })
	
	sets.me.melee.kraken = { --swaps to if kraken is offhand regardless of other settings
		ammo		=	"Aurgelmir Orb +1",
		head		=	"Sulevia's Mask +2",
		body		=	"Hjarrandi Breast.",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Ptero. Brais +3",
		feet		=	"Valorous Greaves",
		neck		=	"Dgn. Collar +2",
		waist		=	"Tempus Fugit",
		left_ear	=	"Telos Earring",
		right_ear	=	"Crep. Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		=	DRGCape.DEXSTP,
		}
		
	
	-- Turtle set used for panic button and is equiped when stunned/stoned
	sets.me.melee.turtle = set_combine(sets.me.melee.dtDefault,{
		ammo		=	"Crepuscular Pebble",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Nyame Flanchard",--RELIC.Legs,
		feet		=	"Nyame Sollerets",
		neck		=	"Dragoon's Collar +2",
		waist		=	"Carrier's Sash",
		left_ear	=	"Handler's Earring +1",
		right_ear	=	"Odnowa Earring +1",
		left_ring	=	"Defending Ring",
		right_ring	=	"Shadow Ring",
		back		= 	DRGCape.FC
	
	})
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
	-- only shining one has unique ws sets since it changes the nature of ws's 
	sets.me["Impulse Drive"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	AF.Legs,
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Sailfi Belt +1",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRWS
	}
	sets.me.acc["Impulse Drive"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	AF.Legs,
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Kentarch Belt +1",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRWS
	}
	sets.me.Shining["Impulse Drive"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	AF.Legs,
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Sailfi Belt +1",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRWS
	}
	sets.htp["Impulse Drive"] = { --this is for overwriting moonshade at high tp
		right_ear	=	"Sherida Earring",
		}
	sets.me["Stardiver"] = {
		ammo		=	"Crepuscular Pebble",
		head		=	RELIC.Head,
		body		=	"Gleti's Cuirass",
		hands		=	"Sulev. Gauntlets +2",--eventually nyame
		legs		=	"Nyame Flanchard",
		feet		=	"Lustra. Leggings +1",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Moonshade Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Sroda Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRDA
	}
	sets.me.acc["Stardiver"] = {
		ammo		=	"Voluspa Tathlum",
		head		=	RELIC.Head,
		body		=	"Dagon Breast.",
		hands		=	"Sulev. Gauntlets +2",
		legs		=	AF.Legs,
		feet		=	AF.Feet,
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Moonshade Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRDA
	}
	
	sets.me.Shining["Stardiver"] = {
		ammo		=	"Crepuscular Pebble",
		head		=	"Blistering Sallet +1",
		body		=	"Gleti's Cuirass",
		hands		=	"Sulev. Gauntlets +2",
		legs		=	"Gleti's Breeches",
		feet		=	"Lustra. Leggings +1",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Moonshade Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRDA
	}
	sets.htp["Stardiver"] = {
		left_ear	=	"Sroda Earring",
	}

	sets.me["Camlann's Torment"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	"Gleti's Breeches",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Fotia Belt",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		= 	DRGCape.STRWS	
	}	
	sets.me.acc["Camlann's Torment"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Kentarch Belt +1",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		= 	DRGCape.STRWS	
	}	
	
	sets.me.Shining["Camlann's Torment"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	"Gleti's Breeches",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Fotia Belt",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		= 	DRGCape.STRWS	
	}
	sets.htp["Camlann's Torment"] = {}
	
	sets.me["Sonic Thrust"] = sets.me["Impulse Drive"]
	sets.me.Shining["Sonic Thrust"] = sets.me.Shining["Impulse Drive"]
	sets.htp["Sonic Thrust"] =sets.htp["Impulse Drive"]
	
	sets.me["Drakesbane"] = {
		ammo		=	"Coiste Bodhar",
		head		=	"Flam. Zucchetto",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	EMPY.Legs,
		feet		=	"Flam. Gambieras",
		neck		=	"Dgn. Collar +2",
		waist		=	"Sailfi Belt +1",
		left_ear	=	"Sroda Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRDA
    }
	sets.me.acc["Drakesbane"] = {
		ammo		=	"Coiste Bodhar",
		head		=	"Flam. Zucchetto",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	AF.Legs,
		feet		=	"Flam. Gambieras",
		neck		=	"Dgn. Collar +2",
		waist		=	"Sailfi Belt +1",
		left_ear	=	"Sroda Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRDA
    }
-- due to extra crit from shining one may have to worry about 100% crit at high tp
    sets.me.Shining["Drakesbane"] = {
		ammo		=	"Coiste Bodhar",
		head		=	"Flam. Zucchetto",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	EMPY.Legs,
		feet		=	"Flam. Gambieras",
		neck		=	"Dgn. Collar +2",
		waist		=	"Sailfi Belt +1",
		left_ear	=	"Sroda Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		=	DRGCape.STRDA
    }
	sets.htp["Drakesbane"] = {}
	sets.me["Raiden Thrust"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Sibyl Scarf",
		waist		=	"Orpheus's Sash",
		left_ear	=	"Moonshade Earring",
		right_ear	=	"Friomisi Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Metamor. Ring +1",
		back		=	DRGCape.INTWS 
	}
	sets.me.acc["Raiden Thrust"] = sets.me["Raiden Thrust"]
	sets.me.Shining["Raiden Thrust"] = sets.me["Raiden Thrust"]
	sets.htp["Raiden Thrust"] = {
		left_ear	= 	"Thrud Earring",
		}
	--max acc and mag acc flamma set usually best followed by relic not wasting inventory slots
	sets.me["Leg Sweep"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Fotia Belt",
		left_ear	=	"Moonshade Earring",
		right_ear	=	"Mache Earring +1",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		= 	DRGCape.STRWS
	}
	sets.me.acc["Leg Sweep"] = sets.me["Leg Sweep"]
	sets.me.Shining["Leg Sweep"] = sets.me["Leg Sweep"]
	sets.htp["Leg Sweep"] = {
		left_ear	= 	"Thrud Earring",
		}
	sets.me["Geirskogul"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	AF.Legs,
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Kentarch Belt +1",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		Back 		=	DRGCape.DEXWS
	}	
	sets.me.acc["Geirskogul"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	AF.Legs,
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Kentarch Belt +1",
		left_ear	=	"Mache Earring +1",
		right_ear	=	"Thrud Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		Back 		=	DRGCape.DEXWS
	}	
	sets.htp["Geirskogul"] = {}

	
    sets.me["Savage Blade"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Sailfi Belt +1",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Sroda Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		= 	DRGCape.STRWS	
    }
	sets.me.acc["Savage Blade"] = {
		ammo		=	"Knobkierrie",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Fotia Belt",
		left_ear	=	"Thrud Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Niqmaddu Ring",
		back 		= 	DRGCape.STRWS	
    }
	sets.htp["Savage Blade"] = {
		right_ear	=	"Sherida Earring",
	}
	-- 80 DEX crit 3 hit ws ftp transfered
    sets.me["Retribution"] = {
        ammo		=	"Knobkierrie",
        head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
        legs		=	AF.Legs, 
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Thrud Earring",
        right_ear	=	"Moonshade Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Niqmaddu Ring", 
        back		=	DRGCape.STRWS,
    }
	 sets.me.acc["Retribution"] = {
        ammo		=	"Knobkierrie",
        head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
        legs		=	AF.Legs, 
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Thrud Earring",
        right_ear	=	"Moonshade Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Regal Ring", 
        back		=	DRGCape.STRWS,
    }
	sets.htp["Retribution"] = {
		right_ear	=	"Sherida Earring",
	}
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	sets.me.Enmity={
		head		=	"Loess Barbuta +1", 	-- +24
        body		=	"Emet Harness +1", 		-- +10
        hands		=	"Gleti's Gauntlets",
        legs		=	"Zoar Subligar +1", 	-- +6
        feet		=	"Rager Ledel. +1", 		-- +7
        neck		=	"Unmoving Collar +1", 	-- +10
        waist		=	"Trance Belt",	 		-- +4
        left_ear	=	"Cryptic Earring", 		-- +4
        right_ear	=	"Trux Earring", 		-- +5
        left_ring	=	"Eihwaz Ring", 			-- +5
        right_ring	=	"Pernicious Ring", 		-- +5
        back		=	DRGCape.AccDA, 			--maybe make enmity cape
	} --+80 now 200 is cap
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
		ammo		=	"Sapience Orb",						--2
		head		=	"Carmine Mask +1",					--14
		body		=	"Sacro Breastplate",				--10
		hands		=	"Leyline Gloves",	 				--8
		legs		=	"Enif Cosciales",					--8
		feet		=	"Carmine Greaves +1",				--8
		neck		=	"Baetyl Pendant",					--4
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Loquac. Earring",					--2
		right_ear	=	"Etiolation Earring", 				--1
		left_ring	=	"Weather. Ring +1",					--6
		right_ring	=	"Prolix Ring",						--2
		back		=	DRGCape.FC							--10
    }											--Total: 	75/80 
	--for utsusemi this nets +6 to 81/80
    sets.precast["Utsusemi: Ichi"] = set_combine(sets.precast.casting,{
		neck		=	"Magoraga Beads",
    })

	sets.precast["Utsusemi: Ni"] = set_combine(sets.precast.casting,{
		neck		=	"Magoraga Beads",
    })
	---------------------
	--Jump sets----------I use jumps for somewhat different things with different weapons these sets reflect that.
	---------------------
	
	--jump tp = (Number of hit)*floor((base tp)*(store tp)*(spirit/soul bonus))+floor((Jump TP bonus)*(Store tp))
	--spirit/soul bonus = 2 for spirit, 3 for soul
	
	sets.jumps= {}
	--------------------------------------------------------------
	--Default Jump Sets this is used for all cases other than Trishula and Shining One, May eventually make a set for naegling as well.
	--------------------------------------------------------------
	sets.jumps.default ={}
	sets.jumps.default.wyv={}
	sets.jumps.default.nowyv={}
	
	sets.jumps.default.wyv.jump = {
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
		}
		--															75 store tp
		-- with naegling need 74 store tp for 4 hits of tp off of DA with AF body
	--without wyvern no reason to use relic body, AF body generates far more tp than needed so drop stp for da where reasonable.
	sets.jumps.default.nowyv.jump = set_combine(sets.jumps.default.wyv.jump,{
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
		})
	--always set relic legs to high jump for more enmity removal with store tp (AF also has -enmity but no store tp)
	sets.jumps.default.wyv.highjump =set_combine(sets.jumps.default.wyv.jump,{
		legs		=	RELIC.Legs,
		})
	sets.jumps.default.nowyv.highjump = set_combine(sets.jumps.default.wyv.hijump,{
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
		})
	
	sets.jumps.default.wyv.spiritjump = set_combine(sets.jumps.default.wyv.jump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8		
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10	
		feet		=	EMPY.Feet,						--60jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Cessance Earring",							--3
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.DEXSTP								--10	
	})	--needs 62 store tp 							
	sets.jumps.default.nowyv.spiritjump = set_combine(sets.jumps.default.wyv.spiritjump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8		
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10	
		feet		=	EMPY.Feet,						--60jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Cessance Earring",							--3
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.DEXSTP								--10
	})
	
	sets.jumps.default.wyv.souljump = {		
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8							
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10	
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							--5
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
		}
													--74jump	--48+15  need 69 store tp
	sets.jumps.default.nowyv.souljump = set_combine(sets.jumps.default.wyv.souljump,{
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
      })
	--------------------------------------------------------------
	--Accuracy Jump sets overwrides other jump sets when I set my tp set to accuracy.
	--------------------------------------------------------------
	sets.jumps.acc ={}
	sets.jumps.acc.wyv={}
	sets.jumps.acc.nowyv={}
	--optimized for 1420 acc
	sets.jumps.acc.wyv.jump = set_combine(sets.jumps.default.wyv.jump,{
		ammo		=	"Voluspa Tathlum",								
		head		=	"Hjarrandi Helm",							
		body		=	RELIC.Body,						
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	sets.jumps.acc.nowyv.jump = set_combine(sets.jumps.default.nowyv.jump,{
		ammo		=	"Voluspa Tathlum",									
		head		=	"Hjarrandi Helm",							
		body		=	AF.Body,									
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	sets.jumps.acc.wyv.highjump = set_combine(sets.jumps.default.wyv.highjump,{
		ammo		=	"Voluspa Tathlum",									
		head		=	"Hjarrandi Helm",							
		body		=	RELIC.Body,						
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	sets.jumps.acc.nowyv.highjump = set_combine(sets.jumps.default.nowyv.highjump,{
		ammo		=	"Voluspa Tathlum",									
		head		=	"Hjarrandi Helm",							
		body		=	AF.Body,								
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	sets.jumps.acc.wyv.spiritjump = set_combine(sets.jumps.default.wyv.spiritjump,{
		ammo		=	"Voluspa Tathlum",								
		head		=	"Hjarrandi Helm",							
		body		=	RELIC.Body,						
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	sets.jumps.acc.nowyv.spiritjump = set_combine(sets.jumps.default.nowyv.spiritjump,{
		ammo		=	"Voluspa Tathlum",								
		head		=	"Hjarrandi Helm",							
		body		=	AF.Body,								
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	sets.jumps.acc.wyv.souljump = set_combine(sets.jumps.default.wyv.souljump,{		
		ammo		=	"Voluspa Tathlum",								
		head		=	"Hjarrandi Helm",							
		body		=	RELIC.Body,						
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	
	sets.jumps.acc.nowyv.souljump = set_combine(sets.jumps.default.nowyv.souljump,{
		ammo		=	"Voluspa Tathlum",									
		head		=	"Hjarrandi Helm",							
		body		=	AF.Body,									
		hands		=	AF.Hands,									
		legs		=	RELIC.Legs,								
		feet		=	AF.Feet,				
		neck		=	"Dgn. Collar +2",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Telos Earring",							
		right_ear	=	"Mache Earring +1",							
		left_ring	=	"Regal Ring",								
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	
		back 		= 	DRGCape.AccDA								
														
		})
	
	--------------------------------------------------------------
	--Trishula Jump sets
	--------------------------------------------------------------
	sets.jumps.trish ={}
	sets.jumps.trish.wyv={}
	sets.jumps.trish.nowyv={}
	--optimized for trish
	sets.jumps.trish.wyv.jump = set_combine(sets.jumps.default.wyv.jump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	RELIC.Body,						
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",							
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA								
														--74jump	--40+20+10=70 stp enough for a DA to reduce normal hits to 1k by 3.
		})
	sets.jumps.trish.nowyv.jump = set_combine(sets.jumps.default.nowyv.jump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8					
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10	
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Brutal Earring",							--1						
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA								
														--113jump	--51+15+10=76 stp 
		})
	sets.jumps.trish.wyv.highjump = set_combine(sets.jumps.default.wyv.highjump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	RELIC.Body,						
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",							
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA									
														--74jump	--43+15+10=68 stp  enough for DA to reduce normal hits to 1k by 3
		})
	sets.jumps.trish.nowyv.highjump = set_combine(sets.jumps.default.nowyv.highjump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8					
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10	
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Brutal Earring",							--1
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA									
														--113jump	--51+15+10=76 stp 
		})
	sets.jumps.trish.wyv.spiritjump = set_combine(sets.jumps.default.wyv.spiritjump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	RELIC.Body,						
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",							
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA		
		})												--74jump  	--40+20+10=70 stp
	sets.jumps.trish.nowyv.spiritjump = set_combine(sets.jumps.default.nowyv.spiritjump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8					
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10	
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Brutal Earring",							--1
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA								
														--113jump	--51+15+10=76 stp 
		})					
	sets.jumps.trish.wyv.souljump = set_combine(sets.jumps.default.wyv.souljump,{		
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	RELIC.Body,						
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",							
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA		
		})												--74jump  	--40+20+10=70 stp 
	
	sets.jumps.trish.nowyv.souljump = set_combine(sets.jumps.default.nowyv.souljump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8					
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10	
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Brutal Earring",							--1
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.AccDA								
														--113jump	--51+15+10=76 stp 					
		})	

	
	--shining one builds require tp builds to reach 2k+ and so have very differant builds.
	sets.jumps.shining ={}
	sets.jumps.shining.wyv={}
	sets.jumps.shining.nowyv={}
	
	sets.jumps.shining.wyv.jump = set_combine(sets.jumps.default.wyv.jump,{
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
														--113jump	--75+20=95 stp  95 stp for 4 hits worth of tp from DA
		})
	sets.jumps.shining.nowyv.jump = set_combine(sets.jumps.default.nowyv.jump,{
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
														--113jump	--75+20=95 stp  95 stp for 4 hits worth of tp from DA
		})
	--always set relic legs to high jump for more enmity removal with store tp (AF also has -enmity but no store tp)
	sets.jumps.shining.wyv.highjump =set_combine(sets.jumps.default.wyv.highjump,{
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
														--113jump	--75+20=95 stp  95 stp for 4 hits worth of tp from DA
		})
	sets.jumps.shining.nowyv.highjump = set_combine(sets.jumps.default.nowyv.highjump,{
		ammo		=	"Aurgelmir Orb +1",							--5
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},	--6
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},	--6
		back 		= 	DRGCape.DEXSTP								--10
														--113jump	--75+20=95 stp  95 stp for 4 hits worth of tp from DA
		})
	
	sets.jumps.shining.wyv.spiritjump = set_combine(sets.jumps.default.wyv.spiritjump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	EMPY.Feet,						--60jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",							
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.DEXSTP								--10
														--133jump	--58+20=78 stp need 76 stp needed for 6 hits worth of tp from DA
	})
	sets.jumps.shining.nowyv.spiritjump = set_combine(sets.jumps.default.nowyv.spiritjump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	EMPY.Feet,						--60jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Dedition Earring",							--8
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.DEXSTP								--10
														--133jump	--66+20 = 86stp 85 store tp to get 4 hits worth from DA
		})
	
	sets.jumps.shining.wyv.souljump = set_combine(sets.jumps.default.wyv.souljump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",							
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.DEXSTP								--10
														--113jump	--58+20=78 stp  76 stp for 8 hits worth from DA
		})
	sets.jumps.shining.nowyv.souljump = set_combine(sets.jumps.default.nowyv.souljump,{
		ammo		=	"Coiste Bodhar",							--3
		head		=	"Hjarrandi Helm",							--7
		body		=	AF.Body,						--39jump	--8
		hands		=	AF.Hands,						--34jump			
		legs		=	RELIC.Legs,									--10
		feet		=	"Ostro Greaves",				--40jump
		neck		=	"Vim Torque +1",							--10
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Sroda Earring",							
		right_ear	=	"Sherida Earring",							--5
		left_ring	=	"Petrov Ring",								--5
		right_ring	=	"Niqmaddu Ring",	
		back 		= 	DRGCape.DEXSTP								--10
														--113jump	--58+20=78 stp  76 stp for 3 hits worth of tp from DA
		})
    ---------------------
    -- Ability Precasting
    ---------------------
	sets.precast["Angon"] = {
		ammo		=	"Angon",
		head 		=	"Volte Cap",
		hands		=	RELIC.Hands,
		feet		=	"Volte Boots",
		legs		=	"Volte Hose",
		waist		=	"Chaac Belt",
		ear1		=	"Dragoon's Earring",
		
		} 
	sets.precast["Ancient Circle"] = {legs=AF.Legs} 
	sets.precast["Spirit Link"] = {
		head="Vishap Armet +3",
		hands="Pel. Vambraces +1",
		feet="Ptero. Greaves +3"
		} 
	sets.precast["Spirit Surge"] = {
		body="Ptero. Mail +3",
		hands="Despair Fin. Gaunt.",
		neck="Dgn. Collar +2",
		ear1="Handler's Earring +1",
		ear2="Lancer's Earring",
		back="Updraft Mantle",
		legs="Vishap Brais +3",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		} 
	sets.precast["Steady Wing"] = {
		hands="Despair Fin. Gaunt.",
		neck="Dgn. Collar +2",
		ear1="Handler's Earring +1",
		ear2="Lancer's Earring",
		back="Updraft Mantle",
		legs="Vishap Brais +3",
		feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
		} 
	sets.precast["Provoke"] = sets.me.Enmity
	sets.precast["Warcry"] = sets.me.Enmity

	
	----------
    -- Midcast
    ----------
	
    
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
	--I do optimize obi use assuming its competing with Orpheus
    sets.midcast.Orpheus = {
        waist="Orpheus's Sash", 
    }  
	--used for ws with ancient circle active, assumes you only use circle when fighting dragons
	sets.midcast.Founders = {
		body="Found. Breastplate",
	}
	
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells, generally want AF head with +hp gear for triggering healing breaths
    sets.midcast.casting = {
		ammo		=	"Egoist's Tathlum",
		head		=	AF.Head,
		body		=	"Hjarrandi Breast.",
		hands		=	"Regal Gloves",--could swap for nyame but its a ton of hp and I do have some excess dt
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2", --could swap for more hp but I'd rather maintain wyvern dt.
		waist		=	"Gold Mog. Belt",
		left_ear	=	"Odnowa Earring +1",
		right_ear	=	"Etiolation Earring",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Moonlight Ring",
		back		=	"Moonlight Cape",
    }


	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = set_combine(sets.midcast.casting, {
        neck		=	"Incanter's Torque",
        waist		=	"Olympus Sash",
        left_ear	=	"Andoaa Earring",
        right_ear	=	"Mimir Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
    })






    -- Phalanx need 500 skill and max phalanx potency
    sets.midcast.phalanx = set_combine(sets.midcast.enhancing.duration, {
        head		=	TaeonHead.Phalanx,
        body		=	TaeonBody.Phalanx,
        hands		=	TaeonHands.Phalanx,
		neck		=	"Incanter's Torque",
        waist		=	"Olympus Sash",
        left_ear	=	"Andoaa Earring",
        right_ear	=	"Mimir Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.duration, {
		hands="Stone Mufflers",
		left_ear="Earthcry Earring",
		
    })
	sets.midcast.BarElement = set_combine(sets.midcast.enhancing.duration,{
	})

    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
		waist="Gishdubar Sash", --20 sec base duration on self is better but only better on self
    })
	
	

	sets.midcast["Flash"] = sets.me.Enmity
	
 	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{


    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		waist="Hachirin-no-Obi",
		back="Twilight Cape"
    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = set_combine(sets.midcast.enhancing.duration, {

    })

	------------
	--DRG Unique
	------------
	
	sets.HealingBreath = set_combine(sets.me.melee.dtTrish,{
		ammo		=	"Crepuscular Pebble",
		head		=	RELIC.Head,
		body		=	{ name="Acro Surcoat", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		hands		=	{ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		legs		=	AF.Legs,
		feet		=	RELIC.Feet,
		neck		=	"Chanoix's Gorget",
		waist		=	"Gold Mog. Belt",
		left_ring	=	"Defending Ring",
		right_ring	=	"Gelatinous Ring +1",
		left_ear	=	"Lancer's Earring",
		right_ear	=	"Odnowa Earring +1",
		back		=	DRGCape.Breath
		})
		-- for elemental breath now 172 mag acc 1 lvl 42 augment breath 28 breath
	sets.ElementalBreath = set_combine(sets.me.melee.dtTrish,{
		ammo		=	"Voluspa Tathlum",
		head		=	RELIC.Head,
		body		=	{ name="Acro Surcoat", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		hands		=	{ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		legs		=	{ name="Acro Breeches", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		feet		=	{ name="Acro Leggings", augments={'Pet: Mag. Acc.+25','Pet: Breath+8',}},
		neck		=	"Dgn. Collar +2",
		waist		=	"Incarnation Sash",
		left_ring	=	"Defending Ring",
		right_ring	=	"C. Palug Ring",
		right_ear	=	"Handler's Earring +1",
		left_ear	=	"Enmerkar Earring",
		back		=	DRGCape.Breath,
		})
	sets.ElementalBreathdt = set_combine(sets.me.melee.dtTrish,{
		ammo		=	"Voluspa Tathlum",
		head		=	RELIC.Head,
		body		=	"Nyame Mail",				--9
		hands		=	"Gleti's Gauntlets",		--7
		legs		=	"Nyame Flanchard",			--8
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Incarnation Sash",			--4
		left_ring	=	"Defending Ring",			--10
		right_ring	=	"C. Palug Ring",			--5
		right_ear	=	"Handler's Earring +1",		
		left_ear	=	"Enmerkar Earring",
		back		=	DRGCape.Breath,				
		})
	sets.ElementalBreathmdt = set_combine(sets.me.melee.dtTrish,{
		ammo		=	"Voluspa Tathlum",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",				--9
		hands		=	"Gleti's Gauntlets",		--7
		legs		=	"Nyame Flanchard",			--8
		feet		=	"Nyame Sollerets",
		neck		=	"Dgn. Collar +2",
		waist		=	"Carrier's Sash",
		left_ring	=	"Defending Ring",			--10
		right_ring	=	"C. Palug Ring",			--5
		right_ear	=	"Handler's Earring +1",		
		left_ear	=	"Enmerkar Earring",
		back		=	DRGCape.Breath,				
		})

	-- Healing Breath is modified by Wyvern Max HP and Wyvern: Breath+
	-- Elemental Breaths are modified by Wyvern Current HP, Wyvern: Breath+, and Pet: Magic Accuracy
	-- Remove Status Breaths are presumably affected by nothing	
	sets.Sleep = set_combine(sets.me.melee.turtle,{
		neck		=	"Vim Torque +1",
		hands 		=	"Gleti's Gauntlets",
	})
	
	
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
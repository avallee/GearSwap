--[[
	Jakey's DRK.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
	Shortcuts add on is assumed still required.
	
		 Toggle Function: 
        gs c toggle melee               Toggle locking of weapons
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
idleModes = M('dt','refresh')
meleeModes = M('normal', 'acc', 'dt', 'sb')
nukeModes = M('normal', 'occult')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Caladbolg','Lycurgos','Apocalypse','Liberator')--,'Drepanum','Kraken Club'
subWeapon = M('Utu Grip')--,''
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
	windower.send_command('bind home gs c nuke cycle')        -- home to Cycles Nuke element
	--windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
	windower.send_command('bind f10 gs c toggle idlemode')       -- F9 to change Idle Mode    
	windower.send_command('bind f11 gs c toggle meleemode')      -- F10 to change Melee Mode  
	windower.send_command('bind !f9 gs c toggle melee') 		-- Alt-F9 Toggle locking of weapons to prevent dread spikes or absorb spells from swapping weapons
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
	--windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	--windower.send_command('bind f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
	windower.send_command('bind ^F10 gs c toggle matchsc')		-- CTRL-F10 to change Match SC Mode      	
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
keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
keybinds_on['key_bind_enspell_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    --send_command('unbind insert')
    --send_command('unbind delete')	
    send_command('unbind !f9')
    --send_command('unbind f11')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
	send_command('unbind !f10')	
    send_command('unbind ^f10')
	send_command('unbind f11')
    send_command('unbind !`')
    send_command('unbind home')
	send_command('unbind !home')
	send_command('unbind ^home')

end

include('DRK_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(2,10) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Ig. Burgeonet +3"
    AF.Body		=	"Ignominy Cuirass +3"
    AF.Hands	=	"Ig. Gauntlets +3"
    AF.Legs		=	"Ig. Flanchard +3"
    AF.Feet		=	"Ig. Sollerets +3"

    --Vitiation
    RELIC.Head		=	"Fall. Burgeonet +3"
    RELIC.Body		=	"Fall. Cuirass +1"
    RELIC.Hands 	=	"Fall. Fin. Gaunt. +3"
    RELIC.Legs		=	"Fall. Flanchard +3"
    RELIC.Feet		=	""

    --Lethargy
    EMPY.Head		=	""
    EMPY.Body		=	"Heath. Cuirass +1"
    EMPY.Hands		=	"Heath. Gauntlets +1"
    EMPY.Legs		=	"Heath. Flanchard +1"
    EMPY.Feet		=	"Heath. Sollerets +1"


	
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
	
	AcroHands = {}
	AcroHands.stp = { name="Acro Gauntlets", augments={'Accuracy+25','"Store TP"+6','STR+7 DEX+7',}}
	
	
	
	-- Capes:
    -- Sucellos's And such, add your own.
    DRKCape = {}
	DRKCape.TP = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	DRKCape.accSTP = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	DRKCape.STRWS = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	DRKCape.STRDA = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	DRKCape.VITWS = { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	DRKCape.FC = { name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	DRKCape.STP = { name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}}

	-- SETS
     
    sets.me = {}        		-- leave this empty
	sets.htp = {}
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
	sets.me.am3 = {} 
    sets.weapons = {}			-- leave this empty
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    sets.me.idle.refresh = {
        ammo		=	"Crepuscular Pebble",
        head		=	"Jumalik Helm",
        body		=	"Jumalik Mail",
        hands		=	"Sakpata's Gauntlets",
        legs		=	"Carmine Cuisses +1",
        feet		=	"Nyame Sollerets",
        neck		=	"Rep. Plat. Medal",
        waist		=	"Carrier's Sash",
        left_ear	=	"Infused Earring",
        right_ear	=	"Odnowa Earring +1",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	DRKCape.TP,
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
		head		=	"Nyame Helm",
		body 		=	"Sakpata's Plate",

    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.refresh,{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- melee sets consider making a DW set if ever becomes relevant
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normal = set_combine(sets.me.idle.normal,{   
        ammo		=	"Coiste Bodhar",
        head		=	"Sakpata's Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Sakpata's Gauntlets",
        legs		=	AF.Legs,
        feet		=	"Sakpata's Leggings",
        neck		=	"Abyssal Beads +2",
        waist		=	"Ioskeha Belt +1", 
        left_ear	=	"Cessance Earring",
        right_ear	=	"Brutal Earring",
		left_ring   =  	"Niqmaddu Ring",
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"}, 
        back		=	DRKCape.TP,   
    })
	sets.me.am3.normal = { --designed for LIberator AM3
		ammo		=	"Aurgelmir Orb +1",
        head		=	"Flam. Zucchetto +2",
        body		=	"Hjarrandi Breast.",
        hands		=	"Sakpata's Gauntlets",
        legs		=	"Odyssean Cuisses", --13 stp
        feet		=	"Valorous Greaves", --cam improve augment
        neck		=	"Abyssal Beads +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Dedition Earring",
        right_ear	=   "Telos Earring",
		left_ring   =  	"Niqmaddu Ring",
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"}, 
        back		=	DRKCape.accSTP  
	}
    sets.me.melee.acc = set_combine(sets.me.melee.normal,{
		ammo		=	"Seeth. Bomblet +1",
		hands		=	"Gazu Bracelet +1",
		waist		=	"Ioskeha Belt +1",
		left_ear	= 	"Mache Earring +1",
		right_ear	=   "Telos Earring",
    })
	sets.me.am3.acc = set_combine(sets.me.am3.normal,{
		hands		=	"Gazu Bracelet +1",
		legs		=	"Flamma Dirs +2",
		feet		=	"Flam. Gambieras +2",
		left_ear	= 	"Mache Earring +1",
		back		=	DRKCape.accSTP
	})
    sets.me.melee.dt = set_combine(sets.me.melee.normal,{ --full sakpata + cape = 50 dt
		legs		=	"Sakpata's Cuisses",
		waist		=	"Sailfi Belt +1",
    })
	sets.me.am3.dt = set_combine(sets.me.am3.normal,{
		head		=	"Sakpata's Helm",
		legs		=	"Sakpata's Cuisses",
		feet		=	"Sakpata's Leggings",
		back		=	DRKCape.accSTP
	})
    sets.me.melee.sb = set_combine(sets.me.melee.normal,{
		ammo		=	"Seeth. Bomblet +1",
		head		=	"Sakpata's Helm",
		body		=	"Dagon Breast.",
		hands		=	"Sakpata's Gauntlets",
		legs		=	"Sakpata's Cuisses",
		feet		=	"Sakpata's Leggings",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Cessance Earring",
		right_ear	=   "Telos Earring",
		left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Defending Ring",--{name="Chirich Ring +1", bag="wardrobe2"}, 

    })
	sets.me.am3.sb = set_combine(sets.me.melee.normal,{ --probably not a great combo
		ammo		=	"Seeth. Bomblet +1",
		head		=	"Sakpata's Helm",
		body		=	"Dagon Breast.",
		hands		=	"Sakpata's Gauntlets",
		legs		=	"Sakpata's Cuisses",
		feet		=	"Sakpata's Leggings",
		waist		=	"Ioskeha Belt +1",
		left_ear	=	"Cessance Earring",
		right_ear	=   "Telos Earring",
		left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Defending Ring",--{name="Chirich Ring +1", bag="wardrobe2"}, 
		back		=	DRKCape.accSTP
    })

	
	sets.me.melee.turtle = set_combine(sets.me.melee.dt,{
		neck		=	"Warder's Charm +1",
		left_ring 	= 	"Shadow Ring",
		right_ring	=	"Defending Ring", -- make mag eva and parry cape or maybe pure mag eva, also carrier's sash

	
	})
	sets.Sleep = set_combine(sets.me.melee.turtle, {
	neck= "Vim Torque +1",
	})
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    --50 STR 50 MND so STR is king large first hit
	sets.me["Resolution"] = {
        ammo		=	"Seeth. Bomblet +1",
        head		=	"Sakpata's Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Sakpata's Gauntlets",
        legs		=	AF.Legs,
        feet		=	"Sakpata's Leggings",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Regal Ring",
        back		=	DRKCape.STRDA
	}
	sets.htp["Resolution"] = {
		left_ear	= "Schere Earring",
	}
	
	sets.me["Torcleaver"] = {
        ammo		=	"Knobkierrie",
        head		=	"Nyame Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Nyame Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Nyame Sollerets",
        neck		=	"Abyssal Beads +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear	=	"Thrud Earring",
        left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Regal Ring",
        back		=	DRKCape.VITWS,
	}
	sets.htp["Torcleaver"] = {
		left_ear	=	"Lugra Earring +1",
	}
	
	sets.me["Guillotine"] = set_combine(sets.me["Torcleaver"],{
		back 		=	DRKCape.STRWS,
	})
	sets.htp["Guillotine"] = {
		left_ear	=	"Lugra Earring +1",
	}
	

	sets.me["Spiral Hell"] = {
        ammo		=	"Knobkierrie",
        head		=	"Nyame Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Nyame Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Nyame Sollerets",
        neck		=	"Abyssal Beads +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear	=	"Thrud Earring",
        left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Epaminondas's Ring",
        back		=	DRKCape.STRWS,
	}
	sets.htp["Spiral Hell"] = {
		left_ear	=	"Lugra Earring +1",
	}
	sets.me["Cross Reaper"] = sets.me["Spiral Hell"]
	sets.htp["Cross Reaper"] = {
		left_ear	=	"Lugra Earring +1",
	}
	sets.me["Catastrophe"] = {
		ammo		=	"Knobkierrie",
        head		=	"Nyame Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Nyame Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Nyame Sollerets",
        neck		=	"Abyssal Beads +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Lugra Earring +1",
        right_ear	=	"Thrud Earring",
        left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Epaminondas's Ring",
        back		=	DRKCape.STRWS,
	}
	sets.htp["Catastrophe"] = {}

	
	sets.me["Entropy"] = {
        ammo		=	"Coiste Bodhar",
        head		=	"Sakpata's Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Sakpata's Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Sakpata's Leggings",
        neck		=	"Abyssal Beads +2",
        waist		=	"Fotia Belt",
        left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Metamor. Ring +1",
        back		=	DRKCape.STRDA --prefer INTDA
	}
	sets.htp["Entropy"] = {
		left_ear	= "Schere Earring",
	}
	sets.me["Quietus"] = sets.me["Spiral Hell"]
	sets.htp["Quietus"] = {
		left_ear	=	"Lugra Earring +1",
	}
	sets.me["Insurgency"] = {
        ammo		=	"Knobkierrie",
        head		=	"Nyame Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Nyame Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Nyame Sollerets",
        neck		=	"Abyssal Beads +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Niqmaddu Ring",
        right_ring	=	"Regal Ring",
        back		=	DRKCape.STRWS,
	}

	sets.htp["Insurgency"] = {
		left_ear	=	"Thrud Earring",
	}
	sets.me["Steel Cyclone"] = sets.me["Guillotine"]
	sets.htp["Steel Cyclone"] = sets.htp["Guillotine"]
	sets.me["Upheaval"] = sets.me["Torcleaver"]
	sets.htp["Upheaval"] = sets.htp["Torcleaver"]
	sets.me["Fell Cleave"] = sets.me["Guillotine"]
	sets.htp["Fell Cleave"] = sets.htp["Guillotine"]
	sets.me["Armor Break"] = {
        ammo		=	"Seeth. Bomblet +1",
        head		=	"Sakpata's Helm",
        body		=	"Sakpata's Plate",
        hands		=	"Sakpata's Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Sakpata's Leggings",
        neck		=	"Abyssal Beads +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Crep. Earring",
        right_ear	=	"Malignance Earring",
        left_ring   =  	"Metamor. Ring +1",
        right_ring	=	"Cacoethic Ring +1",
        back		=	DRKCape.STP,
	}
	sets.htp["Armor Break"] = {}
	sets.me["Weapon Break"] = sets.me["Armor Break"]
	sets.htp["Weapon Break"] = {}
    sets.me["Infernal Scythe"] = {
        ammo		=	"Ghastly Tathlum +1",
        head		=	"Pixie Hairpin +1",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Sibyl Scarf",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Archon Ring",
        back		=	DRKCape.STRWS, --int ws macc/mdmg
    }
	sets.htp["Infernal Scythe"] = {}
	sets.me["Shadow of Death"] = {
        ammo		=	"Ghastly Tathlum +1",
        head		=	"Pixie Hairpin +1",
         body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Sibyl Scarf",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Archon Ring",
        back		=	DRKCape.STRWS, --int ws macc/mdmg
	}
	sets.htp["Shadow of Death"] = {
		left_ear	=	"Friomisi Earring",
	}
	sets.me["Shockwave"] = { --max mag acc
		ammo		=	"Pemphredo Tathlum",
        head		=	"Carmine Mask +1",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
        right_ring	=	"Metamor. Ring +1",
        back		=	DRKCape.FC,
	}
	sets.htp["Shockwave"] = {
		left_ear	=	"Friomisi Earring",
	}
	sets.me["Freezebite"] = {
		ammo		=	"Ghastly Tathlum +1",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Sibyl Scarf",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Metamor. Ring +1",
        back		=	DRKCape.STRWS, --int ws macc/mdmg
	}
	sets.htp["Freezebite"] = {
		left_ear	=	"Friomisi Earring",
	}
	
	-- 50 agi 20 str ranged single hit agi gives ranged acc 3 for 4
	sets.me["Empyreal Arrow"] = {
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Raetic Bangles +1",
        left_ring	=	"Longshot Ring", -- need ranged acc rings    
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        right_ring	=	"Cacoethic Ring +1", 
        back		=	DRKCape.STRWS,
	}
	sets.htp["Empyreal Arrow"] = {
		right_ear	=	"Thrud Earring",
	}
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	
	
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
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast 
    sets.precast.casting = {
		ammo		=	"Sapience Orb",			--2
		head		=	"Carmine Mask +1",		--14
		body		=	"Sacro Breastplate",	--10
		hands		=	"Leyline Gloves",		--8
        legs		=	"Enif Cosciales",		--8
		feet		=	"Odyssean Greaves",		--11
        neck		=	"Baetyl Pendant",    	--4
        waist		=	{name = "Gold Mog. Belt",	 priority = 14},		 
        left_ear	=	{name = "Tuisto Earring", priority = 15},  	--2
        right_ear	=	"Malignance Earring",	--4
        left_ring	=	"Kishar Ring",			--4
        right_ring	=	"Weather. Ring +1",		--6
		back		=	DRKCape.FC				--10
    }											--Total: 83/80

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })

	sets.precast["Impact"] = set_combine(sets.precast.casting,{
		head=empty,
		body="Crepuscular Cloak",
		left_ear	=	"Loquac. Earring",  	--2 this helps mitigate fc lost but still net -22 so 61/80
    })

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

    sets.precast["Blood Weapon"] = {body = RELIC.Body}
	sets.precast["Diabolic Eye"] = {hands = RELIC.Hands}
	sets.precast["Jump"] =set_combine(sets.me.melee.normal,{--could probably optimize more
		hands 		= 	"Crusher Gauntlets",
		feet 		= 	"Ostro Greaves",
	})
	sets.precast["High Jump"] =sets.precast["Jump"]
	sets.precast["Weapon Bash"] = {hands = AF.Hands}
	sets.precast["Arcane Circle"] = {feet = AF.Feet}
	
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
	sets.midcast.Founders = {
		body="Found. Breastplate",
	}
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
	head		=	"Pixie Hairpin +1",
	waist		=	"Sacro Cord",
    left_ring	=	"Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
	waist		=	"Sacro Cord",
    }	

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
 
    }

    sets.midcast.nuking.normal = {
        --main		=	"Maxentius",
        --sub		=	"Ammurapi Shield",
    
        ammo		=	"Ghastly Tathlum +1",
        head		=	"Nyame Helm",
        body		=	"Sacro Breastplate",
        hands		=	"Carmine Fin. Ga. +1",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Sibyl Scarf",
        waist		=	"Slrymir Cord +1",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Mephitas's Ring +1",
        right_ring	=	"Metamor. Ring +1",
        back		=	DRKCape.FC
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		neck		=	"Warder's Charm +1",
        left_ring	=	"Mujin Band",
    })
	
    sets.midcast.nuking.occult = set_combine(sets.midcast.nuking.normal, {
	    ammo		=	"Aurgelmir Orb +1", -- 5
        head		=	"Sulevia's Mask +2",
        body		=	"Hjarrandi Breast.",
        hands		=	AcroHands.stp,
        legs		=	"Odyssean Cuisses", --odyssean can augment to +8 +5 base stp
        feet		=	EMPY.Feet,
        neck		=	"Vim Torque +1",
        waist		=	"Patentia Sash",
        left_ear	=	"Dedition Earring",
        right_ear	=	"Crep. Earring",
        left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
        right_ring	=	"Crepuscular Ring",
        back		=	DRKCape.STP
    })
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.occult = set_combine(sets.midcast.nuking.occult, {

    })	
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod for sleep silence dispel Frazzle II
    sets.midcast.Enfeebling.macc = {
		ammo		=	"Pemphredo Tathlum",
        head		=	"Carmine Mask +1",
        body		=	"Crepuscular Mail",
        hands		=	"Sakpata's Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Sakpata's Leggings",
        neck		=	"Erra Pendant",
        waist		=	"Skymir Cord +1",
        left_ear	=	"Crep. Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Stikini Ring +1",
        right_ring	=	"Stikini Ring +1",
        back		=	DRKCape.FC
		}
	sets.midcast.Enfeebling.maccINT =set_combine(sets.midcast.Enfeebling.macc, {
	})
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {
		--mag acc set
		--[[ammo		=	"Pemphredo Tathlum",
        head		=	"Carmine Mask +1",
        body		=	"Carm. Sc. Mail +1",
        hands		=	"Nyame Gauntlets",
        legs		=	RELIC.Legs,
        feet		=	"Nyame Sollerets",
        neck		=	"Abyssal Beads +2",
        waist		=	"Skymir Cord +1",
        left_ear	=	"Crep. Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Stikini Ring +1",
        right_ring	=	"Stikini Ring +1",
        back		=	DRKCape.FC]]
		
		--enmity set
		ammo		=	"Sapience Orb",
		head		=	"Loess Barbuta +1",
        body		=	"Emet Harness +1",
        hands		=	"Nyame Gauntlets",
        legs		=	"Zoar Subligar +1",
        feet		=	"Nyame Sollerets",
        neck		=	"Unmoving Collar +1",
        waist		=	"Trance Belt",
        left_ear	=	"Cryptic Earring",
        right_ear	=	"Trux Earring",
        left_ring	=	"Eihwaz Ring",
        right_ring	=	"Pernicious Ring",
        back		=	DRKCape.FC
		

	})
	
	sets.midcast["Dread Spikes"] =	{ --max hp + empy body ratri usefull but need su3 and don't go full ratri
		main		=	"Crepuscular Scythe",--this does cost tp/AM so can lock weapon to avoid depending on situation.
		ammo		=	"Egoist's Tathlum", --happy egg can be better or worse 
        head		=	"Ratri Sallet +1",
        body		=	EMPY.Body,
        hands		=	"Ratri Gadlings +1",
        legs		=	"Sakpata's Cuisses", --could go ratri for more hp but dramatic cost in dt.
        feet		=	"Rat. Sollerets +1",
        neck		=	"Unmoving Collar +1",
        waist		=	"Gold Mog. Belt", 
        left_ear	=	"Tuisto Earring",
        right_ear	=	"Odnowa Earring +1",
        left_ring	=	"Moonlight Ring",
        right_ring	=	"Gelatinous Ring +1",--moonlight slightly better
        back		=	"Moonlight Cape"
	}

	
	sets.midcast["Impact"] = { --max mag acc
		ammo		=	"Pemphredo Tathlum",
		head		=	empty,
		body		=	"Crepuscular Cloak",
		hands		=	"Sakpata's Gauntlets",
        legs		=	"Sakpata's Cuisses",
        feet		=	"Sakpata's Leggings",
        neck		=	"Erra Pendant",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Crep. Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
        right_ring	=	"Crepuscular Ring",
        back		=	DRKCape.STP
	}
	
	sets.midcast.OccImpact = set_combine(sets.midcast.nuking.occult, {
		head=empty,
		body="Crepuscular Cloak",

	})
	sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeebling.macc, {
		main="Daybreak",
		sub="Ammurapi Shield",
	})
	--Type B-potency from: Mnd & "Enfeeb Potency" gear for Slow Addle Parralyze (based on dMND and potency not skill or skill already capped)
    sets.midcast.Enfeebling.mndpot = set_combine(sets.midcast.Enfeebling.macc, {

    })
	-- Type C-potency from: Int & "Enfeeb Potency" gear for Blind (based on dINT and potency not skill)
    sets.midcast.Enfeebling.intpot = set_combine(sets.midcast.Enfeebling.macc, {
    })
	--Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear for Poison II no capped skill
    sets.midcast.Enfeebling.skillpot = set_combine(sets.midcast.Enfeebling.macc, {

    })
	-- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear Distract III, Frazzle III cap at 610 skill but want max potency too
    sets.midcast.Enfeebling.skillmndpot = set_combine(sets.midcast.Enfeebling.macc, {
	
    })
	-- Type F-potency from "Enfeebling potency" gear only Gravity (no skill needed)
    sets.midcast.Enfeebling.potency = set_combine(sets.midcast.Enfeebling.macc, {

    })
	--max duration 
	sets.midcast.Enfeebling.Duration= set_combine(sets.midcast.Enfeebling.macc, {
		left_ring = "Kishar Ring",
	})
	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {
        waist		=	"Olympus Sash",
        left_ear	=	"Andoaa Earring",
        right_ear	=	"Thureous Earring",
        left_ring	=	"Stikini Ring +1",
        right_ring	=	"Stikini Ring +1",
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

	sets.midcast["Endark"] = {
		ammo		=	"Pemphredo Tathlum",
		head		=	AF.Head,
		body		=	"Carm. Sc. Mail +1",
        hands		=	RELIC.Hands,
        legs		=	EMPY.Legs,
        feet		=	"Rat. Sollerets +1",
        neck		=	"Incanter's Torque",
        waist		=	"Casso Sash",
        left_ear	=	"Mani Earring",
        right_ear	=	"Dark Earring",
        left_ring	=	"Stikini Ring +1",
        right_ring	=	"Evanescence Ring",
        back		=	"Niht Mantle"
		}
	sets.midcast["Endark II"] = sets.midcast["Endark"]
    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing.duration, {

    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.noSwapDur, {
		ammo="Pemphredo Tathlum",
		waist="Siegel Sash",
		neck="Nodens Gorget",
		hands="Stone Mufflers",
		legs="Shedir Seraweels",
		right_ear="Earthcry Earring",
		
    })
	sets.midcast.BarElement = set_combine(sets.midcast.enhancing.duration,{
		legs="Shedir Seraweels",
	})
	sets.midcast.GainStat = set_combine(sets.midcast.enhancing.duration,{
		hands = RELIC.Hands,
	})
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
		waist="Gishdubar Sash", --20 sec base duration on self
    })
	
	sets.midcast.TH = set_combine(sets.midcast.Enfeebling.Duration,{
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
	})
	
	sets.midcast["Bio"] = sets.midcast.TH
	sets.midcast["Dia"] = sets.midcast.TH
	sets.midcast["Diaga"] = sets.midcast.TH
	sets.midcast["Bio III"] = sets.midcast.TH
	--102 spell interupt rate to be uninteruptable(besides knockback) also want as much +aquaveil as possible
    sets.midcast.aquaveil = set_combine(sets.midcast.enhancing.noSwapDur, {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Amalric Coif +1", 	--+2
		body		=	"Ros. Jaseran +1", 	-- 		25%
		hands		=	"Chronic Gloves", 	-- 		31%
		legs		=	"Shedir Seraweels", 	--+1
		feet		=	"Amalric Nails +1", 	--		16%
		neck		=	"Willpower Torque", 	-- 		5%
		waist		=	"Emphatikos Rope", 	--+1 	12%
        left_ring	=	"Freke Ring", 	-- 		10%
        right_ring	=	"Evanescence Ring",--	5%
	}) 						--total	  +4	104%
	sets.midcast["Blink"] = set_combine(sets.midcast.enhancing.noSwapDur, {
	})
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Pixie Hairpin +1",
		body		=	"Carm. Sc. Mail +1",
		hands		=	RELIC.Hands,
		legs		=	RELIC.Legs,
		feet		=	{name = "Rat. Sollerets +1", priority = 15},
		neck		=	"Erra Pendant",
		waist		=	"Orpheus's Sash",
		left_ear	=	"Nehalennia Earring",
		right_ear	=	"Influx Earring",
		left_ring	=	"Archon Ring",
		right_ring	=	"Evanescence Ring",
		back		=	"Niht Mantle",
    })
	sets.midcast.DSDrain = set_combine(sets.midcast["Drain"],{
		head 		=	RELIC.Head,
	})
	sets.midcast.NVDrain = set_combine(sets.midcast["Drain"],{
		legs 		=	EMPY.Legs,
	})
	sets.midcast.DSNVDrain = set_combine(sets.midcast["Drain"],{
		head 		=	RELIC.Head,
		legs 		=	EMPY.Legs,

	})
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	sets.midcast.Absorb = set_combine(sets.midcast["Drain"], {
		main		=	"Liberator",
		sub			=	"Khonsu",
		ranged		=	"Ullr",
		ammo		=	empty,
		head		=	AF.Head,
		body		=	"Crepuscular Mail",
		waist		=	"Skrymir Cord +1",
		left_ear	=	"Crep. Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Kishar Ring",
		right_ring	=	"Metamor. Ring +1",
		back		=	"Chuparrosa Mantle",
	})
	--focus on magic accuracy
	sets.midcast["Absorb-Attri"] = set_combine(sets.midcast["Drain"], {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Sakpata's Helm",
		body		=	"Crepuscular Mail",
        hands		=	RELIC.Hands,
        legs		=	RELIC.Legs,
        feet		=	AF.Feet,
        neck		=	"Erra Pendant",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Crep. Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	"Metamor. Ring +1",
        back		=	DRKCape.FC
	})
	
	sets.midcast.DSAbsorb = set_combine(sets.midcast.Absorb,{ --DS provides massive mag acc so can use absorb potency/duration gear
		head 		=	RELIC.Head,
		hands		=	"Pavor Gauntlets",
		legs		=	"Black Cuisses",
	})
	sets.midcast.NVAbsorb = set_combine(sets.midcast.Absorb,{
		legs 		=	EMPY.Legs,
	})
	sets.midcast.DSNVAbsorb = set_combine(sets.midcast.Absorb,{
		head 		=	RELIC.Head,
		hands		=	"Pavor Gauntlets",
		legs 		=	EMPY.Legs,
	})
	sets.midcast["Absorb-TP"] = set_combine(sets.midcast["Drain"],{
		hands		=	EMPY.Hands,
		back		=	DRKCape.FC,
	})
	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		ammo="Pemphredo Tathlum",
		body="Jumalik Mail",
		neck="Incanter's Torque",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",


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
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
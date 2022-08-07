--[[
	Jakey's THF.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
	Shortcuts add on is assumed still required.

        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off for locking of weapons
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode. 
        gs c toggle mainweapon			cycles main weapons in the list you defined below
		gs c toggle subweapon			cycles main weapons in the list you defined below
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        

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
idleModes = M('Normal','Refresh')
meleeModes = M('Normal','Acc','DT','TH')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Tauret','Twashtar','Naegling','Karambit')
subWeapon = M("Gleti's Knife",'Centovente','Twashtar','')

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
	--windower.send_command('bind home gs c nuke cycle')        -- home to Cycles Nuke element
	--windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
	windower.send_command('bind f10 gs c toggle idlemode')       -- F9 to change Idle Mode    
	windower.send_command('bind f11 gs c toggle meleemode')      -- F10 to change Melee Mode 
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	--windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
	--windower.send_command('bind !home gs c nuke enspellup')		-- Home Cycle Enspell Up
	--windower.send_command('bind ^home gs c nuke gainup')
	--windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	--windower.send_command('bind f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	--windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
	--windower.send_command('bind ^F10 gs c toggle matchsc')		-- CTRL-F10 to change Match SC Mode      	
	--windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version       
	--windower.send_command('bind ^end gs c hud keybinds')        -- CTRL-End to toggle Keybinds  
	
--[[
    This gets passed in when the Keybinds is turned on.
    IF YOU CHANGED ANY OF THE KEYBINDS ABOVE, edit the ones below so it can be reflected in the hud using the "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F10)'
keybinds_on['key_bind_melee'] = '(F11)'
--keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mainweapon'] = '(ALT-F8)'
keybinds_on['key_bind_subweapon'] = '(CTRL-F8)'
--keybinds_on['key_bind_element_cycle'] = '(INS + DEL)'
--keybinds_on['key_bind_enspell_cycle'] = '(HOME + PgUP)'
keybinds_on['key_bind_lock_weapon'] = '(ALT-F9)'
--keybinds_on['key_bind_matchsc'] = '(F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind !f9')
    send_command('unbind f11')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind !`')
    send_command('unbind home')
	send_command('unbind !home')
	send_command('unbind ^home')
    send_command('unbind !f10')	
    send_command('unbind f10')
end

include('THF_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,3) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Pill. Bonnet +3"
    AF.Body		=	"Pillager's Vest +3"
    AF.Hands	=	""
    AF.Legs		=	"Pill. Culottes +3"
    AF.Feet		=	"Pill. Poulaines +3"

    --Vitiation
    RELIC.Head		=	"Plun. Bonnet +3"
    RELIC.Body		=	"Plunderer's Vest +3"
    RELIC.Hands 	=	"Plun. Armlets +3"
    RELIC.Legs		=	"Plun. Culottes +3"
    RELIC.Feet		=	"Plun. Poulaines +3"

    --Lethargy
    EMPY.Head		=	""
    EMPY.Body		=	""
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	"Skulk. Poulaines +1"

	AdhemHead = {}
	AdhemHead.STR = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemHead.Acc = { name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	
	AdhemBody = {}
	AdhemBody.STR = { name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemBody.FC = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}

	AdhemHands = {}
	AdhemHands.STR = { name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemHands.Acc = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}	

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
	
	HercHands = {}
	HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	HercHands.MABWS = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +4%','INT+10','"Mag.Atk.Bns."+11',}}
	
	HercLegs = {}
	HercLegs.FC = { name="Herculean Trousers", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','"Fast Cast"+6','"Mag.Atk.Bns."+2',}}
	HercLegs.MB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+1%','INT+10','"Mag.Atk.Bns."+11',}}
	
	HercFeet = {}
	HercFeet.FC = { name="Herculean Boots", augments={'Mag. Acc.+9','"Fast Cast"+6',}}
	HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+2%','INT+8','Mag. Acc.+3','"Mag.Atk.Bns."+13',}}
	HercFeet.MABDA = { name="Herculean Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Dbl.Atk."+4','Mag. Acc.+6','"Mag.Atk.Bns."+15',}}

	
	-- Capes:
    -- Sucellos's And such, add your own.
    THFCape = {}
	THFCape.DEXSTP = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	THFCape.DEXCRIT = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	THFCape.DEXWS = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

	-- SETS
     
    sets.me = {}        		-- leave this empty
	sets.htp = {}
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
	sets.me.th = {}
    sets.weapons = {}			-- leave this empty
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    sets.me.idle.Normal = {
		ammo		=	"Crepuscular Pebble",
		head		=	"Gleti's Mask",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Gleti's Breeches",
		feet		=	AF.Feet,
		neck		=	"Rep. Plat. Medal",
		waist		=	"Engraved Belt",
		left_ear	=	"Infused Earring",
        right_ear	=	"Odnowa Earring +1",
		left_ring	=	"Defending Ring",
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		= 	THFCape.DEXSTP 
		}
	sets.me.idle.Refresh = {
		ammo		=	"Crepuscular Pebble",
		head		=	"Gleti's Mask",
		body		=	"Gleti's Cuirass",
		hands		=	"Gleti's Gauntlets",
		legs		=	"Gleti's Breeches",
		feet		=	AF.Feet,
		neck		=	"Loricate Torque +1",
		waist		=	"Engraved Belt",
		left_ear	=	"Infused Earring",
        right_ear	=	"",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		= 	THFCape.DEXSTP 
		}

	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield sets
	------------------------------------------------------------------------------------------------------
    sets.me.melee.Normal ={   
		ammo		=	"Coiste Bodhar",
		head		=	AdhemHead.Acc,
		body		=	AF.Body,
		hands		=	AdhemHands.Acc,
		legs		=	AF.Legs, --"Samnuha Tights",
		feet		=	RELIC.Feet,
		neck		=	"Asn. Gorget +2",
		waist		=	"Reiki Yotai",
		left_ear	=	"Sherida Earring",
		right_ear	=	"Telos Earring",
		left_ring	=	"Hetairoi Ring",
		right_ring	=	"Gere Ring",
		back		= 	THFCape.DEXSTP 
		}
	sets.me.th.Normal = set_combine(sets.me.melee.Normal,{  
		hands		=	RELIC.Hands,
		feet		=	EMPY.Feet,
		waist		=	"Chaac Belt",
	})
    sets.me.melee.Acc = set_combine(sets.me.melee.Normal,{
		ammo		=	"Aurgelmir Orb +1",
		head		=	"Malignance Chapeau",
		legs		=	AF.Legs,
		feet		=	"Malignance Boots",
    })
	sets.me.th.Acc = set_combine(sets.me.melee.Acc,{  
		hands		=	RELIC.Hands,
		feet		=	EMPY.Feet,
		waist		=	"Chaac Belt",
	})
    sets.me.melee.DT = set_combine(sets.me.melee.Normal,{
		ammo		=	"Coiste Bodhar",
		head		=	"Malignance Chapeau",
		body		=	"Malignance Tabard",
		hands		=	"Malignance Gloves",
		legs		=	"Malignance Tights",
		feet		=	"Malignance Boots",
		left_ring	=	"Defending Ring",
    })
	sets.me.th.DT = set_combine(sets.me.melee.DT,{  

		hands		=	RELIC.Hands,
		feet		=	EMPY.Feet,
		right_ring	=	"Moonlight Ring",
		waist		=	"Chaac Belt",
	})
    sets.me.melee.TH = set_combine(sets.me.melee.DT,{
		ammo		=	"Crepuscular Pebble",
		hands		=	RELIC.Hands,
		feet		=	EMPY.Feet,
		right_ring	=	"Moonlight Ring",
		--waist		=	"Chaac Belt",
    })
	sets.me.th.TH = set_combine(sets.me.melee.TH,{  
		head 		=	"Volte Cap",
		waist		=	"Chaac Belt",
	})
	
	sets.me.melee.turtle = set_combine(sets.me.melee.DT,{
		left_ring 	= 	"Shadow Ring",
		right_ring	=	"Defending Ring",
		right_ear	=	"Odnowa Earring +1",

	
	})
	sets.Sleep = set_combine(sets.me.melee.turtle, {
	head= "Frenzy Sallet",
	})
	
	
	
	------------------------------------------------------------------------------------------------------
	--ranged sets
	------------------------------------------------------------------------------------------------------
	sets.me.preshot = {
		ammo		=	"Chapuli Arrow",
		head		=	TaeonHead.Snap,				--10/10
        body		=	TaeonBody.Snap,				--10/10
        hands		=	"Carmine Fin. Ga. +1",		--8
        left_ring	=	"Longshot Ring",   
        legs		=	TaeonLegs.Snap,				--10/10
        feet		=	TaeonFeet.Snap,				--9/10
        neck		=	"Combatant's Torque",
        waist		=	"Yemaya Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Sherida Earring",
        right_ring	=	"Cacoethic Ring +1", 
        back		=	"Sacro Mantle",		
		}									--snapshot 47/48 only need 40 with flurry2 but often dont want to lose haste
	sets.me.midshot = {
		ammo		=	"Chapuli Arrow", --use easily replaced ammo for ranged attacks
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        left_ring	=	"Longshot Ring",   
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Combatant's Torque",
        waist		=	"Yemaya Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Sherida Earring",
        right_ring	=	"Cacoethic Ring +1", 
        back		=	"Sacro Mantle",
		}
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    --50 STR 50 MND so STR is king large first hit
	
	sets.me["Extenterator"] = {
		ammo		=	"C. Palug Stone",
		head		=	AdhemHead.Acc,
		body		=	AF.Body,
		hands		=	AdhemHands.Acc,
		legs		=	AF.Legs,--"Meg. Chausses +2", meg are better but not worth inv slot
		feet		=	RELIC.Feet,
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Sherida Earring",
		right_ear	=	"Brutal Earring",
		left_ring	=	"Ilabrat Ring",
		right_ring	=	"Regal Ring",
		back 		= 	"Sacro Mantle",
	}	
		
	
	
	sets.me["Evisceration"] = {
		ammo		=	"Yetshila +1",
		head		=	AdhemHead.STR,
		body		=	"Gleti's Cuirass",
		hands		=	AdhemHands.STR,
		legs		=	AF.Legs,
		feet		=	"Gleti's Boots",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Moonshade Earring",
		right_ear	=	"Odr Earring",
		left_ring	=	"Regal Ring",
		right_ring	=	"Gere Ring",
		back 		= 	THFCape.DEXCRIT,
		}
	
	sets.htp["Evisceration"] = {
		right_ear	=	"Sherida Earring",
	}
	
	
	sets.me["Rudra's Storm"] = {
		ammo		=	"Crepuscular Pebble",
		head		=	"Nyame Helm",
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Asn. Gorget +2",
		waist		=	"Kentarch Belt +1",
		left_ear	=	"Sherida Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Regal Ring",
		back 		= 	THFCape.DEXWS,
	}
	sets.me.RudraSATA= set_combine(sets.me["Rudra's Storm"],{
		ammo		=	"Yetshila +1",
		head		=	AF.Head,
		body		=	"Gleti's Cuirass",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Asn. Gorget +2",
		waist		=	"Kentarch Belt +1",
		left_ear	=	"Sherida Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Regal Ring",
		back 		= 	THFCape.DEXWS,
	})
	sets.htp["Rudra's Storm"] = {
		right_ear	=	"Odr Earring",
	}
	sets.me["Circle Blade"] = {
		ammo		=	"Seeth. Bomblet +1",
		head		=	AF.Head,
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Asn. Gorget +2",
		waist		=	"Fotia Belt",
		left_ear	=	"Sherida Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Regal Ring",
		back 		= 	THFCape.DEXWS,
		}
	sets.me["Mandalic Stab"]= sets.me["Rudra's Storm"]
	sets.me.MandalicSATA=sets.me.RudraSATA
	sets.me["Savage Blade"] = {
		ammo		=	"Seeth. Bomblet +1",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Asn. Gorget +2",
		waist		=	"Sailfi Belt +1",
		left_ear	=	"Sherida Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Sroda Ring",
		right_ring	=	"Epaminondas's Ring",
		back 		= 	THFCape.DEXWS,--maybe make a str cape if I ever do a lot of savage on thf
	}
	sets.htp["Savage Blade"] = {
		right_ear	=	"Ishvara Earring",
	}
	
	sets.me["Aeolian Edge"] = {
		ammo		=	"Seeth. Bomblet +1",
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
		right_ring	=	"Dingir Ring",
		back 		=	THFCape.DEXWS,

	}
	sets.me["Cyclone"] = sets.me.th.TH
	
	sets.me["Last Stand"] = {
		head		=	"Nyame Helm",
		body		=	"Malignance Tabard",
		hands		=	"Meg. Gloves +2",
		legs		=	"Meg. Chausses +2",
		feet		=	"Malignance Boots",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Telos Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Cacoethic Ring +1",
		back 		= 	"Sacro Mantle",	
	}
	sets.me["Empyreal Arrow"] ={
		head		=	"Nyame Helm",
		body		=	"Malignance Tabard",
		hands		=	"Meg. Gloves +2",
		legs		=	"Meg. Chausses +2",
		feet		=	"Malignance Boots",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Telos Earring",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Epaminondas's Ring",
		right_ring	=	"Cacoethic Ring +1",
		back 		= 	"Sacro Mantle",	
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
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
		ammo		=	"Sapience Orb",			--2
		head		=	"Herculean Helm",		--13
		body		=	AdhemBody.FC,			--10
		hands		=	"Leyline Gloves",		--7 can get to 8
        legs		=	"Enif Cosciales",		--8
		feet		=	HercFeet.FC,			--6
        neck		=	"Baetyl Pendant",    	--4 can get 1 more
        waist		=	"",			 
        left_ear	=	"Loquac. Earring",  	--2
        right_ear	=	"Etiolation Earring",	--1
        left_ring	=	"Prolix Ring",			--2
        right_ring	=	"Weather. Ring +1",		--6
		back		=	THFCape.DEXSTP,
    }											--Total: 61 need 80

    sets.precast["Utsusemi: Ichi"] = set_combine(sets.precast.casting,{
		--neck		=	"Magoraga Beads",
    })

	sets.precast["Utsusemi: Ni"] = set_combine(sets.precast.casting,{
		--neck		=	"Magoraga Beads",
    })
	sets.precast["Dispelga"] = set_combine(sets.precast.casting,{
		main="Daybreak",
		sub="Ammurapi Shield",
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

    sets.precast["Perfect Dodge"] = {hands = RELIC.Hands}
	sets.precast["Steal"] = {
		ammo = "Barathrum",
		head = RELIC.Head,
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		legs = "Malignance Tights",
		feet = AF.Feet,
		}
	sets.precast["Despoil"] ={
		ammo = "Barathrum",
		legs = EMPY.Legs,
		feet = EMPY.Feet,
		}
	--maximize DEX+AGI for max hp drain
	sets.precast["Mug"] ={
		ammo		=	"C. Palug Stone",
		head		=	"Turms Cap",		
		body		=	"Malignance Tabard",
		hands		=	"Malignance Gloves",
        legs		=	AF.Legs,
		feet		=	"Malignance Boots",
        neck		=	"Asn. Gorget +2",	
        waist		=	"Chaac Belt",
        left_ear	=	"Odr Earring",
        right_ear	=	"Mache Earring +1",
		left_ring	=	"Ilabrat Ring",
		right_ring	=	"Regal Ring",	
		back 		= 	"Sacro Mantle",
	}
	sets.precast["Flee"] = {feet = AF.Feet}
	sets.precast["Accomplice"] = {head = EMPY.Head}
	sets.precast["Feint"] = {legs = RELIC.Legs}

	
	
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
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------


    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
        hands		=	RELIC.Hands,
        feet		=	EMPY.Feet,
    }

    sets.midcast.nuking.normal = {
        hands		=	RELIC.Hands,
        feet		=	EMPY.Feet,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {

    })
	
    sets.midcast.nuking.acc = set_combine(sets.midcast.nuking.normal, {

    })
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
    })	
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod for sleep silence dispel Frazzle II
    sets.midcast.Enfeebling.macc = {
        hands		=	RELIC.Hands,
        feet		=	EMPY.Feet,
		}
	sets.midcast.Enfeebling.maccINT =set_combine(sets.midcast.Enfeebling.macc, {
	})
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {

	})
	sets.midcast.OccAcum={
        hands		=	RELIC.Hands,
        feet		=	EMPY.Feet,
		}
	
	sets.midcast["Impact"] = set_combine(sets.midcast.OccAcum, {
		head=empty,
		body="Twilight Cloak",

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
	    hands		=	RELIC.Hands,
        feet		=	EMPY.Feet,
    })
	-- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear Distract III, Frazzle III cap at 610 skill but want max potency too
    sets.midcast.Enfeebling.skillmndpot = set_combine(sets.midcast.Enfeebling.macc, {
	
    })
	-- Type F-potency from "Enfeebling potency" gear only Gravity (no skill needed)
    sets.midcast.Enfeebling.potency = set_combine(sets.midcast.Enfeebling.macc, {
		hands		=	RELIC.Hands,
        feet		=	EMPY.Feet,
    })
	--max duration 
	sets.midcast.Enfeebling.Duration= set_combine(sets.midcast.Enfeebling.macc, {
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
	

	

	--102 spell interupt rate to be uninteruptable(besides knockback) also want as much +aquaveil as possible


	
end
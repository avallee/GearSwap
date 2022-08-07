--[[
        Jakey's MNK.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
		Shortcuts add on is assumed still required.
		
		 Toggle Function: 
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle mainweapon			cycles main weapons in the list you defined below
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
meleeModes = M('normal','acc','pdt','mdt','counterdt')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Godhands','Verethragna','Xoanon','Spharai')--

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
	--windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
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
--keybinds_on['key_bind_subweapon'] = '(CTRL-F8)'
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

include('MNK_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,11) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Anch. Crown +3"
    AF.Body		=	"Anch. Cyclas +3"
    AF.Hands	=	"Anchor. Gloves +3"
    AF.Legs		=	"Anch. Hose +3"
    AF.Feet		=	"Anch. Gaiters +3"

    --Vitiation
    RELIC.Head		=	"Hes. Crown +3"
    RELIC.Body		=	"Hes. Cyclas +3"
    RELIC.Hands 	=	"Hes. Gloves +3"
    RELIC.Legs		=	"Hes. Hose +3"
    RELIC.Feet		=	"Hes. Gaiters +3"

    --Lethargy
    EMPY.Head		=	""
    EMPY.Body		=	"Bhikku Cyclas +1"
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	"Bhikku Gaiters +1"

	AdhemHead = {}
	AdhemHead.STR = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemHead.Acc = { name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
	
	AdhemBody = {}
	AdhemBody.STR = { name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemBody.FC = { name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}}

	AdhemHands = {}
	AdhemHands.STR = { name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}
	AdhemHands.Acc = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}	
	
	HercHands = {}
	HercHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	HercHands.MABWS = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +4%','INT+10','"Mag.Atk.Bns."+11',}}
	HercHands.Counter = { name="Herculean Gloves", augments={'Accuracy+28','"Counter"+5','AGI+1',}}
	
	HercLegs = {}
	HercLegs.FC = { name="Herculean Trousers", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','"Fast Cast"+6','"Mag.Atk.Bns."+2',}}
	HercLegs.MB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+1%','INT+10','"Mag.Atk.Bns."+11',}}
	
	HercFeet = {}
	HercFeet.FC = { name="Herculean Boots", augments={'Mag. Acc.+9','"Fast Cast"+6',}}
	HercFeet.DEXWS = { name="Herculean Boots", augments={'Accuracy+20 Attack+20','Weapon skill damage +4%','DEX+13','Attack+13',}}
    HercFeet.CritDmg={ name="Herculean Boots", augments={'Attack+27','Crit. hit damage +4%','STR+10',}}
	HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+2%','INT+8','Mag. Acc.+3','"Mag.Atk.Bns."+13',}}
	
	
	-- Capes:
    -- Sucellos's And such, add your own.
    MNKCape = {}
	MNKCape.DEXDA = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}
	MNKCape.STRDA = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	MNKCape.STRCRIT = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}
	MNKCape.VITWS = { name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	MNKCape.AccSTP	= { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	MNKCape.VITDA = { name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	MNKCape.Cata = { name="Segomo's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	-- SETS
     
    sets.me = {}        		-- leave this empty
	sets.htp = {}
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
	sets.me.imp = {}
	sets.me.am3 = {}
	sets.me.am3imp = {}
    sets.weapons = {}			-- leave this empty
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    sets.me.idle.normal = {
        ammo		=	"Crepuscular Pebble",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
        feet		=	"Herald's Gaiters",
		neck		=	"Rep. Plat. Medal",
        waist		=	"Engraved Belt",
        left_ear	=	"Eabani Earring",
        right_ear	=	"Odnowa Earring +1",
        left_ring	=	"Defending Ring",
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	MNKCape.AccSTP,
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.normal,{
	--back = MNKCape.DEXDA,
    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.normal,{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield sets
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normal = set_combine(sets.me.idle.normal,{   
        ammo		=	"Coiste Bodhar",
        head		=	AdhemHead.Acc,
        body		=	"Mpaca's Doublet",
        hands		=	AdhemHands.Acc,
        legs		=	RELIC.Legs,
        feet		=	AF.Feet,
		neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
		left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Gere Ring", 
        right_ring	=	"Niqmaddu Ring", 
        back		=	MNKCape.AccSTP,  
    })
	sets.me.imp.normal = set_combine(sets.me.melee.normal,{  
		body		=	EMPY.Body,
	})
	sets.me.am3.normal = set_combine(sets.me.melee.normal,{
		ammo		=	"Coiste Bodhar",
        head		=	AdhemHead.Acc,
        body		=	"Mpaca's Doublet",
        hands		=	"Mpaca's Gloves",
        legs		=	RELIC.Legs,
        feet		=	AF.Feet,
		neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
		left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Gere Ring", 
        right_ring	=	"Niqmaddu Ring", 
        back		=	MNKCape.DEXDA,
	})
	sets.me.am3imp.normal = set_combine(sets.me.melee.normal,{
		ammo		=	"Coiste Bodhar",
        head		=	AdhemHead.Acc,
        body		=	EMPY.Body,
        hands		=	"Mpaca's Gloves",
        legs		=	RELIC.Legs,
        feet		=	AF.Feet,
		neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
		left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Gere Ring", 
        right_ring	=	"Niqmaddu Ring", 
        back		=	MNKCape.DEXDA,
	})
    sets.me.melee.acc = set_combine(sets.me.melee.normal,{
		ammo		=	"Coiste Bodhar",
        head		=	"Ken. Jinpachi +1",
        body		=	"Mpaca's Doublet",
        hands		=	"Malignance Gloves",
        legs		=	"Ken. Hakama +1",
        feet		=	"Ken. Sune-Ate +1",
		neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
		left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Gere Ring", 
        right_ring	=	"Niqmaddu Ring", 
        back		=	MNKCape.AccSTP,  
		
    })
	sets.me.imp.acc = set_combine(sets.me.melee.acc,{  
		body		=	EMPY.Body,
	})
	sets.me.am3.acc = set_combine(sets.me.melee.acc,{
		ammo		=	"Coiste Bodhar",
        head		=	"Ken. Jinpachi +1",
        body		=	"Mpaca's Doublet",
        hands		=	"Mpaca's Gloves",
        legs		=	"Mpaca's Hose",
        feet		=	"Ken. Sune-Ate +1",
		neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
		left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Gere Ring", 
        right_ring	=	"Niqmaddu Ring", 
        back		=	MNKCape.AccSTP,
	})
	sets.me.am3imp.acc = set_combine(sets.me.melee.acc,{
		ammo		=	"Coiste Bodhar",
        head		=	"Ken. Jinpachi +1",
        body		=	EMPY.Body,
        hands		=	"Mpaca's Gloves",
        legs		=	"Mpaca's Hose",
        feet		=	"Ken. Sune-Ate +1",
		neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
		left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Gere Ring", 
        right_ring	=	"Niqmaddu Ring", 
        back		=	MNKCape.DEXDA, 
	})
	 sets.me.melee.pdt = set_combine(sets.me.melee.acc,{
		ammo		=	"Crepuscular Pebble",
        head		=	"Mpaca's Cap",
        body		=	"Mpaca's Doublet",
        hands		=	"Malignance Gloves",
        legs		=	"Mpaca's Hose",
        feet		=	"Ken. Sune-Ate +1",
		neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
		left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
		left_ring	=	"Gere Ring", 
        right_ring	=	"Niqmaddu Ring", 
        back		=	MNKCape.AccSTP,  
    })
	sets.me.imp.pdt = set_combine(sets.me.melee.pdt,{  

	})
	sets.me.am3.pdt = set_combine(sets.me.melee.pdt,{  

	})
	sets.me.am3imp.pdt = set_combine(sets.me.melee.pdt,{  

	})
    sets.me.melee.mdt = set_combine(sets.me.melee.acc,{
		ammo		=	"Crepuscular Pebble",
		body		=	"Malignance Tabard",
		hands		=	"Malignance Gloves",
		legs		=	"Malignance Tights",
		left_ring	=	"Defending Ring",
		back		=	MNKCape.AccSTP,
    })
	sets.me.imp.mdt = set_combine(sets.me.melee.mdt,{  

	})
	sets.me.am3.mdt = set_combine(sets.me.melee.mdt,{  

	})
	sets.me.am3imp.mdt = set_combine(sets.me.melee.mdt,{  

	})
	
    sets.me.melee.counterdt = set_combine(sets.me.melee.normal,{
	    ammo		=	"Hasty Pinion +1",
        head		=	"Nyame Helm",				--			7
        body		=	"Mpaca's Doublet",			--10		10
        hands		=	"Malignance Gloves",		--			5
        legs		=	AF.Legs,					--6			
        feet		=	"Malignance Boots",			--			4
		neck		=	"Bathy Choker +1",			--10
        waist		=	"Moonbow Belt +1",			--			6
        left_ear	=	"Cryptic Earring",			--3
        right_ear	=	"Odnowa Earring +1",		--			3
        left_ring	=	"Defending Ring",			--			10
		right_ring	=	"Gelatinous Ring +1",		--			7
        back		=	MNKCape.DEXDA,  			--10
										--counter 27+39+14=80 dt=50
    })
	sets.me.imp.counterdt = set_combine(sets.me.melee.counterdt,{  
	})
	sets.me.am3.counterdt = set_combine(sets.me.melee.counterdt,{  
	})
	sets.me.am3imp.counterdt = set_combine(sets.me.melee.counterdt,{  
	})
	
	sets.me.melee.turtle = set_combine(sets.me.melee.counterdt,{
		main		=	"Spharai",

	
	})
	sets.Sleep = set_combine(sets.me.melee.dt, {
	head= "Frenzy Sallet",
	})
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    --80 STR transfer fTP crit 10-45%
	sets.me["Victory Smite"] = {
        ammo		=	"Coiste Bodhar",
        head		=	AdhemHead.STR,
        body		=	"Mpaca's Doublet", 		-- 7
        hands		=	"Ryuo Tekko +1", 		-- 5
        legs		=	"Mpaca's Hose",			-- 6 
        feet		=	"Mpaca's Boots",		-- 3
        neck		=	"Fotia Gorget",
        waist		=	"Moonbow Belt +1",
        left_ear	=	"Schere Earring",
        right_ear	=	"Odr Earring",			-- 5
        left_ring   =  	"Gere Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.STRCRIT, 
	}
	--improve non imp set with crit cape crit earring using godhands should realistically look at 80%+ crit rate
	--total crit rate is 15dDex+5merit+50imp+10ws(at 100) so 20% from gear caps at 100%
	sets.me.VictoryImp = set_combine(sets.me["Victory Smite"],{
		body		=	EMPY.Body,
		back		=	MNKCape.STRDA,
		
	})
	sets.htp["Victory Smite"] ={}
	-- 85 dex consider mag acc for the plague effect. tp bonus only improves plague accuracy mpaca where possible will improve this with minimal dps loss
	sets.me["Shijin Spiral"] = {
        ammo		=	"Crepuscular Pebble",
        head		=	"Mpaca's Cap", --mpaca loss of damage but lot more mag acc
        body		=	"Mpaca's Doublet", 
        hands		=	"Mpaca's Gloves",--AdhemHands.STR,
        legs		=	"Mpaca's Hose",
        feet		=	"Mpaca's Boots",
        neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
        left_ear	=	"Mache Earring +1",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.DEXDA,
	}
	sets.htp["Shijin Spiral"] ={}
	--15 str 15 vit capped at 8 hits multi attack does nothing tp bonus is just acc this leaves ws dmg which is super weak and pdl which is good
	sets.me["Asuran Fists"] = {
        ammo		=	"Crepuscular Pebble",
        head		=	RELIC.Head,
        body		=	"Nyame Mail",
        hands		=	AF.Hands,
        legs		=	"Mpaca's Hose",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Tuisto Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Regal Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.VITWS,
	
	}
	sets.htp["Asuran Fists"] = {}
	--40 str 40 vit now high ftp transfer so TA> ws damage
	sets.me["Tornado Kick"] = {
        ammo		=	"Knobkierrie",
        head		=	"Mpaca's Cap",
        body		=	"Mpaca's DOublet",
        hands		=	AdhemHands.STR,
        legs		=	"Mpaca's Hose",
        feet		=	"Mpaca's Boots",
        neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
        left_ear	=	"Schere Earring",
        right_ear	=	"Moonshade Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.STRDA,
	
	}
	--during footwork want all the +kick damage
	sets.me.TornadoFoot = set_combine(sets.me["Tornado Kick"],{
        neck		=	"Mnk. Nodowa +2",
		feet		=	AF.Feet,
	})
	sets.htp["Tornado Kick"] = {
		right_ear	=	"Sherida Earring",
	}
	-- 50 str 50 dex now high ftp transfer so TA > ws damage
	sets.me["Dragon Kick"] = {
        ammo		=	"Knobkierrie",
        head		=	"Mpaca's Cap",
        body		=	"Mpaca's Doublet",
        hands		=	AdhemHands.STR,
        legs		=	"Mpaca's Hose",
        feet		=	"Mpaca's Boots",
        neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.STRDA,
	}
	--durring footwork want all the +kick damage
	sets.me.DragonFoot = set_combine(sets.me["Dragon Kick"],{
        neck		=	"Mnk. Nodowa +2",
		feet		=	AF.Feet,
	})
	sets.htp["Tornado Kick"] = {
		left_ear	=	"Schere Earring",
	}
	--20 str 50 VIT now high ftp transfer so TA > ws damage also 50% bonus attack on it so phys damage limit
	--adjusted for attack not capped
	sets.me["Howling Fist"] = {
        ammo		=	"Coiste Bodhar",
		head		=	"Mpaca's Cap",
        body		=	"Mpaca's Doublet",
        hands		=	AdhemHands.STR,
        legs		=	"Mpaca's Hose",
        feet		=	"Mpaca's Boots",
        neck		=	"Mnk. Nodowa +2", --for the phys dmg limit
        --neck		=	"Rep. Plat. Medal",
		waist		=	"Moonbow Belt +1",
        left_ear	=	"Schere Earring",
        right_ear	=	"Moonshade Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.VITDA,
		--back		=	MNKCape.STRDA,
	}
	sets.htp["Howling Fist"]  = {
		right_ear	=	"Sherida Earring",
	}
	--80 vit 3 ftp first hit so ws damage is good.
	sets.me["Final Heaven"] = {
        ammo		=	"Knobkierrie",
        head		=	RELIC.Head,
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
        left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Regal Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.VITWS,
	}
	sets.htp["Final Heaven"] = {}
	
	--100 str 1 ftp replicating so fotia is king tp only increases area of attack
	sets.me["Spinning Attack"] = {
        ammo		=	"Knobkierrie",
        head		=	RELIC.Head,
        body		=	"Nyame Mail",
        hands		=	AF.Hands,
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Schere Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.STRDA,
	}
	sets.htp["Spinning Attack"] = {}
	--30 str 30 dex high ftp transfer
	sets.me["Raging Fists"] = {
        ammo		=	"Aurgelmir Orb +1",
        head		=	"Mpaca's Cap", 
        body		=	"Mpaca's Doublet",
        hands		=	AdhemHands.STR,
        legs		=	"Mpaca's Hose",
        feet		=	"Mpaca's Boots", 
        neck		=	"Mnk. Nodowa +2",
        waist		=	"Moonbow Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.STRDA,
	}
	sets.htp["Raging Fists"] = {
		left_ear	=	"Schere Earring",
	}
	--100 VIT only used for stun so mag acc, tp bonus improves mag acc.
	sets.me["Shoulder Tackle"] = {
        ammo		=	"Knobkierrie",
        head		=	"Mpaca's Cap",
        body		=	"Mpaca's Doublet",
        hands		=	"Mpaca's Gloves",
        legs		=	"Mpaca's Hose",
        feet		=	"Mpaca's Boots",
        neck		=	"Fotia Gorget",
        waist		=	"Moonbow Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Regal Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.VITWS,
	
	}
	
	sets.me["Cataclysm"] = {
        ammo		=	"Knobkierrie",
        head		=	"Pixie Hairpin +1",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Sibyl Scarf",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Friomisi Earring",
        left_ring   =  	"Epaminondas's Ring",
        right_ring	=	"Archon Ring",
        back		=	MNKCape.Cata, 
	}
	sets.htp["Cataclysm"] = {}--need something to beat 4 mab if I want to get serious.
	sets.me["Shell Crusher"] = {
		ammo		=	"Knobkierrie",
        head		=	"Mpaca's Cap",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
		neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Regal Ring",
        right_ring	=	"Niqmaddu Ring",
        back		=	MNKCape.VITWS,
	}
	sets.htp["Shell Crusher"] = {} --can add more mag acc I guess
	
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
		hands		=	"Leyline Gloves",		--8
        legs		=	HercLegs.FC,			--6
		feet		=	HercFeet.FC,			--6
        neck		=	"Baetyl Pendant",    	--4
        waist		=	"Moonbow Belt +1",			 
        left_ear	=	"Loquac. Earring",  	--2
        right_ear	=	"Etiolation Earring",	--1
        left_ring	=	"Prolix Ring",			--2
        right_ring	=	"Weather. Ring +1",		--6
		back		=	"",		--make a FC cape if doing a lot of /nin
    }											--Total: 59 need 80

    sets.precast["Utsusemi: Ichi"] = set_combine(sets.precast.casting,{
		neck		=	"Magoraga Beads",
    })

	sets.precast["Utsusemi: Ni"] = set_combine(sets.precast.casting,{
		neck		=	"Magoraga Beads",
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

	sets.TH = {
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		legs		=	"Volte Hose"
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
	}

    sets.precast["Hundred Fists"] = {body = RELIC.Legs}
	sets.precast["Chi Blast"] =set_combine(sets.TH,{
		head = RELIC.Head
	})
	sets.precast["Chakra"] ={
		body = AF.Body,
		hands = RELIC.Hands,
	}
	sets.precast["Counterstance"] = {feet = RELIC.Feet}
	sets.precast["Mantra"] = {feet = RELIC.Feet}
	sets.precast["Focus"] = {head = AF.Head}
	sets.precast["Dodge"] = {feet = AF.Feet}
	sets.precast["Footwork"] = {feet = "Shukuyu Sune-Ate"}
	--sets.precast["Impetus"] = sets.me.imp[meleeModes.value]
	--ask sash slow gear or at least no haste gear and then max dt
	sets.precast["Boost"] = {
		ammo		=	"Crepuscular Pebble",
		head		=	"Gnadbhod's Helm",
		body		=	empty,
		hands		=	AF.Hands,
		legs		=	empty,
		feet		=	"Mahant Sandals",
		neck		=	"Justiciar's Torque",
		waist		= 	"Ask Sash",
		left_ring	=	"Defending Ring",
		right_ring	=	"Gelatinous Ring +1",
		left_ear	=	"Tuisto Earring",
		right_ear	=	"Etiolation Earring",
		back		=	MNKCape.AccSTP,  
		}
	
	sets.Boost = {
		ammo		=	"Crepuscular Pebble",
		head		=	"Gnadbhod's Helm",
		body		=	empty,
		hands		=	empty,
		legs		=	empty,
		feet		=	"Mahant Sandals",
		neck		=	"Justiciar's Torque",
		waist		= 	"Ask Sash",
		left_ring	=	"Defending Ring",
		right_ring	=	"Gelatinous Ring +1",
		left_ear	=	"Tuisto Earring",
		right_ear	=	"Etiolation Earring",
		back		=	MNKCape.AccSTP,  
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
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------


    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
 
    }

    sets.midcast.nuking.normal = {

    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
    
        left_ring	=	"Mujin Band",
    })
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod for sleep silence dispel Frazzle II
    sets.midcast.Enfeebling.macc = {
		

		}
	sets.midcast.Enfeebling.maccINT =set_combine(sets.midcast.Enfeebling.macc, {
	})
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {

	})
	sets.midcast.OccAcum={

		}
	

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
	
	sets.midcast.TH = set_combine(sets.me.melee.dt,{
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
	})
	
	sets.midcast["Bio"] = sets.midcast.TH
	sets.midcast["Dia"] = sets.midcast.TH
	sets.precast["Provoke"] = {
		ammo		=	"Sapience Orb",
		head		=	"Halitus Helm",
        body		=	"Emet Harness +1",
        hands		=	"Kurys Gloves",
        legs		=	"Wukong's Haka. +1",
        feet		=	"Rager Ledel. +1",
        neck		=	"Moonlight Necklace",
        waist		=	"Goading Belt",
        left_ear	=	"Cryptic Earring",
        right_ear	=	"Trux Earring",
        left_ring	=	"Eihwaz Ring",
        right_ring	=	"Pernicious Ring",
        back		=	MNKCape.AccSTP, --maybe make enmity cape
		}
	--102 spell interupt rate to be uninteruptable(besides knockback) also want as much +aquaveil as possible


	
end
--[[
	Bubblesandsongs's BRD.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
	Shortcuts add on is assumed still required.
        Custom commands:
        Becasue /sch can be a thing... I've opted to keep this part 
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
		
		gs c nuke sendbuff1				sings base songs
		gs c nuke sendbuff2				sings full potency songs
		gs c nuke cooldown				NITRO
		gs c nuke song1					sing song1
		gs c nuke song2					sing song2
		gs c nuke song3					sing song3
		gs c nuke song4					sing song4
		gs c nuke song5					sing song5
		
		gs c toggle song1				toggles song1
		gs c toggle song1b				toggles song1 other direction
		gs c toggle song2				toggles song2
		gs c toggle song2b				toggles song2 other direction
		gs c toggle song3				toggles song3
		gs c toggle song3b				toggles song3 other direction
		gs c toggle song4				toggles song4
		gs c toggle song4b				toggles song4 other direction
		gs c toggle song5				toggles song5
		gs c toggle song5b				toggles song5 other direction
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off for locking of weapons
        gs c toggle idlemode            Toggles between Refresh, DT and MDT idle mode.
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
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
idleModes = M('dt')
meleeModes = M('normal','acc','dt')
nukeModes = M('normal', 'acc')
songModes = M('potency','base')
songNumber = M('4','5')--how many songs can you sing should be either 3,4 or 4,5

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Carnwenhan','Naegling','Tauret')
subWeapon = M('Genmei Shield','Demers. Degen +1','Crepuscular Knife','Kraken Club')
------------------------------------------------------------------------------------------------------

----------------------------------------------------------
-- Auto CP Cape: Will put on CP cape automatically when
-- fighting Apex mobs and job is not mastered
----------------------------------------------------------
CP_CAPE = "" -- Put your CP cape here
----------------------------------------------------------

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1560    --important to update these if you have a smaller screen
hud_y_pos = 50     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'


-- Setup your Key Bindings here:
	windower.send_command('bind home gs c toggle songmode')        -- toggle between base and potency song modes 
	windower.send_command('bind f10 gs c toggle meleemode')      -- F10 to change Melee Mode 
	windower.send_command('bind !f9 gs c toggle song1')       -- F9 to change Idle Mode    
	windower.send_command('bind ^f9 gs c toggle song1b') 		-- Alt-F9 Toggle Melee mode on / off, locking of weapons
	windower.send_command('bind !F10 gs c toggle song2')		
	windower.send_command('bind ^f10 gs c toggle song2b')     
	windower.send_command('bind !f11 gs c toggle song3')     	
	windower.send_command('bind ^f11 gs c toggle song3b')	
	windower.send_command('bind !f12 gs c toggle song4')
	windower.send_command('bind ^f12 gs c toggle song4b')
	windower.send_command('bind f11 gs c toggle song5')
	windower.send_command('bind f12 gs c toggle song5b')
	windower.send_command('bind !home gs c toggle songnumber')	--CTRL-home

	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.

     	
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

include('BRD_Lib.lua')

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
    AF.Head		=	"Brioso Roundlet +3"
    AF.Body		=	"Brioso Just."
    AF.Hands	=	"Brioso Cuffs +3"
    AF.Legs		=	"Brioso Cannions"
    AF.Feet		=	"Brioso Slippers +3"


    RELIC.Head		=	""
    RELIC.Body		=	"Bihu Jstcorps. +3"
    RELIC.Hands 	=	""
    RELIC.Legs		=	"Bihu Cannions"
    RELIC.Feet		=	"Bihu Slippers +1"


    EMPY.Head		=	"Fili Calot +1"
    EMPY.Body		=	"Fili Hongreline +1"
    EMPY.Hands		=	"Fili Manchettes +1"
    EMPY.Legs		=	"Fili Rhingrave +1"
    EMPY.Feet		=	"Fili Cothurnes +1"

	TelHead = {}
	TelHead.Dur = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}}
	
    TelBod = {}
	TelBod.Dur = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}

	TelHands = {}
	TelHands.Dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}}
	
	TelLeg = {}
	TelLeg.Dur = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	
	TelFeet={}
	TelFeet.Dur = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}

	Lino = {}
	Lino.QA = { name="Linos", augments={'Accuracy+20','"Store TP"+4','Quadruple Attack +3',}}
	Lino.WS = { name="Linos", augments={'Attack+20','Weapon skill damage +3%','STR+6 CHR+6',}}
	-- Capes:
    -- Sucellos's And such, add your own.
    BRDCape = {}
    BRDCape.FC = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	BRDCape.DW = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	BRDCape.STP = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	BRDCape.CHRWS = { name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	BRDCape.STRWS = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	-- SETS
     
    sets.me = {}        		-- leave this empty
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
    sets.weapons = {}			-- leave this empty
	sets.avatar = {}
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set


    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
        neck		=	"Rep. Plat. Medal",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	EMPY.Feet,
		waist		=	"Fucho-no-Obi",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe2"},
		back		=	BRDCape.DW,
    })  
	 sets.avatar.dt = {
		neck		=	"Rep. Plat. Medal",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Assid. Pants +1",
        feet		=	"Artsieq Boots",
		waist		=	"Fucho-no-Obi",
		right_ear	=	"Evans Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe2"},
		back		=	BRDCape.DW,
    }

	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield 11 sets /nin
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw = set_combine(sets.me.idle.normal,{   
		ranged		=	Lino.QA,
        head		=	"Aya. Zucchetto +2",
        body		=	"Ashera Harness",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Aya. Gambieras +2",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Odnowa Earring +1",
        right_ear	=	"Crep. Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe"},
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	BRDCape.DW,   
    })
    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
		ranged		=	Lino.QA,
        head		=	"Aya. Zucchetto +2",
        body		=	"Ashera Harness",
        hands		=	"Gazu Bracelet +1",
        legs		=	"Nyame Flanchard",
        feet		=	"Aya. Gambieras +2",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Odnowa Earring +1",
        right_ear	=	"Crep. Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe"},
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	BRDCape.DW,  
    })
    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
		ranged		=	Lino.QA,
        head		=	"Aya. Zucchetto +2",
        body		=	"Ashera Harness",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Odnowa Earring +1",
        right_ear	=	"Crep. Earring",
		left_ring	=	"Moonlight Ring",
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	BRDCape.DW,
    })
    sets.me.melee.mdtdw = set_combine(sets.me.melee.normaldw,{

    })
	
	sets.me.melee.sbdw = set_combine(sets.me.melee.normaldw,{

	})
	
	------------------------------------------------------------------------------------------------------
	-- Dual Wield 21 sets /dnc
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldn = set_combine(sets.me.idle.normal,{   
        ranged		=	Lino.QA,
        head		=	"Aya. Zucchetto +2",
        body		=	"Ashera Harness",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Aya. Gambieras +2",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Eabani Earring",
        right_ear	=	"Suppanomimi",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe"},
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	BRDCape.DW,        
    })
    sets.me.melee.accdn = set_combine(sets.me.melee.normaldn,{
		hands		=	"Gazu Bracelet +1",
    })
    sets.me.melee.dtdn = set_combine(sets.me.melee.normaldn,{
		ranged		=	Lino.QA,
        head		=	"Nyame Helm",
        body		=	"Ashera Harness",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Eabani Earring",
        right_ear	=	"Suppanomimi",
		left_ring	=	"Moonlight Ring",
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	BRDCape.DW,
    })
    sets.me.melee.mdtdn = set_combine(sets.me.melee.normaldn,{

    })
	
	sets.me.melee.sbdn = set_combine(sets.me.melee.normaldn,{

	})
	------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So canjust put what will be changing when off hand is a shield
 	------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{
		ranged		=	Lino.QA,
        head		=	"Aya. Zucchetto +2",
        body		=	"Ashera Harness",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Aya. Gambieras +2",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"",
        right_ear	=	"Crep. Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe"},
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	BRDCape.STP,   

    })
    sets.me.melee.accsw = set_combine(sets.me.melee.normalsw,{
		hands		=	"Gazu Bracelet +1",
    })
    sets.me.melee.dtsw = set_combine(sets.me.melee.normalsw,{
		ranged		=	Lino.QA,
        head		=	"Aya. Zucchetto +2",
        body		=	"Ashera Harness",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"",
        right_ear	=	"Crep. Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe"},
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
        back		=	BRDCape.STP,
    })
    sets.me.melee.mdtsw = set_combine(sets.me.melee.normalsw,{


    })
	
	sets.me.melee.turtle = set_combine(sets.me.melee.dtsw,{

	
	})
	
	------------------------------------------------------------------------------------------------------
	--ranged sets
	------------------------------------------------------------------------------------------------------
	sets.me.preshot = {

		}									
	sets.me.midshot = {

		}
	
	
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    --50 STR 50 MND high ftp first hit
	sets.me["Savage Blade"] = {
		ranged 		=	Lino.WS,
        head		=	"Nyame Helm",
        body		=	RELIC.Body,
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"",
        right_ear	=	"Moonshade Earring",
		left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Epaminondas's Ring",
        back		=	BRDCape.STRWS,
	}
	sets.me["Mordant Rime"] = {
		ranged 		=	Lino.WS,
		head		=	"Nyame Helm",
        body		=	RELIC.Body,
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Bard's Charm +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Regal Earring", 
        right_ear	=	"Moonshade Earring", --not useful for this ws
		left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Epaminondas's Ring",
        back		=	BRDCape.CHRWS,
	}



	-- 80 DEX crit 3 hit ws ftp transfered
    sets.me["Evisceration"] = {
		ranged 		=	Lino.QA,
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"",
        left_ring   =  	"",
        right_ring	=	"",
        back		=	BRDCape.STRWS,
    }

	

	--dINT INT and DEX does not use su5 so magic damage and dstat aren't devalued
	sets.me["Aeolian Edge"] = {
		ranged 		=	Lino.WS,
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Sibyl Scarf",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"",
        left_ring   =  	"",
        right_ring	=	"",
        back		=	BRDCape.CHRWS,
    }

	
	-- 50 agi 20 str ranged single hit agi gives ranged acc 3 for 4
	sets.me["Empyreal Arrow"] = {
		ammo		=	"Beryllium Arrow",
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        left_ring	=	"Longshot Ring", -- need ranged acc rings    
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Moonshade Earring",
        right_ring	=	"Cacoethic Ring +1", 
        back		=	"",
	}
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
		head		=	EMPY.Head,		
		body		=	"Inyanga Jubbah +2",				
		hands		=	"Leyline Gloves",
        legs		=	"Aya. Cosciales +2",
		feet		=	RELIC.Feet,			
        neck		=	"Voltsurge Torque",    
        waist		=	"Embla Sash",			 
        left_ear	=	"Etiolation Earring", 
        right_ear	=	"Loquac. Earring",
        left_ring	=	"Kishar Ring",
        right_ring	=	"Weather. Ring",	
		back		=	BRDCape.FC,
    }											--

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })
	sets.precast["Honor March"] = set_combine(sets.precast.casting,{
		ranged	=	"Marsyas"
    })
	--need 21 more fc to make up for body and head
	sets.precast["Impact"] = set_combine(sets.precast.casting,{
		head		=	empty,
		body		=	"Twilight Cloak",
    })
	sets.precast["Dispelga"] = set_combine(sets.precast.casting,{
		main="Daybreak",
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

    sets.precast["Soul Voice"] = {legs = RELIC.Legs}
	sets.precast["Troubadour"] = {body = RELIC.Body}
	sets.precast["Nightingale"] = {feet = RELIC.Feet}
	sets.precast["Sublimation"] = {waist="Embla Sash"}
	sets.precast["Provoke"] = sets.me.Enmity
	sets.precast["Warcry"] = sets.me.Enmity

	
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
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.DarkHelix = {
	head		=	"Pixie Hairpin +1",
	waist		=	"Skrymir Cord +1",
    left_ring	=	"Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
	waist		=	"Skrymir Cord +1",
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

	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.maccINT, {
        hands		=	"Regal Cuffs",
        feet		=	"Malignance Boots",
		waist		=	"Acuity Belt +1",
        right_ear	=	"Malignance Earring",
	})
	
	sets.midcast["Impact"] = set_combine(sets.midcast.Enfeebling.maccINT, {
		head=empty,
		body		=	"Twilight Cloak",
		hands		=	"Regal Cuffs",
		feet		=	"Malignance Boots",
		waist		=	"Acuity Belt +1",
		right_ear	=	"Malignance Earring",
		

	})
	--dispel doesn't need duration
	sets.midcast["Dispel"]	= set_combine(sets.midcast.Enfeebling.maccINT, {
		hands		=	"Regal Cuffs",
		right_ear	=	"Malignance Earring",
	})
	sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeebling.maccINT, {
		main		=	"Daybreak",
		sub			=	"Ammurapi Shield",
		hands		=	"Regal Cuffs",
		right_ear	=	"Malignance Earring",
	})

	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {
		main		=	"Oranyan",
		head		=	TelHead.Dur,
		body		=	TelBod.Dur,
		hands		=	TelHands.Dur,
		legs		=	TelLeg.Dur,
		feet		=	TelFeet.Dur,
        neck		=	"",
        waist		=	"Embla Sash",
        left_ear	=	"",
        right_ear	=	"",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe2"},
        back		=	""
    }





    -- Phalanx need 500 skill and max phalanx potency
    sets.midcast.phalanx = set_combine(sets.midcast.enhancing.duration, {

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
		main 		=	"",
		sub			=	"",
		ranged		=	"",
		ammo		=	"",
		legs="Shedir Seraweels",
	})
	sets.midcast.GainStat = set_combine(sets.midcast.enhancing.duration,{
		hands = RELIC.Hands,
	})
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
		head="Amalric Coif +1", --2
    })
	sets.midcast.refreshself = set_combine(sets.midcast.enhancing.duration, {
		head="Amalric Coif +1", --2
		back = "Grapevine Cape",
		waist="Gishdubar Sash", 
    })
	sets.midcast.refreshsend = {
        back = "Grapevine Cape",
		waist="Gishdubar Sash", 
	}
	
	sets.midcast.TH = set_combine(sets.midcast.Enfeebling.Duration,{
	main="",
	sub="",
	ranged="",
	ammo="",
	head="Wh. Rarab Cap +1",
	hands="Chironic Gloves",
	waist="Chaac Belt",
	})

	
	
	sets.midcast["Dia"] = sets.midcast.TH
	sets.midcast["Dia II"] = sets.midcast.TH
	sets.midcast["Diaga"] = sets.midcast.TH
	sets.midcast["Bio II"] = sets.midcast.TH
	sets.midcast["Bio"] = sets.midcast.TH
	sets.midcast["Inundation"] = sets.midcast.TH
	
	sets.midcast["Foe Requiem IV"] = sets.midcast.TH
	sets.midcast["Foe Requiem III"] = sets.midcast.TH
	sets.midcast["Foe Requiem II"] = sets.midcast.TH
	--102 spell interupt rate to be uninteruptable(besides knockback) also want as much +aquaveil as possible, duration caps at 30min regardless of gear
    sets.midcast.aquaveil = set_combine(sets.midcast.enhancing.noSwapDur, {
		ammo		=	"Staunch Tathlum +1", 	--			11%			3% don't count tathlum if using bow
		head		=	"Amalric Coif +1", 		--+2
		body		=	"Ros. Jaseran +1", 		-- 			25%			
		hands		=	"Regal Cuffs", 			--+2
		legs		=	"Shedir Seraweels", 	--+1
		feet		=	"Amalric Nails +1", 	--			16%
		neck		=	"Loricate Torque +1", 	-- 			5%			6%
		waist		=	"Emphatikos Rope", 		--+1 		12%
        left_ring	=	"Freke Ring", 			-- 			10%
        right_ring	=	"Defending Ring",		--						10%
		left_ear	=	"Halasz Earring",		--			5%
		right_ear	=	"Magnetic Earring",		--			8%
		back		=	BRDCape.FC,			--			10%
	}) 								   --total	AV +4  SIRD	102%    pdt 19% can't use bow if worries about SIRD
	

	
	sets.midcast["Blink"] = { 
	
	}
	sets.midcast["Utsusemi: Ichi"] = sets.midcast["Blink"]
	
	sets.midcast["Utsusemi: Ni"] = sets.midcast["Blink"]
	
	sets.midcast["Flash"] = sets.me.Enmity
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        ammo		=	"Pemphredo Tathlum",
		head		=	"Pixie Hairpin +1",
		body		=	"Amalric Doublet +1",
		hands		=	"",
		legs		=	"Chironic Hose",
		feet		=	"",
		neck		=	"Erra Pendant",
		waist		=	"Fucho-no-Obi",
		left_ear	=	"Hirudinea Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Archon Ring",
		right_ring	=	"Evanescence Ring",
		back		=	"",
		})
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency, could make a fast cast cape and try to cap out recast time but close enough.
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		Ammo		=	"Pemphredo Tathlum",
	    head		=	"Vanya Hood",
		body		=	"Vanya Robe",
		hands		=	"Vanya Cuffs",
		legs		=	"Vanya Slops",
		feet		=	"Vanya Clogs",
		neck		=	"",
		waist		=	"Embla Sash",
		left_ear	=	"",
		right_ear	=	"",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	"Janniston Ring",
		back		=	BRDCape.FC,
		

    })

	sets.midcast.song ={}
	sets.midcast.song.base = {--used for low duration songs to overwrite
		ranged		=	"Daurdabla",--extra song instrument
        head		=	EMPY.Head, --madrigal
		body		= 	EMPY.Body, --minuet
		hands		=	EMPY.Hands, --march
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Moonbow Whistle +1",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"",
        right_ear	=	"",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe2"},
        back		=	BRDCape.FC,
		}
	sets.midcast.song.potency = {
		main		=	"Carnwenhan",
		ranged		=	"Gjallarhorn",
		head		=	EMPY.Head, --madrigal
		body		= 	EMPY.Body, --minuet
		hands		=	EMPY.Hands, --march
		legs		=	"Inyanga Shalwar +2",
		feet		=	AF.Feet,
		neck		=	"Moonbow Whistle +1",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"",
        right_ear	=	"",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe2"},
        back		=	BRDCape.FC,
		}
		
	sets.midcast["Honor March"] = set_combine(sets.midcast.song.potency, {
		ranged		=	"Marsyas"
	})

	sets.midcast.Lullaby = set_combine(sets.midcast.song.potency, {
		ranged		=	"Blurred Harp +1",
		head 		= 	AF.Head,
		hands 		= 	AF.Hands,
		left_ear	=	"Regal Earring",
        right_ear	=	"Gersemi Earring",
		waist		=	"Acuity Belt +1"
		})
		
		--String skill increases aoe with a harp at 486, 567 and 648 skill tiers
	sets.midcast.Requiem = sets.midcast.Lullaby
	sets.midcast.Threnody = set_combine(sets.midcast.Lullaby, {
		body		=	"Mou. Manteel +1",
	})
	sets.midcast.Songdebuff = sets.midcast.Lullaby
	sets.midcast.Paeon = set_combine(sets.midcast.song.potency, {
		head = AF.Head,
		})
	sets.midcast.Ballad = set_combine(sets.midcast.song.potency, {
		legs = EMPY.Legs,
		})
	sets.midcast.Scherzo = set_combine(sets.midcast.song.potency, {
		feet = EMPY.Feet,
		})
	sets.midcast.Etude = set_combine(sets.midcast.song.potency, {
		head = "Mousai Turban +1",
		})
	sets.midcast.Carol = set_combine(sets.midcast.song.potency, {
		hands = "Mousai Gages +1",
		})
	
	sets.midcast.Minne = set_combine(sets.midcast.song.potency, {
		legs = "Mou. Seraweels +1",
		})
	
	sets.midcast.Mambo = set_combine(sets.midcast.song.potency, {
		feet = "Mou. Crackows +1",
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
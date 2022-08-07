--[[	
	Jakey's BLM.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
	Shortcuts add on is assumed still required.
	
        Custom commands:
        Becasue /sch can be a thing... I've opted to keep this part 
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
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
		gs c toggle vroom				cycles idle feet for either flee or heralds
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking
        gs c nuke cycledown             Cycles element type for nuking in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
		gs c nuke t6					Cast tier 6 nuke of saved element
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
--mote_include_version = 2
-- Load and initialize the include file.
--include('Mote-Include.lua')

include('organizer-lib') -- optional
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'death')
meleeModes = M('normal', 'acc')
nukeModes = M('normal', 'acc', 'naked','occult')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Laevateinn',"Archmage's Staff")
subWeapon = M('Khonsu','Rigorous Grip +1')
vroom = M("Herald's Gaiters","Hippo. Socks +1")
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
	windower.send_command('bind !f11 gs c toggle meleemode')      -- F10 to change Melee Mode  
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
	--windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	--windower.send_command('bind f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	windower.send_command('bind f11 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
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

include('BLM_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,5) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()

    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty
	-- Fill this with your own JSE. 

    AF.Head		=	""
    AF.Body		=	"Spaekona's Coat +3"
    AF.Hands	=	""
    AF.Legs		=	"Spae. Tonban +3"
    AF.Feet		=	""


    RELIC.Head		=	"Arch. Petasos +3"
    RELIC.Body		=	"Arch. Coat +3"
    RELIC.Hands 	=	"Arch. Gloves +3"
    RELIC.Legs		=	"Arch. Tonban +3"
    RELIC.Feet		=	"Arch. Sabots +3"


    EMPY.Head		=	""
    EMPY.Body		=	""
    EMPY.Hands		=	""
    EMPY.Legs		=	""
    EMPY.Feet		=	"Wicce Sabots +1"
    

    TelBod = {}
	TelBod.Dur = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
	TelBod.Reg = { name="Telchine Chas.", augments={'"Fast Cast"+4','"Regen" potency+3',}}
	
	TelHead = {}
	TelHead.Dur = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
	
	TelHand = {}
	TelHand.Dur = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}}
	
	TelLeg = {}
	TelLeg.Dur = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	TelLeg.Reg = { name="Telchine Braconi", augments={'"Regen" potency+3',}}
	
	TelFeet={}
	TelFeet.Dur = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}

	MerlHead = {}
	MerlHead.MB = { name="Merlinic Hood", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Magic burst dmg.+10%','INT+7','"Mag.Atk.Bns."+8',}}
	
	MerlBody = {}
	MerlBody.FC = { name="Merlinic Jubbah", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+8',}}
	
	MerlLegs = {}
	MerlLegs.MB = { name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','INT+9','Mag. Acc.+5',}}
	MerlLegs.TH = { name="Merlinic Shalwar", augments={'Accuracy+3','AGI+3','"Treasure Hunter"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	
	MerlFeet = {}
	MerlFeet.FC = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+7',}}
	MerlFeet.Occ = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+7','"Occult Acumen"+11','INT+9','Mag. Acc.+1',}}
	
	MerlHands = {}
	MerlHands.Aspir = { name="Merlinic Dastanas", augments={'Mag. Acc.+16','"Drain" and "Aspir" potency +11','INT+7',}}
	MerlHands.Ref = { name="Merlinic Dastanas", augments={'Accuracy+8','INT+1','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	MerlHands.Occ = { name="Merlinic Dastanas", augments={'Mag. Acc.+14','"Occult Acumen"+11','MND+5',}}
	
	
	
	
	
	
	-- Capes:
	Tara = {}
	Tara.INTMAB ={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	Tara.INTWS = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Tara.DEXSTP = { name="Taranus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
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
    sets.me.idle.refresh = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Befouled Crown",
		body		=	"Jhakri Robe +2",
		hands		=	MerlHands.Ref,
		legs		=	"Assid. Pants +1",
		feet		=	"Herald's Gaiters",
		neck		=	"Rep. Plat. Medal",
		waist		=	"Fucho-no-Obi",
		right_ear	=	"Evans Earring",
		left_ear	=	"Etiolation Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back=Tara.INTMAB,
    }
	sets.me.warder = {
		neck 		=	"Warder's Charm +1",
		}
	sets.me.chrys =	{
		neck		=	"Chrys. Torque",
		}
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
		ammo		=	"Crepuscular Pebble",
		head		=	"Nyame Helm",
		body		=	"Agwu's Robe",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Herald's Gaiters",
		left_ear	=	"Odnowa Earring +1",
		neck		=	"Rep. Plat. Medal",
		waist		=	{name = "Shinjutsu-no-Obi +1", priority = 13},
		left_ring	=	"Defending Ring",
        right_ring	=	{name = "Mephitas's Ring +1", priority = 11},
		left_ear	=	"Influx Earring",
		right_ear	=	"Nehalennia Earring",
		back		=	Tara.INTMAB,
    })  
		 
    sets.me.idle.death = set_combine(sets.me.idle.refresh,{
		ammo		=	"Ghastly Tathlum +1",
		head		=	{name = "Amalric Coif +1", priority = 13},
		body		=	{name = "Amalric Doublet +1", priority = 15},
		hands		=	MerlHands.Ref,
		legs		=	"Assid. Pants +1",
		feet		=	{name = "Amalric Nails +1", priority = 14},
		neck		=	"Rep. Plat. Medal",
		waist		=	{name = "Shinjutsu-no-Obi +1", priority = 12},
		right_ear	=	"Evans Earring",
		left_ear	=	"Etiolation Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name = "Mephitas's Ring +1", priority = 11},
		back		=	"Aurist's Cape +1",
    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield sets
	------------------------------------------------------------------------------------------------------
    sets.me.melee= set_combine(sets.me.idle.normal,{   
		ammo		=	"Crepuscular Pebble",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Gazu Bracelet +1",
		legs		=	"Jhakri Slops +2",
		feet		=	"Nyame Sollerets",
		neck		=	"Combatant's Torque",
		waist		=	"Windbuffet Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Cessance Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		=	Tara.DEXSTP,   
	})
	------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So canjust put what will be changing when off hand is a shield
 	------------------------------------------------------------------------------------------------------   
	
	sets.me.melee.turtle = set_combine(sets.me.idle.dt ,{
	
	})
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    sets.me["Shattersoul"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Fotia Gorget",
		waist		=	"Acuity Belt +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Mache Earring +1",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Cacoethic Ring +1",
		back		=	Tara.DEXSTP, --maybe make a melee ws cape
    }
	
	sets.me["Full Swing"]= sets.me["Shattersoul"]
	sets.me["Retribution"]= sets.me["Shattersoul"]
	sets.me["Spirit Taker"]= sets.me["Shattersoul"]
	sets.me["Shell Crusher"]= sets.me["Shattersoul"]
	
	
    sets.me["Myrkr"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Amalric Coif +1",
		body		=	"Amalric Doublet +1",
		hands		=	"Regal Cuffs",
		legs		=	"Amalric Slops +1",
		feet		=	"Amalric Nails +1",
		neck		=	"Nodens Gorget",
		waist		=	"Shinjutsu-no-Obi +1",
		left_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear	=	"Etiolation Earring",
		left_ring	=	"Mephitas's Ring",
		right_ring	=	"Mephitas's Ring +1",
		back		=	"Aurist's Cape +1",
    }
	
	sets.me["Vidohunir"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Pixie Hairpin +1",
		body		=	"Nyame Mail",
		hands		=	"Jhakri Cuffs +2",
		legs		=	"Nyame Flanchard",
		feet		=	"Agwu's Pigaches",
		neck		=	"Src. Stole +2",
		waist		=	"Orpheus's Sash",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Freke Ring",
		back		=	Tara.INTWS,
    } 
	
	sets.me["Cataclysm"] = set_combine(sets.me["Vidohunir"],{ 
		neck		=	"Saevus Pendant +1",
		right_ear	=	{ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring	=	"Archon Ring",
		right_ring	=	"Epaminondas's Ring",
	})
	sets.htp["Cataclysm"] = { 
		right_ear	=	"Malignance Earring",
	}
	sets.me["Sunburst"] = sets.me["Cataclysm"]
	sets.htp["Sunburst"] = sets.htp["Cataclysm"] 	
	sets.me["Starburst"] = sets.me["Cataclysm"]
	sets.htp["Starburst"] = sets.htp["Cataclysm"]
	
	sets.me["Rock Crusher"] = set_combine(sets.me["Cataclysm"],{
	head 		= 	"Agwu's Cap",
	neck 		=	"Quanpur Necklace",
	left_ring	=	"Freke Ring",
	})
	sets.htp["Rock Crusher"] = { 
		right_ear	=	"Malignance Earring",
	}
	sets.me["Earth Crucher"] =sets.me["Rock Crusher"]
	sets.htp["Earth Crucher"] =sets.htp["Rock Crusher"]
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
		ammo		=	"Ghastly Tathlum +1",
		head		=	{name = "Amalric Coif +1", priority = 13},
		body		=	"Zendik Robe",
		hands		=	{name = "Regal Cuffs", priority = 12},
		legs		=	{name = "Amalric Slops +1", priority = 14},
		feet		=	MerlFeet.FC,
		neck		=	"Baetyl Pendant",
		waist		=	{name = "Shinjutsu-no-Obi +1", priority = 11},
		left_ear	=	"Etiolation Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Weather. Ring +1",
		right_ring	=	{name = "Mephitas's Ring +1", priority = 15},
		back		=	"Fi Follet Cape +1",
    }	

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })

	sets.precast["Impact"] = set_combine(sets.precast.casting,{
		head=empty,
		body="Crepuscular Cloak",
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

    sets.precast["Manafont"] = {body = RELIC.Body}
	
	sets.buff["Mana Wall"] = {
		feet="Wicce Sabots +1",
		back=Tara.INTMAB,
	}
	sets.buff.ManaStaff = {
		main = "Archmage's Staff",
		back = Tara.INTMAB,
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
 
        --main		=	"Maxentius",
        --sub		=	"Ammurapi Shield",
        ammo		=	"Pemphredo Tathlum",
        --head		=	Merl.Head.ACC,
        --body		=	Amal.Body.A,
        --hands		=	Amal.Hands.D,
        --legs		=	Amal.Legs.A,
        --feet		=	Amal.Feet.A,
        --neck		=	"Dls. Torque +2",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        back		=	Tara.INTMAB,
        left_ring	=	"Metamor. Ring +1",  
        right_ring	=	"Freke Ring",
    }

    sets.midcast.nuking.normal = {
        --main		=	"Maxentius",
        --sub		=	"Ammurapi Shield",
    
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
		body		=	AF.Body,
        hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
        neck		=	"Sibyl Scarf",
        waist		=	"Acuity Belt +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Freke Ring",
        back		=	Tara.INTMAB
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
		ammo		=	"Ghastly Tathlum +1",
        head		=	"Ea Hat +1",-- switch to agwu at r25
		body		=	AF.Body,
        hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
        neck		=	"Mizu. Kubikazari",
    })
	
    sets.midcast.nuking.acc = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
        body		=	"Agwu's Robe",
        hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
        neck		=	"Sibyl Scarf",
        waist		=	"Acuity Belt +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Freke Ring",
        back		=	Tara.INTMAB
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
		ammo		=	"Ghastly Tathlum +1",
        head		=	"Ea Hat +1",-- switch to agwu at r25
		body		=	"Ea Houppe. +1",
        hands		=	"Agwu's Gages",
        legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
        neck		=	"Mizu. Kubikazari",
    })	
	sets.midcast.nuking.naked = {
		ammo		=	empty,
		head		=	empty,
        body		=	AF.Body,
        hands		=	empty,
        legs		=	empty,
        feet		=	empty,
        neck		=	empty,
        waist		=	"Acuity Belt +1",
        left_ear	=	empty,
        right_ear	=	empty,
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	empty,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.naked = set_combine(sets.midcast.nuking.naked, {
    })	
	
	sets.me.Occult={
		ammo		=	"Seraphic Ampulla",
		head		=	"Mall. Chapeau +2",
		body		=	AF.Body,
		hands		=	MerlHands.Occ,
		legs		=	"Perdition Slops",
		feet		=	MerlFeet.Occ,
		neck		=	"Combatant's Torque",
		waist		=	"Patentia Sash",
		left_ear	=	"Crep. Earring",
		right_ear	=	"Dedition Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	"Crepuscular Ring",
		back		=	Tara.DEXSTP,
	}
	sets.midcast.nuking.occult = sets.me.Occult
	sets.midcast.MB.occult = sets.midcast.MB.acc
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod for sleep silence dispel Frazzle II
    sets.midcast.Enfeebling.macc = {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Amalric Coif +1",
		body		=	AF.Body,
		hands		=	"Regal Cuffs",
		legs		=	AF.Legs,
		feet		=	RELIC.Feet,
		neck		=	"Incanter's Torque",
		waist		=	"Acuity Belt +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1",
		}
	sets.midcast.Enfeebling.maccINT =set_combine(sets.midcast.Enfeebling.macc, {
	})
	
	--max INT and Mag Acc with Relic Legs and Feet enfeebling magic and duration is useless
	sets.midcast["ElementalEnfeeble"]= {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Amalric Coif +1",
		body		=	"Amalric Doublet +1",
		hands		=	"Regal Cuffs",
		legs		=	RELIC.Legs,
		feet		=	RELIC.Feet,
		neck		=	"Incanter's Torque",
		waist		=	"Acuity Belt +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Mephitas's Ring +1",
		back		=	"Aurist's Cape +1",
	
	}
	
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.macc, {

	})
	
	sets.midcast["Impact"] = set_combine(sets.midcast.Enfeebling.macc, {
		ammo		=	"Pemphredo Tathlum",
		head		=	empty,
		body		=	"Crepuscular Cloak",
		hands		=	RELIC.Hands,
		legs		=	AF.Legs,
		feet		=	"Agwu's Pigaches",
		neck		=	"Src. Stole +2",
		waist		=	"Acuity Belt +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1"

	})
	
	sets.midcast.OccImpact = set_combine(sets.me.Occult,{
		head		=	empty,
		body		=	"Crepuscular Cloak",
	})
	sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeebling.macc, {
		main="Daybreak",
		sub="Ammurapi Shield",
	})
	sets.midcast['Comet'] = set_combine(sets.midcast.MB.normal, {
		head="Pixie Hairpin +1",
		right_ring="Archon Ring",
	})
	--death magic dmg is capped at 32, otherwise current mpx3, mab, affinity based no int.
	sets.midcast['Death'] = set_combine(sets.midcast.MB.acc, {
		head		=	{name = "Pixie Hairpin +1", priority = 11},
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	{name = "Amalric Slops +1", priority = 13},
		feet		=	{name = "Amalric Nails +1", priority = 12},
		neck 		=	"Mizu. Kubikazari",
		waist		=	"Skrymir Cord +1",
		left_ear	=	"Friomisi Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Archon Ring",
		right_ring	=	{name = "Mephitas's Ring +1", priority = 15},
	
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
		ammo		=	"Ghastly Tathlum +1",
		head		=	TelHead.Dur,
		body		=	TelBod.Dur,
		hands		=	TelHand.Dur,
		legs		=	TelLeg.Dur,
		feet		=	TelFeet.Dur,
		neck		=	"Incanter's Torque",
		waist		=	{name = "Shinjutsu-no-Obi", priority = 14},
		left_ear	=	{name = "Etiolation Earring", priority = 15},
		right_ear	=	"Mimir Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name = "Mephitas's Ring +1", priority = 13},
		back		=	"FI Follet Cape +1"
    }
	sets.midcast.enhancing.noSwapDur = set_combine(sets.midcast.enhancing.duration, {
		main 		=	"",
		sub			=	"",
	
	})
    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {
    }) 

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {

    })  


    -- Phalanx
    sets.midcast.phalanx =  set_combine(sets.midcast.enhancing.duration, {
    })

    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.noSwapDur, {
		waist="Siegel Sash",
		neck="Nodens Gorget",
		legs="Shedir Seraweels",
		right_ear="Earthcry Earring",
		
    })
	sets.midcast.BarElement = set_combine(sets.midcast.enhancing.duration,{
		legs="Shedir Seraweels",
	})
	sets.midcast.GainStat = set_combine(sets.midcast.enhancing.duration,{
	})
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
		head="Amalric Coif +1", --2
    })
	sets.midcast.RefreshSelf = set_combine(sets.midcast.refresh ,{
		waist		=	"Gishdubar Sash",
		back 		=	"Grapevine Cape",
	})
	
	sets.midcast.TH = set_combine(sets.midcast.Enfeebling.Duration,{
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
	})
	
	sets.midcast["Dia III"] = sets.midcast.TH
	sets.midcast["Dia"] = sets.midcast.TH
	sets.midcast["Diaga"] = sets.midcast.TH
    sets.midcast.aquaveil = set_combine(sets.midcast.enhancing.noSwapDur, {
		ammo		=	"Staunch Tathlum +1", 	--			11%			3% don't count tathlum if using bow
		head		=	"Amalric Coif +1", 		--+2
		body		=	"Ros. Jaseran +1", 		-- 			25%			
		hands		=	"Regal Cuffs", 			--+2
		legs		=	"Shedir Seraweels", 	--+1
		feet		=	"Amalric Nails +1", 	--			16%
		neck		=	"Loricate Torque +1", 	-- 						6%
		waist		=	"Emphatikos Rope", 		--+1 		12%
        left_ring	=	"Freke Ring", 			-- 			10%
        right_ring	=	"Evanescence Ring",		--			5%
		left_ear	=	"Halasz Earring",		--			5%
		right_ear	=	"Magnetic Earring",		--			8%
		back 		=	Tara.INTMAB	
	})
	sets.midcast["Blink"] = set_combine(sets.midcast.enhancing.noSwapDur, {
	})
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Pixie Hairpin +1",
		body		=	"Amalric Doublet +1",
		hands		=	MerlHands.Aspir,
		legs		=	AF.Legs,
		feet		=	"Agwu's Pigaches",
		neck		=	"Erra Pendant",
		waist		=	"Fucho-no-Obi",
		left_ear	=	"Hirudinea Earring",
		right_ear	=	"Etiolation Earring",
		left_ring	=	"Evanescence Ring",
		right_ring	=	"Mephitas's Ring +1",
		back		=	"Aurist's Cape +1",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		ammo		=	"Crepuscular Pebble",
		head		=	"Vanya Hood",
		body		=	"Heka's Kalasiris",
		hands		=	"Bokwus Gloves",
		legs		=	"Vanya Slops",
		feet		=	"Vanya Clogs",
		neck		=	"Incanter's Torque",
		waist		=	"Shinjutsu-no-Obi +1",
		left_ear	=	"Mendi. Earring",
		right_ear	=	"Etiolation Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1",

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
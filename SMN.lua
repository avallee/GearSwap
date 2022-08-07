--[[
	Jakey's SMN.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
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
idleModes = M('refresh', 'dt', 'petdt')
meleeModes = M('normal')
nukeModes = M('normal', 'acc')
mode = M('normal','acc')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Nirvana')
subWeapon = M('Elan Strap +1') 
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
	--windower.send_command('bind f10 gs c toggle meleemode')      -- F10 to change Melee Mode 
	--windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	--windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
	--windower.send_command('bind f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	windower.send_command('bind f11 gs c toggle mode')			-- Alt-F11 to change to acc mode for BPs  
	--windower.send_command('bind ^F11 gs c toggle matchsc')		-- CTRL-F10 to change Match SC Mode      	
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
    --send_command('unbind !f8')
    --send_command('unbind ^f8')
    send_command('unbind f10')
    send_command('unbind !`')
    --send_command('unbind home')
	--send_command('unbind !home')
	--send_command('unbind ^home')
    send_command('unbind !f10')	
    send_command('unbind ^f10')
end

include('SMN_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,8) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	""
    AF.Body		=	"Con. Doublet +3"
    AF.Hands	=	"Convo. Bracers +3"
    AF.Legs		=	""
    AF.Feet		=	"Convo. Pigaches +3"

    --Vitiation
    RELIC.Head		=	"Glyphic Horn +1"
    RELIC.Body		=	"Glyphic Doublet +3"
    RELIC.Hands 	=	""
    RELIC.Legs		=	""
    RELIC.Feet		=	""

    --Lethargy
    EMPY.Head		=	"Beckoner's Horn +1"
    EMPY.Body		=	"Beck. Doublet +1"
    EMPY.Hands		=	""
    EMPY.Legs		=	"Beck. Spats +1"
    EMPY.Feet		=	"Beck. Pigaches +1"

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
	MerlBody.MB ={ name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+10%','"Mag.Atk.Bns."+9',}}
	
	MerlLegs = {}
	MerlLegs.MB = { name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','INT+9','Mag. Acc.+5',}}
	MerlLegs.Phalanx = { name="Merlinic Shalwar", augments={'STR+1','CHR+1','Phalanx +5','Accuracy+16 Attack+16','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	
	MerlFeet = {}
	MerlFeet.Aspir = { name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +11','INT+8','Mag. Acc.+13','"Mag.Atk.Bns."+15',}}
	MerlFeet.FC = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+7',}}
	MerlFeet.MB = { name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+15','"Mag.Atk.Bns."+13',}}
	MerlFeet.Occ = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+7','"Occult Acumen"+11','INT+9','Mag. Acc.+1',}}
	
	MerlHands = {}
	MerlHands.Aspir = { name="Merlinic Dastanas", augments={'Mag. Acc.+16','"Drain" and "Aspir" potency +11','INT+7',}}
	MerlHands.Ref = { name="Merlinic Dastanas", augments={'Accuracy+8','INT+1','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	MerlHands.PetAcc={ name="Merlinic Dastanas", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Blood Pact Dmg.+10','Pet: Mag. Acc.+3','Pet: "Mag.Atk.Bns."+15',}}
	MerlHands.PetMacc={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+25 Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+6','Pet: INT+8','Pet: "Mag.Atk.Bns."+9',}}
	
	GrioAug = {}
	GrioAug.Enfeeb = { name="Grioavolr", augments={'Enfb.mag. skill +16','Mag. Acc.+9','"Mag.Atk.Bns."+24',}}
	GrioAug.Avatar = { name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: "Mag.Atk.Bns."+23','DMG:+8',}}
	
	ApogLegs = {}
	ApogLegs.mab = { name="Apogee Slacks +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	ApogLegs.phys = { name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}}
	
	ApogFeet = {}
	ApogFeet.mab = { name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
	ApogFeet.phys = { name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}
	
	-- Capes:
    -- Sucellos's And such, add your own.
    SMNCape = {}
    SMNCape.Phys 	=	{ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}}
    SMNCape.Mag 	=	{ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: Magic Damage+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
	SMNCape.melee	=	{ name="Campestres's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	SMNCape.MND		=	{ name="Campestres's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	
	SMNCape.Skill	=	"Conveyance Cape"
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
    sets.me.idle.refresh = {
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"Beckoner's Horn +1",
		body		=	"Apo. Dalmatica +1",
		hands		=	MerlHands.Ref,
		legs		=	"Assid. Pants +1",
		feet		=	"Herald's Gaiters",
		neck		=	"Smn. Collar +2",
		waist		=	"Fucho-no-Obi",
		left_ear	=	"Lugalbanda Earring",
		right_ear	=	"C. Palug Earring",
		left_ring	=	"Stikini Ring +1",
		right_ring	=	"Stikini Ring +1",
        back		=	SMNCape.Mag,
    }
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
		head		=	"Hike Khat +1",
		feet		=	"Baaya. Sabots +1",
		neck 		=	"Loricate Torque +1",
		waist		=	"Regal Belt",
		left_ring	=	"Gelatinous Ring +1",
        right_ring	=	"Defending Ring",
    })  
	sets.me.idle.petdt = sets.me.idle.dt 
    sets.avatar.refresh = {
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"Beckoner's Horn +1",
		body		=	"Apo. Dalmatica +1",
		hands		=	MerlHands.Ref,
		legs		=	"Assid. Pants +1",
		feet		=	"Baaya. Sabots +1",
		neck		=	"Smn. Collar +2",
		waist		=	"Lucidity Sash",
		left_ear	=	"Evans Earring",
		right_ear	=	"C. Palug Earring",
		left_ring	=	"Stikini Ring +1",
		right_ring	=	"Stikini Ring +1",
		back		=	SMNCape.Phys
    }
	
	sets.avatar.petdt = {
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"Hike Khat +1",
		body		=	"Apo. Dalmatica +1",
		hands		=	AF.Hands,
		legs		=	"Tali'ah Sera. +2",
		feet		=	AF.Feet,
		neck		=	"Smn. Collar +2",
		waist		=	"Fucho-no-Obi",
		left_ear	=	"Enmerkar Earring",
		right_ear	=	"C. Palug Earring",
		left_ring	=	"Stikini Ring +1",
		right_ring	=	"Stikini Ring +1",
		back		=	SMNCape.Phys
		}
	
    sets.avatar.dt = set_combine(sets.avatar.refresh,{
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"Hike Khat +1",
		body		=	"Apo. Dalmatica +1",
		hands		=	MerlHands.Ref,
		legs		=	"Assid. Pants +1",
		feet		=	"Baaya. Sabots +1",
		neck		=	"Smn. Collar +2",
		waist		=	"Lucidity Sash",
		left_ear	=	"Evans Earring",
		right_ear	=	"C. Palug Earring",
		left_ring	=	"Gelatinous Ring +1",
        right_ring	=	"Defending Ring",
		back		=	SMNCape.Phys

    })  
	
    sets.me.resting = { 
		waist		=	"Shinjutsu-no-Obi +1",
    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	------------------------------------------------------------------------------------------------------
     sets.me.melee = set_combine(sets.me.idle[idleModes.current],{
	 	ammo		=	"Epitaph",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Gazu Bracelet +1",
		legs		=	"Nyame Flanchard",
		feet		=	AF.Feet, 
		neck		=	"Combatant's Torque",
		waist		=	"Windbuffet Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Cessance Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		= 	SMNCape.melee
    })
    

	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------

	--40% STR 40% MND (no dstat)
    sets.me["Garland of Bliss"] = {
        ammo		=	"Pemphredo Tathlum",
        head		=	"C. Palug Crown",
        body		=	"Nyame Mail",
        hands		=	"Amalric Gages +1",
        legs		=	"Nyame Flanchard",
        feet		=	"Amalric Nails +1",
		neck		=	"Baetyl Pendant",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Friomisi Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Weather. Ring +1",
        back		=	SMNCape.MND
    }
	sets.me["Spirit Taker"] = {
	 	ammo		=	"Epitaph",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	AF.Feet, 
		neck		=	"Combatant's Torque",
		waist		=	"Windbuffet Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Cessance Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		= 	SMNCape.melee	
	}
	sets.me["Shattersoul"] = sets.me["Spirit Taker"]
	sets.me["Retribution"] = sets.me["Spirit Taker"]
	sets.me["Full Swing"] = sets.me["Spirit Taker"]
	sets.me["Shell Crusher"] = sets.me["Spirit Taker"]
	
	sets.me["Cataclysm"] = {
		head		=	"Pixie Hairpin +1",
        body		=	"Amalric Doublet +1",
        hands		=	"Amalric Gages +1",
        legs		=	"Amalric Slops +1",
        feet		=	"Amalric Nails +1",
		neck		=	"Baetyl Pendant",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Archon Ring",
        back		=	SMNCape.MND	
		}
	sets.me["Myrkr"] = {
		head		=	EMPY.Head,
        body		=	AF.Body,
        hands		=	"Baayami Cuffs +1",
        legs		=	"Amalric Slops +1",
        feet		=	"Amalric Nails +1",
		neck		=	"Nodens Gorget",
        waist		=	"Shinjutsu-no-Obi +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Etiolation Earring",
        left_ring	=	"Mephitas's Ring",
        right_ring	=	"Mephitas's Ring +1",
        back		=	"Twilight Cape"
		}

   ----------------------------
    -- Summoning Skill Related
    -- Including all blood pacts
    ----------------------------
      
    -- + Summoning Magic. This is a base set for max skill and blood pacts and we'll overwrite later as and when we need to
	    sets.avatar.skill = {
		ammo		=	"Epitaph",
		head		=	"Beckoner's Horn +1",
		body		=	"Baayami Robe +1",
		hands		=	"Baayami Cuffs +1",
		legs		=	"Baayami Slops +1",
		feet		=	"Baayami Sabots +1",
		neck		=	"Incanter's Torque",
		waist		=	"Lucidity Sash", --farm a Kobo Obi at some point
		left_ear	=	"Lodurr Earring",
		right_ear	=	"C. Palug Earring",
		left_ring	=	"Evoker's Ring",
		right_ring	=	"Stikini Ring +1",
		back		=	SMNCape.Skill,
    }
    -------------------------
    -- Individual Blood Pacts
    -------------------------
      
    -- Physical damage
    sets.avatar.atk = set_combine(sets.avatar.skill,{
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"Helios Band",
		body		=	AF.Body, 
		hands		=	MerlHands.PetAcc,
		legs		=	ApogLegs.phys, 
		feet		=	ApogFeet.phys,
		neck		=	"Smn. Collar +2",
		waist		=	"Incarnation Sash",
		left_ear	=	"Lugalbanda Earring",
		right_ear	=	"Gelos Earring",
		left_ring	=	{name="Varar Ring +1", bag="wardrobe3"},
		right_ring	=	"C. Palug Ring",
		back		=	SMNCape.Phys,	
    })
	--Volte Strike
	sets.avatar.critical = set_combine(sets.avatar.skill,{
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"Helios Band",
		body		=	RELIC.Body, 
		hands		=	MerlHands.PetAcc,
		legs		=	ApogLegs.phys, 
		feet		=	ApogFeet.phys,
		neck		=	"Smn. Collar +2",
		waist		=	"Incarnation Sash",
		left_ear	=	"Lugalbanda Earring",
		right_ear	=	"Gelos Earring",
		left_ring	=	{name="Varar Ring +1", bag="wardrobe3"},
		right_ring	=	"C. Palug Ring",
		back		=	SMNCape.Phys,	
    })
	
    sets.avatar.pacc = set_combine(sets.avatar.atk,{
		hands		=	AF.Hands,
		feet		=	AF.Feet,
    })
      
    -- Magic Attack
    sets.avatar.mab = set_combine(sets.avatar.skill,{
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"C. Palug Crown",
		body		=	"Apo. Dalmatica +1",
		hands		=	MerlHands.PetMacc,
		legs		=	"Enticer's Pants",
		feet		=	ApogFeet.mab,
		neck		=	"Smn. Collar +2",
		waist		=	"Regal Belt",
		left_ear	=	"Lugalbanda Earring",
		right_ear	=	"Gelos Earring",
		left_ring	=	{name="Varar Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Varar Ring +1", bag="wardrobe4"},
		back		=	SMNCape.Mag,
	
    })
	
    sets.avatar.mb = set_combine(sets.avatar.mab,{
	--hands=RELIC.Hands    --This seems silly
	})
    
	-- Hybrid
    sets.avatar.hybrid = set_combine(sets.avatar.skill,{
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"C. Palug Crown",
		body		=	"Apo. Dalmatica +1",
		hands		=	MerlHands.PetAcc,
		legs		=	ApogLegs.mab, --prefer mab augment
		feet		=	ApogFeet.mab,
		neck		=	"Smn. Collar +2",
		waist		=	"Regal Belt",
		left_ear	=	"Lugalbanda Earring",
		right_ear	=	"Gelos Earring",
		left_ring	=	{name="Varar Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Varar Ring +1", bag="wardrobe4"},
		back		=	SMNCape.Mag,
    })
      
    -- Magic Accuracy
    sets.avatar.macc = set_combine(sets.avatar.skill,{
		main		=	"Nirvana",
		sub			=	"Elan Strap +1",
		ammo		=	"Epitaph",
		head		=	"C. Palug Crown",
		body		=	AF.Body,
		hands		=	MerlHands.PetMacc,
		legs		=	"Enticer's Pants",
		feet		=	AF.Feet,
		neck		=	"Smn. Collar +2",
		waist		=	"Regal Belt",
		left_ear	=	"Lugalbanda Earring",
		right_ear	=	"Gelos Earring",
		left_ring	=	{name="Varar Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Varar Ring +1", bag="wardrobe4"},
		back		=	SMNCape.Mag,
    })
      
    -- Buffs
    sets.avatar.buff = set_combine(sets.avatar.skill,{
		head="Baayami Hat",

    })
      
    -- Other
    sets.avatar.other = set_combine(sets.avatar.skill,{

    })
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
    sets.midcast.nuking = {}		-- leave this empty
    sets.midcast.MB	= {}		-- leave this empty   
    sets.midcast.enhancing = {} 	-- leave this empty   
	sets.current = {}
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
		ammo		=	"Epitaph",
		head="Amalric Coif +1",			--11
		body="Zendik Robe",				--13
		hands="Hagondes	Cuffs",			--5
		legs="Psycloth Lappas",			--7
		feet=MerlFeet.FC,				--12
		neck="Baetyl Pendant",			--4
		waist="Witful Belt",			--3
		left_ear="Loquac. Earring",		--2
		right_ear="Malignance Earring",	--4
		left_ring="Kishar Ring",		--4
		right_ring="Weather. Ring +1",	--6
		back="Fi Follet Cape +1",				--10
    }   						--Total   81

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })
	--need 21 more fc to make up for body and head
	sets.precast["Impact"] = set_combine(sets.precast.casting,{
		head		=	empty,
		body		=	"Crepuscular Cloak",
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
      
	--combined 30 I II III, have 10 III from jp can have 15 I or II also need 670 skill and +3 AF
    sets.precast.bp = {
		ammo		=	"Epitaph", --II 5
		head		=	EMPY.Head,
		body		=	"Baayami Robe +1",
		hands		=	"Baayami Cuffs +1", --I 7
		legs		=	"Baayami Slops +1", --I 8
		feet		=	"Baayami Sabots +1",
		neck		=	"Incanter's Torque",
		waist		=	"Lucidity Sash",--kobo is better
		left_ear	=	"Lodurr Earring",
		right_ear	=	"C. Palug Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	SMNCape.Skill, 
    }--735 is next skill tier, at master level 50 if I max everything I'm 5 short without weapon swaps, hopefully empy+3 gets there.
      
    -- Mana Cede
    sets.precast["Mana Cede"] = set_combine(sets.avatar.skill,{
		hands=EMPY.Hands,
    })
      
    -- Astral Flow  
    sets.precast["Astral Flow"] = {
	head=RELIC.Head,
    }
	sets.precast["Sublimation"] = {waist="Embla Sash"}

	
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
	waist		=	"Acuity Belt +1",
    left_ring	=	"Archon Ring",
    }
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    sets.midcast.Helix = {
	waist		=	"Acuity Belt +1",
    }	

    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells, makes avatars uninteruptable
    sets.midcast.casting = {
		ammo		=	"Epitaph",
		head		=	"Beckoner's Horn +1",
		body 		=	"Baayami Robe +1",
		hands		=	MerlHands.Ref,
		legs		=	"Assid. Pants +1",
		feet		=	ApogFeet.phys,
		neck		=	"Smn. Collar +2",
		waist		=	"Shinjutsu-no-Obi +1",
		left_ear	=	"Enmerkar Earring",
		right_ear	=	"C. Palug Earring",
		left_ring	=	"Freke Ring",
        right_ring	=	"Defending Ring",	
		back		=	SMNCape.Phys

	
    }

    sets.midcast.nuking.normal = {
        --main		=	"Maxentius",
        --sub		=	"Ammurapi Shield",
    
        --ammo		=	"Pemphredo Tathlum",
        head		=	"C. Palug Crown",
        body		=	"Seidr Cotehardie",
        hands		=	"Amalric Gages +1",
        legs		=	"Amalric Slops +1",
        feet		=	"Amalric Nails +1",
        neck		=	"Baetyl Pendant",
        waist		=	"Acuity Belt +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",--"Shiva Ring +1",
        right_ring	=	"Freke Ring",
        back		=	"Aurist's Cape +1",
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
    
		hands		=	"Amalric Gages +1",
        neck		=	"Mizu. Kubikazari",
        left_ring	=	"Mujin Band",
    })
	
    sets.midcast.nuking.acc = {
        head		=	"C. Palug Crown",
        body		=	"Amalric Doublet +1",
        hands		=	"Amalric Gages +1",
        legs		=	"Amalric Slops +1",
        feet		=	"Amalric Nails +1",
        neck		=	"Baetyl Pendant",
        waist		=	"Acuity Belt +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Freke Ring",
        back		=	"Aurist's Cape +1",
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
		hands		=	"Amalric Gages +1",
        neck		=	"Mizu. Kubikazari",
        left_ring	=	"Mujin Band",
    })	
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	--Type A-pure macc no potency mod for sleep silence dispel Frazzle II
    sets.midcast.Enfeebling.MND = {
		head		=	"Amalric Coif +1",
        body		=	"Amalric Doublet +1",
        hands		=	"Regal Cuffs",
        legs		=	"Tali'ah Sera. +2",
        feet		=	"Nyame Sollerets",
        neck		=	"Erra Pendant",
		waist		=	"Acuity Belt +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	"Aurist's Cape +1",
		}
	
	sets.midcast.Enfeebling.INT =set_combine(sets.midcast.Enfeebling.macc, {
		--back		=	SMNCape.INT,
		left_ring	=	"Metamor. Ring +1",
		waist		=	"Acuity Belt +1",
	})

	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.INT, {
        hands		=	"Regal Cuffs",
		waist		=	"Acuity Belt +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
	})
	
	sets.midcast["Impact"] = set_combine(sets.midcast.Enfeebling.INT, {
		ammo		=	"Seraphic Ampulla",
		head		=	empty,
		body		=	"Crepuscular Cloak",
		hands		=	MerlHands.Occ,
		legs		=	"Perdition Slops",
		feet		=	MerlFeet.Occ,
		neck		=	"Combatant's Torque",
		waist		=	"Shinjutsu-no-Obi +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Dedition Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		=	SMNCape.melee,
		

	})
	sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeebling.INT, {
		main="Daybreak",
		sub="Ammurapi Shield",
	})
	

	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
		head		=	TelHead.Dur,
		body		=	TelBod.Dur,
		hands		=	TelHand.Dur,
		legs		=	TelLeg.Dur,
		feet		=	TelFeet.Dur,
		neck		=	"Incanter's Torque",
		waist		=	"Embla Sash",
		left_ear	=	"Andoaa Earring",
        right_ear	=	"Mimir Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Perimede Cape",
    })
      
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		waist="Siegel Sash",
		neck="Nodens Gorget",
		legs="Shedir Seraweels",
		right_ear="Earthcry Earring",
    })
	
	sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
		head="Amalric Coif +1",
	
	})
	sets.midcast.RefreshSelf = set_combine(sets.midcast.refresh ,{
		waist		=	"Gishdubar Sash",
		back 		=	"Grapevine Cape",
	})
    -- Elemental Siphon, eg, Tatsumaki Thingies, Esper Stone, etc
    sets.midcast.siphon = set_combine(sets.avatar.skill,{
		main="Chatoyant Staff",
		head="Baayami Hat",
		feet="Beck. Pigaches +1",
    })
        

	sets.midcast.BarElement = set_combine(sets.midcast.enhancing.duration,{
		legs="Shedir Seraweels",
	})

		--waist="Gishdubar Sash", --20 sec base duration on self is better but only better on self
	
	sets.midcast.TH = set_combine(sets.midcast.Enfeebling.Duration,{
		main		=	"",
		sub			=	"",
		ranged		=	"",
		ammo		=	"",
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
	})
	
	sets.midcast["Dia II"] = sets.midcast.TH
	sets.midcast["Dia"] = sets.midcast.TH
	sets.midcast["Diaga"] = sets.midcast.TH
	sets.midcast["Bio II"] = sets.midcast.TH
	sets.midcast["Bio"] = sets.midcast.TH
	--since no swapping ammo and dont have sird cape for smn not going to have full sird available 
    sets.midcast.aquaveil = set_combine(sets.midcast.enhancing.noSwapDur, {
		head		=	"Amalric Coif +1", 	--+2
		body		=	"Ros. Jaseran +1", 	-- 			25%			5%
		hands		=	"Regal Cuffs", 			--+2
		legs		=	"Shedir Seraweels", 	--+1
		feet		=	"Amalric Nails +1", 	--			16%
		neck		=	"Willpower Torque", 	-- 			5%
		waist		=	"Emphatikos Rope", 	--+1 		12%
        left_ring	=	"Freke Ring", 	-- 			10%
        right_ring	=	"Evanescence Ring",--		5%
		--back=SMNCape.TP, 			--						10%
	}) 						--total	AV +4  SIRD	104%    pdt	15% *assuming post augment if I get the earring can use d ring and if I put 2 merits in I can use neck

	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
		head		=	"Pixie Hairpin +1",
		body		=	"Amalric Doublet +1",
		hands		=	MerlHands.Aspir,
		legs		=	"Tali'ah Sera.",
		feet		=	MerlFeet.Aspir,
		neck		=	"Erra Pendant",
		waist		=	"Fucho-no-Obi",
		left_ear	=	"Hirudinea Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Archon Ring",
		right_ring	=	"Evanescence Ring",
		back		=	"Aurist's Cape +1",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
    -- Cure Potency
    sets.midcast.cure = set_combine(sets.midcast.casting,{
		Ammo		=	"Pemphredo Tathlum",
	    head		=	"Vanya Hood",
		body		=	"Heka's Kalasiris",
		hands		=	"Bokwus Gloves",
		legs		=	"Psycloth Lappas",
		feet		=	"Vanya Clogs",
		neck		=	"Incanter's Torque",
		waist		=	"Cascade Belt",
		left_ear	=	"Mendi. Earring",
		right_ear	=	"Static Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
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
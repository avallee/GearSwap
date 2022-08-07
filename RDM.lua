--[[
	Jakey's RDM.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
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
		gs c nuke enspellup             Cycles element type for enspell
		gs c nuke enspelldown		Cycles element type for enspell in reverse order 
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm buff of saved element  if /sch
		gs c nuke enspell		Cast enspell of saved enspell element		
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
idleModes = M('refresh', 'dt', 'shield')
meleeModes = M('normal', 'acc', 'dt', 'enspell')
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

mainWeapon = M('Crocea Mors','Naegling','Maxentius','Excalibur','Tauret','Daybreak')--,'Norgish Dagger'
subWeapon = M('Thibron','Daybreak',"Gleti's Knife","Bunzi's Rod",'Sacro Bulwark','Ammurapi Shield','Levante Dagger','Pukulatmuj +1')--,'Pukulatmuj +1','Forfend +1','Qutrub Knife'
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
	windower.send_command('bind !f10 gs c toggle melee') 		-- Alt-F9 Toggle Melee mode on / off, locking of weapons
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
	windower.send_command('bind !home gs c nuke enspellup')		-- Home Cycle Enspell Up
	windower.send_command('bind ^home gs c nuke gainup')
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

include('RDM_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,9) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Atro. Chapeau +1"
    AF.Body		=	"Atrophy Tabard +3"
    AF.Hands	=	"Atrophy Gloves +3"
    AF.Legs		=	"Atrophy Tights +3"
    AF.Feet		=	"Atrophy Boots +3"

    --Vitiation
    RELIC.Head		=	"Viti. Chapeau +3"
    RELIC.Body		=	"Viti. Tabard +3"
    RELIC.Hands 	=	"Viti. Gloves +3"
    RELIC.Legs		=	"Viti. Tights +3"
    RELIC.Feet		=	"Vitiation Boots +3"

    --Lethargy
    EMPY.Head		=	"Leth. Chappel +1"
    EMPY.Body		=	"Lethargy Sayon +1"
    EMPY.Hands		=	"Leth. Gantherots +1"
    EMPY.Legs		=	"Leth. Fuseau +1"
    EMPY.Feet		=	"Leth. Houseaux +1"

    TelBod = {}
	TelBod.Dur = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
	TelBod.Reg = { name="Telchine Chas.", augments={'"Fast Cast"+4','"Regen" potency+3',}}
	
	TelHead = {}
	TelHead.Dur = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
	
	TelLeg = {}
	TelLeg.Dur = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}}
	TelLeg.Reg = { name="Telchine Braconi", augments={'"Regen" potency+3',}}
	
	TelFeet={}
	TelFeet.Dur = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}

	MerlHead = {}
	MerlHead.Phalanx = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+7','Mag. crit. hit dmg. +5%','Phalanx +4','Accuracy+9 Attack+9',}}
	
	MerlBody = {}
	MerlBody.Phalanx = { name="Merlinic Jubbah", augments={'Pet: Haste+2','Attack+6','Phalanx +5',}}
	
	MerlLegs = {}
	MerlLegs.MB = { name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','INT+9','Mag. Acc.+5',}}
	MerlLegs.TH = { name="Merlinic Shalwar", augments={'Accuracy+3','AGI+3','"Treasure Hunter"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	MerlLegs.WS = { name="Merlinic Shalwar", augments={'Pet: "Mag.Atk.Bns."+9','Mag. Acc.+23','Weapon skill damage +10%','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	MerlLegs.Phalanx = { name="Merlinic Shalwar", augments={'STR+1','CHR+1','Phalanx +5','Accuracy+16 Attack+16','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	
	MerlFeet = {}
	MerlFeet.Aspir = { name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +11','INT+8','Mag. Acc.+13','"Mag.Atk.Bns."+15',}}
	MerlFeet.FC = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+7',}}
	MerlFeet.MB = { name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+10%','Mag. Acc.+15','"Mag.Atk.Bns."+13',}}
	
	MerlHands = {}
	MerlHands.Aspir = { name="Merlinic Dastanas", augments={'Mag. Acc.+16','"Drain" and "Aspir" potency +11','INT+7',}}
	MerlHands.Ref = { name="Merlinic Dastanas", augments={'Accuracy+8','INT+1','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	
	ChironicFeet={}
	ChironicFeet.TH = { name="Chironic Slippers", augments={'Magic dmg. taken -1%','"Subtle Blow"+7','"Treasure Hunter"+2','Accuracy+4 Attack+4',}}
	ChironicFeet.Phalanx = { name="Chironic Slippers", augments={'Pet: STR+3','MND+10','Phalanx +5','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
	ChironicFeet.Ref = { name="Chironic Slippers", augments={'Pet: Mag. Acc.+17','Pet: "Dbl.Atk."+2 Pet: Crit.hit rate +2','"Refresh"+2','Accuracy+10 Attack+10',}}
	
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
	
	ColadaAug = {}
	ColadaAug.EnhDur = { name="Colada", augments={'Enh. Mag. eff. dur. +4','Mag. Acc.+11','DMG:+9',}}
	ColadaAug.Phalanx1 = { name="Colada", augments={'Pet: Attack+18 Pet: Rng.Atk.+18','STR+4','Phalanx +4','DMG:+1',}}
	
	GrioAug = {}
	GrioAug.Enfeeb = { name="Grioavolr", augments={'Enfb.mag. skill +16','Mag. Acc.+9','"Mag.Atk.Bns."+24',}}
	GrioAug.Avatar = { name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: "Mag.Atk.Bns."+23','DMG:+8',}}
	
	-- Capes:
    -- Sucellos's And such, add your own.
    RDMCape = {}
    RDMCape.DW		=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    RDMCape.CDC		=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	RDMCape.Enm		=	{ name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}}
	RDMCape.MACC	=	{ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	RDMCape.STRWS 	=   { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	RDMCape.MNDWS	=	{ name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	RDMCape.STP		=	{ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	RDMCape.INT		=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}}
	RDMCape.INTWS	=	{ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%',}} --only used for red lotus post su5 sword
	RDMCape.RaWS	=	{ name="Sucellos's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	RDMCape.Ranged	=	{ name="Sucellos's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
	RDMCape.Snap	=	{ name="Sucellos's Cape", augments={'Snapshot +10',}}
	RDMCape.Enh		=	"Ghostfyre Cape"
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
        ammo        =   "Homiliary",
        head		=	RELIC.Head,
        body		=	"Jhakri Robe +2",
        hands		=	MerlHands.Ref,
        legs		=	"Carmine Cuisses +1",
        feet		=	ChironicFeet.Ref,
		neck		=	"Rep. Plat. Medal",
        waist		=	"Fucho-no-Obi",
        left_ear	=	"Eabani Earring",
		right_ear	=	"Odnowa Earring +1",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	RDMCape.STP,
    }

    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
        neck		=	"Loricate Torque +1",
        head		=	"Viti. Chapeau +3",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
		neck		=	"Loricate Torque +1",
		waist		=	"Carrier's Sash",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	RDMCape.STP,
    })  
    sets.me.idle.shield = set_combine(sets.me.idle.refresh,{
        neck		=	"Combatant's Torque",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	AF.Feet,
		waist		=	"Carrier's Sash",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	"Defending Ring",
		left_ear	=	"Foresti Earring",
		right_ear	=	"Thureous Earring",
		back		=	RDMCape.STP,
    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
	------------------------------------------------------------------------------------------------------
	-- Dual Wield 11 sets /nin
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldw = set_combine(sets.me.idle.normal,{   
        ammo        =   "Aurgelmir Orb +1",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Anu Torque",
		waist		=	"Reiki Yotai",
		left_ear	=	"Eabani Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	"Hetairoi Ring",
        back		=	RDMCape.STP,   
    })
    sets.me.melee.accdw = set_combine(sets.me.melee.normaldw,{
        --head		=	Carm.Head.D,
        neck		=	"Combatant's Torque",
        right_ear	=	"Mache Earring +1",
        hands 		=	"Gazu Bracelet +1",
        right_ring	=	"Cacoethic Ring +1", 
    })
    sets.me.melee.dtdw = set_combine(sets.me.melee.normaldw,{
		neck		=	"Warder's Charm +1",--"Warder's Charm +1",
        right_ring	=	"Defending Ring",
    })
    sets.me.melee.enspelldw = set_combine(sets.me.melee.normaldw,{
		ammo		=	"Sroda Tathlum",
		head		=	"Umuthi Hat",
		hands		=	"Aya. Manopolas +2",
		--feet		=	"Taeon Boots",
        neck		=	"Combatant's Torque",
		waist		=	"Orpheus's Sash",
		right_ear	=	"Suppanomimi",
		left_ear	=	"Eabani Earring",
		back		=	RDMCape.Enh, 
    })
	
	sets.me.melee.sbdw = set_combine(sets.me.melee.normaldw,{
		neck		=	"Bathy Choker +1",
		left_ear	=	"Assuage Earring",
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
	})
	
	------------------------------------------------------------------------------------------------------
	-- Dual Wield 21 sets /dnc
	------------------------------------------------------------------------------------------------------
    sets.me.melee.normaldn = set_combine(sets.me.idle.normal,{   
        ammo        =   "Aurgelmir Orb +1",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Anu Torque",
        waist		=	"Reiki Yotai",
		left_ear	=	"Eabani Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	"Hetairoi Ring",
        back		=	RDMCape.DW,   
    })
    sets.me.melee.accdn = set_combine(sets.me.melee.normaldn,{
        --head		=	Carm.Head.D,
        neck		=	"Combatant's Torque",
        hands 		=	"Gazu Bracelet +1",
		right_ear	=	"Mache Earring +1",
        right_ring	=	"Cacoethic Ring +1", 
    })
    sets.me.melee.dtdn = set_combine(sets.me.melee.normaldn,{
		neck		=	"Combatant's Torque",
        right_ring	=	"Defending Ring",
    })
    sets.me.melee.enspelldn = set_combine(sets.me.melee.normaldn,{
		ammo		=	"Sroda Tathlum",
		head		=	"Umuthi Hat",
		hands		=	"Aya. Manopolas +2",
        neck		=	"Combatant's Torque",
		waist		=	"Orpheus's Sash",
    })
	
	sets.me.melee.sbdn = set_combine(sets.me.melee.normaldn,{
		neck		=	"Bathy Choker +1",
		left_ear	=	"Digni. Earring",
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
	})
	------------------------------------------------------------------------------------------------------
	-- Single Wield sets. -- combines from DW sets
	-- So canjust put what will be changing when off hand is a shield
 	------------------------------------------------------------------------------------------------------   
    sets.me.melee.normalsw = set_combine(sets.me.melee.normaldw,{
		neck		=	"Combatant's Torque",	
		back		=	RDMCape.Shield,
    })
    sets.me.melee.accsw = set_combine(sets.me.melee.accdw,{
		neck		=	"Combatant's Torque",
		back		=	RDMCape.Shield,

    })
    sets.me.melee.dtsw = set_combine(sets.me.melee.dtdw,{
		neck		=	"Combatant's Torque",
		feet		=	AF.Feet,
		waist		=	"Carrier's Sash",
		left_ear	=	"Foresti Earring",
		right_ear	=	"Thureous Earring",
		back		=	RDMCape.Shield,
    })
    sets.me.melee.enspellsw = set_combine(sets.me.melee.enspelldw,{ --designed for capped sb and enspell 2s for enspel2
		ammo		=	"Sroda Tathlum",
        head		=	"Umuthi Hat",
		body		=	RELIC.Body,
		hands		=	"Aya. Manopolas +2",
		legs		=	AF.Legs,
		neck		=	"Bathy Choker +1",
		waist		=	"Orpheus's Sash",
		left_ear	=	"Digni. Earring",
		right_ear	=	"Sherida Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		=	RDMCape.Enh,

    })
	sets.Quanpur = {
		neck		=	"Quanpur Necklace"	
		}
	
	sets.me.melee.turtle = set_combine(sets.me.melee.dtsw,{
		main		= 	"Excalibur",
		sub 		= 	"Sacro Bulwark",
		left_ring 	= 	"Shadow Ring",
		right_ring	=	"Defending Ring",
		back		=	RDMCape.Shield,
	
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
		left_ring	=	"Crepuscular Ring",			--3
        right_ring	=	"Cacoethic Ring +1", 
        back		=	RDMCape.Snap,				--10
		}									--snapshot 60/61 only need 40 with flurry2 but often dont want to lose haste
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
		left_ring	=	"Crepuscular Ring",	
        right_ring	=	"Cacoethic Ring +1", 
        back		=	RDMCape.Ranged,
		}
	
	
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    --50 STR 50 MND high ftp first hit
	sets.me["Savage Blade"] = {
        ammo        =   "Crepuscular Pebble",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Sroda Ring",
        right_ring	=	"Epaminondas's Ring",
        back		=	RDMCape.STRWS,
	}
	sets.htp["Savage Blade"] = {
		left_ear	=	"Regal Earring",
	}
	
	sets.me["Knights of Round"] = {
        ammo        =   "Crepuscular Pebble",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Regal Earring",
        right_ear	=	"Sherida Earring",
        left_ring   =  	"Sroda Ring",
        right_ring	=	"Epaminondas's Ring",
        back		=	RDMCape.STRWS,
	}
	sets.htp["Knights of Round"] = {}
	
	--70 MND 30 STR so STR and MND about even large first hit
    sets.me["Black Halo"] = {
        ammo        =   "Crepuscular Pebble",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Dls. Torque +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Moonshade Earring",
        left_ring   =  	"Metamor. Ring +1",
        right_ring	=	"Epaminondas's Ring",
        back		=	RDMCape.MNDWS,
    }
	sets.htp["Black Halo"] = {
		right_ear	=	"Sherida Earring",
	}
	sets.me["Death Blossom"] = sets.me["Black Halo"]
	sets.htp["Death Blossom"] = sets.htp["Black Halo"]
	--85% MND still uses phys formula but with attack penalty so stack attack and MND multi hit with caried ftp
    sets.me["Requiescat"] = {
        ammo        =   "Crepuscular Pebble",--aurgelmir slightly better when not attack capped
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Regal Earring",
        right_ear	=	"Moonshade Earring",
        left_ring   =  	"Metamor. Ring +1", 
		right_ring	=	"Hetairoi Ring",--ilabat better if not attack capped
        back		=	RDMCape.MNDWS, --MND DA would be slightly stronger most of the time
    }
	sets.htp["Requiescat"] = {
		right_ear	=	"Sherida Earring",
	}
	-- 80 DEX crit 3 hit ws ftp transfered
    sets.me["Chant du Cygne"] = {
        ammo		=	"Yetshila +1",
		head		=	"Blistering Sallet +1",
        body		=	"Ayanmo Corazza +2",
        hands		=	"Nyame Gauntlets",
        legs		=	"Zoar Subligar +1", 
        feet		=	"Thereoid Greaves",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Mache Earring +1",
        right_ear	=	"Sherida Earring",
        left_ring	=	"Ilabrat Ring",
        right_ring	=	"Cacoethic Ring +1", --begrudging more damage
        back		=	RDMCape.CDC,
    }
	sets.htp["Chant du Cygne"] = {}
	sets.me["Evisceration"] = sets.me["Chant du Cygne"]
	sets.htp["Evisceration"] = {}
	--magic dINT 50 MND 30 STR 
    sets.me["Sanguine Blade"] = { 
        ammo		=	"Ghastly Tathlum +1",
        head		=	"Pixie Hairpin +1",
        body		=	"Nyame Mail",
        hands		=	"Jhakri Cuffs +2",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
		neck		=	"Sibyl Scarf",
		waist		=	"Orpheus's Sash",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Metamor. Ring +1",
        back		=	RDMCape.MACC,
    }
	sets.htp["Sanguine Blade"] = {}
	--magic dINT 40 STR 40 INT
    sets.me["Red Lotus Blade"] = {
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Jhakri Cuffs +2",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
		neck		=	"Sibyl Scarf",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Regal Earring",
        right_ear	=	"Moonshade Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Freke Ring",
        back		=	RDMCape.INTWS,
    }
	sets.htp["Red Lotus Blade"] = {
		right_ear	=	"Malignance Earring",
	}
	--dINT INT and DEX does not use su5 so magic damage and dstat aren't devalued
	sets.me["Aeolian Edge"] = {
        ammo		=	"Ghastly Tathlum +1",
        head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Jhakri Cuffs +2",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
		neck		=	"Sibyl Scarf",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Regal Earring",
        right_ear	=	"Moonshade Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Freke Ring",
        back		=	RDMCape.INTWS,
    }
	sets.htp["Aeolian Edge"] = {
		right_ear	=	"Malignance Earring",
	}
	--40% STR 40% MND 
    sets.me["Seraph Blade"] = {
        ammo		=	"Pemphredo Tathlum",
		head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Jhakri Cuffs +2",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
		neck		=	"Baetyl Pendant",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Weather. Ring +1",
        back		=	RDMCape.MACC,
    }
	sets.htp["Seraph Blade"] = {
		left_ear	=	"Regal Earring",
	}
	
	-- 50 agi 20 str ranged single hit agi gives ranged acc 3 for 4
	sets.me["Empyreal Arrow"] = {
		ammo		=	"Beryllium Arrow",
		head		=	"Nyame Helm",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        left_ring	=	"Longshot Ring", -- need ranged acc rings    
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets",
        neck		=	"Fotia Gorget",
        waist		=	"Fotia Belt",
        left_ear	=	"Telos Earring",
        right_ear	=	"Moonshade Earring",
        right_ring	=	"Cacoethic Ring +1", 
        back		=	RDMCape.RaWS,
	}
	sets.htp["Empyreal Arrow"] = {
		right_ear	=	"Crep. Earring",
	}
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though 
	sets.me.Enmity={
		ammo		=	"Sapience Orb",			-- +2
		head		=	"Halitus Helm", 		-- +8
        body		=	"Emet Harness +1", 		-- +10
        hands		=	"Malignance Gloves",
        legs		=	"Zoar Subligar +1", 	-- +6
        feet		=	"Rager Ledel. +1", 		-- +7
        neck		=	"Unmoving Collar +1", 	-- +10
        waist		=	"Trance Belt",	 		-- +4
        left_ear	=	"Cryptic Earring", 		-- +4
        right_ear	=	"Trux Earring", 		-- +5
        left_ring	=	"Eihwaz Ring", 			-- +5
        right_ring	=	"Pernicious Ring", 		-- +5
        back		=	RDMCape.Enm, 			-- +10
	} --+76 now 200 is cap
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
		body		=	RELIC.Body,				--15
		hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
		feet		=	MerlFeet.FC,			--12
        neck		=	"Loricate Torque +1",    
        waist		=	"Witful Belt",			--3  
        left_ear	=	"Etiolation Earring",  	--1
        right_ear	=	"Thureous Earring",
        left_ring	=	"Gelatinous Ring +1",
        right_ring	=	"Weather. Ring +1",		--6
		back		=	"Perimede Cape",
    }											--Total: 51 need 42	atm

    sets.precast["Stun"] = set_combine(sets.precast.casting,{

    })
	--need 21 more fc to make up for body and head
	sets.precast["Impact"] = set_combine(sets.precast.casting,{
		head		=	empty,
		body		=	"Crepuscular Cloak",
		hands		=	"Leyline Gloves",		--7
        legs		=	"Kaykaus Tights +1",	--7
		feet		=	MerlFeet.FC,			--12
        neck		=	"Baetyl Pendant",    	--4
        waist		=	"Witful Belt",			--3  
        left_ear	=	"Loquac. Earring",  	--2
        right_ear	=	"Malignance Earring",	--4
        left_ring	=	"Defending Ring",
        right_ring	=	"Weather. Ring +1",		--6
		back		=	"Perimede Cape",
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

    sets.precast["Chainspell"] = {body = RELIC.Body}
	sets.precast["Sublimation"] = {waist="Embla Sash"}
	sets.precast["Provoke"] = sets.me.Enmity
	sets.precast["Warcry"] = sets.me.Enmity
	sets.precast["Convert"] = {
		main		=	"Murgleis",
		sub			=	"Culminus",
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",	
        legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",			
        neck		=	"Unmoving Collar +1",    
        waist		=	"Gold Mog. Belt",			 
        left_ear	=	"Etiolation Earring",  	
        right_ear	=	"Thureous Earring",	
        left_ring	=	"Eihwaz Ring",
        right_ring	=	"Gelatinous Ring +1",		
		back		=	"Moonlight Cape",
	}
	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist	=	"Hachirin-no-Obi",
    }
	sets.midcast.ObiFull = {
		left_ear	=	"Telos Earring",
		waist		=	"Hachirin-no-Obi",
		back		=	RDMCape.DW,
	}
    sets.midcast.Orpheus = {
        waist="Orpheus's Sash", 
    } 
	sets.midcast.OrpheusFull = {
		left_ear	=	"Telos Earring",
		waist		=	"Orpheus's Sash",
		back		=	RDMCape.DW,
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
        --ammo		=	"Pemphredo Tathlum",
        --head		=	Merl.Head.ACC,
        --body		=	Amal.Body.A,
        --hands		=	Amal.Hands.D,
        --legs		=	Amal.Legs.A,
        --feet		=	Amal.Feet.A,
        --neck		=	"Dls. Torque +2",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        back		=	RDMCape.MACC,
        left_ring	=	"Shiva Ring +1",   
        right_ring	=	"Freke Ring",
    }

    sets.midcast.nuking.normal = {
        ammo		=	"Ghastly Tathlum +1",
        head		=	"C. Palug Crown",
        body		=	"Seidr Cotehardie",
        hands		=	"Amalric Gages +1",
        legs		=	"Amalric Slops +1",
        feet		=	"Amalric Nails +1",
        neck		=	"Baetyl Pendant",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Freke Ring",
        back		=	RDMCape.INT
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
    
        head		=	"Ea Hat +1",
        hands		=	"Amalric Gages +1",		
        legs		=	"Ea Slops +1",
        neck		=	"Mizu. Kubikazari",
        left_ring	=	"Mujin Band",
    })
	
    sets.midcast.nuking.acc = {
        ammo		=	"Ghastly Tathlum +1",
        head		=	"C. Palug Crown",
        body		=	"Amalric Doublet +1",
        hands		=	"Amalric Gages +1",
        legs		=	"Amalric Slops +1",
        feet		=	"Amalric Nails +1",
        neck		=	"Baetyl Pendant",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Regal Earring",
        right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Freke Ring",
        back		=	RDMCape.INT
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.acc, {
        head		=	"Ea Hat +1",
		body		=	"Ea Houppe. +1",
        hands		=	"Amalric Gages +1",
        legs		=	"Ea Slops +1",
		feet		=	"Amalric Nails +1",
        neck		=	"Mizu. Kubikazari",
        left_ring	=	"Mujin Band",
    })	
	
    -- Enfeebling

	sets.midcast.Enfeebling = {} -- leave Empty
	sets.midcast.EnfeeblingS = {}
	--Type A-pure macc no potency mod for sleep silence dispel Frazzle II
    sets.midcast.Enfeebling.macc = {
		--main		=	"Crocea Mors",
		--sub			=	"Daybreak",
		ranged		=	empty,
        ammo		=	"Regal Gem",
		head		=	RELIC.Head,
        body		=	AF.Body,
        hands		=	"Regal Cuffs",
        legs		=	"Chironic Hose",
        feet		=	RELIC.Feet,
        neck		=	"Dls. Torque +2",
		waist		=	"Obstin. Sash",
        left_ear	=	"Regal Earring",
        right_ear	=	"Snotra Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        --right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		right_ring	=	"Kishar Ring",
		back		=	"Aurist's Cape +1",

		}
	sets.midcast.EnfeeblingS.macc =set_combine(sets.midcast.Enfeebling.macc, {
		main		=	"Murgleis",
		sub			=	"Bunzi's Rod",
		ranged		=	"Ullr",
        --ammo		=	"",
	})
	sets.midcast.Enfeebling.maccINT =set_combine(sets.midcast.Enfeebling.macc, {
		left_ring	=	"Metamor. Ring +1",
		waist		=	"Obstin. Sash",
	})
	sets.midcast.EnfeeblingS.maccINT =set_combine(sets.midcast.Enfeebling.maccINT, {
		main		=	"Murgleis",
		sub			=	"Bunzi's Rod",
		ranged		=	"Ullr",
        ammo		=	"",
	})
	sets.midcast["Stun"] = set_combine(sets.midcast.Enfeebling.maccINT, {
        hands		=	"Regal Cuffs",
        feet		=	"Malignance Boots",
		waist		=	"Acuity Belt +1",
        right_ear	=	"Malignance Earring",
	})
	
	sets.midcast["Impact"] = set_combine(sets.midcast.Enfeebling.maccINT, {
		head=empty,
		body		=	"Crepuscular Cloak",
		hands		=	"Regal Cuffs",
		legs		=	"Ea Slops +1",
		feet		=	"Malignance Boots",
		waist		=	"Acuity Belt +1",
		right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		right_ear	=	"Malignance Earring",
		

	})
	--dispel doesn't need duration
	sets.midcast["Dispel"]	= set_combine(sets.midcast.Enfeebling.maccINT, {
		hands		=	"Regal Cuffs",
		right_ear	=	"Malignance Earring",
		waist		=	"Acuity Belt +1",
	})
	sets.midcast["Dispelga"] = set_combine(sets.midcast.Enfeebling.maccINT, {
		main		=	"Daybreak",
		sub			=	"Ammurapi Shield",
		hands		=	"Regal Cuffs",
		right_ear	=	"Malignance Earring",
		waist		=	"Acuity Belt +1",
	})
	--Type B-potency from: Mnd & "Enfeeb Potency" gear for Slow Addle Parralyze (based on dMND and potency not skill or skill already capped)
    sets.midcast.Enfeebling.mndpot = set_combine(sets.midcast.Enfeebling.macc, {
		body 		= 	EMPY.Body,
		left_ring	=	"Metamor. Ring +1",
		back		=	RDMCape.MACC,
    })
	sets.midcast.EnfeeblingS.mndpot =set_combine(sets.midcast.Enfeebling.mndpot, {
		main		=	"Murgleis",
		sub			=	"Bunzi's Rod",
		ranged		=	empty,
        ammo		=	"Regal Gem",
	})
	-- Type C-potency from: Int & "Enfeeb Potency" gear for Blind (based on dINT and potency not skill)
    sets.midcast.Enfeebling.intpot = set_combine(sets.midcast.Enfeebling.macc, {
		body 		= 	EMPY.Body,
		back 		= 	RDMCape.INT,
		left_ring	=	"Metamor. Ring +1",
		waist		=	"Acuity Belt +1",
    })
	sets.midcast.EnfeeblingS.intpot =set_combine(sets.midcast.Enfeebling.intpot, {
		main		=	"Murgleis",
		sub			=	"Bunzi's Rod",
		ranged		=	empty,
        ammo		=	"Regal Gem",
	})
	--Type D-potency from: Enfeeb Skill & "Enfeeb Potency" gear for Poison II no capped skill
    sets.midcast.Enfeebling.skillpot = set_combine(sets.midcast.Enfeebling.macc, {
		neck 		=	"Incanter's Torque",
		body 		= 	AF.Body,
		hands		=	"Kaykaus Cuffs +1",
		right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		waist		=	"Obstin. Sash",
        left_ear	=	"Vor Earring",	
    })
	sets.midcast.EnfeeblingS.skillpot =set_combine(sets.midcast.Enfeebling.skillpot, {
		main		=	GrioAug.Enfeeb,
		sub			=	"Mephitis Grip",
		ranged		=	empty,
        ammo		=	"Regal Gem",
	})
	-- Tpe E-potency from: Enfeeb skill, Mnd, & "Enfeeb Potency" gear Distract III, Frazzle III cap at 610 skill but want max potency too
    sets.midcast.Enfeebling.skillmndpot = set_combine(sets.midcast.Enfeebling.macc, {
		body 		= 	EMPY.Body,
		hands		=	"Kaykaus Cuffs +1",
		--right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		waist		=	"Obstin. Sash",
        left_ear	=	"Vor Earring",
        back		=	RDMCape.MACC,		
    })
	sets.midcast.EnfeeblingS.skillmndpot =set_combine(sets.midcast.Enfeebling.skillmndpot, {
		main		=	"Murgleis", --due to master levels no longer need skill staff/grip
		sub			=	"Bunzi's Rod",
		ranged		=	empty,
        ammo		=	"Regal Gem",
	})
	-- Type F-potency from "Enfeebling potency" gear only Gravity (no skill needed but INT)
    sets.midcast.Enfeebling.potency = set_combine(sets.midcast.Enfeebling.macc, {
		body 		= 	EMPY.Body,
		back 		= 	RDMCape.INT,
		left_ring	=	"Metamor. Ring +1",
		waist		=	"Acuity Belt +1",
    })
	sets.midcast.EnfeeblingS.potency =set_combine(sets.midcast.Enfeebling.potency, {
		main		=	"Murgleis",
		sub			=	"Bunzi's Rod",
		ranged		=	empty,
        ammo		=	"Regal Gem",
	})
	--max duration 
	sets.midcast.Enfeebling.Duration= set_combine(sets.midcast.Enfeebling.macc, {
		main		=	"Murgleis",
		sub			=	"Bunzi's Rod",
		ranged		=	empty,
        ammo		=	"Regal Gem",
		head 		= 	EMPY.Head,
		body 		= 	EMPY.Body,
		hands 		= 	"Regal Cuffs",
		legs 		= 	EMPY.Legs,
		feet 		= 	EMPY.Feet,
		left_ring 	= 	"Kishar Ring",
		back		=	RDMCape.MACC,
	})
	--with saboteur empy hands edge out regal for duration
	sets.midcast.Enfeebling.DurationSab= set_combine(sets.midcast.Enfeebling.Duration, {
		hands		=	EMPY.Hands,
	})
	
    -- Enhancing yourself 
    sets.midcast.enhancing.duration = {
        main		=	ColadaAug.EnhDur,
        sub			=	"Ammurapi Shield",
        ammo		=	"Homiliary",
        head		=	TelHead.Dur,
        body		=	RELIC.Body,
        hands		=	AF.Hands,
        legs		=	TelLeg.Dur,
        feet		=	EMPY.Feet,
        neck		=	"Dls. Torque +2",
        waist		=	"Embla Sash",
        left_ear	=	"Andoaa Earring",
        right_ear	=	"Mimir Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	RDMCape.Enh
    }
	sets.midcast.enhancing.noSwapDur = set_combine(sets.midcast.enhancing.duration, {
		main 		=	"",
		sub			=	"",
	
	})

    -- For Potency spells like Temper and Enspells
    sets.midcast.enhancing.potency = set_combine(sets.midcast.enhancing.duration, {
        main		=	"Pukulatmuj +1",
        sub			=	{name = "Forfend +1", priority = 15},
        ammo		=	"Homiliary",
        head		=	"Befouled Crown",
        body		=	RELIC.Body,
        hands		=	RELIC.Hands,
        legs		=	AF.Legs,
        feet		=	EMPY.Feet,
        neck		=	"Incanter's Torque",
        waist		=	"Olympus Sash",
        left_ear	=	"Andoaa Earring",
        right_ear	=	"Mimir Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	RDMCape.Enh
    })

	sets.midcast.enhancing.potencySW = set_combine(sets.midcast.enhancing.potency, { --if you don't have forfend +1 r15

	})

    -- This is used when casting under Composure but enhancing someone else other than yourself. 
    sets.midcast.enhancing.composure = set_combine(sets.midcast.enhancing.duration, {
		head 		=	EMPY.Head,
		body		=	EMPY.Body,
        hands		=	AF.Hands,
        legs		=	EMPY.Legs,
		feet		=	EMPY.Feet,
        back		=	RDMCape.Enh
    })  


    -- Phalanx need 500 skill and max phalanx potency
    sets.midcast.phalanx = set_combine(sets.midcast.enhancing.duration, {
		main		=	"Sakpata's Sword",
		sub			=	ColadaAug.Phalanx1,
        head		=	MerlHead.Phalanx,
        body		=	MerlBody.Phalanx,
        hands		=	TaeonHands.Phalanx,
        legs		=	MerlLegs.Phalanx,
        feet		=	ChironicFeet.Phalanx,
		--waist		=	"Olympus Sash", -- needed 3 more skill before master levels
    })
	sets.midcast.phalanxSW = set_combine(sets.midcast.enhancing.duration, {
		main		=	"Sakpata's Sword",
		sub			=	"Ammurapi Shield",
        head		=	TaeonHead.Phalanx,
        body		=	TaeonBody.Phalanx,
        hands		=	TaeonHands.Phalanx,
        legs		=	MerlLegs.Phalanx,
        feet		=	ChironicFeet.Phalanx,
		--waist		=	"Olympus Sash", -- needed 3 more skill before master levels
	})
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing.noSwapDur, {
		waist		=	"Siegel Sash",
		neck		=	"Nodens Gorget",
		hands		=	"Stone Mufflers",
		legs		=	"Shedir Seraweels",
		left_ear	=	"Earthcry Earring",
		
    })
	
	--duration capped without any weapon swaps
	sets.midcast.BarElement = set_combine(sets.midcast.enhancing.duration,{
		main 		=	"",
		sub			=	"",
		ranged		=	"",
		ammo		=	"",
		legs		=	"Shedir Seraweels",
	})
	sets.midcast.GainStat = set_combine(sets.midcast.enhancing.duration,{
		hands = RELIC.Hands,
	})
    sets.midcast.refresh = set_combine(sets.midcast.enhancing.duration, {
		head		=	"Amalric Coif +1", --2
		body		= 	AF.Body, --2
		legs		= 	EMPY.Legs, --2
    })
	sets.midcast.RefreshSelf = set_combine(sets.midcast.refresh, {
		waist		=	"Gishdubar Sash", 
		back 		=	"Grapevine Cape",
    })
	
	sets.midcast.TH = set_combine(sets.midcast.Enfeebling.Duration,{
		main		=	"",
		sub			=	"",
		ranged		=	"",
		ammo		=	"",
		head 		=	"Volte Cap",
		hands 		= 	"Volte Bracers",
		feet 		= 	"Volte Bracers",
		waist		=	"Chaac Belt",
	})
	-- adjusted for TH + damag over time and duration regal gem would give another 10 dot.
	sets.midcast["Dia III"] = 	{	
		main		=	"",
		sub			=	"",
		ranged		=	"",
        ammo		=	"Regal Gem",				--10
		head 		=	"Volte Cap",
        body		=	EMPY.Body,					--14
        hands		=	"Volte Bracers",
        legs		=	EMPY.Legs,
        feet		=	"Volte Boots",				--could add more dot with relic feet but TH for now
        neck		=	"Dls. Torque +2",			--10
		waist		=	"Chaac Belt",
        left_ear	=	"Regal Earring",
        right_ear	=	"Snotra Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	"Kishar Ring",
        back		=	RDMCape.MACC,				--10
	
	}
	
	
	sets.midcast["Dia"] = sets.midcast.TH
	sets.midcast["Diaga"] = sets.midcast.TH
	sets.midcast["Bio III"] = sets.midcast.TH
	sets.midcast["Bio"] = sets.midcast.TH
	sets.midcast["Inundation"] = sets.midcast.TH
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
		back		=	RDMCape.INT, 			--			10%
	}) 								   --total	AV +6  SIRD	102%    pdt 19% can't use bow if worries about SIRD
	
	sets.midcast.aquaAOE = set_combine(sets.midcast.enhancing.duration,{ --for assession dont need sird just duration
		head		=	"Amalric Coif +1", 		--+2
		hands		=	"Regal Cuffs", 			--+2
		legs		=	"Shedir Seraweels", 	--+1
		waist		=	"Emphatikos Rope", 		--+1 
		
	})
	
	sets.midcast["Blink"] = set_combine(sets.midcast.enhancing.noSwapDur, { 
		ammo		=	"Staunch Tathlum +1", 	--			11%			3%		
		head		=	"Nyame Helm", 	--						6%
		body		=	"Ros. Jaseran +1", 		-- 			25%			
		hands		=	"Malignance Gloves", 	-- 						5%
		legs		=	"Carmine Cuisses +1", 	--			20%
		feet		=	"Amalric Nails +1", 	--			16%
		neck		=	"Loricate Torque +1", 	-- 			5%			6% 			
		waist		=	"Emphatikos Rope", 		--	 		12%
        left_ring	=	"Defending Ring",		--						10%
        right_ring	=	"Weather. Ring +1",		--									6%
		left_ear	=	"Malignance Earring",	--									8%	
		right_ear	=	"Magnetic Earring",		--			8%
		back		=	"Fi Follet Cape +1", 	--			5%						10%
												--	   SIRD 102%	pdt	30%		fc	24%
	
	})
	sets.midcast["Utsusemi: Ichi"] = sets.midcast["Blink"]
	
	sets.midcast["Utsusemi: Ni"] = sets.midcast["Blink"]
	
	sets.midcast["Flash"] = sets.me.Enmity
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
        ammo		=	"Pemphredo Tathlum",
		head		=	"Pixie Hairpin +1",
		body		=	"Amalric Doublet +1",
		hands		=	MerlHands.Aspir,
		legs		=	"Chironic Hose",
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
 	
    sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency, could make a fast cast cape and try to cap out recast time but close enough.
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
        ammo		=	"Regal Gem",
		head		=	"Kaykaus Mitra +1",
		body		=	"Kaykaus Bliaut +1",
		hands		=	"Kaykaus Cuffs +1",
		legs		=	"Kaykaus Tights +1",
		feet		=	"Kaykaus Boots +1",
		neck		=	"Incanter's Torque",
		waist		=	"Shinjutsu-no-Obi +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Meili Earring",
        left_ring	=	"Naji's Loop",
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1",

    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		waist="Hachirin-no-Obi",
		back="Twilight Cape"
    }) 
	sets.midcast.cure.self = set_combine(sets.midcast.cure.normal,{
		waist="Gishdubar Sash",
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
--[[
    Jakey's NIN.lua Partially based off Elizabet's RDM lua https://github.com/Tunaliz/Liz_Gearswaps
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
		home gs c toggle rune			Cycles runes for run sub
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
meleeModes = M('dps', 'acc', 'dt', 'tank')

------------------------------------------------------------------------------------------------------
-- Important to read!
------------------------------------------------------------------------------------------------------
-- This will be used later down for weapon combos, here's mine for example, you can add your REMA+offhand of choice in there
-- Add you weapons in the Main list and/or sub list.
-- Don't put any weapons / sub in your IDLE and ENGAGED sets'
-- You can put specific weapons in the midcasts and precast sets for spells, but after a spell is 
-- cast and we revert to idle or engaged sets, we'll be checking the following for weapon selection. 
-- Defaults are the first in each list

mainWeapon = M('Heishi Shorinken','Fudo Masamune B','Fudo Masamune C','Naegling','Tauret','Hachimonji') 
subWeapon = M('Kunimitsu','Hitaki','Tsuru','Crepuscular Knife',"Gleti's Knife") 
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
	windower.send_command('bind !f8 gs c toggle mainweapon')	-- Alt-F8 Toggle Main Weapon
	windower.send_command('bind ^f8 gs c toggle subweapon')		-- CTRL-F8 Toggle sub Weapon.
	windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
	windower.send_command('bind !home gs c toggle rune')		-- toggle runes for /run
	--windower.send_command('bind PAGEUP gs c nuke enspelldown')  -- PgUP Cycle Enspell Down
	--windower.send_command('bind f10 gs c toggle mb')           -- F10 toggles Magic Burst Mode on / off.
	windower.send_command('bind !f11 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
	windower.send_command('bind ^F11 gs c toggle matchsc')		-- CTRL-F10 to change Match SC Mode      	
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

include('NIN_Lib.lua')

-- Optional. Swap to your sch macro sheet / book
set_macros(1,12) -- Sheet, Book

refreshType = idleModes[1] -- leave this as is     

-- Setup your Gear Sets below:
function get_sets()
    
    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty


	-- Fill this with your own JSE. 
    --Atrophy
    AF.Head		=	"Hachiya Hatsu. +3"
    AF.Body		=	"Hachiya Chain. +3"
    AF.Hands	=	"Hachiya Tekko +3"
    AF.Legs		=	""
    AF.Feet		=	"Hachiya Kyahan +3"

    --Vitiation
    RELIC.Head		=	"Mochi. Hatsuburi +3"
    RELIC.Body		=	"Mochi. Chainmail +3"
    RELIC.Hands 	=	"Mochizuki Tekko +3"
    RELIC.Legs		=	"Mochi. Hakama +3"
    RELIC.Feet		=	"Mochi. Kyahan +3"

    --Lethargy
    EMPY.Head		=	"Hattori Zukin +1"
    EMPY.Body		=	""
    EMPY.Hands		=	"Hattori Tekko +1"
    EMPY.Legs		=	""
    EMPY.Feet		=	"Hattori Kyahan +1"


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
	
	HercLegs = {}
	HercLegs.FC = { name="Herculean Trousers", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','"Fast Cast"+6','"Mag.Atk.Bns."+2',}}
	HercLegs.MB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+1%','INT+10','"Mag.Atk.Bns."+11',}}
	
	HercFeet = {}
	HercFeet.FC = { name="Herculean Boots", augments={'Mag. Acc.+9','"Fast Cast"+6',}}
	HercFeet.MAB = { name="Herculean Boots", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Magic burst dmg.+2%','INT+8','Mag. Acc.+3','"Mag.Atk.Bns."+13',}}
	HercFeet.MABWS = { name="Herculean Boots", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +2%','STR+13','Mag. Acc.+14',}}

	
	-- Capes:
    -- Sucellos's And such, add your own.
    NINCape = {}
    NINCape.DEXDA		=	{ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	NINCape.INTMAB		=	{ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
	NINCape.STRWS		=	{ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	NINCape.AGIWS		=	{ name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	NINCape.FC			=	{ name="Andartia's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Spell interruption rate down-10%',}}
	NINCape.STP			=	{ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	NINCape.Eva			=	{ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Parrying rate+5%',}}
	

	-- SETS
     
    sets.me = {}        		-- leave this empty
	sets.htp = {}
	sets.mtp = {}
    sets.buff = {} 			-- leave this empty
    sets.me.idle = {}			-- leave this empty
    sets.me.melee = {}          	-- leave this empty
    sets.weapons = {}			-- leave this empty
	
    -- Optional 
    --include('AugGear.lua') -- I list all my Augmented gears in a sidecar file since it's shared across many jobs. 

    -- Leave weapons out of the idles and melee sets. You can/should add weapons to the casting sets though
    -- Your idle set
    sets.me.idle.refresh = {
		--ammo		=	"Seki Shuriken",
        neck		=	"Loricate Torque +1",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
        feet		=	AF.Feet,
		waist		=	"Engraved Belt",
        left_ear	=	"Etiolation Earring",
		right_ear	=	"Odnowa Earring +1",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	NINCape.DEXDA,
    }

    -- Your idle DT set
    sets.me.idle.dt = {
		ammo		=	"Seki Shuriken",
        neck		=	"Rep. Plat. Medal",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
        feet		=	AF.Feet,
		waist		=	"Engraved Belt",
        left_ear	=	"Etiolation Earring",
		right_ear	=	"Odnowa Earring +1",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	"Defending Ring",
        back		=	NINCape.DEXDA,
    } 
	
	
	-- you start with 35 ambu katana caps at 100 for regain
	sets.me.idle.dw = set_combine(sets.me.idle.dt,{
		head		=	"Ryuo Somen +1"		-- 9
		body 		=	AF.Body,  			-- 10
		hands		=	"Floral Gauntlets",	-- 5
		Legs		=	RELIC.Legs,			-- 10
		feet		=	"Hiza. Sune-Ate +2",-- 8
		waist		=	"Reiki Totai",		-- 7
		right_ear	=	"Suppanomimi",		-- 5
		left_ear	=	"Eabani Earring",	-- 4
											-- 58 + 35 can easily cap out if I make a dual wield cape
	})
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist=""}     
    
	-- Melee Related Sets
	------------------------------------------------------------------------------------------------------
	-- Default sets used for when I don't offhand tp bonus or Tsuru
	------------------------------------------------------------------------------------------------------
	--max dps when acc and magic evasion are not concerns, capped subtle blow with buff
    sets.me.melee.dpsnor = set_combine(sets.me.idle.normal,{   --low acc glass cannon
		ammo		=	"Seki Shuriken",
        head		=	AdhemHead.Acc,
        body		=	"Mpaca's Doublet",
        hands		=	AdhemHands.Acc,
        legs		=	"Samnuha Tights",	
        feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        right_ear	=	"Brutal Earring",
        left_ear	=	"Dedition Earring",
        left_ring	=	"Gere Ring",
        right_ring	=	"Epona's Ring", 
		back		=	NINCape.STP,
    })
	--lot more acc and mag eva, capped subtle blow (even without buff) high racc so mpaca is out
    sets.me.melee.accnor = set_combine(sets.me.melee.dpsnor,{
        ammo		=	"Date Shuriken",
		head		=	"Ken. Jinpachi +1",
        body		=	"Ken. Samue +1",
		hands		=	"Malignance Gloves",
		legs		=	"Ken. Hakama +1",
		feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        right_ear	=	"Cessance Earring",
        left_ear	=	"Telos Earring",
        left_ring	=	"Gere Ring",
        right_ring	=	"Epona's Ring", 
		back		=	NINCape.STP,
    })
	--capped dt but still solid damage, capped subtle blow with buff
    sets.me.melee.dtnor = set_combine(sets.me.melee.accnor,{
        ammo		=	"Date Shuriken",
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Ken. Hakama +1",
		feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
		waist		=	"Sailfi Belt +1",
        right_ear	=	"Odnowa Earring +1",
		left_ear	=	"Telos Earring",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Defending Ring",
		back		=	NINCape.DEXDA, 
    })
	sets.me.melee.tanknor = set_combine(sets.me.melee.dtnor,{ --high evasion/mag eva with capped dt subtle blow caps with buff
        ammo		=	"Date Shuriken",--ammo		=	"Yamarang",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Malignance Tights",
		feet		=	"Malignance Boots",
		waist 		=	"Engraved Belt",
		neck		=	"Bathy Choker +1",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Defending Ring",
		left_ear	=	"Eabani Earring",
		right_ear	=	"Odnowa Earring +1",
		back 		=	NINCape.Eva, 
    })
	

	------------------------------------------------------------------------------------------------------
	-- tp bonus offhand sets much higher acc, also meant to use with su5 path b mainhand so store tp heavy
 	------------------------------------------------------------------------------------------------------   
    sets.me.melee.dpstp = set_combine(sets.me.melee.dpsnor,{
		ammo		=	"Seki Shuriken",
        head		=	"Malignance Chapeau",
        body		=	"Mpaca's Doublet",
        hands		=	"Malignance Gloves",
        legs		=	"Ken. Hakama +1",	
        feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
        waist 		=	"Kentarch Belt +1",
        right_ear	=	"Crep. Earring",
        left_ear	=	"Telos Earring",
        left_ring	=	"Gere Ring",
        right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		=	NINCape.STP,
    })
	--max acc also has capped subtle blow not capped dt
    sets.me.melee.acctp = set_combine(sets.me.melee.accnor,{
		ammo		=	"Date Shuriken",
        head		=	"Malignance Chapeau",
		body		=	"Ken. Samue +1",
		hands		=	"Malignance Gloves",
		legs		=	"Ken. Hakama +1",
		feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
		waist 		=	"Kentarch Belt +1",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		right_ear	=	"Crep. Earring",
        left_ear	=	"Telos Earring",
		back		=	NINCape.STP,
    })
	-- this is capped dt over 130 more evasion, 5% more parry but definitely a loss to damage especially when not using shuriken, capped subtle blow with buff
	sets.me.melee.dttp = set_combine(sets.me.melee.dtnor,{ 
		ammo		=	"Date Shuriken",
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Ken. Hakama +1",
		feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
		waist 		=	"Kentarch Belt +1",
        right_ear	=	"Odnowa Earring +1",
		left_ear	=	"Telos Earring",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Defending Ring",
		back		=	NINCape.STP, 
		
    })
	sets.me.melee.tanktp = set_combine(sets.me.melee.tanknor,{ --high evasion/mag eva with capped dt subtle blow caps with buff
        ammo		=	"Date Shuriken",--ammo		=	"Yamarang",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Malignance Tights",
		feet		=	"Malignance Boots",
		waist 		=	"Engraved Belt",
		neck		=	"Bathy Choker +1",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Defending Ring",
		left_ear	=	"Eabani Earring",
		right_ear	=	"Odnowa Earring +1",
		back 		=	NINCape.Eva, 
    })
	------------------------------------------------------------------
	--GK Builds optimal for 40-50 store tp total so without sam roll will need that much with sam roll want minimal store tp.
	------------------------------------------------------------------
	--use this for no sam roll
	sets.me.melee.dpsgk = set_combine(sets.me.melee.dpsnor,{
		ammo		=	"Seki Shuriken",
        head		=	"Ken. Jinpachi +1",
        body		=	"Mpaca's Doublet",
        hands		=	"Malignance Gloves",
        legs		=	"Mpaca's Hose",	
        feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        right_ear	=	"Brutal Earring",
        left_ear	=	"Cessance Earring",
        left_ring	=	"Gere Ring",
        right_ring	=	"Epona's Ring", 
		back		=	NINCape.DEXDA,
    })
	--optimized for sam roll
    sets.me.melee.accgk = set_combine(sets.me.melee.accnor,{
		ammo		=	"Date Shuriken",
        head		=	"Ken. Jinpachi +1",
		body		=	"Ken. Samue +1",
		hands		=	"Mpaca's Gloves",
		legs		=	"Mpaca's Hose",	
		feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
		left_ring	=	"Gere Ring",
        right_ring	=	"Epona's Ring", 
		right_ear	=	"Brutal Earring",
        left_ear	=	"Cessance Earring",
		back		=	NINCape.DEXDA,
    })
	-- this is capped dt over 130 more evasion, 5% more parry but definitely a loss to damage especially when not using shuriken, capped subtle blow with buff
	sets.me.melee.dtgk = set_combine(sets.me.melee.dtnor,{ 
		ammo		=	"Date Shuriken",
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Ken. Hakama +1",
		feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
		waist 		=	"Kentarch Belt +1",
        right_ear	=	"Odnowa Earring +1",
		left_ear	=	"Telos Earring",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Defending Ring",
		back		=	NINCape.STP, 
		
    })
	sets.me.melee.tankgk = set_combine(sets.me.melee.tanknor,{ --high evasion/mag eva with capped dt subtle blow caps with buff
        ammo		=	"Date Shuriken",--ammo		=	"Yamarang",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Malignance Tights",
		feet		=	"Malignance Boots",
		waist 		=	"Engraved Belt",
		neck		=	"Bathy Choker +1",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Defending Ring",
		left_ear	=	"Eabani Earring",
		right_ear	=	"Odnowa Earring +1",
		back 		=	NINCape.Eva, 
    })
	
	-------------------------------------------------------------------------
	-- optimized for 8 more dt from offhand Tsuru primarily used for tanking so even dps build should have no adhem or samnuha assume su5 path c mainhand
	-------------------------------------------------------------------------
	 sets.me.melee.dpstsu = set_combine(sets.me.melee.dpsnor,{
        ammo		=	"Date Shuriken",
         head		=	"Ken. Jinpachi +1",
        body		=	"Mpaca's Doublet",
        hands		=	"Malignance Gloves",
        legs		=	"Mpaca's Hose",	
        feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        right_ear	=	"Brutal Earring",
        left_ear	=	"Dedition Earring",
        left_ring	=	"Gere Ring",
        right_ring	=	"Epona's Ring", 
		back		=	NINCape.DEXDA,
    })
	-- optimized for 8 more dt from offhand Tsuru
    sets.me.melee.acctsu = set_combine(sets.me.melee.accnor,{
		ammo		=	"Date Shuriken",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Ken. Hakama +1",
		waist 		=	"Sailfi Belt +1",
		left_ring	=	"Gere Ring",
		right_ring	=	"Defending Ring",
		left_ear	=	"Telos Earring",
		right_ear	=	"Odnowa Earring +1",
		back		=	NINCape.STP,
    })
	-- optimized for 8 more dt from offhand Tsuru
	sets.me.melee.dttsu = set_combine(sets.me.melee.dtnor,{ 
		ammo		=	"Date Shuriken",
		head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Ken. Hakama +1",
		feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
		waist		=	"Sailfi Belt +1",
        right_ear	=	"Odnowa Earring +1",
		left_ear	=	"Telos Earring",
		left_ring	=	"Gere Ring",
		right_ring	=	"Defending Ring",
		back		=	NINCape.DEXDA,  
		
    })
	sets.me.melee.tanktsu = set_combine(sets.me.melee.tanknor,{ --high evasion/mag eva with capped dt subtle blow caps with buff
        ammo		=	"Date Shuriken",--ammo		=	"Yamarang",
        head		=	"Malignance Chapeau",
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
		legs		=	"Malignance Tights",
		feet		=	"Malignance Boots",
		waist 		=	"Engraved Belt",
		neck		=	"Bathy Choker +1",
		left_ring	=	"Gelatinous Ring +1",
		right_ring	=	"Hizamaru Ring", --solid evasion with store tp and acc, could go shadow ring if magic is more concern
		left_ear	=	"Eabani Earring",
		right_ear	=	"Odnowa Earring +1",
		back 		=	NINCape.Eva, 
    })
	
	

	
	sets.me.melee.turtle = set_combine(sets.me.melee.tanknor,{
		neck		=	"Loricate Torque +1",
		left_ring	=	"Shadow Ring",
	
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
		back		=	NINCape.DEXDA,			--10
		}									--snapshot 57/58 only need 40 with flurry2 but often dont want to lose haste
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
        back		=	NINCape.DEXDA,
		}
	-- for PD, stack dakken store tp and ranged acc. 
	sets.me.daken 	= {
		ammo		=	"Date Shuriken",
		head		=	"Malignance Chapeau",
        body		=	RELIC.Body,
        hands		=	AF.Hands,
        legs		=	"Malignance Tights",
        feet		=	"Malignance Boots",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Reiki Yotai",
        left_ear	=	"Telos Earring",
        right_ear	=	"Crep. Earring",
		left_ring	=	"Crepuscular Ring",
		right_ring	=	"Cacoethic Ring +1",
        back		=	"Sacro Mantle", --could make a ranged acc cape with store tp
		}
	
	------------------------------------------------------------------------------------------------------
    -- Weapon Skills sets just add them by name.
	------------------------------------------------------------------------------------------------------
    --50 STR 50 MND high ftp first hit
	sets.me["Savage Blade"] = {
        ammo		=	"Seeth. Bomblet +1",	 
        head		=	"Mpaca's Cap", 
        body		=	"Nyame Mail", 
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",	
        feet		=	"Nyame Sollerets",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Epaminondas's Ring",
        back		=	NINCape.STRWS, 
	}
	sets.mtp["Savage Blade"] = { --swap to nyame helm first at high tp
		head = "Nyame Helm",
	}
	sets.htp["Savage Blade"] = { --then swap earring at even higher tp
		left_ear = "Ishvara Earring",
	}
	--30 str 30 dex frontloaded high ftp varys with tp
	sets.me["Blade: Ten"] = {
        ammo		=	"Seeth. Bomblet +1",  
        head		=	"Mpaca's Cap",
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",
        feet		=	"Nyame Sollerets", 
        neck		=	"Ninja Nodowa +2", 
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.STRWS, 
	}
	sets.mtp["Blade: Ten"] = {
		head = "Nyame Helm",
	}
	sets.htp["Blade: Ten"] = {
		left_ear = "Ishvara Earring",
	}
	sets.me["Tachi: Kasha"] = sets.me["Blade: Ten"]
	sets.mtp["Tachi: Kasha"] = sets.mtp["Blade: Ten"]
	sets.htp["Tachi: Kasha"] = sets.htp["Blade: Ten"]
	--80 dex but super att increases with tp
    sets.me["Blade: Shun"] = {
        ammo        =   "Crepuscular Pebble", 
        head		=	"Mpaca's Cap", 
        body		=	"Malignance Tabard",
        hands		=	"Malignance Gloves",
        legs		=	"Mpaca's Hose",
        feet		=	"Ken. Sune-Ate +1",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Lugra Earring +1",
        right_ear	=	"Moonshade Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.DEXDA,
    }
	sets.htp["Blade: Shun"] = {
		right_ear	=	"Brutal Earring",
	}
	--80% AGI 5 ftp with crit varrying with tp  without empy best is su5/ambu
    sets.me["Blade: Hi"] = {
        ammo        =   "Yetshila +1",
        head		=	AdhemHead.Acc,
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	RELIC.Legs,	
        feet		=	"Nyame Sollerets",
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Odr Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.AGIWS,
    }
	--30% str 30% dex  crit varrying with tp  if ddex capped already have 55% crit with innin
    sets.me["Blade: Jin"] = {
        ammo        =   "Yetshila +1",
        head		=	AdhemHead.STR,
        body		=	"Mpaca's Doublet",
        hands		=	"Ryuo Tekko +1", 
        legs		=	"Mpaca's Hose",	
        feet		=	"Mpaca's Boots", 
        neck		=	"Ninja Nodowa +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Odr Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.DEXDA, 
    }
	-- 60 str 60 int 1ftp nontransfer 3x attack bonus tp only increases blind duration
    sets.me["Blade: Kamu"] = {
        ammo		=	"Aurgelmir Orb +1",	 
        head		=	AdhemHead.STR,
        body		=	"Ken. Samue +1",
        hands		=	"Malignance Gloves", 
        legs		=	"Mpaca's Hose",	
        feet		=	"Ken. Sune-Ate +1", 
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Brutal Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Sroda Ring",
        back		=	NINCape.STRWS, 
	}
	--30 str 30 dex 1.25 ftp transfer 5 hit acc for tp
	sets.me["Blade: Ku"] = {   
        ammo		=	"Aurgelmir Orb +1",	 
        head		=	"Ken. Jinpachi +1",
        body		=	"Mpaca's Doublet",
        hands		=	AdhemHands.STR,
        legs		=	"Mpaca's Hose",	
        feet		=	"Mpaca's Boots", 
        neck		=	"Ninja Nodowa +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Lugra Earring +1",
        right_ear	=	"Brutal Earring",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.DEXDA,
    }
	--single hit crit ws but crit is independent of crit gear ddex etc. only depends on tp 60% str 60% dex
	sets.me["Blade: Rin"] = {
		ammo        =   "Yetshila +1",
        head		=	"Mpaca's Cap",
        body		=	"Mpaca's Doublet",
        hands		=	"Ryuo Tekko +1", 
        legs		=	RELIC.Legs,	
        feet		=	RELIC.Feet,
        neck		=	"Ninja Nodowa +2",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Moonshade Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.STRWS,
	
	}
	--20 str 60 dex strong para duration based on tp use mpaca for mix damage mag acc
	sets.me["Blade: Retsu"] = {
        ammo		=	"Aurgelmir Orb +1",	 
        head		=	"Mpaca's Cap",
        body		=	"Mpaca's Doublet",
        hands		=	AdhemHands.STR, 
        legs		=	RELIC.Legs,	
        feet		=	RELIC.Feet, 
        neck		=	"Fotia Gorget",
        waist		=	"Sailfi Belt +1",
        left_ear	=	"Brutal Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.DEXDA, 
	}
	
	sets.me["Evisceration"] =  {
        ammo        =   "Yetshila +1",
        head		=	AdhemHead.STR,
        body		=	"Ken. Samue +1",
        hands		=	"Ryuo Tekko +1", 
        legs		=	"Mpaca's Hose",	
        feet		=	"Ken. Sune-Ate +1", 
        neck		=	"Ninja Nodowa +2",
        waist		=	"Fotia Belt",
        left_ear	=	"Odr Earring",
        right_ear	=	"Lugra Earring +1",
        left_ring   =  	"Gere Ring",
        right_ring	=	"Regal Ring",
        back		=	NINCape.DEXDA, 
    } 
	
	
	--elemental ws are Yu and Ei, these are pure mab/magic damage etx
	--yu 40 dex 40 int water  does not scale with tp 3ftp
	sets.me["Blade: Yu"] = {
	    ammo		=	"Seeth. Bomblet +1",
        head		=	RELIC.Head,
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard", 
        feet		=	"Nyame Sollerets",
		neck		=	"Baetyl Pendant",
        waist		=	"Orpheus's Sash",
        left_ear	=	"Lugra Earring +1",
        right_ear	=	"Friomisi Earring",
        left_ring	=	"Epaminondas's Ring",
        right_ring	=	"Dingir Ring",
        back		=	NINCape.INTMAB, 
		}
	--ei 40 str 40 int with halved and capped dint (scales with tp)
	sets.me["Blade: Ei"] = set_combine(sets.me["Blade: Yu"],{
		head		= 	"Pixie Haripin +1",
        left_ear	=	"Moonshade Earring",
	})
	sets.me["Aeolian Edge"] = set_combine(sets.me["Blade: Yu"],{
        left_ear	=	"Moonshade Earring",
	})
	--Hybrid ws apparently these do normal physical damage ws with 1 ftp non transfer and then a second damage effect which takes that physical
	-- and muliplies it by fTP that varies by tp listed on ws and 
	--(((Physical ws)*fTP)+mDMG) * mDiff * Affinity * Day/Weather * SDT * WSD
	
	--chi 2 hit earth 30 str 30 int
	sets.me["Blade: Chi"] = {
	    ammo		=	"Seeth. Bomblet +1",
        head		=	RELIC.Head,
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard",		
        feet		=	"Nyame Sollerets",
        neck		=	"Baetyl Pendant",	-- wins for chi, fotia better for fewer hit hybrids
        waist		=	"Orpheus's Sash",
        left_ear	=	"Moonshade Earring", 
        right_ear	=	"Lugra Earring +1",
        left_ring	=	"Epona's Ring", 
        right_ring	=	"Gere Ring", 
        back		=	NINCape.STRWS, 
		}
	sets.htp["Blade: Chi"] ={
		left_ear	=	"Ishvara Earring",
	}
	--teki water 30 str 30 int
	sets.me["Blade: Teki"] = set_combine(sets.me["Blade: Chi"],{
		neck		=	"Fotia Gorget",
	})
	sets.htp["Blade: Teki"] ={
		left_ear	=	"Ishvara Earring",
	}
	--to ice 40 str 40 int
	sets.me["Blade: To"] = set_combine(sets.me["Blade: Chi"],{
		neck		=	"Fotia Gorget",
	})
	sets.htp["Blade: To"] ={
		left_ear	=	"Ishvara Earring",
	}
	--fire
	sets.me["Tachi: Kagero"] = set_combine(sets.me["Blade: Chi"],{
		neck		=	"Fotia Gorget",
	})
	sets.htp["Tachi: Kagero"] ={
		left_ear	=	"Ishvara Earring",
	}
	--lightning
	sets.me["Tachi: Goten"] = set_combine(sets.me["Blade: Chi"],{
		neck		=	"Fotia Gorget",
	})
	sets.htp["Tachi: Goten"] ={
		left_ear	=	"Ishvara Earring",
	}
	--wind
	sets.me["Tachi: Jinpu"] = set_combine(sets.me["Blade: Chi"],{
		neck		=	"Fotia Gorget",
	})
	sets.htp["Tachi: Jinpu"] ={
		left_ear	=	"Ishvara Earring",
	}
	--light
	sets.me["Tachi: Koki"] = set_combine(sets.me["Blade: Chi"],{
		neck		=	"Fotia Gorget",
		left_ring	=	"Weather. Ring +1",
	})
	sets.htp["Tachi: Koki"] ={
		left_ear	=	"Ishvara Earring",
	}
	
	sets.me.Enmity={
		ammo		=	"Date Shuriken",		-- +3
		head		=	"Herculean Helm", 		--  provides fast cast for the spells that use maybe make seperate set at some point
        body		=	"Emet Harness +1", 		-- +10
        hands		=	"Kurys Gloves",			-- +9
        legs		=	"Zoar Subligar +1", 	-- +6
        feet		=	RELIC.Feet, 			-- +8
        neck		=	"Moonlight Necklace", 	-- +15
        waist		=	"Trance Belt",	 		-- +4
        left_ear	=	"Cryptic Earring", 		-- +4 
        right_ear	=	"Trux Earring", 		-- +5
        left_ring	=	"Pernicious Ring", 		-- +5
        right_ring	=	"Eihwaz Ring", 			-- +5
        back		=	NINCape.Eva, 			-- +10 
	} 		--+84  + 60 from JA and spell + 70 with su5 katana with full shadows  +15 from tsuru for 229, 200 is cap so can miss 2 shadows or not have full power yonin
	
	
	sets.me.EnmityNB={ --without ammo swap to reduce blinking date shuriken made obsolete
		ammo		=	"Date Shuriken",		--	+3
		head		=	"Herculean Helm", 		--  provides fast cast for the spells that use
        body		=	"Emet Harness +1", 		-- +10
        hands		=	"Kurys Gloves",			-- +9
        legs		=	"Zoar Subligar +1", 	-- +6
        feet		=	RELIC.Feet, 			-- +8
        neck		=	"Moonlight Necklace", 	-- +15
        waist		=	"Trance Belt",	 		-- +4
        left_ear	=	"Cryptic Earring", 		-- +4
        right_ear	=	"Trux Earring", 		-- +5
        left_ring	=	"Pernicious Ring", 		-- +5
        right_ring	=	"Eihwaz Ring", 			-- +5
        back		=	NINCape.Eva, 			-- +10 
	} 	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty     
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast RDM need 50 pre JP 42 at master
    sets.precast.casting = {
		ammo		=	"Sapience Orb",			--2
		head		=	"Herculean Helm",		--13
		body		=	AdhemBody.FC,			--10
		hands		=	"Leyline Gloves",		--7 can get to 8
        legs		=	HercLegs.FC, 			--6 
		feet		=	HercFeet.FC,			--6
        neck		=	"Baetyl Pendant",    	--4 can get 1 more
        waist		=	"Flume Belt +1", 
        left_ear	=	"Etiolation Earring",  	--1 can get 1 more at cost of hp
        right_ear	=	"Loquac. Earring",		--2
        left_ring	=	"Kishar Ring",			--4
        right_ring	=	"Weather. Ring +1",		--6
		back		=	NINCape.FC,				--10
    }											--Total: 71 need 60 to cap ninjutsu, 80 to cap everything else
	
	
	
	sets.precast.ninjutsu = set_combine(sets.precast.casting,{--since I don't need as much keep hp higher.
		ammo		=	"",		-- reduce blinking
		left_ring	=	"Gelatinous Ring +1",	-- -4
		right_ear	=	"Odnowa Earring +1",		-- -2
    })											-- 63 out of 60 

    sets.precast["Utsusemi"] = set_combine(sets.precast.ninjutsu,{
		feet		=	EMPY.Feet,
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

    sets.precast["Mjin Gakure"] = {legs = RELIC.Legs}
	
	sets.precast["Provoke"] = sets.me.Enmity
	sets.precast["Animated Flourish"] = sets.me.Enmity
	sets.precast["Warcry"] = sets.me.Enmity
	sets.precast["Last Resort"] = sets.me.Enmity
	sets.precast["Souleater"] = sets.me.Enmity
	sets.precast["Swordplay"] = sets.me.Enmity
	sets.precast["Vallation"] = sets.me.Enmity
	sets.precast["Pflug"] = sets.me.Enmity
	sets.precast["Sentinel"] = sets.me.Enmity
	
	sets.precast["Jump"]= set_combine(sets.me.melee.normalin,{ 
		ammo =	"Aurgelmir Orb +1", --Dakken appears not to trigger
		}) 
	sets.precast["High Jump"] = sets.precast["Jump"]
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


    -- This is what you use for Yonin so even if dispelled you have +enmity, nuking and enfeebles are seperate
    sets.midcast.casting = sets.me.Enmity
	--if Innan then max ninja tool expertise and -enmity
	sets.midcast.castingin = set_combine(sets.me.melee.dtin, {
		hands		=	RELIC.Hands
	})
	--if I could go path c on Nyame it would make these nuking sets very OP
    sets.midcast.nuking = {

        ammo		=	"Ghastly Tathlum +1",
        head		=	RELIC.Head,
        body		=	"Nyame Mail",
        hands		=	"Nyame Gauntlets",
        legs		=	"Nyame Flanchard", 
        feet		=	"Nyame Sollerets",
        neck		=	"Baetyl Pendant",
        waist		=	"Skrymir Cord +1",
        left_ear	=	"Lugra Earring +1",
        right_ear	=	"Friomisi Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Dingir Ring",
        back		=	NINCape.INTMAB,
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst pretty much only use with kunimitsu so only need 30 mbb
    sets.midcast.MB = set_combine(sets.midcast.nuking, {  
		ammo		=	"Ghastly Tathlum +1",
        head		=	RELIC.Head,
        body		=	"Nyame Mail",			--7
        hands		=	"Nyame Gauntlets",		--5
        legs		=	"Nyame Flanchard", 		--6
		feet		=	"Nyame Sollerets",		--5
		neck		=	"Warder's Charm +1",	--10
		waist		=	"Skrymir Cord +1",
        left_ear	=	"Lugra Earring +1",
        right_ear	=	"Friomisi Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	"Mujin Band",
        back		=	NINCape.INTMAB,
    })											--33/40 MBB +10from katana
	
	--Futae versions
	sets.midcast.Fnuking = set_combine(sets.midcast.nuking, {
        hands 		= 	EMPY.Hands,
    })
	sets.midcast.FMB = set_combine(sets.midcast.MB, {
        hands 		= 	EMPY.Hands,
		feet		=	AF.Feet,
    })

	

	
    -- Enfeebling

	sets.midcast.Yonin = {} -- leave Empty
	sets.midcast.Innin = {}
	sets.midcast.YoninC = {}

	--debuffs max mag acc
    sets.midcast.Yonin["NinDeBuff"] = set_combine(sets.me.Enmity, {
        ammo		=	"",
        head		=	AF.Head,
        body		=	"Malignance Tabard",
        hands		=	RELIC.Hands, --can get a little higher magic acc but this saves a ton of tools
        legs		=	"Malignance Tights", 
        feet		=	AF.Feet,
        neck		=	"Moonlight Necklace",
        waist		=	"Gosha Sarashi",--could get some macc here but lose an inventory slot
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        left_ear	=	"Etiolation Earring", --dignitary for more macc
		right_ear	=	"Crep. Earring",
        back		=	NINCape.INTMAB,
	})
	sets.midcast.YoninC["NinDeBuff"] = sets.midcast.Yonin["NinDeBuff"]
	
	sets.midcast.Innin["NinDeBuff"] = set_combine(sets.midcast.Yonin["NinDeBuff"], {
        ammo		=	"Pemphredo Tathlum",
	})
	--for Treasure Hunter
	sets.midcast.Yonin["Dokumori: Ichi"] = set_combine(sets.midcast.Yonin["NinDeBuff"], {
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
		})
	sets.midcast.YoninC["Dokumori: Ichi"] = sets.midcast.Yonin["Dokumori: Ichi"]
	sets.midcast.Innin["Dokumori: Ichi"] = sets.midcast.Yonin["Dokumori: Ichi"]
	



    -- Enhancing yourself these spells cast slower so want dt and may as well use ninja tool expertise since not much enmity.
    sets.midcast.Yonin["NinBuff"] = set_combine(sets.me.melee.dtyo, { 
		hands		=	RELIC.Hands,
		waist 		=	"Gosha Sarashi",
        back		=	NINCape.FC, 
	})
	sets.midcast.YoninC["NinBuff"]=sets.midcast.Yonin["NinBuff"]
	sets.midcast.Innin["NinBuff"] =set_combine(sets.me.melee.dtyo, {
		hands		=	RELIC.Hands,
		waist 		=	"Gosha Sarashi",
        back		=	NINCape.FC, 
	})
	--max skill for Migawari, every 4-5 skill is another 1% lower activation could get DI earring and a 5 skill belt without recast issues. need 22 FC to cap recast times with su5 C
	sets.midcast.Yonin["Migawari: Ichi"] = set_combine(sets.precast.ninjutsu, {
		head 		= 	AF.Head,
		hands		=	RELIC.Hands,
		waist 		=	"Gosha Sarashi",
		feet 		= 	RELIC.Feet,
        neck		=	"Incanter's Torque",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        back		=	NINCape.FC,
	})
	sets.midcast.YoninC["Migawari: Ichi"]=sets.midcast.Yonin["Migawari: Ichi"]
	sets.midcast.Innin["Migawari: Ichi"] = set_combine(sets.precast.casting, { --without su5 c need 72 fc to cap recast times so more focused on recast times
		waist 		=	"Gosha Sarashi",
		feet 		= 	RELIC.Feet,
        neck		=	"Incanter's Torque",
        back		=	NINCape.FC, 
	
	})
	--utsusemi are major for enmity in yonin and with su5 but need 22 fc to cap recast times with su5 c
	sets.midcast.YoninC["Utsusemi"] = set_combine(sets.me.Enmity, {
		head		=	"Herculean Helm",
		body		=	AdhemBody.FC,
		feet		= 	EMPY.Feet,
		back 		=	NINCape.Eva,
	})
	sets.midcast.Yonin["Utsusemi"] = set_combine(sets.me.Enmity, {
		ammo		=	"Sapience Orb",
		head		=	"Herculean Helm",
		body		=	AdhemBody.FC,
		hands		=	"Leyline Gloves",
		legs		=	HercLegs.FC, 
		feet		= 	EMPY.Feet,
		left_ear	=	"Etiolation Earring",  	
        right_ear	=	"Loquac. Earring",	
		left_ring	=	"Kishar Ring",		
        right_ring	=	"Weather. Ring +1",	
		back 		=	NINCape.FC,
	})
	--dont need enmity but would still like ninja tool expertise since not tanking so its ok recast timers not capped.
	sets.midcast.Innin["Utsusemi"] = set_combine(sets.precast.casting, {
		hands		=	RELIC.Hands,
		feet		= 	EMPY.Feet,
		waist 		=	"Gosha Sarashi",
		back		=	NINCape.FC,
	})
	
	sets.midcast.Yonin["Aquaveil"] = set_combine(sets.me.melee.dtyo, {
		ammo		=	"",
        neck		=	"Incanter's Torque",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
        left_ear	=	"Mimir Earring", 
		right_ear	=	"Andoaa Earring",
		waist		=	"Olympus Sash",
		})
	sets.midcast.YoninC["Aquaveil"]=sets.midcast.Yonin["Aquaveil"]
	sets.midcast.Innin["Aquaveil"] = sets.midcast.Yonin["Aquaveil"]
	
	sets.midcast.Yonin.BarElement = sets.midcast.Yonin["Aquaveil"]
	sets.midcast.YoninC.BarElement =sets.midcast.Yonin.BarElement
	sets.midcast.Innin.BarElement = sets.midcast.Yonin["Aquaveil"]
		
	-- equips for utsusemi when shadows are down instead of enmity or dt/tool expertise
	sets.midcast.SIRD = set_combine(sets.midcast.Yonin["Utsusemi"], {
	    ammo		=	"Staunch Tathlum +1",							--11
		head		=	TaeonHead.Phalanx,								--10
		neck		=	"Moonlight Necklace",							--15
		ear1		=	"Halasz Earring", 								--5
		ear2		=	"Magnetic Earring",								--8
		body		=	TaeonBody.Phalanx,								--10
		hands		=	"Rawhide Gloves",								--15
		right_ring	=	"Defending Ring",								
		left_ring	=	"Gelatinous Ring +1",
		waist		=	"Audumbla Sash",								--10
		legs		=	"Wukong's Haka. +1",							--10
		feet		=	EMPY.Feet,
		back		=	NINCape.FC, 									--10
																		--103 total
	})
	--again for when shadows are down, this does make migawari weaker but when you need it up you need it up also 30 fc for capped recast with su5
	sets.midcast.SIRDMiga = set_combine(sets.midcast.Yonin["Migawari: Ichi"], { 
	    ammo		=	"Staunch Tathlum +1",							--11
		head		=	TaeonHead.Phalanx,								--10
		neck		=	"Moonlight Necklace",							--15
		ear1		=	"Halasz Earring", 								--5
		ear2		=	"Magnetic Earring",								--8
		body		=	TaeonBody.Phalanx,								--10
		hands		=	"Rawhide Gloves",								--15
        left_ring	=	"Kishar Ring",			
        right_ring	=	"Weather. Ring +1",		
		waist		=	"Audumbla Sash",								--10
		legs		=	"Wukong's Haka. +1",							--10
		feet		=	HercFeet.FC,			
		back		=	NINCape.FC, 									--10
																		--103 total
	})



	--may make a better set for these that lowers recasts more at the cost of some enmity, these don't benefit from su5 c so need 72 fc to cap recast.
	sets.midcast.Innin["Flash"] = sets.me.Enmity
	sets.midcast.Innin["Stun"] = sets.me.Enmity
	sets.midcast.Yonin["Flash"] = sets.me.Enmity
	sets.midcast.Yonin["Stun"] = sets.me.Enmity
	sets.midcast.Yonin["Poisonga"] = sets.me.Enmity
	sets.midcast.Innin["Poisonga"] = sets.me.Enmity

	
end
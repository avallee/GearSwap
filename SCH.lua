
--[[
	Jakey's SCH.lua Partially based off Elizabet's SCH lua https://github.com/Tunaliz/Liz_Gearswaps
	Shortcuts add on is assumed still required.
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
                
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm II buff of saved element  
                    
        gs c sc tier                    Cycles SC Tier (1 & 2)
        gs c sc castsc                  Cast All the stuff to create a SC burstable by the nuke element set with '/console gs c nuke element'.
        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.
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

-------------------------------------------------------------                                        
--                              
--      ,---.     |    o               
--      |   |,---.|--- .,---.,---.,---.
--      |   ||   ||    ||   ||   |`---.
--      `---'|---'`---'``---'`   '`---'
--           |                         
-------------------------------------------------------------  

include('organizer-lib') -- Can remove this if you dont use organizer
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt')
regenModes = M('hybrid', 'duration')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc', 'occult')

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
    windower.send_command('bind home gs c nuke cycle')        	-- home to Cycles Nuke element
    --windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
    windower.send_command('bind f10 gs c toggle idlemode')       -- F9 to change Idle Mode    
    windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
    windower.send_command('bind !home gs c sc tier')				-- home to change SC tier between Level 1 or Level 2 SC
    windower.send_command('bind end gs c toggle regenmode')		-- end to change Regen Mode	
    --windower.send_command('bind f10 gs c toggle mb')            -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind f11 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F11 gs c toggle matchsc')      -- CTRL-F10 to change Match SC Mode
    --windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version   

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_sc_level'] = '(HOME)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    --send_command('unbind insert')
    --send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind !home')
    send_command('unbind end')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !f9')	
    --send_command('unbind !end')      	
end


--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')          -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------


-- Optional. Swap to your sch macro sheet / book
set_macros(1,2) -- Sheet, Book


-------------------------------------------------------------                                        
--      ,---.                         |         
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------                                              

-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty
	
	    -- JSE
    AF = {}         -- leave this empty
    RELIC = {}      -- leave this empty
    EMPY = {}       -- leave this empty
	
		-- Fill this with your own JSE. 
    --Academic's
    AF.Head		=	"Acad. Mortar. +3"
    AF.Body		=	"Acad. Gown +3"
    AF.Hands	=	"Acad. Bracers +3"
    AF.Legs		=	"Acad. Pants +3"
    AF.Feet		=	"Acad. Loafers +3"

    --Pedagogy
    RELIC.Head		=	"Peda. M.Board +3"
    RELIC.Body		=	"Peda. Gown +3"
    RELIC.Hands 	=	"Peda. Bracers +3"
    RELIC.Legs		=	"Peda. Pants +3"
    RELIC.Feet		=	"Peda. Loafers +3"

    --Arbatel
    EMPY.Head		=	"Arbatel Bonnet +1"
    EMPY.Body		=	""
    EMPY.Hands		=	"Arbatel Bracers +1"
    EMPY.Legs		=	""
    EMPY.Feet		=	""
	
	Lugh = {}
	Lugh.INTMAB ={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Damage taken-5%',}}
	Lugh.AccHas ={ name="Lugh's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	Lugh.Omni ={ name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	
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
	
	Bookworm = {}
	Bookworm.Reg = { name="Bookworm's Cape", augments={'INT+1','MND+1','Helix eff. dur. +10','"Regen" potency+10',}}
	Bookworm.Helix = { name="Bookworm's Cape", augments={'INT+4','MND+4','Helix eff. dur. +20',}}
	
	MerlHead = {}
	MerlHead.MB = { name="Merlinic Hood", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Magic burst dmg.+10%','INT+7','"Mag.Atk.Bns."+8',}}
	
	MerlBody = {}
	MerlBody.FC = { name="Merlinic Jubbah", augments={'"Fast Cast"+7','"Mag.Atk.Bns."+8',}}
	MerlBody.MB ={ name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+10%','"Mag.Atk.Bns."+9',}}
	
	MerlLegs = {}
	MerlLegs.MB = { name="Merlinic Shalwar", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','INT+9','Mag. Acc.+5',}}
	MerlLegs.TH = { name="Merlinic Shalwar", augments={'Accuracy+3','AGI+3','"Treasure Hunter"+2','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	MerlLegs.WS = { name="Merlinic Shalwar", augments={'Pet: "Mag.Atk.Bns."+9','Mag. Acc.+23','Weapon skill damage +10%','Accuracy+12 Attack+12','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	
	MerlFeet = {}
	MerlFeet.FC = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+7',}}
	MerlFeet.Occ = { name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+7','"Occult Acumen"+11','INT+9','Mag. Acc.+1',}}
	
	MerlHands = {}
	MerlHands.Aspir = { name="Merlinic Dastanas", augments={'Mag. Acc.+16','"Drain" and "Aspir" potency +11','INT+7',}}
	MerlHands.Ref = { name="Merlinic Dastanas", augments={'Accuracy+8','INT+1','"Refresh"+2','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
	MerlHands.Occ = { name="Merlinic Dastanas", augments={'Mag. Acc.+14','"Occult Acumen"+11','MND+5',}}
	
	ChironicFeet={}
	ChironicFeet.TH = { name="Chironic Slippers", augments={'AGI+10','Pet: DEX+6','"Treasure Hunter"+1','Accuracy+18 Attack+18','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	ChironicFeet.Phalanx = { name="Chironic Slippers", augments={'Pet: STR+3','MND+10','Phalanx +5','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
	ChironicFeet.Ref = { name="Chironic Slippers", augments={'Pet: Mag. Acc.+17','Pet: "Dbl.Atk."+2 Pet: Crit.hit rate +2','"Refresh"+2','Accuracy+10 Attack+10',}}
	
	
    -- Your idle set
    sets.me.idle.refresh = {
		main		=	"Tupsimati",
		sub			=	"Khonsu",
		ammo		=	"Homiliary",
		head		=	"Befouled Crown",
		body		=	"Jhakri Robe +2",
		hands		=	MerlHands.Ref,
		legs		=	"Assid. Pants +1",
		feet		=	"Herald's Gaiters",
		neck		=	"Rep. Plat. Medal",
		waist		=	"Fucho-no-Obi",
		left_ear	=	"Infused Earring",
		right_ear	=	"Savant's Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	Lugh.AccHas
    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh,{
		head		=	AF.Head,
		Body		=	RELIC.Body,
		feet		=	ChironicFeet.Ref,
		waist		=	"Embla Sash",
		left_ear	=	"Infused Earring",
		right_ear	=	"Savant's Earring",
		
    })   
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle.refresh,{
		head		=	"Nyame Helm",
		body		=	"Agwu's Robe",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Loricate Torque +1",
		left_ear	=	"Odnowa Earring +1",
		back		=	Lugh.AccHas
    })  
    sets.me.idle.mdt = set_combine(sets.me.idle.refresh,{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 
		waist		=	"Shinjutsu-no-Obi +1",
    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
    sets.me.melee = set_combine(sets.me.idle[idleModes.current],{
		ammo		=	"Crepuscular Pebble",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Gazu Bracelet +1",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Combatant's Torque",
		waist		=	"Windbuffet Belt +1",
		left_ear	=	"Telos Earring",
		right_ear	=	"Cessance Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	{name="Chirich Ring +1", bag="wardrobe2"},
		back		=	Lugh.AccHas
    })
	
	sets.Shit=set_combine(sets.me.idle.dt,{
		ammo		=	"Crepuscular Pebble",	
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Warder's Charm +1",
		left_ear	=	"Eabani Earring",
		right_ear	=	"Lugalbanda Earring",
		right_ring	=	"Shadow Ring",
		back		=	Lugh.AccHas,
	})
      
    -- Weapon Skills sets just add them by name.
    sets.me["Shattersoul"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Argute Stole +2",
		waist		=	"Acuity Belt +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Mache Earring +1",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Cacoethic Ring +1",
		back		=	Lugh.AccHas
    }
	
	sets.me["Full Swing"]= {
		ammo		=	"Amar Cluster",
		head		=	"Nyame Helm",
		body		=	"Nyame Mail",
		hands		=	"Nyame Gauntlets",
		legs		=	"Nyame Flanchard",
		feet		=	"Nyame Sollerets",
		neck		=	"Fotia Gorget",
		waist		=	"Fotia Belt",
		left_ear	=	"Mache Earring +1",
		right_ear	=	"Moonshade Earring",
		left_ring	=	"Cacoethic Ring +1",
		right_ring	=	"Epaminondas's Ring",
		back		=	Lugh.AccHas
    }
	sets.me["Retribution"]= sets.me["Full Swing"]
	sets.me["Spirit Taker"]= sets.me["Full Swing"]
	sets.me["Shell Crusher"]= sets.me["Full Swing"]
	
    sets.me["Myrkr"] = {
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Amalric Coif +1",
		body		=	"Amalric Doublet +1",
		hands		=	"Kaykaus Cuffs +1",
		legs		=	"Amalric Slops +1",
		feet		=	"Amalric Nails +1",
		neck		=	"Nodens Gorget",
		waist		=	"Shinjutsu-no-Obi +1",
		left_ear	=	"Moonshade Earring",
		right_ear	=	"Etiolation Earring",
		left_ring	=	"Mephitas's Ring",
		right_ring	=	"Mephitas's Ring +1",
		back		=	"Aurist's Cape +1",
    }
	
	sets.me["Omniscience"] = {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Pixie Hairpin +1",
		body		=	"Nyame Mail",
		hands		=	"Jhakri Cuffs +2",
		legs		=	"Amalric Slops +1",
		feet		=	"Amalric Nails +1",
		neck		=	"Argute Stole +2",
		waist		=	"Orpheus's Sash",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Epaminondas's Ring",
		back		=	Lugh.Omni
    } 
	
	sets.me["Cataclysm"] = sets.me["Omniscience"] 
	sets.me["Sunburst"] = sets.me["Omniscience"] 
	sets.me["Starburst"] = sets.me["Omniscience"] 
	
	sets.me["Rock Crusher"] = set_combine(sets.me["Omniscience"],{
		head 		=	"Agwu's Cap",
		left_ring	=	"Freke Ring",
	})
	sets.me["Earth Crucher"] =sets.me["Rock Crusher"]
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
	sets.me.Occult={
		ammo		=	"Seraphic Ampulla",
		head		=	"Mall. Chapeau +2",
		body		=	"Seidr Cotehardie",
		hands		=	MerlHands.Occ,
		legs		=	"Perdition Slops",
		feet		=	MerlFeet.Occ,
		neck		=	"Combatant's Torque",
		waist		=	"Patentia Sash",
		left_ear	=	"Crep. Earring",
		right_ear	=	"Dedition Earring",
		left_ring	=	{name="Chirich Ring +1", bag="wardrobe3"},
		right_ring	=	"Crepuscular Ring",
		back		=	Lugh.AccHas
	}
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ------------
    -- Buff Sets
    ------------	
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = {head="Arbatel bonnet +1"}
    sets.buff['Perpetuance'] = {main = "Musa", hands="Arbatel Bracers +1"}
	sets.buff['Accession'] = {}
    sets.buff['Immanence'] = set_combine(sets.me.Occult,{
	hands="Arbatel Bracers +1"
	})
    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}
    sets.buff['Klimaform'] = {}	
    -- Ebulience set empy now as we get better damage out of a good Merlinic head
    sets.buff['Ebullience'] = {} -- I left it there still if it becomes needed so the SCH.lua file won't need modification should you want to use this set
   
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast 
    -- Grimoire: 10(cap:25) / rdm: 15
    sets.precast.casting = {
		main		=	"Tupsimati",
		sub			=	"Khonsu",
		ammo		=	"Impatiens",					
		head		=	RELIC.Head,
		body		=	"Zendik Robe",						--13
		hands		=	AF.Hands,							--9
		legs		=	"Pinga Pants +1",					--13
		feet		=	MerlFeet.FC,						--12
		neck		=	"Baetyl Pendant",					--4
		waist		=	"Witful Belt",						--3
		left_ear	=	"Loquac. Earring",					--2
		right_ear	=	"Malignance Earring",				--4
		left_ring	=	"Weather. Ring +1",					--6
		right_ring	=	"Kishar Ring",						--4
		back		=	"Fi Follet Cape +1",				--10
    }
	-- 80% fc, enough to cap without /rdm also 1% from capped quickcast and grimoire bonus from head
	
	--assumes I use weather/alacrity with stun could make more extensive rule so that this works for any spell with alacrity since grim bonuses don't work then and my as well make sure I'm capped for non /rdm.
	sets.precast["Stun"] = set_combine(sets.precast.casting,{	
		head		=	"Amalric Coif +1",				--11
		feet		=	RELIC.Feet,						--8
	})

    -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)  
    -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
    -- Then only swap in what under this set after everything else. Only activates when /rdm otherwise values fast cast
    sets.precast.grimoire = {
		head=RELIC.Head,
		feet=AF.Feet,
    }

	
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{

    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{

    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
	
    })
	
    sets.precast['Impact']=set_combine(sets.precast.casting,{
		ammo		=	"Sapience Orb", --only want to trade in quick cast for fast cast while subjobless content is common.
		head		=	empty,
		body		=	"Crepuscular Cloak",
		waist		=	"Shinjutsu-no-Obi +1"
	})
	
	sets.precast['Dispelga'] = set_combine(sets.precast.casting,{
		main		=	"Daybreak",
		sub			=	"Ammurapi Shield",
	})

      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Tabula Rasa"] = {legs="Peda. Pants +3"}
    sets.precast["Enlightenment"] = {body="Peda. Gown +3"}	 
    sets.precast["Sublimation"] = {    
		--main="Siriti",
		--sub="Genbu's Shield",
		head		=	AF.Head,
		body		=	RELIC.Body,
		right_ear	=	"Savant's Earring",
		waist		=	"Embla Sash"
		}	  

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist		=	"Hachirin-no-Obi",
    }
	
	sets.midcast.Orpheus = {
		waist		=	"Orpheus's Sash",
	}
	


    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {

    }
	
	sets.midcast["Sublimation"] = sets.precast["Sublimation"] 
	
    sets.midcast.nuking.normal = { --optimized for tier 3-5
		main		=	"Tupsimati",
		sub			=	"Khonsu",
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
		body		=	"Agwu's Robe",--"Seidr Cotehardie",
		hands		=	"Amalric Gages +1",
		legs		=	"Agwu's Slops",
		feet		=	"Amalric Nails +1",
		neck		=	"Argute Stole +2",
		waist		=	"Acuity Belt +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Freke Ring",
		back		=	Lugh.INTMAB
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {
		head		=	RELIC.Head,
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
    })
	
	sets.midcast['Impact'] = set_combine(sets.me.Occult,{
		ammo		=	"Pemphredo Tathlum",
		head		=	empty,
		body		=	"Crepuscular Cloak",
		hands		=	AF.Hands,
		legs		=	RELIC.Legs,
		feet		=	AF.Feet,
		neck		=	"Argute Stole +2",
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
	
	
    sets.midcast.nuking.acc = {
		main		=	"Tupsimati",
		sub			=	"Khonsu",
		ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
		body		=	AF.Body,
		hands		=	"Agwu's Gages",
		legs		=	RELIC.Legs,
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		waist		=	"Acuity Belt +1",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Freke Ring",
		back		=	Lugh.INTMAB
    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.normal, {
		head		=	RELIC.Head,
		body		=	AF.Body,
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
    })	
	
	sets.midcast.nuking.occult = sets.me.Occult
	sets.midcast.MB.occult = sets.midcast.MB.normal
	
		-----------------------------------------------------------------------------------------------
	-- Pixie in DarkHelix
	-- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
	sets.midcast.TH = {
		main="",
		sub="",
		ranged="",
		ammo="",
		head 		=	"Volte Cap",
		hands		=	"Volte Bracers",
		feet		=	"Volte Boots",
		waist		=	"Chaac Belt",
	}
	sets.midcast["Dia"] = sets.midcast.TH
	sets.midcast["Diaga"] = sets.midcast.TH
	sets.midcast.Helix = {}
	sets.midcast.Helix2 = {}
	sets.midcast.DarkHelix2 = {}
	sets.midcast.LightHelix2 = {}
	
	sets.midcast.Helix.normal = sets.me.Occult -- only used for making SCs may as well get more tp
	sets.midcast.Helix.MB = sets.me.Occult
	
	sets.midcast.Helix2.normal = set_combine(sets.midcast.nuking.normal, {
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1", --"Mallquis Ring", --helix 2 Dint caps very low, if capped mallquis wins
		right_ring	=	"Freke Ring",
		waist		=	"Skrymir Cord +1",
		back		=	Bookworm.Helix,
    })
	sets.midcast.Helix2.MB = set_combine(sets.midcast.nuking.MB, {
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Mujin Band",
		right_ring	=	"Freke Ring",
		waist		=	"Skrymir Cord +1",
		back		=	Bookworm.Helix,
    })
	
	
	
    sets.midcast.DarkHelix2.normal = {
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Pixie Hairpin +1",
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Archon Ring",
		right_ring	=	"Freke Ring",
		waist		=	"Skrymir Cord +1",
		back		=	Bookworm.Helix,
    }
    sets.midcast.DarkHelix2.MB = {
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Pixie Hairpin +1",
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Archon Ring",
		right_ring	=	"Freke Ring",
		waist		=	"Skrymir Cord +1",
		back		=	Bookworm.Helix,
    }
	sets.midcast.Kaust = {}
	sets.midcast.Kaust.normal = {
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Pixie Hairpin +1",
		body		=	"Agwu's Robe",
		hands		=	"Amalric Gages +1",
		legs		=	"Amalric Slops +1",
		feet		=	"Amalric Nails +1",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Freke Ring",
		waist		=	"Acuity Belt +1",
		back		=	Lugh.INTMAB
		}
	sets.midcast.Kaust.MB = {
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Pixie Hairpin +1",
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		left_ring	=	"Metamor. Ring +1",
		right_ring	=	"Freke Ring",
		waist		=	"Acuity Belt +1",
		back		=	Lugh.INTMAB
	
	}
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    --I only use helix 1 for SCs so use occult accumen to get tp

	sets.midcast.LightHelix2.normal = {
		Main		=	"Daybreak",
		sub			=	"Culminus",
        ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		right_ring	=	"Freke Ring",
		left_ring	=	"Weather. Ring +1",	
		waist		=	"Skrymir Cord +1",
		back		=	Bookworm.Helix,
	}
	
	
		sets.midcast.LightHelix2.MB = {
		Main		=	"Daybreak",
		sub			=	"Culminus",
	    ammo		=	"Ghastly Tathlum +1",
		head		=	"Agwu's Cap",
		body		=	"Agwu's Robe",
		hands		=	"Agwu's Gages",
		legs		=	"Agwu's Slops",
		feet		=	"Agwu's Pigaches",
		neck		=	"Argute Stole +2",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
		right_ring	=	"Freke Ring",
		left_ring	=	"Weather. Ring +1",	
		waist		=	"Skrymir Cord +1",
		back		=	Bookworm.Helix,
		}
	
	
    -- Enfeebling
	--to reach 90% recast reduction with weather and relic feet and alacrity need 0 fast cast although some in case conditions not met are nice and I do need capped haste.
	sets.midcast["Stun"] = {
		ammo		=	"Pemphredo Tathlum",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	AF.Hands,
		legs		=	RELIC.Legs,
		feet		=	RELIC.Feet,
		neck		=	"Argute Stole +2",
		waist		=	"Witful Belt",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1",
	}	
    sets.midcast.IntEnfeebling = {
		ammo		=	"Pemphredo Tathlum",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	"Regal Cuffs",
		legs		=	"Chironic Hose",
		feet		=	AF.Feet,
		neck		=	"Argute Stole +2",
		waist		=	"Rumination Sash",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
        left_ring	=	"Metamor. Ring +1",
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1",
    }
    sets.midcast.MndEnfeebling = {
		ammo		=	"Pemphredo Tathlum",
		head		=	AF.Head,
		body		=	AF.Body,
		hands		=	"Regal Cuffs",
		legs		=	"Chironic Hose",
		feet		=	AF.Feet,
		neck		=	"Argute Stole +2",
		waist		=	"Rumination Sash",
		left_ear	=	"Regal Earring",
		right_ear	=	"Malignance Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1",
    }
	
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{
		ammo		=	"Pemphredo Tathlum",
		head		=	TelHead.Dur,
		body		=	RELIC.Body,
		hands		=	EMPY.Hands, --could make tel hands for when perpetuance not up.
		legs		=	TelLeg.Dur,
		feet		=	TelFeet.Dur,
		neck		=	"Incanter's Torque",
		waist		=	"Embla Sash",
		left_ear	=	"Andoaa Earring",
		right_ear	=	"Mimir Earring",
        left_ring	=	{name="Stikini Ring +1", bag="wardrobe"},
        right_ring	=	{name="Stikini Ring +1", bag="wardrobe3"},
		back		=	"Aurist's Cape +1",
    })
    sets.midcast.storm = set_combine(sets.midcast.enhancing,{
		feet		=	"Peda. Loafers +3",
    })       
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		waist		=	"Siegel Sash",
		neck		=	"Nodens Gorget",
		legs		=	"Shedir Seraweels",
		left_ear	=	"Earthcry Earring",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
		head		=	"Amalric Coif +1",
    })
	sets.midcast.RefreshSelf = set_combine(sets.midcast.refresh ,{
		waist		=	"Gishdubar Sash",
		back 		=	"Grapevine Cape",
		})
    sets.midcast.aquaveil = set_combine(sets.midcast.enhancing,{
		ammo		=	"Staunch Tathlum +1", 	--			11%			3% don't count tathlum if using bow
		head		=	"Amalric Coif +1", 		--+2
		body		=	"Ros. Jaseran +1", 		-- 			25%			
		hands		=	"Regal Cuffs", 			--+2
		legs		=	"Shedir Seraweels", 	--+1
		feet		=	"Amalric Nails +1", 	--			16%
		neck		=	"Loricate Torque +1", 	-- 			5%			6%
		waist		=	"Emphatikos Rope", 		--+1 		12%
        left_ring	=	"Freke Ring", 			-- 			10%
        right_ring	=	"Evanescence Ring",		--			5%
		left_ear	=	"Halasz Earring",		--			5%
		right_ear	=	"Magnetic Earring",		--			8%
		back		=	"Fi Follet Cape +1",	--			5%
    })
	
	sets.midcast.aquaAOE = set_combine(sets.midcast.enhancing,{ --for assession dont need sird just duration and potency
		main 		=	"Vadose Rod",			--+1
		sub			=	"Ammurapi Shield",
		head		=	"Amalric Coif +1", 		--+2
		hands		=	"Regal Cuffs", 			--+2
		legs		=	"Shedir Seraweels", 	--+1
		waist		=	"Emphatikos Rope", 		--+1 
		
	})
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Pixie Hairpin +1",
		body		=	AF.Body,
		hands		=	MerlHands.Aspir,
		legs		=	RELIC.Legs,
		feet		=	"Agwu's Pigaches",
		neck		=	"Erra Pendant",
		waist		=	"Fucho-no-Obi",
		left_ear	=	"Regal Earring",
		right_ear	=	"Hirudinea Earring",
		left_ring	=	"Archon Ring",
		right_ring	=	"Evanescence Ring",
		back		=	"Aurist's Cape +1",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{
		ammo		=	"Pemphredo Tathlum",
		head		=	"Kaykaus Mitra +1",
		body		=	"Kaykaus Bliaut +1",
		hands		=	RELIC.Hands,
		legs		=	"Kaykaus Tights +1",
		feet		=	"Kaykaus Boots +1",
		neck		=	"Incanter's Torque",
		waist		=	"Shinjutsu-no-Obi +1",
		left_ear	=	"Meili Earring",
		right_ear	=	"Mendi. Earring",
        left_ring	=	"Naji's Loop",
        right_ring	=	"Mephitas's Ring +1",
		back		=	"Aurist's Cape +1",
    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		waist		=	"Hachirin-no-Obi",
		back		=	"Twilight Cape"

    }) 
	sets.midcast["Cursna"] = {
		ammo		=	"Pemphredo Tathlum",
		head		=	"Vanya Hood",
		body		=	RELIC.Body,
		hands		=	RELIC.Hands, -- need Hieros mittens
		legs		=	AF.Legs, 
		feet		=	"Vanya Clogs",
		neck		=	"Debilis Medallion",
		waist		=	"Gishdubar Sash", --consider skill waist
		left_ear	=	"Meili Earring",
		right_ear	=	"Mendi. Earring",
        left_ring	=	"Haoma's Ring",
        right_ring	=	"Melenaus's Ring",
		back		=	"Oretan. Cape +1",
    }
	
	sets.midcast.CursnaSelf = set_combine(sets.midcast["Cursna"],{
		neck		=	"Nicander's Necklace",
		waist		=	"Gishdubar Sash",
	})

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = {} 	-- leave this empty
	-- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {
		main		=	"Musa",
		sub			=	"Khonsu",
		ammo		=	"Homiliary",
		head		=	EMPY.Head,
		body		=	TelBod.Dur,
		hands		=	EMPY.Hands,
		legs		=	TelLeg.Dur,
		feet		=	TelFeet.Dur,
		neck		=	"Incanter's Torque",
		waist		=	"Embla Sash",
		back		=	Bookworm.Reg
    }
	-- Focus on Regen Duration 	
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{
		head		=	TelHead.Dur,
		body		=	TelBod.Dur,
		legs		=	TelLeg.Dur,
		back		=	Lugh.INTMAB,
    }) 
	-- Focus on Regen Potency 	
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{
		body=TelBod.Reg,
		legs=TelLeg.Reg,
    }) 
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end
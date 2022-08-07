
-------------------------------------------------------------------------------------------------------------------
-- Spell mappings allow defining a general category or description that each of sets of related
-- spells all fall under.
-------------------------------------------------------------------------------------------------------------------


spell_maps = {
    ['Cure']='Cure',['Cure II']='Cure',['Cure III']='Cure',['Cure IV']='Cure',['Cure V']='Cure',['Cure VI']='Cure',
    ['Full Cure']='Cure',
    ['Cura']='Curaga',['Cura II']='Curaga',['Cura III']='Curaga',
    ['Curaga']='Curaga',['Curaga II']='Curaga',['Curaga III']='Curaga',['Curaga IV']='Curaga',['Curaga V']='Curaga',
    -- Status Removal doesn't include Esuna or Sacrifice, since they work differently than the rest
    ['Poisona']='StatusRemoval',['Paralyna']='StatusRemoval',['Silena']='StatusRemoval',['Blindna']='StatusRemoval',['Cursna']='StatusRemoval',
    ['Stona']='StatusRemoval',['Viruna']='StatusRemoval',['Erase']='StatusRemoval',
    ['Barfire']='BarElement',['Barstone']='BarElement',['Barwater']='BarElement',['Baraero']='BarElement',['Barblizzard']='BarElement',['Barthunder']='BarElement',
    ['Barfira']='BarElement',['Barstonra']='BarElement',['Barwatera']='BarElement',['Baraera']='BarElement',['Barblizzara']='BarElement',['Barthundra']='BarElement',
    ['Raise']='Raise',['Raise II']='Raise',['Raise III']='Raise',['Arise']='Raise',
    ['Reraise']='Reraise',['Reraise II']='Reraise',['Reraise III']='Reraise',['Reraise IV']='Reraise',
    ['Protect']='Protect',['Protect II']='Protect',['Protect III']='Protect',['Protect IV']='Protect',['Protect V']='Protect',
    ['Shell']='Shell',['Shell II']='Shell',['Shell III']='Shell',['Shell IV']='Shell',['Shell V']='Shell',
    ['Protectra']='Protectra',['Protectra II']='Protectra',['Protectra III']='Protectra',['Protectra IV']='Protectra',['Protectra V']='Protectra',
    ['Shellra']='Shellra',['Shellra II']='Shellra',['Shellra III']='Shellra',['Shellra IV']='Shellra',['Shellra V']='Shellra',
    ['Regen']='Regen',['Regen II']='Regen',['Regen III']='Regen',['Regen IV']='Regen',['Regen V']='Regen',
    ['Refresh']='Refresh',['Refresh II']='Refresh',['Refresh III']='Refresh',
    ['Teleport-Holla']='Teleport',['Teleport-Dem']='Teleport',['Teleport-Mea']='Teleport',['Teleport-Altep']='Teleport',['Teleport-Yhoat']='Teleport',
    ['Teleport-Vahzl']='Teleport',['Recall-Pashh']='Teleport',['Recall-Meriph']='Teleport',['Recall-Jugner']='Teleport',
    ['Valor Minuet']='Minuet',['Valor Minuet II']='Minuet',['Valor Minuet III']='Minuet',['Valor Minuet IV']='Minuet',['Valor Minuet V']='Minuet',
    ["Knight's Minne"]='Minne',["Knight's Minne II"]='Minne',["Knight's Minne III"]='Minne',["Knight's Minne IV"]='Minne',["Knight's Minne V"]='Minne',
    ['Advancing March']='March',['Victory March']='March',
    ['Sword Madrigal']='Madrigal',['Blade Madrigal']='Madrigal',
    ["Hunter's Prelude"]='Prelude',["Archer's Prelude"]='Prelude',
    ['Sheepfoe Mambo']='Mambo',['Dragonfoe Mambo']='Mambo',
    ['Raptor Mazurka']='Mazurka',['Chocobo Mazurka']='Mazurka',
    ['Sinewy Etude']='Etude',['Dextrous Etude']='Etude',['Vivacious Etude']='Etude',['Quick Etude']='Etude',['Learned Etude']='Etude',['Spirited Etude']='Etude',['Enchanting Etude']='Etude',
    ['Herculean Etude']='Etude',['Uncanny Etude']='Etude',['Vital Etude']='Etude',['Swift Etude']='Etude',['Sage Etude']='Etude',['Logical Etude']='Etude',['Bewitching Etude']='Etude',
    ["Mage's Ballad"]='Ballad',["Mage's Ballad II"]='Ballad',["Mage's Ballad III"]='Ballad',
    ["Army's Paeon"]='Paeon',["Army's Paeon II"]='Paeon',["Army's Paeon III"]='Paeon',["Army's Paeon IV"]='Paeon',["Army's Paeon V"]='Paeon',["Army's Paeon VI"]='Paeon',
    ['Fire Carol']='Carol',['Ice Carol']='Carol',['Wind Carol']='Carol',['Earth Carol']='Carol',['Lightning Carol']='Carol',['Water Carol']='Carol',['Light Carol']='Carol',['Dark Carol']='Carol',
    ['Fire Carol II']='Carol',['Ice Carol II']='Carol',['Wind Carol II']='Carol',['Earth Carol II']='Carol',['Lightning Carol II']='Carol',['Water Carol II']='Carol',['Light Carol II']='Carol',['Dark Carol II']='Carol',
    ['Foe Lullaby']='Lullaby',['Foe Lullaby II']='Lullaby',['Horde Lullaby']='Lullaby',['Horde Lullaby II']='Lullaby',
    ['Fire Threnody']='Threnody',['Ice Threnody']='Threnody',['Wind Threnody']='Threnody',['Earth Threnody']='Threnody',['Lightning Threnody']='Threnody',['Water Threnody']='Threnody',['Light Threnody']='Threnody',['Dark Threnody']='Threnody',
    ['Fire Threnody II']='Threnody',['Ice Threnody II']='Threnody',['Wind Threnody II']='Threnody',['Earth Threnody II']='Threnody',['Lightning Threnody II']='Threnody',['Water Threnody II']='Threnody',['Light Threnody II']='Threnody',['Dark Threnody II']='Threnody',
    ['Battlefield Elegy']='Elegy',['Carnage Elegy']='Elegy',
    ['Foe Requiem']='Requiem',['Foe Requiem II']='Requiem',['Foe Requiem III']='Requiem',['Foe Requiem IV']='Requiem',['Foe Requiem V']='Requiem',['Foe Requiem VI']='Requiem',['Foe Requiem VII']='Requiem',
    ['Utsusemi: Ichi']='Utsusemi',['Utsusemi: Ni']='Utsusemi',['Utsusemi: San']='Utsusemi',
    ['Katon: Ichi'] = 'ElementalNinjutsu',['Suiton: Ichi'] = 'ElementalNinjutsu',['Raiton: Ichi'] = 'ElementalNinjutsu',
    ['Doton: Ichi'] = 'ElementalNinjutsu',['Huton: Ichi'] = 'ElementalNinjutsu',['Hyoton: Ichi'] = 'ElementalNinjutsu',
    ['Katon: Ni'] = 'ElementalNinjutsu',['Suiton: Ni'] = 'ElementalNinjutsu',['Raiton: Ni'] = 'ElementalNinjutsu',
    ['Doton: Ni'] = 'ElementalNinjutsu',['Huton: Ni'] = 'ElementalNinjutsu',['Hyoton: Ni'] = 'ElementalNinjutsu',
    ['Katon: San'] = 'ElementalNinjutsu',['Suiton: San'] = 'ElementalNinjutsu',['Raiton: San'] = 'ElementalNinjutsu',
    ['Doton: San'] = 'ElementalNinjutsu',['Huton: San'] = 'ElementalNinjutsu',['Hyoton: San'] = 'ElementalNinjutsu',
    ['Banish']='Banish',['Banish II']='Banish',['Banish III']='Banish',['Banishga']='Banish',['Banishga II']='Banish',
    ['Holy']='Holy',['Holy II']='Holy',['Drain']='Drain',['Drain II']='Drain',['Drain III']='Drain',['Aspir']='Aspir',['Aspir II']='Aspir',
    ['Absorb-Str']='Absorb',['Absorb-Dex']='Absorb',['Absorb-Vit']='Absorb',['Absorb-Agi']='Absorb',['Absorb-Int']='Absorb',['Absorb-Mnd']='Absorb',['Absorb-Chr']='Absorb',
    ['Absorb-Acc']='Absorb',['Absorb-TP']='Absorb',['Absorb-Attri']='Absorb',
    ['Enlight']='Enlight',['Enlight II']='Enlight',['Endark']='Endark',['Endark II']='Endark',
    ['Burn']='ElementalEnfeeble',['Frost']='ElementalEnfeeble',['Choke']='ElementalEnfeeble',['Rasp']='ElementalEnfeeble',['Shock']='ElementalEnfeeble',['Drown']='ElementalEnfeeble',
    ['Pyrohelix']='Helix',['Cryohelix']='Helix',['Anemohelix']='Helix',['Geohelix']='Helix',['Ionohelix']='Helix',['Hydrohelix']='Helix',['Luminohelix']='Helix',['Noctohelix']='DarkHelix',
    ['Pyrohelix II']='Helix',['Cryohelix II']='Helix',['Anemohelix II']='Helix',['Geohelix II']='Helix',['Ionohelix II']='Helix',['Hydrohelix II']='Helix',['Luminohelix II']='Helix',['Noctohelix II']='DarkHelix',
    ['Firestorm']='Storm',['Hailstorm']='Storm',['Windstorm']='Storm',['Sandstorm']='Storm',['Thunderstorm']='Storm',['Rainstorm']='Storm',['Aurorastorm']='Storm',['Voidstorm']='Storm',
    ['Firestorm II']='Storm',['Hailstorm II']='Storm',['Windstorm II']='Storm',['Sandstorm II']='Storm',['Thunderstorm II']='Storm',['Rainstorm II']='Storm',['Aurorastorm II']='Storm',['Voidstorm II']='Storm',
    ['Fire Maneuver']='Maneuver',['Ice Maneuver']='Maneuver',['Wind Maneuver']='Maneuver',['Earth Maneuver']='Maneuver',['Thunder Maneuver']='Maneuver',['Water Maneuver']='Maneuver',['Light Maneuver']='Maneuver',['Dark Maneuver']='Maneuver',
	['Enstone']='Enspell',['Enwater']='Enspell',['Enaero']='Enspell',['Enfire']='Enspell',['Enblizzard']='Enspell',['Enthunder']='Enspell',
	['Gain-STR']='GainStat',['Gain-DEX']='GainStat',['Gain-VIT']='GainStat',['Gain-AGI']='GainStat',['Gain-INT']='GainStat',['Gain-MND']='GainStat',['Gain-CHR']='GainStat',
	}



pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    pacts.buffoffense = {['Carbuncle']='Glittering Ruby', ['Ifrit']='Crimson Howl', ['Garuda']='Hastega II', ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl', ['Shiva']='Crystal Blessing', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',['Siren']='Katabatic Blades'} --['Siren']=''
    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II',['Siren']="Wind's Blessing"}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', 
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye',['Siren']='Bitter Elegy'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence', ['Ramuh']='Thunderspark', ['Cait Sith']='Mewing Lullaby'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby',['Siren']='Lunatic Voice'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV',['Siren']='Tornado II'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Gash',['Siren']='Hysteric Assault'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy',['Siren']='Sonic Buffet'}
	pacts.bp99 = {['Ifrit']='Conflag Strike', ['Ramuh']='Volt Strike', ['Titan']='Crag Throw', ['Fenrir']='Impact', ['Diabolos']='Blindside',['Siren']='Hysteric Assault'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

--		
		
bp_physical=S{	'Punch','Rock Throw','Barracuda Dive','Claw','Axe Kick','Shock Strike','Camisado','Regal Scratch','Poison Nails',
				'Moonlit Charge','Crescent Fang','Rock Buster','Tail Whip','Double Punch','Megalith Throw','Double Slap','Eclipse Bite',
				'Mountain Buster','Spinning Dive','Rush','Crag Throw','Hysteric Assault','Welt','Roundhouse'}
bp_critical=S{	'Volt Strike', 'Chaotic Strike','Predator Claws'}
bp_hybrid=S{	'Burning Strike','Flaming Crush'}

bp_magical=S{	'Inferno','Earthen Fury','Tidal Wave','Aerial Blast','Diamond Dust','Judgment Bolt','Searing Light','Howling Moon',
				'Ruinous Omen','Fire II','Stone II','Water II','Aero II','Blizzard II','Thunder II','Thunderspark','Somnolence',
				'Meteorite','Fire IV','Stone IV','Water IV','Aero IV','Blizzard IV','Thunder IV','Nether Blast','Meteor Strike',
				'Geocrush','Grand Fall','Wind Blade','Heavenly Strike','Thunderstorm','Level ? Holy','Holy Mist','Lunar Bay',
				'Night Terror','Conflagration Strike', 'Zantetsuken','Tornado II','Sonic Buffet'}
				
bp_debuff=S{	'Lunar Cry','Mewing Lullaby','Nightmare','Lunar Roar','Slowga','Ultimate Terror','Sleepga','Eerie Eye','Tidal Roar',
				'Diamond Storm','Shock Squall','Pavor Nocturnus','Lunatic Voice','Bitter Elegy'}
				
bp_buff=S{		'Shining Ruby','Frost Armor','Rolling Thunder','Crimson Howl','Lightning Armor','Ecliptic Growl','Hastega','Noctoshield',
				'Ecliptic Howl','Dream Shroud','Earthen Armor','Fleet Wind','Inferno Howl','Soothing Ruby','Heavenward Howl',
				'Soothing Current','Hastega II','Crystal Blessing','Katabic Blades','Chinook',"Wind's Blessing"}

bp_other=S{		'Healing Ruby','Raise II','Aerial Armor','Reraise II','Whispering Wind','Glittering Ruby','Earthen Ward','Spring Water','Healing Ruby II'} 

AvatarList=S{	'Shiva','Ramuh','Garuda','Leviathan','Diabolos','Titan','Fenrir','Ifrit','Siren','Carbuncle','Fire Spirit','Air Spirit','Ice Spirit',
				'Thunder Spirit','Light Spirit','Dark Spirit','Earth Spirit','Water Spirit','Cait Sith','Alexander','Odin','Atomos'}
				
spirit_element={Fire='Fire Spirit',Earth='Earth Spirit',Water='Water Spirit',Wind='Air Spirit',Ice='Ice Spirit',Lightning='Thunder Spirit',
				Light='Light Spirit',Dark='Dark Spirit'}spirit_conflict={Fire='Ice',Earth='Lightning',Water='Fire',Wind='Earth',Ice='Wind',
				Lightning='Water',Light='Dark',Dark='Light'}
				
-- Set Macros for your SMN's macro page, book.
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

hud_padding = 10

pName = player.name
-- Saying hello
windower.add_to_chat(8,'----- Welcome back to your SMN.lua, '..pName..' -----')

--------------------------------------------------------------------------------------------------------------
-- HUD STUFF
--------------------------------------------------------------------------------------------------------------
-- Colors for Text
Colors = {
    ["Fire"] = "\\cs(204, 0, 0)", 
    ["Water"] = "\\cs(0, 102, 204)", 
    ["Wind"] = "\\cs(51, 102, 0)", 
    ["Light"] = "\\cs(255, 255, 255)", 
    ["Earth"] = "\\cs(139, 139, 19)", 
    ["Ice"] = "\\cs(0, 204, 204)", 
    ["Lightning"] = "\\cs(102, 0, 204)",
    ['Dark']="\\cs(92, 92, 92)"
}
AvaColors = {
    ["Ifrit"] = "\\cs(204, 0, 0)", 
	["Fire Spirit"] = "\\cs(204, 0, 0)", 
    ["Leviathan"] = "\\cs(0, 102, 204)", 
    ["Water Spirit"] = "\\cs(0, 102, 204)",
    ["Garuda"] = "\\cs(51, 102, 0)", 
	["Siren"] = "\\cs(51, 102, 0)", 
	["Wind Spirit"] = "\\cs(51, 102, 0)", 
    ["Carbuncle"] = "\\cs(255, 255, 255)", 
    ["Cait Sith"] = "\\cs(255, 255, 255)", 
	["Alexander"] = "\\cs(255, 255, 255)", 
	["Light Spirit"] = "\\cs(255, 255, 255)",
    ["Titan"] = "\\cs(139, 139, 19)", 
    ["Earth Spirit"] = "\\cs(139, 139, 19)", 
    ["Shiva"] = "\\cs(0, 204, 204)", 
    ["Ice Spirit"] = "\\cs(0, 204, 204)",
    ["Ramuh"] = "\\cs(102, 0, 204)",
	["Thunder Spirit"] = "\\cs(102, 0, 204)",
    ["Fenrir"]="\\cs(92, 92, 92)",
	["Diabolos"]="\\cs(92, 92, 92)",
	["Odin"]="\\cs(92, 92, 92)",
	["Atomos"]="\\cs(92, 92, 92)",
	["Dark Spirit"]="\\cs(92, 92, 92)"
}

scColor = "\\cs(0, 204, 204)"

textHideMode = M(false)
textHideOptions = M(false)
textHideJob = M(false)
textHideBattle = M(false)
textHideHUB = M(false)
useLightMode = M(false)
hud_bottom = false
useLightMode = M(false)
matchsc = M(true)

const_on = "\\cs(32, 255, 32)ON\\cr"
const_off = "\\cs(255, 32, 32)OFF\\cr"

hud_x_pos_og = hud_x_pos
hud_y_pos_og = hud_y_pos
hud_font_size_og = hud_font_size
hud_padding_og = hud_padding
hud_transparency_og = hud_transparency

MB_Window = 0
time_start = 0


-- Standard Mode
hub_mode_std = [[\cs(255, 115, 0)Modes: \cr              
		\cs(200, 200, 200)Avatar:\cr ${avatar_color}${avatar_name|No Avatar yet} \cr   
\cs(255, 255, 64)${key_bind_idle} \cs(200, 200, 200)Idle:\cr \cs(125,125,255)${player_current_idle|Refresh}
\cs(255, 255, 64)${key_bind_melee} \cs(200, 200, 200)Melee:\cr \cs(125,125,255)${player_current_melee|Refresh}
\cs(255, 255, 64)${key_bind_casting} \cs(200, 200, 200)Avatar:\cr \cs(125,125,255)${player_current_casting|Normal}
]]

hub_options_std = [[ \cs(255, 115, 0)Options: \cr         
\cs(255, 255, 64)${key_bind_matchsc}\cs(200, 200, 200)Match SC Element:\cr ${player_match_sc}
]]

hub_job_std = [[ \cs(255, 115, 0)${player_job}: \cr             
		\cs(200, 200, 200)BP70:\cr \cs(125,125,255)${avatar_Phys|N/A} \cs(200, 200, 200)BP99:\cr \cs(125,125,255)${avatar_99|N/A}\cr
		\cs(200, 200, 200)Merit:\cr \cs(125,125,255)${avatar_Magic|N/A} \cs(200, 200, 200)Special:\cr \cs(125,125,255)${avatar_Special|N/A}\cr
		\cs(200, 200, 200)OffenBuff:\cr \cs(125,125,255)${avatar_OffensBuff|N/A} \cs(200, 200, 200)DefenBuff:\cr \cs(125,125,255)${avatar_DefenseBuff|N/A}\cr
		\cs(200, 200, 200)Debuff:\cr \cs(125,125,255)${avatar_Debuff|N/A} \cs(200, 200, 200)Debuff2:\cr \cs(125,125,255)${avatar_Debuff2|N/A} \cr
		\cs(200, 200, 200)Cure:\cr \cs(125,125,255)${avatar_Cure|N/A} \cr
]]

hub_battle_std = [[ \cs(255, 115, 0)Battle: \cr             
        \cs(200, 200, 200)Last SC:\cr ${last_sc_element_color}${last_sc|No SC yet} \cr           
        \cs(200, 200, 200)Burst Window:\cr ${last_sc_element_color}${burst_window|0} \cr
        \cs(200, 200, 200)Magic Burst:\cr ${player_current_mb}  \cr        
]]

-- LITE Mode
hub_mode_lte = [[ \cs(255, 115, 0) == Modes: \cr              \cs(255, 255, 64)${key_bind_idle} \cs(200, 200, 200)Idle:\cr \cs(125,125,255)${player_current_idle|Refresh}              \cs(255, 255, 64)${key_bind_melee} \cs(200, 200, 200)Melee:\cr \cs(125,125,255)${player_current_melee|Refresh}              \cs(255, 255, 64)${key_bind_mainweapon} \cs(200, 200, 200)Main Weapon:\cr \cs(125,125,255)${player_current_mainweapon|Crocea Mors}              \cs(255, 255, 64)${key_bind_subweapon} \cs(200, 200, 200)Sub Weapon:\cr \cs(125,125,255)${player_current_subweapon|Ammurapi Shield}            \cs(255, 255, 64)${key_bind_casting} \cs(200, 200, 200)Nuking:\cr \cs(125,125,255)${player_current_casting|Normal} ]]

hub_options_lte = [[ \cs(255, 115, 0)== Options: \cr              \cs(255, 255, 64)${key_bind_matchsc}\cs(200, 200, 200)Match SC Element:\cr ${player_match_sc}            \cs(255, 255, 64)${key_bind_lock_weapon} \cs(200, 200, 200)Lock Weapon:\cr ${toggle_lock_weapon}            \cs(255, 255, 64)${key_bind_movespeed_lock}\cs(200, 200, 200)Carm Cuisse:\cr ${toggle_movespeed_lock} ]]

hub_job_lte = [[ \cs(255, 115, 0) == ${player_job}: \cr             \cs(255, 255, 64)${key_bind_element_cycle} \cs(200, 200, 200)Nuking:\cr ${element_color|\\cs(0, 204, 204)}${toggle_element_cycle|Ice} \cr             \cs(255, 255, 64)${key_bind_enspell_cycle} \cs(200, 200, 200)Enspell:\cr ${enspell_color|\\cs(0, 204, 204)}${toggle_enspell_cycle|Ice} \cr ]]

hub_battle_lte = [[ \cs(255, 115, 0) == Battle: \cr             \cs(200, 200, 200)Last SC:\cr ${last_sc_element_color}${last_sc|No SC yet} \cr             \cs(200, 200, 200)Burst Window:\cr ${last_sc_element_color}${burst_window|0} \cr             \cs(200, 200, 200)Magic Burst:\cr ${player_current_mb}  \cr ]]


-- init style
hub_mode = hub_mode_std
hub_options = hub_options_std
hub_job = hub_job_std
hub_battle = hub_battle_std
--[[
    This gets passed in when the Keybinds are turned off.
    For not it simply sets the variable to an empty string
    (Researching better way to handle this)
]]
keybinds_off = {}
keybinds_off['key_bind_idle'] 			= '       '
keybinds_off['key_bind_melee'] 			= '       '
keybinds_off['key_bind_casting'] 		= '       '
keybinds_off['key_bind_mburst'] 		= '       '
keybinds_on['key_bind_mburst'] 			= '       '
keybinds_off['key_bind_mainweapon'] 	= '       '
keybinds_off['key_bind_subweapon'] 		= '       '
keybinds_on['key_bind_movespeed_lock'] 	= '        '

keybinds_off['key_bind_element_cycle'] 	= '       '
keybinds_off['key_bind_gain_cycle'] 	= '       '
keybinds_off['key_bind_sc_level'] 		= '       '
keybinds_off['key_bind_lock_weapon'] 	= '       '
keybinds_off['key_bind_movespeed_lock'] = '        '
keybinds_off['key_bind_matchsc'] 		= '        '
keybinds_off['key_bind_enspell_cycle'] 	= '       '

function validateTextInformation()

    --Mode Information
    main_text_hub.player_current_idle = idleModes.current
    main_text_hub.player_current_melee = meleeModes.current
	main_text_hub.player_current_mainweapon = mainWeapon.current
	main_text_hub.player_current_subweapon = subWeapon.current
    main_text_hub.player_current_casting = mode.current
    main_text_hub.toggle_element_cycle = elements.current
	main_text_hub.toggle_gain_cycle = gainStat.current
    main_text_hub.player_job = player.job
	
	if last_pet ~= nil then
		main_text_hub.avatar_name = last_pet
	
		main_text_hub.avatar_Phys = pacts.bp70[last_pet]
		main_text_hub.avatar_Magic =pacts.bp75[last_pet]
		main_text_hub.avatar_99 =pacts.bp99[last_pet]
		main_text_hub.avatar_OffensBuff = pacts.buffoffense[last_pet]
		main_text_hub.avatar_DefenseBuff = pacts.buffdefense[last_pet]
		main_text_hub.avatar_Special = pacts.buffspecial[last_pet]
		main_text_hub.avatar_Cure = pacts.cure[last_pet]
		main_text_hub.avatar_Debuff = pacts.debuff1[last_pet]
		main_text_hub.avatar_Debuff2 = pacts.debuff2[last_pet]
		
		main_text_hub.avatar_color = AvaColors[last_pet]
	end

    if last_skillchain ~= nil then
        main_text_hub.last_sc = last_skillchain.english
        main_text_hub.burst_window = tostring(MB_Window)
        main_text_hub.last_sc_element_color = Colors[last_skillchain.elements[1]]
    end

    if mBurst.value then
        main_text_hub.player_current_mb = const_on
    else
        main_text_hub.player_current_mb = const_off
    end
    if matchsc.value then
        main_text_hub.player_match_sc = const_on
    else
        main_text_hub.player_match_sc = const_off
    end
    if meleeing.value then
        main_text_hub.toggle_lock_weapon = const_off
    else
        main_text_hub.toggle_lock_weapon = const_on
    end

    if runspeed.value then
        main_text_hub.toggle_movespeed_lock =  const_on
    else
        main_text_hub.toggle_movespeed_lock =  const_off
    end
    
    if keybinds.value then
        texts.update(main_text_hub, keybinds_on)
    else 
        texts.update(main_text_hub, keybinds_off)
    end
    main_text_hub.element_color = Colors[elements.current]

    main_text_hub.sc_element_color = scColor

end
--Default To Set Up the Text Window
function setupTextWindow()

    local default_settings = {}
    default_settings.pos = {}
    default_settings.pos.x = hud_x_pos
    default_settings.pos.y = hud_y_pos
    default_settings.bg = {}

    default_settings.bg.alpha = hud_transparency
    default_settings.bg.red = 40
    default_settings.bg.green = 40
    default_settings.bg.blue = 55
    default_settings.bg.visible = true
    default_settings.flags = {}
    default_settings.flags.right = false
    default_settings.flags.bottom = false
    default_settings.flags.bold = true
    default_settings.flags.draggable = hud_draggable
    default_settings.flags.italic = false
    default_settings.padding = hud_padding
    default_settings.text = {}
    default_settings.text.size = hud_font_size
    default_settings.text.font = hud_font
    default_settings.text.fonts = {}
    default_settings.text.alpha = 255
    default_settings.text.red = 147
    default_settings.text.green = 161
    default_settings.text.blue = 161
    default_settings.text.stroke = {}
    default_settings.text.stroke.width = 1
    default_settings.text.stroke.alpha = 255
    default_settings.text.stroke.red = 0
    default_settings.text.stroke.green = 0
    default_settings.text.stroke.blue = 0

    --Creates the initial Text Object will use to create the different sections in
    if not (main_text_hub == nil) then
        texts.destroy(main_text_hub)
    end
    main_text_hub = texts.new('', default_settings, default_settings)

    --Appends the different sections to the main_text_hub
    texts.append(main_text_hub, hub_mode)
    --texts.append(main_text_hub, hub_options)
    texts.append(main_text_hub, hub_job)
    texts.append(main_text_hub, hub_battle)
    --We then do a quick validation
    validateTextInformation()

    --Finally we show this to the user
    main_text_hub:show()
    
end
--[[
    This handles hiding the different sections
]]
function hideTextSections()

    --For now when hiding a section its easier to recreate the entire window
    texts.clear(main_text_hub)
    
    --Below we check to make sure this is true by default these are false
    if not textHideMode.value then
        texts.append(main_text_hub, hub_mode)

    end
    if not textHideOptions.value then
        texts.append(main_text_hub, hub_options)
    end
    if not textHideJob.value then
        texts.append(main_text_hub, hub_job)
    end
    if not textHideBattle.value then
        texts.append(main_text_hub, hub_battle)
    end
    validateTextInformation()

end

function toggleHudStyle( useLightMode )
    texts.clear(main_text_hub)
    if useLightMode then
        hud_x_pos = 0     
        hud_y_pos = 0
        hud_font_size = 8
        hud_padding = 2
        hud_transparency = 0
        hud_strokewidth = 2
        hub_options = hub_options_lte
        hub_mode = hub_mode_lte
        hub_job = hub_job_lte
        hub_battle = hub_battle_lte
    else
        hud_x_pos = hud_x_pos_og
        hud_y_pos = hud_y_pos_og
        hud_font_size = hud_font_size_og
        hud_padding = hud_padding_og
        hud_transparency = hud_transparency_og
        hud_strokewidth = 1
        hub_options = hub_options_std
        hub_mode = hub_mode_std
        hub_battle = hub_battle_std
        hub_job = hub_job_std
    end
    texts.pos(main_text_hub, hud_x_pos, hud_y_pos)
    texts.size(main_text_hub, hud_font_size)
    texts.pad(main_text_hub, hud_padding)
    texts.bg_alpha(main_text_hub, hud_transparency)
    texts.stroke_width(main_text_hub, hud_strokewidth)      
    hideTextSections()
end
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function hud_command(command)
 
    local commandArgs = command
    
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1]:lower() == "hud" then --First variable is hide lets find out what

            if commandArgs[2]:lower() == "hide" then -- Hides/Shows the HUB
                textHideHUB:toggle()

                if textHideHUB.value == true then
                    texts.hide(main_text_hub)
                else 
                    texts.show(main_text_hub)
                end

                hideTextSections()
            elseif commandArgs[2]:lower() == "keybinds" then --Hides/Show Keybinds
                keybinds:toggle()

                if keybinds.value then
                    texts.update(main_text_hub, keybinds_on) --If ON then we pass in Table for keybinds to update the variables
                else 
                    texts.update(main_text_hub, keybinds_off) --Otherwise we set them to blank
                end

                hideTextSections()
            elseif commandArgs[2]:lower() == "hidemodes" then --Hides the Mode
                textHideMode:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hideoptions" then --Hides/Show Scholar sectio
                textHideOptions:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hidejob" then --Hides/Show Battle section
                textHideJob:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "hidebattle" then --Hides/Show Battle section
                textHideBattle:toggle()
                hideTextSections()
            elseif commandArgs[2]:lower() == "lite" then --Hides/Show Options
                useLightMode:toggle()
                toggleHudStyle(useLightMode.value)
            
            end
        end
    end
end




nukes = {}
nukes.t1 = {['Earth']="Stone",      ['Water']="Water",      ['Wind']="Aero",     ['Fire']="Fire",    ['Ice']="Blizzard",     ['Lightning']="Thunder", ['Light']="Thunder", ['Dark']="Blizzard"}
nukes.t2 = {['Earth']="Stone II",   ['Water']="Water II",   ['Wind']="Aero II",  ['Fire']="Fire II", ['Ice']="Blizzard II",  ['Lightning']="Thunder II", ['Light']="Thunder II", ['Dark']="Blizzard II"}
nukes.t3 = {['Earth']="Stone III",  ['Water']="Water III",  ['Wind']="Aero III", ['Fire']="Fire III",['Ice']="Blizzard III", ['Lightning']="Thunder III", ['Light']="Thunder III", ['Dark']="Blizzard III"}
nukes.t4 = {['Earth']="Stone IV",   ['Water']="Water IV",   ['Wind']="Aero IV",  ['Fire']="Fire IV", ['Ice']="Blizzard IV",  ['Lightning']="Thunder IV", ['Light']="Thunder IV", ['Dark']="Blizzard IV"}
nukes.t5 = {['Earth']="Stone V",    ['Water']="Water V",    ['Wind']="Aero V",   ['Fire']="Fire V",  ['Ice']="Blizzard V",   ['Lightning']="Thunder V", ['Light']="Thunder V", ['Dark']="Blizzard V"}
nukes.helix = {['Earth']="Geohelix",  ['Water']="Hydrohelix", ['Wind']="Anemohelix",['Fire']="Pyrohelix", ['Ice']="Cryohelix", ['Lightning']="Ionohelix",    ['Light']="Luminohelix", ['Dark']="Noctohelix"}
nukes.storm = {['Earth']="Sandstorm", ['Water']="Rainstorm",  ['Wind']="Windstorm", ['Fire']="Firestorm", ['Ice']="Hailstorm", ['Lightning']="Thunderstorm", ['Light']="Aurorastorm", ['Dark']="Voidstorm"}
nukes.enspell = {['Earth']="Enstone", ['Water']="Enwater",  ['Wind']="Enaero", ['Fire']="Enfire", ['Ice']="Enblizzard", ['Lightning']="Enthunder", ['Light']="", ['Dark']=""}
nukes.gain = {['VIT'] = "Gain-VIT",	  ['MND']="Gain-MND",	['AGI']="Gain-AGI",['STR']="Gain-STR",  ['INT']="Gain-INT", 	['DEX']="Gain-DEX",			['CHR']="Gain-CHR"}

elements =  M('Ice', 'Wind', 'Earth', 'Lightning', 'Water', 'Fire')
enspellElements =  M('Ice', 'Wind', 'Earth', 'Lightning', 'Water', 'Fire')
gainStat = M('STR','MND','INT', 'AGI', 'CHR', 'VIT', 'DEX')

oldElement = elements.current


scTier2 = M(false)
meleeing = M(true)
mBurst = M(false)
runspeed = M(false)
keybinds = M(false)
mBurstOldValue = mBurst.value

if use_UI == true then
    setupTextWindow()
else
    windower.add_to_chat(211,'Nuke now set to element type: '..tostring(elements.current))    
    windower.add_to_chat(211,'Idle mode now set to: '..tostring(idleModes.current))    
    windower.add_to_chat(211,'Mode now set to: '..tostring(mode.current))  
end

Buff = 
    {
        ['Composure'] = false, 
        ['Saboteur'] = false, 
        ['En-Weather'] = false,
        ['En-Day'] = false,
        ['Enspell'] = false,
    }
    
-- Get a spell mapping for the spell.
function get_spell_map(spell)
    return spell_maps[spell.name]
end

-- Reset the state vars tracking strategems.
function update_active_ja(name, gain)
    Buff['Composure'] = buffactive['Composure'] or false
    Buff['Saboteur'] = buffactive['Saboteur'] or false
    Buff['En-Weather'] = buffactive[nukes.enspell[world.weather_element]] or false
    Buff['En-Day'] = buffactive[nukes.enspell[world.day_element]] or false
    Buff['Enspell'] = buffactive[nukes.enspell['Earth']] or buffactive[nukes.enspell['Water']] or buffactive[nukes.enspell['Wind']] or buffactive[nukes.enspell['Fire']] or buffactive[nukes.enspell['Ice']] or buffactive[nukes.enspell['Lightning']] or false
	--enspell check is broken but rest all work and it is less important
end


function buff_refresh(name,buff_details)
    -- Update SCH statagems when a buff refreshes.
    update_active_ja()
    if use_UI == true then
        validateTextInformation()
    end
end

function buff_change(name,gain,buff_details)
    -- Update SCH statagems when a buff is gained or lost.
    update_active_ja()
    if use_UI == true then
        validateTextInformation()
    end
end
 
function precast(spell)
    
    update_active_ja()
    local spell_recasts = windower.ffxi.get_spell_recasts()
	    if midaction() or pet_midaction() then
		return
    end
    if (buffactive['Apogee'] or buffactive['Astral Conduit']) then
        return
    end

    -- If we're doing a blood pact, equip our delay set IF Apogee or Astral Conduit are not active
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') and not (buffactive['Astral Conduit'] or buffactive['Apogee']) then
     
        equip(sets.precast.bp)
         
    elseif spell.type == 'SummonerPact' then
     
        -- This chunk of code handles Elemental Siphon. It will look at the current day and weather and cancel the spell to summon
        -- the right elemental. Your elemental siphon macro should summon a Dark Spirit to trigger this check
         
        -- These use the included lists in global.lua to determine the right spirit to summon
             
        if spell.name == 'Dark Spirit' then
            if world.weather_element == 'Dark' then
             
                -- Dark Weather is active, lets the spell go ahead and equips summoning precast
                equip(sets.precast.casting)
                 
            elseif world.weather_element ~= 'None' and spirit_conflict[world.day_element] ~= world.weather_element then
             
                -- It's not dark weather but there is some weather up, cancels dark and summons the right spirit
                cancel_spell()
                send_command('input /ma "%s" <me>':format(spirit_element[world.weather_element]))
                equip(sets.precast.casting)
                 
            elseif world.day_element == 'Dark' then
             
                -- It's darksday so allow the dark spirit to go ahead and equip summoning
                equip(sets.precast.casting)
                 
            else
             
                -- There is no weather up and it's not darksday, so summon the current day's spirit
                cancel_spell()              
                send_command('input /ma "%s" <me>':format(spirit_element[world.day_element]))
                equip(sets.precast.casting)
                 
            end
        else
         
            -- We're not summoning Dark Spirit, so we don't want to Siphon, which means we're summoning an avatar
            equip(sets.precast.casting)
             
        end
	end
    -- Auto use Echo Drops if you are trying to cast while silenced --    
    if spell.action_type == 'Magic' and buffactive['Silence'] then 
        cancel_spell()
        send_command('input /item "Echo Drops" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Using Echo Drops] ******')
        return        
    end       

    if spell.action_type  == 'Magic' and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
		add_to_chat(8, '****** ['..spell.name..' CANCELED - Spell on Cooldown, Downgrading spell] ******')
        return
    end   
	-- Auto downgrade Phalanx II to Pahalanx I when casting on self, saves macro space so you can set your phalanx macro to cast phalanx2 on <stpt>
    if spell.target.type == 'SELF' and spell.name == "Phalanx II" then
        cancel_spell()
        send_command('input /ma "Phalanx" <me>')  
    end

    -- Moving on to other types of magic --ninjutsu ADD
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'Ninjutsu' or spell.type == 'BlueMagic' or spell.type == 'Trust' then
     
        -- Stoneskin Precast
        if spell.name == 'Stoneskin' then
         
            windower.ffxi.cancel_buff(37)--[[Cancels stoneskin, not delayed incase you get a Quick Cast]]
            equip(sets.precast.stoneskin)
             
        -- Cure Precast
        elseif spell.name:match('Cure') or spell.name:match('Cura') then
         
            equip(sets.precast.cure)         
        -- Enhancing Magic
        elseif spell.skill == 'Enhancing Magic' then
         
            equip(sets.precast.enhancing)            
            if spell.name == 'Sneak' and spell.target.type == 'SELF' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
            end
			if spell.name == 'Temper II' then
				windower.ffxi.cancel_buff(432) --[[Cancels Multi STrikes which is buff for temper]]
			end
        else       
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                
        end
    end
	
    -- Job Abilities
    -- We use a cat
    -- catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
    if sets.precast[spell.name] then
        equip(sets.precast[spell.name])        
    end
end
 
function midcast(spell)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)

    -- No need to annotate all this, it's fairly logical. Just equips the relevant sets for the relevant magic
        -- Our pet is doing something
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
     
        -- We're going to check the lists in global.lua for matches and equip the relevant sets
         
        if bp_physical:contains(spell.name) then
            if mode.current == 'acc' then
                windower.send_command('wait .4;gs equip sets.avatar.pacc')		
			else
				windower.send_command('wait .4;gs equip sets.avatar.atk')
            end
        elseif bp_critical:contains(spell.name) then
            if mode.current == 'acc' then
                windower.send_command('wait .4;gs equip sets.avatar.pacc')		
			else
				windower.send_command('wait .4;gs equip sets.avatar.critical')
            end

			
        elseif bp_hybrid:contains(spell.name) then
            windower.send_command('wait .3;gs equip sets.avatar.hybrid')

        elseif bp_magical:contains(spell.name) then
			if mode.current == 'acc' then
                windower.send_command('wait .3;gs equip sets.avatar.macc')
			elseif mBurst then
                windower.send_command('wait .3;gs equip sets.avatar.mb')			
			else
				windower.send_command('wait .3;gs equip sets.avatar.mab')
            end
 
        elseif bp_debuff:contains(spell.name) then
            windower.send_command('wait .3;gs equip sets.avatar.macc')
             
        elseif bp_buff:contains(spell.name) then
            windower.send_command('wait .3;gs equip sets.avatar.buff') --buffs seem not to need as much time
             
        elseif bp_other:contains(spell.name) then
            windower.send_command('wait .3;gs equip sets.avatar.other')
             
        elseif spell.name == 'Perfect Defense' then
            windower.send_command('wait .3;gs equip sets.avatar.skill')
             
        else
            windower.send_command('wait .3;gs equip sets.avatar.skill')
             
        end
		if pet.name == 'Carbuncle' or pet.name == 'Cait Sith' then
			equip(sets.avatar[pet.name])
		end
    end 
	
	-- Curing
    if spell.name:match('Cure') or spell.name:match('Cura') then
        if spell.element == world.weather_element or spell.element == world.day_element then
            equip(sets.midcast.cure.weather)
        else
            equip(sets.midcast.cure.normal)
        end

    -- Enhancing
    elseif spell.skill == 'Enhancing Magic' then

        if spell.name:match('Protect') or spell.name:match('Shell') then	
            equip(sets.midcast.enhancing.duration)
        elseif spell.name:match('Refresh') then
           if spell.target.type == 'SELF' then
				equip(sets.midcast.RefreshSelf)
			else
				equip(sets.midcast.refresh)
			end
        elseif spell.name:match('Regen') then
            equip(sets.midcast.regen)
        elseif spell.name:match('Aquaveil') then
            equip(sets.midcast.aquaveil)
        elseif spell.name:match('Phalanx') then
			if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
				equip(sets.midcast.phalanxSW)
			else
				equip(sets.midcast.phalanx)
			end 
        elseif spell.name:match('Stoneskin') then
            equip(sets.midcast.stoneskin)
        elseif spell.name:match('Temper') or spellMap == "Enspell" then
			if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
				equip(sets.midcast.enhancing.potencySW)
			else
				equip(sets.midcast.enhancing.potency)
			end
		elseif spell.name:match('Sneak') or spell.name:match('Invisible') then
			equip(sets.midcast.enhancing.noSwapDur)
        else
            equip(sets.midcast.enhancing.duration) -- fall back to duration if not specified above 
        end

        -- Casting on others, then we use composure bonus set unless casting refresh
        if Buff['Composure'] then 
            if  spell.target.type ~= 'SELF' and spell.skill == 'Enhancing Magic' then
				if spell.name ~= 'Refresh III' and spell.name ~= 'Protect IV' and spell.name ~= 'Shell IV' then
					equip(sets.midcast.enhancing.composure)
				end
            end
        end

    -- Enfeebling
    elseif spell.skill == 'Enfeebling Magic' then
        if spell.type =='BlackMagic' then
			equip(sets.midcast.Enfeebling.INT)
		else
			equip(sets.midcast.Enfeebling.MND)
		end
		

    -- Nuking
    elseif spell.type == 'BlackMagic' then
        if mBurst.value == true then
            equip(sets.midcast.MB[nukeModes.current])
        else
            equip(sets.midcast.nuking[nukeModes.current])
        end
        -- Obi up for matching weather / day
		if player.status=='Engaged' and spell.skill == 'Elemental Magic' and spellMap ~= 'Helix' then
			if spell.element == "Dark" or spell.element == "Light" then  --light or dark
				--day or weather due to high affinity available
			if spell.element == world.day_element and spell.element == world.weather_element then
				equip(sets.midcast.Obi)
				--double weather without opposite day
			elseif spell.element == "Dark" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Light" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Light" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Dark" then 
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		else --no affinity so obi only for double weather but not wrong day
			if spell.element == "Fire" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Water" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Ice" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Fire" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Wind" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Ice" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Earth" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Wind" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Lightning" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Earth" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Water" and spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Lightning" then 
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		elseif player.status ~= 'Engaged' and spell.skill ~= 'Enhancing Magic' and spellMap ~= 'Helix' then
			if spell.element == world.weather_element then
				equip(sets.midcast.Obi)
			end
			if spell.element == world.day_element then
				equip(sets.midcast.Obi)
			end
		end
	elseif spell.type == 'SummonerPact'  then
			last_pet = spell.name
			equip(sets.midcast.casting)
	end
    -- And our catch all, if a set exists for this spell name, use it
    if spell.type ~= 'SummonerPact' then  --a few spells have same name as summoner pacts.
		if sets.midcast[spell.name] then
			equip(sets.midcast[spell.name])
    -- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
		elseif sets.midcast[spellMap] then
			equip(sets.midcast[spellMap])
		end
	end
    -- Weapon skills
    -- sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    if sets.me[spell.name] then
			equip(sets.me[spell.name])

			if spell.name == 'Garland of Bliss' then
				-- Double weather darksday doesnt matter
				if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Dark"  then
					equip(sets.midcast.Obi)
				else
					equip(sets.midcast.Orpheus)                
				end
			end

    end
    
    -- Prevent Obi by swapping helix stuff last
    -- Dark based Helix gets "pixie hairpin +1"
    if spellMap == 'DarkHelix'then
        equip(sets.midcast.DarkHelix)
    end
    if spellMap == 'Helix' then
        equip(sets.midcast.Helix)
    end

end


--[[function pet_midcast(spell)
 
    -- Our pet is doing something
    if (spell.type == 'BloodPactRage' or spell.type == 'BloodPactWard') then
     
        -- We're going to check the lists in global.lua for matches and equip the relevant sets
         
        if bp_physical:contains(spell.name) then
            if mode == 'acc' then
                equip(sets.avatar.pacc)		
			else
				equip(sets.avatar.atk)
            end
        elseif bp_critical:contains(spell.name) then
         
            equip(sets.avatar.critical)
			
        elseif bp_hybrid:contains(spell.name) then
         
            equip(sets.avatar.hybrid)

        elseif bp_magical:contains(spell.name) then
         
			if mode == 'acc' then
                equip(sets.avatar.macc)
			elseif mBurst then
                equip(sets.avatar.mb)			
			else
				equip(sets.avatar.mab)
            end
 
        elseif bp_debuff:contains(spell.name) then
         
            equip(sets.avatar.macc)
             
        elseif bp_buff:contains(spell.name) then
         
            equip(sets.avatar.buff)
             
        elseif bp_other:contains(spell.name) then
         
            equip(sets.avatar.other)
             
        elseif spell.name == 'Perfect Defense' then
         
            equip(sets.avatar.skill)
             
        else
         
            equip(sets.avatar.skill)
             
        end
		if pet.name == 'Carbuncle' or pet.name == 'Cait Sith' then
			equip(sets.avatar[pet.name])
		end
    end 
end]]

function aftercast(spell)
     
    -- Pet aftercast is simply a check for whether Conduit and Apogee are up, and then a call to our aftercast function
    -- We have a variable called autobp that we set to true or false with commands to auto repeat BPs for us
    if (buffactive['Apogee'] or buffactive['Astral Conduit']) and autobp then
        send_command('input /pet "%s" <t>':format(spell.name))
        return
    end
    update_active_ja()
    idle(pet)
    -- Add to Chat rules for buffs with variable values.
	buffs_to_chat(spell)
	if (spell.english=="Heavenward Howl") then
		if (world.moon_pct>89) then
				add_to_chat(104,"[Heavenward Howl] Moon Phase Full moon - Endrain 15%")
		elseif (world.moon_pct>73) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 74~90% {Endrain 12%")
		elseif (world.moon_pct>56) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 57~73% {Endrain 8%}")
		elseif (world.moon_pct>39) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 40~56% {First Quarter Moon - Endrain 5% | Last Quarter - moon Enaspir 1%}" )
		elseif (world.moon_pct>24) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 25~39% {Enaspir 2%}")
		elseif (world.moon_pct>9) then
				add_to_chat(104,"[Heavenward Howl] Moon phase 10~24% {Enaspir 4%}")
		else
				add_to_chat(104,"[Heavenward Howl] Moon Phase New Moon - Enaspir 5%")
		end     
	end 
end

function buffs_to_chat(spell)
	-- Add to Chat rules for buffs with variable values
	-- table of tables: spell = T{ "stat_a", "stat_b", step}
	buff_chat_values = {
		['Ecliptic Howl'] = T{"Accuracy","Evasion",4},
		['Ecliptic Growl'] = T{"STR/DEX/VIT","INT/MND/CHR/AGI",1},
		['Lunar Cry'] = T{"Enemy Acc Down","Enemy Eva Down",1},
	}
	if buff_chat_values[spell.english] then
		-- calc value of stat_a: 1 + (the moon phase value * step value)
		local val_a = 1 + (Moon() * buff_chat_values[spell.english][3])
		-- calc value of stat_b: (2 - (6 * step value)) - val_a
		local val_b = (2 + (6 * buff_chat_values[spell.english][3])) - val_a
		-- concatenate all that together
		add_to_chat(104,"["..spell.english.."] "..buff_chat_values[spell.english][1].." "..tostring(val_a).." - "..buff_chat_values[spell.english][2].." "..tostring(val_b))
	-- Dream Shroud is based on time not moon phase
	elseif (spell.english=="Dream Shroud") then
		-- get the hour in 24h format
		local hour24 = math.floor(world.time/60)
		if hour24 < 13 then
			add_to_chat(104,"[Dream Shroud] MAB "..tostring(13-hour24).." - MDB "..tostring(hour24+1))
		else
			add_to_chat(104,"[Dream Shroud] MAB "..tostring(1+(hour24-12)).." - MDB "..tostring(13-(hour24-12)))
		end
	end
end

function Moon()
	-- Assume bonus to effects is symmetrical around New Moon or Full Moon
	-- Actually Phase 0/11 in 12 phase Full Cycle
	-- Originally written for Artemis' Medal
	-- See http://www.ffxiah.com/screenshots/51600
	if world.moon == "New Moon" then
		return 0
	-- Check for Waxing Moon
	elseif world.moon == "Waxing Crescent" then
		-- If %MOONPCT < 24% we know it's Early, rather than Late
		if world.moon_pct < 24 then
			return 1
		else
			return 2
		end
	elseif world.moon == "First Quarter Moon" then
		return 3
	elseif world.moon == "Waxing Gibbous" then
		-- If %MOONPCT < 74% we know it's Early, rather than Late
		if world.moon_pct < 74 then
			return 4
		else
			return 5
		end
	elseif world.moon == "Full Moon" then
		return 6
	-- Check for Waning Moon
	elseif world.moon == "Waning Gibbous" then
		-- If %MOONPCT > 76% we know it's Early, rather than Late
		if world.moon_pct > 76 then
			-- Actually Phase 7 in Full Cycle
			return 5
		else
			-- Actually Phase 8 in Full Cycle
			return 4
		end	
	elseif world.moon == "Last Quarter Moon" then
		-- Actually Phase 9 in Full Cycle
		return 3
	elseif world.moon == "Waning Crescent" then
		-- If %MOONPCT > 26% we know it's Early, rather than Late
		if world.moon_pct > 26 then
			-- Actually Phase 10 in Full Cycle
			return 2
		else
			-- Actually Phase 11 in Full Cycle
			return 1
		end
	end
end
function idle(pet)
 
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
    if (buffactive['Apogee'] or buffactive['Astral Conduit']) then
		return 
    elseif player.status=='Engaged' then   
        -- We're engaged meleeing priority over all.
		windower.send_command('wait .5;gs equip sets.me.melee')	    
	elseif pet.isvalid then
		if pet.name == 'Alexander' then       
			-- We have Alexander so we want idle in max skill instead.
			windower.send_command('wait .5;gs equip sets.avatar.skill')		
		else 
			sets.current.avatar = sets.avatar[idleModes.value]
			windower.send_command('wait .7;gs equip sets.current.avatar')	
		end
    else
        -- We're not meleeing and we have no pet out
		sets.current.idle = sets.me.idle[idleModes.value]
		windower.send_command('wait .2;gs equip sets.current.idle')	
    end
end
 

function status_change(new,old)
    if new == 'Engaged' then  
        -- If we engage check our meleeing status
        idle(pet)
         
    elseif new=='Resting' then
     
        -- We're resting
        equip(sets.me.resting)          
    else
        idle(pet)
    end
end
function pet_change(pet,gain)
 
    -- When we summon or release an avatar
    idle(pet)
end
function self_command(command)
    hud_command(command)
    local commandArgs = command
     
    if #commandArgs:split(' ') >= 2 then
        commandArgs = T(commandArgs:split(' '))
        
        if commandArgs[1] == 'toggle' then
            if commandArgs[2] == 'melee' then
                -- //gs c toggle melee will toggle melee mode on and off.
                -- This basically locks the slots that will cause you to lose TP if changing them,
                -- As well as equip your melee set if you're engaged
                meleeing:toggle()
                lockMainHand(meleeing.value)

            elseif commandArgs[2] == 'idlemode' then
                idleModes:cycle()
                idle(pet)
                if use_UI == true then
                    validateTextInformation()
                else
                    windower.add_to_chat(4,"----- Idle mode Now focus on: "..tostring(idleModes.value))
                end
            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle()
                idle(pet)
                if use_UI == true then
                    validateTextInformation()
                else
                    windower.add_to_chat(4,"----- Idle mode Now focus on: "..tostring(idleModes.value))
                end
            elseif commandArgs[2] == 'mode' then
                mode:cycle()               
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(8,"----- Mode is now: "..tostring(mode.current)) 
                end   
            elseif commandArgs[2] == 'matchsc' then
                matchsc:toggle()               
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(8,"----- Matching SC Mode is now: "..tostring(matchsc.current)) 
                end
            end

        
        elseif commandArgs[1]:lower() == 'scholar' then
            handle_strategems(commandArgs)

        elseif commandArgs[1]:lower() == 'nuke' then
            if not commandArgs[2] then
                windower.add_to_chat(123,'No element type given.')
                return
            end
            
            local nuke = commandArgs[2]:lower()
            
            if (nuke == 'cycle' or nuke == 'cycledown') then
                if nuke == 'cycle' then
                    elements:cycle()
                    oldElement = elements.current
                elseif nuke == 'cycledown' then 
                    elements:cycleback() 
                    oldElement = elements.current
                end
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(211,'Enspell now set to element type: '..tostring(elements.current))
                end  
            
            elseif (nuke == 'Wind' or nuke == 'ice' or nuke == 'fire' or nuke == 'water' or nuke == 'lightning' or nuke == 'earth' or nuke == 'light' or nuke == 'dark') then
                local newType = commandArgs[2]
                elements:set(newType)
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(211,'Nuke now set to element type: '..tostring(elements.current))
                end 
            elseif not nukes[nuke] then
                windower.add_to_chat(123,'Unknown element type: '..tostring(commandArgs[2]))
                return              
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                --recast = windower.ffxi.get_spell_recasts(nukes[nuke][elements.current])
                --if recast > 0 
                send_command('@input /ma "'..nukes[nuke][elements.current]..'"')     
            end
		elseif commandArgs[1]:lower() == 'pact' then
			if not pet.isvalid then
					windower.add_to_chat(122,'No avatar currently available. Returning to default macro set.')
					set_macros(1,8)
				return
			end
		 
			if not commandArgs[2] then
				windower.add_to_chat(123,'No pact type given.')
				return
			end
		 
			local pact = commandArgs[2]:lower()
		 
			if not pacts[pact] then
				windower.add_to_chat(123,'Unknown pact type: '..tostring(pact))
				return
			end
		 
			if pacts[pact][pet.name] then
				if pact == 'astralflow' and not buffactive['astral flow'] then
					windower.add_to_chat(122,'Cannot use Astral Flow pacts at this time.')
					return
				end
		 
				-- Leave out target; let Shortcuts auto-determine it.
				send_command('@input /pet "'..pacts[pact][pet.name]..'"')
			else
				windower.add_to_chat(122,pet.name..' does not have a pact of type ['..pact..'].')
			end
		end
	end
end

function updateMB( mBurst )   
    if mBurst then
        if use_UI == true then
            validateTextInformation()
        else
            windower.add_to_chat(8,"----- Nuking MB Mode OFF -----")
        end
    else
        if use_UI == true then
            validateTextInformation()
        else
            windower.add_to_chat(8,"----- Nuking MB Mode ON -----")
        end
    end
end




function lockMainHand( meleeing )   
    
    if meleeing then
        enable('main','sub','ranged')
        if use_UI == true then
            validateTextInformation()
        else
            windower.add_to_chat(8,'----- Weapons Unlocked, WILL LOSE TP -----')
        end
        idle(pet)
    else
        disable('main','sub','ranged')
        if use_UI == true then
            validateTextInformation()
        else
            windower.add_to_chat(8,'----- Weapons Locked, WILL NOT LOSE TP -----')
        end
        idle(pet)
    end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
-- Copied from SCH lua, gonna leave it as is, still relevant for subbing sch and easy macro

function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end

local skillchains = {
    [767] = {id=767,english='Radiance',elements={'Light','Fire','Lightning','Wind'}, color=Colors[4]},
    [768] = {id=768,english='Umbra',elements={'Dark','Earth','Water','Ice'}, color=Colors[8]},
    [288] = {id=288,english='Light',elements={'Light','Fire','Lightning','Wind'}, color=Colors[4]},
    [289] = {id=289,english='Darkness',elements={'Dark','Earth','Water','Ice'}, color=Colors[8]},
    [290] = {id=290,english='Gravitation',elements={'Earth', 'Dark'}, color=Colors[5]},
    [291] = {id=291,english='Fragmentation',elements={'Lightning','Wind'}, color=Colors[7]},
    [292] = {id=292,english='Distortion',elements={'Ice', 'Water'}, color=Colors[6]},
    [293] = {id=293,english='Fusion',elements={'Fire', 'Light'}, color=Colors[1]},
    [294] = {id=294,english='Compression',elements={'Dark'}, color=Colors[8]},
    [295] = {id=295,english='Liquefaction',elements={'Fire'}, color=Colors[1]},
    [296] = {id=296,english='Induration',elements={'Ice'}, color=Colors[6]},
    [297] = {id=297,english='Reverberation',elements={'Water'}, color=Colors[2]},
    [298] = {id=298,english='Transfixion', elements={'Light'}, color=Colors[4]},
    [299] = {id=299,english='Scission',elements={'Earth'}, color=Colors[5]},
    [300] = {id=300,english='Detonation',elements={'Wind'}, color=Colors[3]},
    [301] = {id=301,english='Impaction',elements={'Lightning'}, color=Colors[7]}
}
windower.register_event('action', function(act)
	for _, target in pairs(act.targets) do
		local battle_target = windower.ffxi.get_mob_by_target("t")
		if battle_target ~= nil and target.id == battle_target.id then
			for _, action in pairs(target.actions) do
				if ((action.add_effect_message > 287 and action.add_effect_message < 302) or action.add_effect_message == 767 or action.add_effect_message == 768) then
					last_skillchain = skillchains[action.add_effect_message]
					mBurstOldValue = mBurst.value
                    MB_Window = 12
					MB_Time = os.time()
					validateTextInformation()
				end
			end
		end
	end
end)

windower.register_event('prerender', function()
	--Items we want to check every second
	if os.time() > time_start then
		time_start = os.time()
		if MB_Window > 0 then
			MB_Window = 10 - (os.time() - MB_Time)
            if matchsc.value then
                selectSCElement()
                mBurst:set(true)
            end
			validateTextInformation()
        else
            elements:set(oldElement)
            mBurst:set(mBurstOldValue)
            validateTextInformation()
		end
	end
end)

function selectSCElement()
    -- Tier 3 SC we favor element already chosen, then day (our weather likely match our set element as a sch) then swap for bad day. 
    if last_skillchain.english == "Light" or last_skillchain.english == "Radiance"  then
        -- First we always prefer the selected element if that element can burst, if not we move on.
        if elements.current == "Fire" or elements.current == "Lightning" or elements.current == "Wind" then
            return
        -- Favor Fire if its Fire's Day or Earth's day (thunder weak on E-Day)
        elseif (world.day_element == "Fire" and world.weather_element ~="Water") or (world.weather_element == "Fire" and world.day_element ~="Water") or (world.weather_element == "Fire" and get_weather_intensity() == 2) or
		(world.day_element == "Earth" and  world.weather_element ~="Lightning") or (world.weather_element == "Earth" and  world.day_element ~="Lightning") or (world.weather_element == "Earth" and get_weather_intensity() == 2)then
            selectedElement = "Fire"
            elements:set(selectedElement)
        -- Favor Wind if its Wind's Day or Earth's day (thunder weak on E-Day)
        elseif (world.day_element == "Wind" and world.weather_element ~="Ice") or (world.weather_element == "Wind" and world.day_element ~="Ice") or (world.weather_element == "Wind" and get_weather_intensity() == 2) then
            selectedElement = "Wind"
            elements:set(selectedElement)
        else
            selectedElement = "Lightning"
            elements:set(selectedElement)
        end
    elseif last_skillchain.english == "Darkness" or last_skillchain.english == "Umbra"  then
        -- First we always prefer the selected element if that element can burst, if not we move on.
        if elements.current == "Earth" or elements.current == "Water" or elements.current == "Ice" then
            return
        -- Favor Water if its Water's Day or Fire's day (Ice weak on F-Day)
        elseif (world.day_element == "Water" and world.weather_element ~="Lightning") or (world.weather_element == "Water" and world.day_element ~="Lightning") or (world.weather_element == "Water" and get_weather_intensity() == 2) or
		(world.day_element == "Fire" and  world.weather_element ~="Ice") or (world.weather_element == "Fire" and  world.day_element ~="Ice") or (world.weather_element == "Fire" and get_weather_intensity() == 2) then
            selectedElement = "Water"
            elements:set(selectedElement)
        -- Favor Earth if its Earth's Day or Fire's day (Ice weak on F-Day)
        elseif (world.day_element == "Earth" and world.weather_element ~="Wind") or (world.weather_element == "Earth" and world.day_element ~="Wind") or (world.weather_element == "Earth" and get_weather_intensity() == 2) then
            selectedElement = "Earth"
            elements:set(selectedElement)        
        else
            selectedElement = "Ice"
            elements:set(selectedElement)
        end
    -- Tier 2 SC we favor element already chosen, then day (our weather likely match our set element as a sch) then swap for bad day. 
    -- In case of Fusion and Grav, we avoid light / dark cause outside of helix, no good nukes,
    -- Also, we more than likely premeditated the helix we stuck on a mob, so unlikely we want to randomly burst a random helix.
    elseif last_skillchain.english == "Gravitation" then
        selectedElement = "Earth"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Fusion" then
        selectedElement = "Fire"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Fragmentation" then
        if elements.current == "Lightning" or elements.current == "Wind" then
            return
        -- Favor Wind if its Wind's Day or Earth's day (thunder weak on E-Day)
        elseif (world.day_element == "Wind" and world.weather_element ~="Ice") or (world.weather_element == "Wind" and world.day_element ~="Ice") or (world.weather_element == "Wind" and get_weather_intensity() == 2) or 
		(world.day_element == "Earth" and  world.weather_element ~="Lightning") or (world.weather_element == "Earth" and  world.day_element ~="Lightning") or (world.weather_element == "Earth" and get_weather_intensity() == 2)then
            selectedElement = "Wind"
            elements:set(selectedElement)
        else
            selectedElement = "Lightning"
            elements:set(selectedElement)
        end
    elseif last_skillchain.english == "Distortion" then
        if elements.current == "Ice" or elements.current == "Water" then
            return
        -- Favor Water is its Water's Day or Earth's day (Ice weak on F-Day)
        elseif (world.day_element == "Water" and world.weather_element ~="Lightning") or (world.weather_element == "Water" and world.day_element ~="Lightning") or (world.weather_element == "Water" and get_weather_intensity() == 2) or
		(world.day_element == "Fire" and  world.weather_element ~="Ice") or (world.weather_element == "Fire" and  world.day_element ~="Ice") or (world.weather_element == "Fire" and get_weather_intensity() == 2) then
            selectedElement = "Water"
            elements:set(selectedElement)
        else
            selectedElement = "Ice"
            elements:set(selectedElement)
        end
    -- Tier 1 SC we go straight to Busrt Element
    elseif last_skillchain.english == "Compression" then
        selectedElement = "Earth"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Liquefaction" then
        selectedElement = "Fire"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Induration" then
        selectedElement = "Ice"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Reverberation" then
        selectedElement = "Water"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Transfixion" then
        selectedElement = "Fire"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Scission" then
        selectedElement = "Earth"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Detonation" then
        selectedElement = "Wind"
        elements:set(selectedElement)
    elseif last_skillchain.english == "Impaction" then
        selectedElement = "Lightning"
        elements:set(selectedElement)
    end
end

-- Function to get the current weather intensity: 0 for none, 1 for single weather, 2 for double weather.
function get_weather_intensity()
    return gearswap.res.weather[world.weather_id].intensity
end

function downgradenuke( spell )

    if spell.name:match(nukes.t1[elements.current]) then   
        if spell.name == nukes.t5[elements.current] then
            newspell = nukes.t4[elements.current]
        elseif spell.name == nukes.t4[elements.current] then
            newspell = nukes.t3[elements.current]
        elseif spell.name == nukes.t3[elements.current] then
            newspell = nukes.t2[elements.current]
        elseif spell.name == nukes.t2[elements.current] then
            newspell = nukes.t1[elements.current]
        end
        send_command('input /ma "'..newspell..'"')
    end
	if spell.name:match("Aspir") then   
        if spell.name == "Aspir III" then
            newspell = "Aspir II"
        elseif spell.name == "Aspir II" then
            newspell = "Aspir"
		elseif spell.name == "Aspir" then
			newspell = ""
        end
        send_command('input /ma '..newspell..'')
    end
	if spell.name:match("Sleep") then   
        if spell.name == "Sleep II" then
            newspell = "Sleep"
        elseif spell.name == "Sleep" then
            newspell = ""
        end
        send_command('input /ma '..newspell..'')
    end

end
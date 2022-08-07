
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
    ['Barsleep']='BarElement',['Barpoison']='BarElement',['Barparalyze']='BarElement',['Barblind']='BarElement',['Barsilence']='BarElement',['Barpetrify']='BarElement',['Barvirus']='BarElement',
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
	['Tonko: Ichi'] = 'NinBuff',['Tonko: Ni'] = 'NinBuff',['Monomi: Ichi'] = 'NinBuff',['Myoshu: Ichi'] = 'NinBuff',['Migawari: Ichi'] = 'NinBuff',['Gekka: Ichi'] = 'NinBuff',['Yain: Ichi'] = 'NinBuff',['Kakka: Ichi'] = 'NinBuff',
	['Kurayami: Ichi'] = 'NinDeBuff',['Kurayami: Ni'] = 'NinDeBuff',['Hojo: Ichi'] = 'NinDeBuff',['Hojo: Ni'] = 'NinDeBuff',['Dokumori: Ichi'] = 'NinDeBuff',['Jubaka: Ichi'] = 'NinDeBuff',
	['Aisha: Ichi'] = 'NinDeBuff',['Yurin: Ichi'] = 'NinDeBuff',
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

enfeeb_maps = {
    ['Dia']='Duration', ['Dia II']='Duration', ['Dia III']='Duration',
    ['Bio']='potency', ['Bio II']='potency', ['Bio III']='potency',
    ['Paralyze']='mndpot', ['Paralyze II']='mndpot', 
    ['Slow']='mndpot', ['Slow II']='mndpot', 
    ['Adle']='mndpot', ['Adle II']='mndpot',
    ['Sleep']='maccINT', ['Sleep II']='maccINT', ['Sleepga']='maccINT', 
    ['Silence']='macc', 
    ['Inundation']='macc', 
    ['Dispel']='maccINT', 
    ['Break']='macc', 
    ['Bind']='macc', 
    ['Blind']='maccINT', ['Blind II']='intpot',--'intpot', 
    ['Gravity']='potency', ['Gravity II']='potency',
	-- We leave Fazzle and FrazzleII as pure macc to help land it in cases its a high resist. 
	-- This lets us follow up with a high potency Frazzle3 
    ['Frazzle']='macc', ['Frazzle II']='macc', ['Frazzle III']='skillmndpot', 
    ['Distract']='mndpot', ['Distract II']='mndpot', ['Distract III']='skillmndpot', 
    ['Poison']='skillpot', ['Poison II']='skillpot', ['Poisonga']='skillpot',
}


-- Set Macros for your SCH's macro page, book.
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
windower.add_to_chat(8,'----- Welcome back to your NIN.lua, '..pName..' -----')

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
RuneColors = {
    ["Light"] = "\\cs(255, 255, 255)", 
    ["Dark"]="\\cs(92, 92, 92)",
    ["Ice"] = "\\cs(0, 204, 204)", 
	["Fire"] = "\\cs(204, 0, 0)", 
    ["Water"] = "\\cs(0, 102, 204)", 
    ["Wind"] = "\\cs(51, 102, 0)", 
    ["Lightning"] = "\\cs(102, 0, 204)",
    ["Earth"] = "\\cs(139, 139, 19)"


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
\cs(255, 255, 64)${key_bind_idle} \cs(200, 200, 200)Idle:\cr \cs(125,125,255)${player_current_idle|Refresh}
\cs(255, 255, 64)${key_bind_melee} \cs(200, 200, 200)Melee:\cr \cs(125,125,255)${player_current_melee|Refresh}
\cs(255, 255, 64)${key_bind_mainweapon} \cs(200, 200, 200)Main Weapon:\cr \cs(125,125,255)${player_current_mainweapon|Crocea Mors}
\cs(255, 255, 64)${key_bind_subweapon} \cs(200, 200, 200)Sub Weapon:\cr \cs(125,125,255)${player_current_subweapon|Ammurapi Shield}
]]

hub_options_std = [[ \cs(255, 115, 0)Options: \cr         
\cs(255, 255, 64)${key_bind_matchsc}\cs(200, 200, 200)Match SC Element:\cr ${player_match_sc}
\cs(255, 255, 64)${key_bind_lock_weapon} \cs(200, 200, 200)Lock Ammo:\cr ${toggle_lock_weapon}
]]

hub_job_std = [[ \cs(255, 115, 0)${player_job}: \cr             
\cs(255, 255, 64)${key_bind_element_cycle} \cs(200, 200, 200)Nuking:\cr ${element_color|\\cs(0, 204, 204)}${toggle_element_cycle|Ice} \cr
\cs(255, 255, 64)${key_bind_rune_cycle} \cs(200, 200, 200)Resist:\cr ${rune_color|\\cs(255, 255, 255)}${toggle_rune_cycle|Light} \cr
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
keybinds_off['key_bind_idle'] = '       '
keybinds_off['key_bind_melee'] = '       '
keybinds_off['key_bind_casting'] = '       '
keybinds_off['key_bind_mburst'] = '       '
keybinds_on['key_bind_mburst'] = '       '
keybinds_off['key_bind_mainweapon'] = '       '
keybinds_off['key_bind_subweapon'] = '       '
keybinds_on['key_bind_movespeed_lock'] = '        '

keybinds_off['key_bind_element_cycle'] = '       '
keybinds_off['key_bind_rune_cycle'] = '       '
keybinds_off['key_bind_gain_cycle'] = '       '
keybinds_off['key_bind_sc_level'] = '       '
keybinds_off['key_bind_lock_weapon'] = '       '
keybinds_off['key_bind_movespeed_lock'] = '        '
keybinds_off['key_bind_matchsc'] = '        '
keybinds_off['key_bind_enspell_cycle'] = '       '

function validateTextInformation()

    --Mode Information
    main_text_hub.player_current_idle = idleModes.current
    main_text_hub.player_current_melee = meleeModes.current
	main_text_hub.player_current_mainweapon = mainWeapon.current
	main_text_hub.player_current_subweapon = subWeapon.current
    main_text_hub.toggle_element_cycle = elements.current
	main_text_hub.toggle_rune_cycle = runes.current
    main_text_hub.player_job = player.job

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
	main_text_hub.rune_color = RuneColors[runes.current]
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
    texts.append(main_text_hub, hub_options)
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
nukes.t1 = {['Earth']="Doton: Ichi", ['Water']="Suiton: Ichi", ['Wind']="Huton: Ichi",['Fire']="Katon: Ichi",['Ice']="Hyoton: Ichi",['Lightning']="Raiton: Ichi",['Light']="Raiton: Ichi",['Dark']="Doton: Ichi",}
nukes.t2 = {['Earth']="Doton: Ni",   ['Water']="Suiton: Ni",   ['Wind']="Huton: Ni",  ['Fire']="Katon: Ni",  ['Ice']="Hyoton: Ni",  ['Lightning']="Raiton: Ni",  ['Light']="Raiton: Ni",  ['Dark']="Doton: Ni",}
nukes.t3 = {['Earth']="Doton: San",  ['Water']="Suiton: San",  ['Wind']="Huton: San", ['Fire']="Katon: San", ['Ice']="Hyoton: San", ['Lightning']="Raiton: San", ['Light']="Raiton: San", ['Dark']="Doton: San",}
nukes.rune = {['Light']="Tenebrae",	 ['Dark']="Lux",		   ['Ice']="Ignis", 	 ['Fire']="Unda", 		['Water']="Sulpor",    ['Lightning']="Tellus", 		['Earth']="Flabra",	     ['Wind']="Gelus",}
elements =  M('Earth', 'Lightning', 'Water', 'Fire', 'Ice', 'Wind')
runes = M('Light','Dark','Ice', 'Fire', 'Water','Lightning', 'Earth', 'Wind')


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
    windower.add_to_chat(211,'Nuke mode now set to: '..tostring(nukeModes.current))  
end

Buff = 
    {
        ['Innin'] = false, 
        ['Yonin'] = false, 
		['Futae'] = false,
		['Copy Image'] = false,
		['Last Resort'] = false,
		['Souleater'] = false,

    }
    
-- Get a spell mapping for the spell.
function get_spell_map(spell)
    return spell_maps[spell.name]
end
-- Get a spell mapping for the enfeeble.
function get_enfeeb_map(spell)
    return enfeeb_maps[spell.name]
end
-- Reset the state vars tracking strategems.
function update_active_ja(name, gain)
    Buff['Innin'] = buffactive['Innin'] or false
    Buff['Yonin'] = buffactive['Yonin'] or false
	Buff['Futae'] = buffactive['Futae'] or false
	Buff['Copy Image'] = (buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)']  or buffactive['Copy Image (4+)']) or false
    Buff['Last Resost'] = buffactive['Last Resort'] or false
    Buff['Souleater'] = buffactive['Souleater'] or false
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
 
function precast(spell,action)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    
    update_active_ja()
    local spell_recasts = windower.ffxi.get_spell_recasts()
	if spell.english == 'Ranged' then
		equip(sets.me.preshot)
	end
    -- Auto use Echo Drops if you are trying to cast while silenced --    
    if spell.action_type == 'Magic' and buffactive['Silence'] then 
        cancel_spell()
        send_command('input /item "Remedy" <me>')     
        add_to_chat(8, '****** ['..spell.name..' CANCELED - Using Echo Drops] ******')
        return        
    end       
	
	if spell.name == 'Last Resort' and buffactive['Last Resort'] then
		cancel_spell()
		windower.ffxi.cancel_buff(64)
	end
	if spell.name == 'Souleater' and buffactive['Souleater'] then
		cancel_spell()
		windower.ffxi.cancel_buff(63)
	end
	
    if spell.action_type  == 'Magic' and spell_recasts[spell.recast_id] > 0 then
        cancel_spell()
        downgradenuke(spell)
		add_to_chat(8, '****** ['..spell.name..' CANCELED - Spell on Cooldown, Downgrading spell] ******')
        return
    end   


    -- Moving on to other types of magic 
    if spell.type == 'WhiteMagic' or spell.type == 'BlackMagic' or spell.type == 'BlueMagic' or spell.type == 'Trust' then
     
		if spell.name == 'Sneak' and spell.target.type == 'SELF' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
		end
		if sets.precast[spellMap] then
			equip(sets.precast[spellMap])	
        else  
		
            -- For everything else we go with max fastcast
            equip(sets.precast.casting)                
        end
    end
	
	if spell.type == 'Ninjutsu' then
		if spell.name == 'Monomi :Ichi' and spell.target.type == 'SELF' then
                windower.ffxi.cancel_buff(71)--[[Cancels Sneak]]
		end
		if sets.precast[spellMap] then
			equip(sets.precast[spellMap])	
        else  
		
            -- For everything else we go with max fastcast
            equip(sets.precast.ninjutsu)                
        end
    end
	
    -- Job Abilities
    -- We use a cat
    -- catch all here, if the set exists for an ability, use it
    -- This way we don't need to write a load of different code for different abilities, just make a set
	local abil_recasts = windower.ffxi.get_ability_recasts()
	if spell.name == 'Yonin' then
		if abil_recasts[146] > 0 then --yonin recast
			cancel_spell() 
			send_command('input /ma "Gekka: Ichi" <me>')
		end
	elseif spell.name =='Innin'  then
		if abil_recasts[147] > 0 then --Innin recast
			cancel_spell() 
			send_command('input /ma "Yain: Ichi" <me>')
		end
    elseif sets.precast[spell.name] then
        equip(sets.precast[spell.name]) 

    end
	
end
 
function midcast(spell,action)
    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
    local enfeebMap = get_enfeeb_map(spell)





	if spell.english == 'Ranged' then
		equip(sets.me.midshot)
    -- Enhancing
 
		

    -- Nuking
    elseif spellMap == 'ElementalNinjutsu' then
		if Buff['Futae'] then
			if mBurst.value == true then
				equip(sets.midcast.FMB)
			else
				equip(sets.midcast.Fnuking)
			end
		
        elseif mBurst.value == true then
            equip(sets.midcast.MB)
        else
            equip(sets.midcast.nuking)
        end
        -- Obi up for matching weather / day
		if player.status~='Engaged' then
			--check weather
			if spell.element == "Fire" and spell.element == world.weather_element and (get_weather_intensity() == 2 or world.day_element ~= "Water")  then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Ice" and spell.element == world.weather_element and (get_weather_intensity() == 2  or world.day_element ~= "Fire") then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Wind" and spell.element == world.weather_element and (get_weather_intensity() == 2  or world.day_element ~= "Ice") then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Earth" and spell.element == world.weather_element and (get_weather_intensity() == 2  or world.day_element ~= "Wind") then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Lightning" and spell.element == world.weather_element and (get_weather_intensity() == 2  or world.day_element ~= "Earth") then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Water" and spell.element == world.weather_element and (get_weather_intensity() == 2  or world.day_element ~= "Lightning") then 
				equip(sets.midcast.Obi)
				--check day
			elseif spell.element == "Fire" and spell.element == world.day_element and  world.weather_element ~= "Water"  then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Ice" and spell.element == world.day_element and  world.weather_element ~= "Fire" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Wind" and spell.element == world.day_element and  world.weather_element ~= "Ice" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Earth" and spell.element == world.day_element and  world.weather_element ~= "Wind" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Lightning" and spell.element == world.day_element and  world.weather_element ~= "Earth" then 
				equip(sets.midcast.Obi)
			elseif spell.element == "Water" and spell.element == world.day_element and  world.weather_element ~= "Lightning" then 
				equip(sets.midcast.Obi)
			end--otherwise leave default waist
		elseif player.status=='Engaged' then
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

    
    -- Fail safe
    elseif spell.type ~= "WeaponSkill" then
		if Buff['Innin'] then
			equip(sets.midcast.castingin)
		else --default to enmity set in case dispelled or something
			equip(sets.midcast.casting)
		end
	end
    -- And our catch all, if a set exists for this spell name, use it
	if mainWeapon.current == 'Fudo Masamune C' then
		if not Buff['Copy Image'] and spell.name:match("Utsusemi") then
			equip(sets.midcast.SIRD)
		elseif not Buff['Copy Image'] and spell.name:match("Migawari") then --if lacking shadows use SIRD set instead of normal set
			equip(sets.midcast.SIRDMiga)
		elseif sets.midcast.YoninC[spell.name] then
			equip(sets.midcast.YoninC[spell.name])
				-- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
		elseif sets.midcast.YoninC[spellMap] then
			equip(sets.midcast.YoninC[spellMap])
		end
	elseif Buff['Innin'] then 
		if not Buff['Copy Image'] and spell.name:match("Utsusemi") then --if lacking shadows use SIRD set instead of normal set
			equip(sets.midcast.SIRD)
		elseif not Buff['Copy Image'] and spell.name:match("Migawari") then --if lacking shadows use SIRD set instead of normal set
			equip(sets.midcast.SIRDMiga)
		elseif sets.midcast.Innin[spell.name] then
			equip(sets.midcast.Innin[spell.name])
			-- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
		elseif sets.midcast.Innin[spellMap] then
			equip(sets.midcast.Innin[spellMap])
		end
	else
		if not Buff['Copy Image'] and spell.name:match("Utsusemi") then
			equip(sets.midcast.SIRD)
		elseif not Buff['Copy Image'] and spell.name:match("Migawari") then --if lacking shadows use SIRD set instead of normal set
			equip(sets.midcast.SIRDMiga)
		elseif sets.midcast.Yonin[spell.name] then
			equip(sets.midcast.Yonin[spell.name])
				-- Catch all for tiered spells (use mapping), basically if no set for spell name, check set for spell mapping. AKA Drain works for all Drain tiers.
		elseif sets.midcast.Yonin[spellMap] then
			equip(sets.midcast.Yonin[spellMap])
		end
	end
    -- Weapon skills
    -- sets.me["Insert Weaponskill"] are basically how I define any non-magic spells sets, aka, WS, JA, Idles, etc.
    if sets.me[spell.name] then
		equip(sets.me[spell.name])

		if spell.name == 'Sanguine Blade' or spell.name == 'Blade: Ei'then
			-- Dark day and dark weather --for nin only dark has enough affinity to change for day + weather
			if spell.element == world.day_element and spell.element == world.weather_element then
				equip(sets.midcast.Obi)
			-- Double dark weather aka Dynamis and not lights day
			elseif spell.element == world.weather_element and get_weather_intensity() == 2  and world.day_element ~= "Light" then 
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if spell.name == 'Red Lotus Blade' or spell.name == 'Tachi: Kagero' then
			-- Double weather and not watersday 
			if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Water" then
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if spell.name == 'Seraph Blade' or spell.name == 'Tachi: Koki' then
			-- Double weather darksday doesnt matter
			if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Dark"  then
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if  spell.name == 'Tachi: Goten' then
				-- Double weather not earths day
			if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Earth" then
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if  spell.name == 'Tachi: Jinpu' or spell.name == 'Aeolian Edge' then
				-- Double weather not ice day
			if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Ice" then
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if  spell.name == 'Blade: Chi' then
				-- Double weather not winds day
			if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Wind" then
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if  spell.name == 'Blade: To' then
				-- Double weather not fire day
			if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Fire" then
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if  spell.name == 'Blade: Teki' or spell.name == 'Blade: Yu'then
				-- Double weather not lightning day
			if spell.element == world.weather_element and get_weather_intensity() == 2 and world.day_element ~= "Lightning" then
				equip(sets.midcast.Obi)
			else
				equip(sets.midcast.Orpheus)                
			end
		end
		if (subWeapon=='Hitaki' and player.TP > 1700) or (mainWeapon=='Heishi Shorinken' and player.TP > 2200) or player.TP > 2700 then
			equip(sets.mtp[spell.name])
		end
		if (subWeapon=='Hitaki' and player.TP > 1900) or (mainWeapon=='Heishi Shorinken' and player.TP > 2400) or player.TP > 2900 then
			equip(sets.htp[spell.name])
		end
		
			

    end
    

end

function aftercast(spell) 

    -- Then initiate idle function to check which set should be equipped
    update_active_ja()
    idle()
end

function idle()
    -- This function is called after every action, and handles which set to equip depending on what we're doing
    -- We check if we're meleeing because we don't want to idle in melee gear when we're only engaged for trusts
    if player.status=='Engaged' then
		if mainWeapon.current == 'Hachimonji' then
			equip(sets.me.melee[meleeModes.value..'gk'])
		elseif subWeapon.current == 'Hitaki' then
			equip(sets.me.melee[meleeModes.value..'tp'])
		elseif subWeapon.current == 'Tsuru' then
			equip(sets.me.melee[meleeModes.value..'tsu'])
		else
			equip(sets.me.melee[meleeModes.value..'nor'])

		end

    else
        equip(sets.me.idle[idleModes.value])
        -- Checks MP for Fucho-no-Obi, I removed because either I need the dt or I'm fine full timing it in idle
        --[[if player.mpp < 51 then
            equip(sets.me.latent_refresh)          
        end]]
    end
	if mainWeapon.current == 'Fudo Masamune B' then
		equip({main ={name="Fudo Masamune", bag="wardrobe3"}})
		if subWeapon.current == 'Fudo Masamune C' then
			equip({sub ={name="Fudo Masamune", bag="wardrobe4"}})
		elseif subWeapon.current == 'Fudo Masamune B' then 
			equip({sub ={name="Fudo Masamune", bag="wardrobe4"}})		
		else
			equip({sub = subWeapon.current})
		end
	elseif mainWeapon.current == 'Fudo Masamune C' then
		equip({main ={name="Fudo Masamune", bag="wardrobe4"}})
		if subWeapon.current == 'Fudo Masamune B' then
			equip({sub ={name="Fudo Masamune", bag="wardrobe3"}})
		elseif subWeapon.current == 'Fudo Masamune C' then
			equip({sub ={name="Fudo Masamune", bag="wardrobe3"}})
		else
			equip({sub = subWeapon.current})
		end
	elseif mainWeapon.current == 'Hachimonji' then
		equip({main = mainWeapon.current})
		equip({sub = "Rigorous Grip +1"})
	else
		equip({main = mainWeapon.current})
		if subWeapon.current == 'Fudo Masamune B' then
			equip({sub ={name="Fudo Masamune", bag="wardrobe3"}})
		elseif subWeapon.current == 'Fudo Masamune C' then
			equip({sub ={name="Fudo Masamune", bag="wardrobe4"}})
		else
			equip({sub = subWeapon.current})
		end
	end
end
 


function status_change(new,old)
    if new == 'Engaged' then  
        -- If we engage check our meleeing status
        idle()
         
    elseif new=='Resting' then
     
        -- We're resting
        equip(sets.me.resting)          
    else
        idle()
    end
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
                idle()
                if use_UI == true then
                    validateTextInformation()
                else
                    windower.add_to_chat(4,"----- Idle mode Now focus on: "..tostring(idleModes.value))
                end
            elseif commandArgs[2] == 'meleemode' then
                meleeModes:cycle()
                idle()
                if use_UI == true then
                    validateTextInformation()
                else
                    windower.add_to_chat(4,"----- Idle mode Now focus on: "..tostring(idleModes.value))
                end
			elseif commandArgs[2] == 'mainweapon' then
                mainWeapon:cycle()
                idle()
                if use_UI == true then
                    validateTextInformation()
                else
                    windower.add_to_chat(4,"----- Main Weapon set now: "..tostring(mainWeapon.value))
                end
			elseif commandArgs[2] == 'subweapon' then
                subWeapon:cycle()
                idle()
                if use_UI == true then
                    validateTextInformation()
                else
                    windower.add_to_chat(4,"----- Sub Weapons set now: "..tostring(subWeapon.value))
                end
            elseif commandArgs[2] == 'nukemode' then
                nukeModes:cycle()               
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(8,"----- Nuking Mode is now: "..tostring(nukeModes.current)) 
                end   
            elseif commandArgs[2] == 'matchsc' then
                matchsc:toggle()               
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(8,"----- Matching SC Mode is now: "..tostring(matchsc.current)) 
                end
			elseif commandArgs[2] == 'rune' then -- gs toggle rune
                    runes:cycle()
                if use_UI == true then                    
                    validateTextInformation()
                else
                    windower.add_to_chat(211,'Rune is now set to: '..tostring(runes.current))
                end 
            end
        end
        
        if commandArgs[1]:lower() == 'scholar' then
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
			elseif nuke == 'rune' then
				send_command('@input /ja "'..nukes[nuke][runes.current]..'"')
            else        
                -- Leave out target; let Shortcuts auto-determine it.
                --recast = windower.ffxi.get_spell_recasts(nukes[nuke][elements.current])
                --if recast > 0 
                send_command('@input /ma "'..nukes[nuke][elements.current]..'"')     
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
        enable('ammo')
        if use_UI == true then
            validateTextInformation()
        else
            windower.add_to_chat(8,'----- Ammo Unlocked, WILL BLINK -----')
        end
        idle()
    else
        disable('ammo')
        if use_UI == true then
            validateTextInformation()
        else
            windower.add_to_chat(8,'----- Ammo Locked, WILL NOT BLINK -----')
        end
        idle()
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
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then

	windower.register_event('action', function(act)
		for _, target in pairs(act.targets) do
			local battle_target = windower.ffxi.get_mob_by_target("t")
			if battle_target ~= nil and target.id == battle_target.id then
				for _, action in pairs(target.actions) do
					if ((action.add_effect_message > 287 and action.add_effect_message < 302) or action.add_effect_message == 767 or action.add_effect_message == 768) then
						last_skillchain = skillchains[action.add_effect_message]
						mBurstOldValue = mBurst.value
						MB_Window = 11
						MB_Time = os.time()
						validateTextInformation()
					end
				end
			end
		end
	end)

	--[[mov = {counter=0}
	if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
		mov.x = windower.ffxi.get_mob_by_index(player.index).x
		mov.y = windower.ffxi.get_mob_by_index(player.index).y
		mov.z = windower.ffxi.get_mob_by_index(player.index).z
	end
	moving = false

	windower.raw_register_event('prerender',function()
		mov.counter = 0--mov.counter + 1;
		if mov.counter>30 then
			local pl = windower.ffxi.get_mob_by_index(player.index)
			if pl and pl.x and mov.x then
				local movement = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 ) > 0.1
				if movement and not moving then
					send_command('gs c toggle runspeed')
					moving = true
				elseif not movement and moving then
					send_command('gs c toggle runspeed')
					moving = false
				end
			end

			if pl and pl.x then
				mov.x = pl.x
				mov.y = pl.y
				mov.z = pl.z
			end
			mov.counter = 0
		end
	end)]]

	windower.register_event('prerender', function()
		--Items we want to check every second
		if os.time() > time_start then
			time_start = os.time()
			--auto_cp()
			if MB_Window > 0 then
				MB_Window = 11 - (os.time() - MB_Time)
				if matchsc.value then
					selectSCElement()
					mBurst:set(true)
				end
				validateTextInformation()
			else
				elements:set(oldElement)
				mBurst:set(false)
				validateTextInformation()
			end
		end
	end)

	function movingCheck()

	end

	function auto_cp()

	--Now we check if we need to lock our back for CP
	--[[if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
			jobpoints = windower.ffxi.get_player().job_points[player.main_job:lower()].jp_spent -- check if we are master
		end
		if jobpoints ~= 2100 and jobpoints ~= nil then -- Basically if not master
			monsterToCheck = windower.ffxi.get_mob_by_target('t')
			if windower.ffxi.get_mob_by_target('t') then -- Sanity Check 
				if #monsterToCheck.name:split(' ') >= 2 then
					monsterName = T(monsterToCheck.name:split(' '))
					if monsterName[1] == "Apex" then
						if monsterToCheck.hpp < 15 then --Check mobs HP Percentage if below 25 then equip CP cape 
							equip({ back = CP_CAPE }) 
							disable("back") --Lock back
						else
							enable("back") --Else make sure the back is enabled
						end 
					end
				end
			else
				enable("back") --Else make sure the back is enabled
			end
		else
			enable("back") --Else make sure the back is enabled
		end]]
	end
end

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
	local spellMap = get_spell_map(spell)

    if spellMap == 'ElementalNinjutsu'  then   
		if spell.name == nukes.t3[elements.current] then
            newspell = nukes.t2[elements.current]
        elseif spell.name == nukes.t2[elements.current] then
            newspell = nukes.t1[elements.current]
		elseif spell.name == nukes.t1[elements.current] then
			newspell = ""--prevents it going endless
        end
        send_command('input /ma "'..newspell..'"')
    end

end
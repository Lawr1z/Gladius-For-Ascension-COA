local L = LibStub("AceLocale-3.0"):GetLocale("Gladius", true)

local function BuildSpellNameMap(spells)
	local result = {}
	for spellId, value in pairs(spells) do
		local name = GetSpellInfo(spellId)
		if name then result[name] = value end
	end
	return result
end

-- Spec-specific buffs
-- Strings are self-buffs only. That unit is that spec.
-- Tables are for castable talent buffs or auras.
function Gladius:GetSpecBuffList()
	return BuildSpellNameMap({
		-- WARRIOR
		[56638]	= L["Arms"],			-- Taste for Blood
		[64976]	= L["Arms"],			-- Juggernaut
		[29801]	= L["Fury"],			-- Rampage
		[50227]	= L["Protection"],		-- Sword and Board
		-- PALADIN
		[20375]	= L["Retribution"],		-- If you are using Seal of Command, I hate you so much
		[31836]	= L["Holy"],			-- Light's Grace
		-- ROGUE
		[36554]	= L["Subtlety"],		-- Shadowstep
		[31223]	= L["Subtlety"],		-- Master of Subtlety
		-- PRIEST
		[47788]	= L["Holy"],			-- Guardian Spirit
		[52800]	= L["Discipline"],		-- Borrowed Time
		[15473]	= L["Shadow"],			-- Shadowform
		[15286]	= L["Shadow"],			-- Vampiric Embrace
		-- DEATHKNIGHT
		[49222]	= L["Unholy"],			-- Bone Shield
		[49016]	= L["Blood"],			-- Hysteria
		[53138]	= L["Blood"],			-- Abomination's Might
		[55610]	= L["Frost"],			-- Imp. Icy Talons
		-- MAGE
		[43039]	= L["Frost"],			-- Ice Barrier
		[11129]	= L["Fire"],			-- Combustion
		[31583]	= L["Arcane"],			-- Arcane Empowerment
		-- WARLOCK
		[30302]	= L["Destruction"],		-- Nether Protection
		-- SHAMAN
		[57663]	= L["Elemental"],		-- Totem of Wrath
		[49284]	= L["Restoration"],		-- Earth Shield
		[51470]	= L["Elemental"],		-- Elemental Oath
		[30809]	= L["Enhancement"],		-- Unleashed Rage
		-- HUNTER
		[20895]	= L["Beast Mastery"],	-- Spirit Bond
		[19506]	= L["Marksmanship"],	-- Trueshot Aura
		-- DRUID
		[24932]	= L["Feral"],			-- Leader of the Pack
		[34123]	= L["Restoration"],		-- Tree of Life
		[24907]	= L["Balance"],			-- Moonkin Aura
		[53251]	= L["Restoration"],		-- Wild Growth
	})
end

-- Spec-specific abilities
-- If someone uses that ability, they are that spec.
function Gladius:GetSpecSpellList()
	return BuildSpellNameMap({
		-- WARRIOR
		[47486]	= L["Arms"],			-- Mortal Strike
		[46924]	= L["Arms"],			-- Bladestorm
		[23881]	= L["Fury"],			-- Bloodthirst
		[12809]	= L["Protection"],		-- Concussion Blow
		[47498]	= L["Protection"],		-- Devastate
		-- PALADIN
		[48827]	= L["Protection"],		-- Avenger's Shield
		[48825]	= L["Holy"],			-- Holy Shock
		[35395]	= L["Retribution"],		-- Crusader Strike
		[53385]	= L["Retribution"],		-- Divine Storm
		[20066]	= L["Retribution"],		-- Repentance
		-- ROGUE
		[48666]	= L["Assassination"],	-- Mutilate
		[51690]	= L["Combat"],			-- Killing Spree
		[13877]	= L["Combat"],			-- Blade Flurry
		[13750]	= L["Combat"],			-- Adrenaline Rush
		[48660]	= L["Subtlety"],		-- Hemorrhage
		-- PRIEST
		[53007]	= L["Discipline"],		-- Penance
		[10060]	= L["Discipline"],		-- Power Infusion
		[33206]	= L["Discipline"],		-- Pain Suppression
		[34861]	= L["Holy"],			-- Circle of Healing
		[15487]	= L["Shadow"],			-- Silence
		[48160]	= L["Shadow"],			-- Vampiric Touch	
		-- DEATHKNIGHT
		[55262]	= L["Blood"],			-- Heart Strike
		[49203]	= L["Frost"],			-- Hungering Cold
		[55268]	= L["Frost"],			-- Frost Strike
		[51411]	= L["Frost"],			-- Howling Blast
		[55271]	= L["Unholy"],			-- Scourge Strike
		-- MAGE
		[44781]	= L["Arcane"],			-- Arcane Barrage
		[55360]	= L["Fire"],			-- Living Bomb
		[42950]	= L["Fire"],			-- Dragon's Breath
		[42945]	= L["Fire"],			-- Blast Wave
		[44572]	= L["Frost"],			-- Deep Freeze
		-- WARLOCK
		[59164]	= L["Affliction"],		-- Haunt
		[47843]	= L["Affliction"],		-- Unstable Affliction
		[59672]	= L["Demonology"],		-- Metamorphosis
		[59172]	= L["Destruction"],		-- Chaos Bolt
		[47847]	= L["Destruction"],		-- Shadowfury
		-- SHAMAN
		[59159]	= L["Elemental"],		-- Thunderstorm
		[16166]	= L["Elemental"],		-- Elemental Mastery
		[51533]	= L["Enhancement"],		-- Feral Spirit
		[30823]	= L["Enhancement"],		-- Shamanistic Rage
		[17364]	= L["Enhancement"],		-- Stormstrike
		[61301]	= L["Restoration"],		-- Riptide
		[51886]	= L["Restoration"],		-- Cleanse Spirit
		-- HUNTER
		[19577]	= L["Beast Mastery"],	-- Intimidation
		[34490]	= L["Marksmanship"],	-- Silencing Shot
		[53209]	= L["Marksmanship"],	-- Chimera Shot
		[60053]	= L["Survival"],		-- Explosive Shot
		[49012]	= L["Survival"],		-- Wyvern Sting
		-- DRUID
		[53201]	= L["Balance"],			-- Starfall
		[61384]	= L["Balance"],			-- Typhoon
		[48566]	= L["Feral"],			-- Mangle (Cat)
		[48564]	= L["Feral"],			-- Mangle (Bear)
		[18562]	= L["Restoration"],		-- Swiftmend
	})
end
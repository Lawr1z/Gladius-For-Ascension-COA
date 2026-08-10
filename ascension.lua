--[[
  Gladius — Project Ascension / Conquest of Azeroth (Vol'jin)
  -----------------------------------------------------------------------
  Classes: official mapping from db.ascension.gg (g_chr_classes).
  Spells: scraped from class skill lists + mechanic verification where
  the DB exposes Mechanic / StunMechanic / Rooted / etc.

  IMPORTANT
  - UnitClass() tokens MUST match the client. Verify with:
      /run local a,b=UnitClass("target"); print(a, b)
  - If a token differs (e.g. KNIGHT_OF_XOROTH), add an alias entry.
  - Name-matched spells without a confirmed mechanic are marked -- UNVERIFIED
    and still tracked (safe: GetSpellInfo nil = skipped at merge).
  - /gladius dumpclass  — print your UnitClass tokens
]]

local L = LibStub("AceLocale-3.0"):GetLocale("Gladius", true)

local QUESTION_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

---------------------------------------------------------------------------
-- 1) ALL CoA CLASSES (db class id → token)
--    IDs: 12–32 from https://db.ascension.gg g_chr_classes
---------------------------------------------------------------------------
Gladius.AscensionClasses = {
	-- id 12
	["BARBARIAN"] = {
		name = "Barbarian", dbId = 12,
		color = { r = 0.78, g = 0.61, b = 0.43 },
		icon = "Interface\\Icons\\Ability_Warrior_Rampage",
		specs = { "Ancestry", "Brutality", "Headhunting" },
	},
	-- id 13
	["WITCHDOCTOR"] = {
		name = "Witch Doctor", dbId = 13,
		color = { r = 0.45, g = 0.75, b = 0.35 },
		icon = "Interface\\Icons\\Spell_Nature_Polymorph",
		specs = { "Brewing", "Voodoo", "Shadowhunting" },
	},
	-- id 14
	["FELSWORN"] = {
		name = "Felsworn", dbId = 14,
		color = { r = 0.55, g = 0.80, b = 0.25 },
		icon = "Interface\\Icons\\Ability_Warlock_DemonicEmpowerment",
		specs = { "Slaying", "Infernal", "Tyrant" },
	},
	-- id 15
	["WITCHHUNTER"] = {
		name = "Witch Hunter", dbId = 15,
		color = { r = 0.70, g = 0.35, b = 0.15 },
		icon = "Interface\\Icons\\Ability_Hunter_MarkedForDeath",
		specs = { "Boltslinger", "Darkness", "Black Knight" },
	},
	-- id 16
	["STORMBRINGER"] = {
		name = "Stormbringer", dbId = 16,
		color = { r = 0.35, g = 0.55, b = 0.95 },
		icon = "Interface\\Icons\\Spell_Nature_Lightning",
		specs = { "Lightning", "Thunder", "Winds" },
	},
	-- id 17
	["KNIGHTOFXOROTH"] = {
		name = "Knight of Xoroth", dbId = 17,
		color = { r = 0.85, g = 0.25, b = 0.10 },
		icon = "Interface\\Icons\\Spell_Fire_FelImmolation",
		specs = { "War", "Hellfire", "Defiance" },
	},
	-- id 18
	["GUARDIAN"] = {
		name = "Guardian", dbId = 18,
		color = { r = 0.80, g = 0.70, b = 0.45 },
		icon = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
		specs = { "Gladiator", "Vanguard", "Inspiration" },
	},
	-- id 19
	["TEMPLAR"] = {
		name = "Templar", dbId = 19,
		color = { r = 0.95, g = 0.90, b = 0.60 },
		icon = "Interface\\Icons\\Spell_Holy_SealOfMight",
		specs = { "Crusader", "Martial", "Discipline" },
	},
	-- id 20
	["BLOODMAGE"] = {
		name = "Bloodmage", dbId = 20,
		color = { r = 0.75, g = 0.10, b = 0.20 },
		icon = "Interface\\Icons\\Spell_Shadow_LifeDrain",
		specs = { "Fleshweaver", "Sanguine", "Accursed", "Eternal" },
	},
	-- id 21
	["RANGER"] = {
		name = "Ranger", dbId = 21,
		color = { r = 0.55, g = 0.70, b = 0.35 },
		icon = "Interface\\Icons\\Ability_Hunter_RunningShot",
		specs = { "Archery", "Brigand", "Farstrider" },
	},
	-- id 22
	["CHRONOMANCER"] = {
		name = "Chronomancer", dbId = 22,
		color = { r = 0.40, g = 0.70, b = 0.90 },
		icon = "Interface\\Icons\\Spell_Arcane_PortalDarnassus",
		specs = { "Duality", "Artificer", "Displacement" },
	},
	-- id 23
	["NECROMANCER"] = {
		name = "Necromancer", dbId = 23,
		color = { r = 0.35, g = 0.70, b = 0.45 },
		icon = "Interface\\Icons\\Spell_Shadow_AnimateDead",
		specs = { "Animation", "Rime", "Death" },
	},
	-- id 24
	["PYROMANCER"] = {
		name = "Pyromancer", dbId = 24,
		color = { r = 0.95, g = 0.45, b = 0.10 },
		icon = "Interface\\Icons\\Spell_Fire_Fireball02",
		specs = { "Incineration", "Draconic", "Flameweaving" },
	},
	-- id 25
	["CULTIST"] = {
		name = "Cultist", dbId = 25,
		color = { r = 0.55, g = 0.25, b = 0.75 },
		icon = "Interface\\Icons\\Spell_Shadow_Shadowfiend",
		specs = { "Godblade", "Corruption", "Influence", "Dreadnought" },
	},
	-- id 26
	["STARCALLER"] = {
		name = "Starcaller", dbId = 26,
		color = { r = 0.55, g = 0.60, b = 0.95 },
		icon = "Interface\\Icons\\Spell_Arcane_StarFire",
		specs = { "Warden", "Sentinel", "Moon Priest", "Moon Guard" },
	},
	-- id 27
	["SUNCLERIC"] = {
		name = "Sun Cleric", dbId = 27,
		color = { r = 1.00, g = 0.82, b = 0.20 },
		icon = "Interface\\Icons\\Spell_Holy_HolyBolt",
		specs = { "Piety", "Seraphim", "Blessings", "Valkyrie" },
	},
	-- id 28
	["TINKER"] = {
		name = "Tinker", dbId = 28,
		color = { r = 0.80, g = 0.65, b = 0.20 },
		icon = "Interface\\Icons\\INV_Gizmo_02",
		specs = { "Demolition", "Mechanics", "Invention" },
	},
	-- id 29
	["VENOMANCER"] = {
		name = "Venomancer", dbId = 29,
		color = { r = 0.40, g = 0.75, b = 0.30 },
		icon = "Interface\\Icons\\Ability_PoisonSting",
		specs = { "Rot", "Vizier", "Stalking", "Fortitude" },
	},
	-- id 30
	["REAPER"] = {
		name = "Reaper", dbId = 30,
		color = { r = 0.50, g = 0.15, b = 0.20 },
		icon = "Interface\\Icons\\INV_Axe_113",
		specs = { "Harvest", "Soul", "Domination" },
	},
	-- id 31
	["PRIMALIST"] = {
		name = "Primalist", dbId = 31,
		color = { r = 0.30, g = 0.80, b = 0.40 },
		icon = "Interface\\Icons\\Ability_Druid_NaturalPerfection",
		specs = { "Geomancy", "Mountain King", "Wildwalker", "Life" },
	},
	-- id 32
	["RUNEMASTER"] = {
		name = "Runemaster", dbId = 32,
		color = { r = 0.50, g = 0.55, b = 0.85 },
		icon = "Interface\\Icons\\Spell_Deathknight_DarkConviction",
		specs = { "Spellslinger", "Riftblade", "Conjuration" },
	},
}

-- Optional aliases if the client returns a different token
Gladius.AscensionClassAliases = {
	["KNIGHT_OF_XOROTH"] = "KNIGHTOFXOROTH",
	["SUN_CLERIC"] = "SUNCLERIC",
	["WITCH_DOCTOR"] = "WITCHDOCTOR",
	["WITCH_HUNTER"] = "WITCHHUNTER",
	["BLOOD_MAGE"] = "BLOODMAGE",
	["STAR_CALLER"] = "STARCALLER",
}

Gladius.AscensionFallbackClass = {
	name = "Unknown",
	color = { r = 0.70, g = 0.70, b = 0.70 },
	icon = QUESTION_ICON,
}

---------------------------------------------------------------------------
-- 2) AURAS — priority 3 = hard CC, 2 = immunity, 1 = soft CC / utility
--    IDs from db.ascension.gg class skill scrapes (Vol'jin / CoA).
---------------------------------------------------------------------------
Gladius.AscensionAuras = {
	-- ===== CONFIRMED mechanic on DB page =====
	[804198] = 3, -- Terrify (Bloodmage) — Mechanic: Horrified
	[802309] = 3, -- Net Throw (Guardian) — Mechanic: Rooted
	[500326] = 3, -- Bonefreeze (Necromancer) — Frozen
	[501959] = 3, -- Bonefreeze (max rank candidate)
	[504409] = 3, -- Hex of Quetz'lun (Witch Doctor) — Frozen
	[560963] = 3, -- Shackle The Unrepentant (Templar) — Banished
	[800887] = 3, -- Spindlebind (Venomancer) — Root
	[803185] = 3, -- Chains of Malice (Knight of Xoroth) — Stun/Root
	[801908] = 3, -- Petrifying Visage (Pyromancer) — Stun/Horror
	[805476] = 3, -- Cindergrip (Pyromancer) — Root
	[801295] = 3, -- Slow Time (Chronomancer) — Pacified
	[804861] = 1, -- Anti-Magic Grenades (Tinker) — Silence

	-- ===== HIGH-CONFIDENCE by name + class identity (UNVERIFIED mechanic) =====
	[802229] = 3, -- Time Out! (Chronomancer)
	[706089] = 3, -- Improved Time Stop (Chronomancer)
	[704680] = 3, -- Freeze Dry (Necromancer)
	[805425] = 3, -- Shard of True Ice (Necromancer)
	[806157] = 3, -- Freeze Ray (Tinker)
	[800876] = 3, -- Web Wrap (Venomancer)
	[704150] = 3, -- Light Nets (Guardian)
	[804597] = 3, -- Binding Shock (Stormbringer)
	[805107] = 3, -- Earthmother's Binding (Primalist)
	[800145] = 3, -- Grip (Primalist)
	[802231] = 3, -- Traprune: Stunning Glyph (Runemaster)
	[705549] = 1, -- Silence In The Cage (Runemaster)
	[800416] = 3, -- Horrorbolt (Cultist)
	[560977] = 3, -- Twilight Horror (Cultist)
	[704870] = 3, -- Cosmic Horror (Cultist)
	[800432] = 1, -- Psychic Suppression (Cultist)
	[800782] = 3, -- Blood Howl (Bloodmage)
	[804207] = 3, -- Wicked Howl (Bloodmage)
	[804811] = 3, -- Monstrous Howl (Bloodmage)
	[806177] = 3, -- Shadow Howl (Bloodmage)
	[501686] = 3, -- Night Hunter's Howl (Bloodmage)
	[501152] = 3, -- Hex of Night (Witch Doctor)
	[501228] = 3, -- Hexing Strike (Witch Doctor)
	[704495] = 3, -- Hexplosion (Witch Doctor)
	[704497] = 3, -- Soul Marionette (Witch Doctor)
	[801435] = 3, -- Knockout (Ranger)
	[805811] = 3, -- Blind Stupor (Barbarian)
	[705196] = 3, -- Knockout Artist (Barbarian)
	[705131] = 3, -- Fel Daze (Felsworn)
	[801457] = 3, -- Binding Scripture (Templar)
	[704640] = 3, -- Binding Torment (Bloodmage)
	[705897] = 3, -- Trapped Spirits (Witch Doctor)
	[804728] = 3, -- Powerful Grip (Barbarian)
}

---------------------------------------------------------------------------
-- 3) DIMINISHING RETURNS
---------------------------------------------------------------------------
Gladius.AscensionDR = {
	-- Confirmed / high confidence
	[804198] = "HORROR",            -- Terrify
	[560977] = "HORROR",            -- Twilight Horror
	[704870] = "HORROR",            -- Cosmic Horror
	[800416] = "HORROR",            -- Horrorbolt
	[800782] = "FEAR",              -- Blood Howl
	[804207] = "FEAR",              -- Wicked Howl
	[804811] = "FEAR",              -- Monstrous Howl
	[806177] = "FEAR",              -- Shadow Howl
	[501686] = "FEAR",              -- Night Hunter's Howl

	[802309] = "CONTROLLEDROOT",    -- Net Throw
	[800887] = "CONTROLLEDROOT",    -- Spindlebind
	[800876] = "CONTROLLEDROOT",    -- Web Wrap
	[704150] = "CONTROLLEDROOT",    -- Light Nets
	[805476] = "CONTROLLEDROOT",    -- Cindergrip
	[804597] = "CONTROLLEDROOT",    -- Binding Shock
	[805107] = "CONTROLLEDROOT",    -- Earthmother's Binding
	[800145] = "CONTROLLEDROOT",    -- Grip
	[803185] = "CONTROLLEDROOT",    -- Chains of Malice (also stun-ish; root DR safer default)

	[500326] = "CONTROLLEDROOT",    -- Bonefreeze (Frozen → treat as root DR in WotLK-style)
	[501959] = "CONTROLLEDROOT",    -- Bonefreeze
	[704680] = "CONTROLLEDROOT",    -- Freeze Dry
	[805425] = "CONTROLLEDROOT",    -- Shard of True Ice
	[806157] = "CONTROLLEDROOT",    -- Freeze Ray
	[504409] = "DISORIENT",         -- Hex of Quetz'lun
	[501152] = "DISORIENT",         -- Hex of Night
	[501228] = "DISORIENT",         -- Hexing Strike
	[704495] = "DISORIENT",         -- Hexplosion

	[801908] = "CONTROLLEDSTUN",    -- Petrifying Visage
	[802231] = "CONTROLLEDSTUN",    -- Traprune: Stunning Glyph
	[801435] = "CONTROLLEDSTUN",    -- Knockout
	[705196] = "CONTROLLEDSTUN",    -- Knockout Artist
	[805811] = "DISORIENT",         -- Blind Stupor
	[705131] = "RANDOMSTUN",        -- Fel Daze

	[560963] = "BANISH",            -- Shackle The Unrepentant
	[704497] = "MINDCONTROL",       -- Soul Marionette

	[801295] = "ASCENSION_TIMESTOP", -- Slow Time
	[802229] = "ASCENSION_TIMESTOP", -- Time Out!
	[706089] = "ASCENSION_TIMESTOP", -- Improved Time Stop

	[705549] = "SILENCE",           -- Silence In The Cage
	[804861] = "SILENCE",           -- Anti-Magic Grenades
	[800432] = "SILENCE",           -- Psychic Suppression

	[800204] = "CHARGE",            -- Felhoof Charge
	[804691] = "CHARGE",            -- Cavalry Charge
	[800144] = "CHARGE",            -- Spirit Charge
}

Gladius.AscensionDRCategories = {
	["ASCENSION_TIMESTOP"] = true,
	["ASCENSION_STUN"] = true,
	["ASCENSION_FEAR"] = true,
}

---------------------------------------------------------------------------
-- 4) INTERRUPTS + CLASS COOLDOWNS
---------------------------------------------------------------------------
Gladius.AscensionInterrupts = {
	-- Vanilla baselines (still useful on Ascension)
	[2139]  = 8,   -- Counterspell
	[1766]  = 5,   -- Kick (Rogue)
	[6552]  = 4,   -- Pummel
	[72]    = 6,   -- Shield Bash
	[57994] = 2,   -- Wind Shear
	[47528] = 4,   -- Mind Freeze
	[19647] = 6,   -- Spell Lock
	[34490] = 3,   -- Silencing Shot
	[47476] = 5,   -- Strangulate
	-- CoA
	[504120] = 5,  -- Kick (Templar) — UNVERIFIED lockout length; tune in-game
}

Gladius.AscensionCooldowns = {
	["BARBARIAN"] = {},
	["WITCHDOCTOR"] = {
		[504409] = 45,  -- Hex of Quetz'lun (estimate)
		[501152] = 45,  -- Hex of Night
	},
	["FELSWORN"] = {
		[800204] = 20,  -- Felhoof Charge
	},
	["WITCHHUNTER"] = {},
	["STORMBRINGER"] = {
		[804597] = 20,  -- Binding Shock
	},
	["KNIGHTOFXOROTH"] = {
		[803185] = 30,  -- Chains of Malice
	},
	["GUARDIAN"] = {
		[802309] = 30,  -- Net Throw
		[704150] = 30,  -- Light Nets
		[804691] = 20,  -- Cavalry Charge
	},
	["TEMPLAR"] = {
		[504120] = 10,  -- Kick
		[560963] = 30,  -- Shackle The Unrepentant
	},
	["BLOODMAGE"] = {
		[804198] = 30,  -- Terrify
		[800782] = 40,  -- Blood Howl
	},
	["RANGER"] = {
		[801435] = 20,  -- Knockout
	},
	["CHRONOMANCER"] = {
		[801295] = 60,  -- Slow Time
		[802229] = 60,  -- Time Out!
	},
	["NECROMANCER"] = {
		[501959] = 30,  -- Bonefreeze
		[704680] = 30,  -- Freeze Dry
	},
	["PYROMANCER"] = {
		[801908] = 45,  -- Petrifying Visage
		[805476] = 30,  -- Cindergrip
	},
	["CULTIST"] = {
		[800416] = 20,  -- Horrorbolt
		[560977] = 45,  -- Twilight Horror
		[800432] = 30,  -- Psychic Suppression
	},
	["STARCALLER"] = {},
	["SUNCLERIC"] = {},
	["TINKER"] = {
		[806157] = 30,  -- Freeze Ray
		[804861] = 30,  -- Anti-Magic Grenades
	},
	["VENOMANCER"] = {
		[800876] = 30,  -- Web Wrap
		[800887] = 30,  -- Spindlebind
	},
	["REAPER"] = {},
	["PRIMALIST"] = {
		[800145] = 30,  -- Grip
		[805107] = 30,  -- Earthmother's Binding
		[800144] = 20,  -- Spirit Charge
	},
	["RUNEMASTER"] = {
		[802231] = 30,  -- Traprune: Stunning Glyph
		[705549] = 45,  -- Silence In The Cage
	},
	-- Vanilla class tables stay intact; empty = no Ascension append
	["MAGE"] = {},
	["WARRIOR"] = {},
	["PRIEST"] = {},
	["ROGUE"] = {},
	["HUNTER"] = {},
	["WARLOCK"] = {},
	["SHAMAN"] = {},
	["PALADIN"] = {},
	["DRUID"] = {},
	["DEATHKNIGHT"] = {},
}

---------------------------------------------------------------------------
-- 5) SPEC DETECTION — fill as you confirm signature buffs/casts in-game
---------------------------------------------------------------------------
Gladius.AscensionSpecBuffs = {
	-- Example: [spellId] = "Rime",
}

Gladius.AscensionSpecSpells = {
	[501959] = "Rime",       -- Bonefreeze
	[800876] = "Stalking",   -- Web Wrap — adjust if wrong spec
	[802231] = "Conjuration",
	[801295] = "Displacement",
	[804198] = "Accursed",
	[504120] = "Martial",
}

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

local function SafeSpellName(spellId)
	if not spellId then return nil end
	return GetSpellInfo(spellId)
end

local function SafeSpellTexture(spellId)
	if not spellId then return QUESTION_ICON end
	local _, _, texture = GetSpellInfo(spellId)
	return texture or QUESTION_ICON
end

local function ResolveClassToken(class)
	if not class then return nil end
	if Gladius.AscensionClassAliases and Gladius.AscensionClassAliases[class] then
		return Gladius.AscensionClassAliases[class]
	end
	return class
end

function Gladius:GetClassColor(class)
	class = ResolveClassToken(class)
	if not class then
		local f = self.AscensionFallbackClass.color
		return f.r, f.g, f.b
	end
	local raid = RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]
	if raid then
		return raid.r, raid.g, raid.b
	end
	local custom = self.AscensionClasses and self.AscensionClasses[class]
	if custom and custom.color then
		return custom.color.r, custom.color.g, custom.color.b
	end
	local f = self.AscensionFallbackClass.color
	return f.r, f.g, f.b
end

function Gladius:SetClassIconTexture(texture, class)
	if not texture then return end
	class = ResolveClassToken(class)
	if class and CLASS_BUTTONS and CLASS_BUTTONS[class] then
		texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
		texture:SetTexCoord(unpack(CLASS_BUTTONS[class]))
		return
	end
	local custom = class and self.AscensionClasses and self.AscensionClasses[class]
	local path = (custom and custom.icon) or self.AscensionFallbackClass.icon or QUESTION_ICON
	texture:SetTexture(path)
	texture:SetTexCoord(0, 1, 0, 1)
end

function Gladius:InjectAscensionClassColors()
	if not RAID_CLASS_COLORS or not self.AscensionClasses then return end
	for token, data in pairs(self.AscensionClasses) do
		if data and data.color and not RAID_CLASS_COLORS[token] then
			RAID_CLASS_COLORS[token] = {
				r = data.color.r,
				g = data.color.g,
				b = data.color.b,
				colorStr = string.format("ff%02x%02x%02x",
					math.floor(data.color.r * 255),
					math.floor(data.color.g * 255),
					math.floor(data.color.b * 255)),
			}
		end
	end
	if self.AscensionClassAliases then
		for alias, real in pairs(self.AscensionClassAliases) do
			local src = RAID_CLASS_COLORS[real]
			if src and not RAID_CLASS_COLORS[alias] then
				RAID_CLASS_COLORS[alias] = src
			end
		end
	end
end

function Gladius:MergeAscensionData()
	self:InjectAscensionClassColors()

	self.cooldownSpells = self.cooldownSpells or {}
	if self.AscensionClasses then
		for token, _ in pairs(self.AscensionClasses) do
			if not self.cooldownSpells[token] then
				self.cooldownSpells[token] = {}
			end
		end
	end

	if self.AscensionCooldowns then
		for class, spells in pairs(self.AscensionCooldowns) do
			if not self.cooldownSpells[class] then
				self.cooldownSpells[class] = {}
			end
			for spellId, cd in pairs(spells) do
				self.cooldownSpells[class][spellId] = cd
				local spellName, _, texture = GetSpellInfo(spellId)
				if spellName then
					self.cooldownSpellIds[spellName] = spellId
					self.spellTextures[spellId] = texture
				end
			end
		end
	end

	if self.AscensionSpecBuffs then
		for spellId, spec in pairs(self.AscensionSpecBuffs) do
			local name = SafeSpellName(spellId)
			if name then self.specBuffs[name] = spec end
		end
	end
	if self.AscensionSpecSpells then
		for spellId, spec in pairs(self.AscensionSpecSpells) do
			local name = SafeSpellName(spellId)
			if name then self.specSpells[name] = spec end
		end
	end

	if self.AscensionDR then
		self.drSpells = self.drSpells or {}
		self.drSpellIds = self.drSpellIds or {}
		self.drSpellTextures = self.drSpellTextures or {}
		for spellId, spellType in pairs(self.AscensionDR) do
			self.drSpells[spellId] = spellType
			local spellName, _, texture = GetSpellInfo(spellId)
			if spellName then
				self.drSpellIds[spellName] = spellType
				self.drSpellTextures[spellName] = texture
			end
		end
	end

	if self.AscensionAuras then
		for spellId, priority in pairs(self.AscensionAuras) do
			local name = SafeSpellName(spellId)
			if name then
				if GladiusAuraList then
					GladiusAuraList[name] = priority
				end
				if self.db and self.db.profile and self.db.profile.auras then
					local found
					for _, aura in pairs(self.db.profile.auras) do
						if aura.name == name then
							aura.priority = priority
							found = true
							break
						end
					end
					if not found then
						table.insert(self.db.profile.auras, {
							name = name,
							priority = priority,
							deleted = false,
						})
					end
				end
			end
		end
		if self.ConvertAuraList then
			self:ConvertAuraList()
		end
	end
end

function Gladius:AscensionApplyInterruptLockout(unit, interruptSpellId)
	local button = self.buttons and self.buttons[unit]
	if not button or not button.castBar then return end

	local lockout = self.AscensionInterrupts and self.AscensionInterrupts[interruptSpellId]
	if not lockout or lockout <= 0 then return end

	local bar = button.castBar
	local texture = SafeSpellTexture(interruptSpellId)
	local name = SafeSpellName(interruptSpellId) or "Interrupted"

	bar.isCasting = nil
	bar.isChanneling = nil
	bar.isLockout = true
	bar.lockoutEnds = GetTime() + lockout
	bar:SetMinMaxValues(0, lockout)
	bar:SetValue(lockout)
	bar.icon:SetTexture(texture)
	bar.spellText:SetText(name .. " lockout")
	bar:SetStatusBarColor(0.8, 0.1, 0.1, 1)
end

-- /gladius dumpclass — print UnitClass tokens for player/target/arena1-5
function Gladius:DumpAscensionClasses()
	local function line(unit)
		if not UnitExists(unit) then return end
		local loc, token = UnitClass(unit)
		local resolved = ResolveClassToken(token)
		local known = resolved and self.AscensionClasses and self.AscensionClasses[resolved]
		print(string.format("|cff33ff99Gladius|r %s: %s / %s%s",
			unit, tostring(loc), tostring(token),
			known and (" [mapped: " .. known.name .. "]") or " |cffff6666[UNMAPPED]|r"))
	end
	print("|cff33ff99Gladius Ascension|r class token dump:")
	line("player")
	line("target")
	line("focus")
	for i = 1, 5 do line("arena" .. i) end
end

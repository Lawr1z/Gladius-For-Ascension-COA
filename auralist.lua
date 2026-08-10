local function BuildSpellNameMap(spells)
	local result = {}
	for spellId, value in pairs(spells) do
		local name = GetSpellInfo(spellId)
		if name then result[name] = value end
	end
	return result
end

function Gladius:GetAuraList()
	return BuildSpellNameMap({
		-- Spell Name			Priority (higher = more priority)
		-- Crowd control
		[33786] 	= 3, 	-- Cyclone
		[18658] 	= 3,	-- Hibernate
		[14309] 	= 3, 	-- Freezing Trap Effect
		[60210]	= 3,	-- Freezing arrow effect
		[6770]	= 3, 	-- Sap
		[2094]	= 3, 	-- Blind
		[5782]	= 3, 	-- Fear
		[47860]	= 3,	-- Death Coil Warlock
		[6358] 	= 3, 	-- Seduction
		[5484] 	= 3, 	-- Howl of Terror
		[5246] 	= 3, 	-- Intimidating Shout
		[8122] 	= 3,	-- Psychic Scream
		[12826] 	= 3,	-- Polymorph
		[28272] 	= 3,	-- Polymorph pig
		[28271] 	= 3,	-- Polymorph turtle
		[61305] 	= 3,	-- Polymorph black cat
		[61025] 	= 3,	-- Polymorph serpent
		[51514]	= 3,	-- Hex
		[18647]	= 3,	-- Banish
		
		-- Roots
		[53308] 	= 3, 	-- Entangling Roots
		[42917]	= 3,	-- Frost Nova
		[16979] 	= 3, 	-- Feral Charge
		[13809] 	= 1, 	-- Frost Trap
		
		-- Stuns and incapacitates
		[8983] 	= 3, 	-- Bash
		[1833] 	= 3,	-- Cheap Shot
		[8643] 	= 3, 	-- Kidney Shot
		[1776]	= 3, 	-- Gouge
		[44572]	= 3, 	-- Deep Freeze
		[49012]	= 3, 	-- Wyvern Sting
		[19503] 	= 3, 	-- Scatter Shot
		[49803]	= 3, 	-- Pounce
		[49802]	= 3, 	-- Maim
		[10308]	= 3, 	-- Hammer of Justice
		[20066] 	= 3, 	-- Repentance
		[46968] 	= 3, 	-- Shockwave
		[49203] 	= 3,	-- Hungering Cold
		[47481]	= 3,	-- Gnaw (dk pet stun)
		
		-- Silences
		[18469] 	= 1,	-- Improved Counterspell
		[15487] 	= 1, 	-- Silence
		[34490] 	= 1, 	-- Silencing Shot	
		[18425]	= 1,	-- Improved Kick
		[49916]	= 1,	-- Strangulate
		
		-- Disarms
		[676] 	= 1, 	-- Disarm
		[51722] 	= 1,	-- Dismantle
		[53359] 	= 1,	-- Chimera Shot - Scorpid	
				
		-- Buffs
		[1022] 	= 1,	-- Blessing of Protection
		[10278] 	= 1,	-- Hand of Protection
		[1044] 	= 1, 	-- Blessing of Freedom
		[2825] 	= 1, 	-- Bloodlust
		[32182] 	= 1, 	-- Heroism
		[33206] 	= 1, 	-- Pain Suppression
		[29166] 	= 1,	-- Innervate
		[18708]  	= 1,	-- Fel Domination
		[54428]	= 1,	-- Divine Plea
		[31821]	= 1,	-- Aura mastery
		
		-- Turtling abilities
		[871]		= 1,	-- Shield Wall
		[48707]	= 1,	-- Anti-Magic Shell
		[31224]	= 1,	-- Cloak of Shadows
		[19263]	= 1,	-- Deterrence
		
		-- Immunities
		[34692] 	= 2, 	-- The Beast Within
		[45438] 	= 2, 	-- Ice Block
		[642] 	= 2,	-- Divine Shield
	})
end
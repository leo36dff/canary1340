local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_FIREAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 0.6) + 7
	local max = (level / 5) + (maglevel * 1.4) + 17
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

rune:id(15)
rune:group("attack")
rune:name("fireball rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_FIREBALL_RUNE)
rune:runeId(3189)
rune:allowFarUse(true)
rune:charges(5)
rune:level(27)
rune:magicLevel(4)
rune:cooldown(1 * 1000)
rune:groupCooldown(0 * 1000)
rune:needTarget(false)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()

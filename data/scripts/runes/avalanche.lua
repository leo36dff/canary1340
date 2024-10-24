local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICEAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
combat:setArea(createCombatArea(AREA_CIRCLE3X3))

function onGetFormulaValues(player, level, maglevel)
    local min, max
    if player:getVocation():getId() == 3 or player:getVocation():getId() == 7 then -- paladin / royal paladin
        min = (level / 5) + (maglevel * 1.3) + 42
        max = (level / 5) + (maglevel * 2.4) + 90
    else
        min = (level / 5) + (maglevel * 2.3) + 42
        max = (level / 5) + (maglevel * 3.4) + 90
    end
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

rune:id(115)
rune:group("attack")
rune:name("avalanche rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_AVALANCHE_RUNE)
rune:runeId(3161)
rune:allowFarUse(true)
rune:charges(4)
rune:level(30)
rune:magicLevel(4)
rune:cooldown(1 * 1000)
rune:groupCooldown(0 * 1000)
rune:isBlocking(false) -- True = Solid / False = Creature
rune:register()

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_EXPLOSION)
combat:setParameter(COMBAT_PARAM_BLOCKARMOR, 1)
combat:setArea(createCombatArea(AREA_CIRCLE1X1))

function onGetFormulaValues(player, level, maglevel)
    local min, max
    if player:getVocation():getId() == 4 or player:getVocation():getId() == 8 then -- Se for Knight ou Elite Knight
        min = (level * 1.1) + (maglevel * 3.3) + 42
        max = (level * 1.3) + (maglevel * 6.4) + 90
    else
        min = (level / 5) + (maglevel * 4.3) + 42
        max = (level / 5) + (maglevel * 5.4) + 90
    end
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

rune:id(18)
rune:group("attack")
rune:name("explosion rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_EXPLOSION_RUNE)
rune:runeId(3200)
rune:allowFarUse(true)
rune:charges(6)
rune:level(31)
rune:magicLevel(6)
rune:cooldown(1 * 1000)
rune:groupCooldown(0 * 1000)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()

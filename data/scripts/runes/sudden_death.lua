local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_SUDDENDEATH)

function onGetFormulaValues(player, level, maglevel)
    local vocationId = player:getVocation():getId()
    local min, max

    if vocationId == 3 or vocationId == 7 then
        min = (level / 5) + (maglevel * 2.605) + 28
        max = (level / 5) + (maglevel * 3.395) + 46
    else
        min = (level / 5) + (maglevel * 4.605) + 28
        max = (level / 5) + (maglevel * 7.395) + 46
    end

    return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
	return combat:execute(creature, var)
end

rune:id(21)
rune:group("attack")
rune:name("sudden death rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_SUDDENDEATH_RUNE)
rune:runeId(3155)
rune:allowFarUse(true)
rune:charges(3)
rune:level(45)
rune:magicLevel(15)
rune:cooldown(1 * 1000)
rune:groupCooldown(0 * 1000)
rune:needTarget(true)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()

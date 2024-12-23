local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)
combat:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, 1)
combat:setParameter(COMBAT_PARAM_DISPEL, CONDITION_PARALYZE)

function onGetFormulaValues(player, level, maglevel)
    local min, max
    if player:getVocation():getId() == 4 or player:getVocation():getId() == 8 then -- Se for Knight ou Elite Knight
        min = (level * 2) + (maglevel * 7.3) + 42
        max = (level * 2) + (maglevel * 12.4) + 90
    else
        min = (level / 5) + (maglevel * 1.3) + 42
        max = (level / 5) + (maglevel * 2.4) + 90
    end
    return min, max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local rune = Spell("rune")

function rune.onCastSpell(creature, var, isHotkey)
    if Monster(var:getNumber(1073762188)) then
        creature:sendCancelMessage("Sorry, not possible.")
        creature:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    else
        return combat:execute(creature, var)
    end
end

rune:id(5)
rune:group("healing")
rune:name("ultimate healing rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_ULTIMATE_HEALING_RUNE)
rune:runeId(3160)
rune:allowFarUse(true)
rune:charges(1)
rune:level(8)
rune:magicLevel(4)
rune:cooldown(1 * 1000)
rune:groupCooldown(0 * 1000)
rune:isAggressive(false)
rune:needTarget(true)
rune:isBlocking(true) -- True = Solid / False = Creature
rune:register()

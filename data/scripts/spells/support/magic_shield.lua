local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, 0)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local condition = Condition(CONDITION_MANASHIELD)
	condition:setParameter(CONDITION_PARAM_TICKS, 180000)
	local player = creature:getPlayer()
	if player then
		local manaToShield = player:getMana()
		condition:setParameter(CONDITION_PARAM_MANASHIELD, manaToShield)
	end
	creature:addCondition(condition)
	return combat:execute(creature, var)
end

spell:name("Magic Shield")
spell:words("utamo vita")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "sorcerer;true", "master sorcerer;true", "paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_MAGIC_SHIELD)
spell:id(44)
spell:cooldown(14 * 1000)
spell:groupCooldown(0 * 1000)
spell:level(14)
spell:mana(50)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()

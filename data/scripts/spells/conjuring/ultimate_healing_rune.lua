local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 3160, 1)
end

spell:name("Ultimate Healing Rune")
spell:words("adura vita")
spell:group("support")
spell:vocation("druid;true", "elder druid;true")
spell:cooldown(10 * 1000)
spell:groupCooldown(0 * 1000)
spell:level(8)
spell:mana(100)
spell:soul(1)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()

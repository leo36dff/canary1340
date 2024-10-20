local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 3161, 4)
end

spell:name("Avalanche Rune")
spell:words("adori mas frigo")
spell:group("support")
spell:vocation("druid;true", "elder druid;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(0 * 1000)
spell:level(8)
spell:mana(120)
spell:soul(1)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 3200, 3)
end

spell:name("Explosion Rune")
spell:words("adevo mas hur")
spell:group("support")
spell:vocation("druid;true", "elder druid;true", "sorcerer;true", "master sorcerer;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(0 * 1000)
spell:level(8)
spell:mana(180)
spell:soul(1)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()

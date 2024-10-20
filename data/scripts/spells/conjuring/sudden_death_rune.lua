local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(3147, 3155, 1)
end

spell:name("Sudden Death Rune")
spell:words("adori vita vis")
spell:group("support")
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:cooldown(2 * 1000)
spell:groupCooldown(0 * 1000)
spell:level(15)
spell:mana(220)
spell:soul(1)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()

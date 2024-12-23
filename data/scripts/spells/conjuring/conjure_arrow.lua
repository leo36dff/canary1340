local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return creature:conjureItem(0, 3447, 10, CONST_ME_MAGIC_BLUE)
end

spell:name("Conjure Arrow")
spell:words("exevo con")
spell:group("support")
spell:vocation("paladin;true", "royal paladin;true")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_CONJURE_ARROW)
spell:id(51)
spell:cooldown(2 * 1000)
spell:groupCooldown(0 * 1000)
spell:level(8)
spell:mana(40)
spell:soul(1)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:needLearn(false)
spell:register()

local spell = Spell("instant")

-- IDs das guildhalls (exemplo, substitua com os IDs reais)
local guildhallIds = {2628, 2629, 2711, 2712, 2713, 2769, 2786, 2787, 2817, 2818, 2819, 2874, 2875, 2876, 2877, 2878, 2879, 2880, 2927, 2931, 2932, 3004, 3005, 3006, 3007, 3008, 3009, 3010, 3011, 3012, 3013, 3014, 3041, 3042, 3044, 3054, 3055, 3146, 3148, 3149, 3189, 3205, 3211, 3218, 3229, 3264, 3280, 3313, 3333, 3334, 3390, 3448, 3462, 3493, 3503, 3526, 3567, 3592, 3633, 3638, 3654, 3659, 3667, 3668, 3669}  -- Adicione os IDs das guildhalls do seu servidor

local function isGuildHall(house)
	return table.contains(guildhallIds, house:getId())
end

function spell.onCastSpell(player, variant)
	local house = player:getTile():getHouse()
	if not house then
		return false
	end

	-- Verifica se a house é uma guildhall
	if not isGuildHall(house) then
		player:sendCancelMessage("You can invite players only on a Guildhall.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if house:canEditAccessList(GUEST_LIST, player) then
		player:setEditHouse(house, GUEST_LIST)
		player:sendHouseWindow(house, GUEST_LIST)
	else
		player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	return true
end

spell:name("House Guest List")
spell:words("aleta sio")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_INVITE_GUESTS)
spell:isAggressive(false)
spell:register()

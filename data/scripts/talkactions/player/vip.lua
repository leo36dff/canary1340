local vip = TalkAction("!checkpremmium", "!premmium")

function vip.onSay(player, words, param)
	if not player:isVip() then
		local msg = "You do not have Premium Account on your account."
		player:sendCancelMessage(msg)
		player:sendTextMessage(MESSAGE_STATUS, msg)
	else
		CheckPremiumAndPrint(player, MESSAGE_STATUS)
	end
	return true
end

vip:groupType("normal")
vip:register()

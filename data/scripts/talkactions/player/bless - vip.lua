local bless = TalkAction("!bless")

function bless.onSay(player, words, param)
    if not player:isVip() then
        player:sendCancelMessage("You need to be PREMIUM to use this command.")
        return false
    end

    Blessings.BuyAllBlesses(player)
    return true
end

bless:groupType("normal")
bless:register()

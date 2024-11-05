local config = {
    max = 1,
    maxVip = 3,
    text = "ANTI-MC: Limited to 2 character for FREE ACCOUNTS or 4 for PREMIUM ACCOUNTS.",
    group_id = 1,  -- apply the limit to players with a group less than or equal to this id
    milliseconds_before_kick_to_read_popup = 3000 -- 9000 = 9 seconds
}

local accepted_ip_list = {"192.168.0.10"}

local function delayedKickPlayerMCLimit(cid)
    local player = Player(cid)
    if player then
        player:remove()
    else
    end
end

local antimc = CreatureEvent("AntiMC")

function antimc.onLogin(player)
    if player:getGroup():getId() <= config.group_id then
        local playerIp = Game.convertIpToString(player:getIp())
        if not isInArray(accepted_ip_list, playerIp) then
            if #getPlayersByIPAddress(player:getIp()) > config.max then
                player:popupFYI(config.text)
                addEvent(delayedKickPlayerMCLimit, config.milliseconds_before_kick_to_read_popup, player:getId())
            end
        else
            if #getPlayersByIPAddress(player:getIp()) > config.maxVip then
                player:popupFYI(config.text)
                addEvent(delayedKickPlayerMCLimit, config.milliseconds_before_kick_to_read_popup, player:getId())
            end
        end
    end
    return true
end

antimc:register()

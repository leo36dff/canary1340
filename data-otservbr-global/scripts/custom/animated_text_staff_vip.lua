local globalevent = GlobalEvent("staffvip")

local staffEffect = 50

function globalevent.onThink(interval)
    for _, player in ipairs(Game.getPlayers()) do
        local position = player:getPosition()
        if player:getGroup():getAccess() and not player:isInGhostMode() then
            player:say("ADMIN", TALKTYPE_MONSTER_SAY)
            position:sendMagicEffect(staffEffect)
        end
    end
    return true
end

globalevent:interval(2500)
globalevent:register()
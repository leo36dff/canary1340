local skillReq = Action()

local summonName = "Training Monk"

function skillReq.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local playerSummons = player:getSummons()
    local playerPosition = player:getPosition()

    if Tile(playerPosition):hasFlag(TILESTATE_PROTECTIONZONE) then
        return player:sendCancelMessage("You must not be in PZ!") 
    end

    -- Verificar se o jogador já tem um summon ativo
    for _, summon in pairs(playerSummons) do
        if summon:getName() == summonName then
            return player:sendCancelMessage("Trainer is already summoned.")
        end
    end

    -- Se não há um "training monk" invocado, criar um novo
    local summon = Game.createMonster(summonName, playerPosition)
    if summon then
        summon:setMaster(player)
        summon:setDropLoot(false)
        summon:registerEvent('SummonThink')
        item:remove(1)
    end

    return true
end

skillReq:id(3533)
skillReq:register()

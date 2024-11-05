local checkInterval = 300 -- segundos (5 minutos entre verificações)

local topMagicPlayers = {
    {playerId = 0, monsterId = 0, position = Position(32371, 32238, 6)},  -- Ajuste a posição onde o monstro será criado
}

local function setMonsterDefaultSettings(monster)
    monster:setName("Top Magic Player [Magic Level: ??]", "a top magic level placeholder creature")
    local outfit = monster:getOutfit()
    outfit.lookType = 0
    outfit.lookTypeEx = 2110
    monster:setOutfit(outfit)
end

local function createTopMagicScoreMonster(index)
    local monster = Game.createMonster("deer", topMagicPlayers[index].position, false, true)
    if monster then
        monster:setDropLoot(false)
        topMagicPlayers[index].monsterId = monster:getId()
        setMonsterDefaultSettings(monster)
    end
    return monster
end

local globalevent = GlobalEvent("onThink_showTopMagicPlayers")

function globalevent.onThink(interval)
    local onlinePlayers = Game.getPlayers()
    local players = {}
    local seenIds = {}
   
    for k, v in ipairs(topMagicPlayers) do
        local player = Player(v.playerId)
        if player and not seenIds[v.playerId] then
            table.insert(players, {magicLevel = player:getMagicLevel(), id = v.playerId})
            seenIds[v.playerId] = true
        else
            v.playerId = 0
        end
    end
   
    for _, player in pairs(onlinePlayers) do
        local playerId = player:getId()
        if not seenIds[playerId] and not player:getGroup():getAccess() then
            table.insert(players, {magicLevel = player:getMagicLevel(), id = playerId})
            seenIds[playerId] = true
        end
    end

    table.sort(players, function(a, b) return a.magicLevel > b.magicLevel end)
   
    for k, v in ipairs(topMagicPlayers) do
        local monster = Monster(v.monsterId)
        if players[k] then
            v.playerId = players[k].id
            local player = Player(v.playerId)
           
            if not monster then
                monster = createTopMagicScoreMonster(k)
            end
           
            if player and monster then
                local newName = string.format("%s [Magic Level: %s]", player:getName(), players[k].magicLevel)
                monster:setName(newName, "the current #" .. k .. " top magic level player " .. newName)
                local outfit = player:getOutfit()
                monster:setOutfit(outfit)
            end
        else
            if monster then
                setMonsterDefaultSettings(monster)
            end
        end
    end
    return true
end

globalevent:interval(checkInterval * 1000)
globalevent:register()

local globalevent = GlobalEvent("onStartup_showTopMagicPlayers")

function globalevent.onStartup()
    for k, v in ipairs(topMagicPlayers) do
        createTopMagicScoreMonster(k)
    end
    return true
end

globalevent:register()

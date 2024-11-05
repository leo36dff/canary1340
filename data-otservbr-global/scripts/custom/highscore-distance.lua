local checkInterval = 300 -- seconds (5 minutes entre verificações)

local topdistancePlayers = {
    {playerId = 0, monsterId = 0, position = Position(32367, 32235, 6)},  -- Ajuste a posição onde o monstro será criado
  }

local function setMonsterDefaultSettings(monster)
    monster:setName("Top distance Player [Skill: ??]", "a top distance skill placeholder creature")
    local outfit = monster:getOutfit()
    outfit.lookType = 0
    outfit.lookTypeEx = 2110
    monster:setOutfit(outfit)
end

local function createTopdistanceScoreMonster(index)
    local monster = Game.createMonster("deer", topdistancePlayers[index].position, false, true)
    if monster then
        monster:setDropLoot(false)
        topdistancePlayers[index].monsterId = monster:getId()
        setMonsterDefaultSettings(monster)
    end
    return monster
end

local globalevent = GlobalEvent("onThink_showTopdistancePlayers")

function globalevent.onThink(interval)
    local onlinePlayers = Game.getPlayers()
    local players = {}
    local seenIds = {}
   
    for k, v in ipairs(topdistancePlayers) do
        local player = Player(v.playerId)
        if player and not seenIds[v.playerId] then
            table.insert(players, {skillLevel = player:getSkillLevel(SKILL_distance), id = v.playerId})
            seenIds[v.playerId] = true
        else
            v.playerId = 0
        end
    end
   
    for _, player in pairs(onlinePlayers) do
        local playerId = player:getId()
        if not seenIds[playerId] and not player:getGroup():getAccess() then
            table.insert(players, {skillLevel = player:getSkillLevel(SKILL_distance), id = playerId})
            seenIds[playerId] = true
        end
    end

    table.sort(players, function(a, b) return a.skillLevel > b.skillLevel end)
   
    for k, v in ipairs(topdistancePlayers) do
        local monster = Monster(v.monsterId)
        if players[k] then
            v.playerId = players[k].id
            local player = Player(v.playerId)
           
            if not monster then
                monster = createTopdistanceScoreMonster(k)
            end
           
            if player and monster then
                local newName = string.format("%s [Skill: %s]", player:getName(), players[k].skillLevel)
                monster:setName(newName, "the current #" .. k .. " top distance skill player " .. newName)
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

local globalevent = GlobalEvent("onStartup_showTopdistancePlayers")

function globalevent.onStartup()
    for k, v in ipairs(topdistancePlayers) do
        createTopdistanceScoreMonster(k)
    end
    return true
end

globalevent:register()

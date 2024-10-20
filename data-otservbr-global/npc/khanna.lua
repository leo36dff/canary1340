local internalNpcName = "Khanna"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 0
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 138,
	lookHead = 59,
	lookBody = 70,
	lookLegs = 93,
	lookFeet = 76,
	lookAddons = 0,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "If you need runes, this is the market stall for you!" },
	{ text = "I'm selling magic equipment. Come and have a look." },
}

local itemsTable = {
	["runes"] = {
		
		
		{ itemName = "blank rune", clientId = 3147, buy = 20 },
		
		
		
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	},
	["wands"] = {
		
		
		
		
		{ itemName = "snakebite rod", clientId = 3066, buy = 500 },
		
		
		
		
		
		
		
		
		
		
		{ itemName = "wand of vortex", clientId = 3074, buy = 500 },
	},
	["exercise weapons"] = {






	},
	["creature products"] = {
		{ itemName = "bashmu fang", clientId = 36820, sell = 600 },
		{ itemName = "bashmu feather", clientId = 36820, sell = 350 },
		{ itemName = "bashmu tongue", clientId = 36820, sell = 400 },
		{ itemName = "blue goanna scale", clientId = 31559, sell = 230 },
		{ itemName = "crystal ball", clientId = 3076, buy = 650 },
		{ itemName = "fafnar symbol", clientId = 31443, sell = 950 },
		{ itemName = "goanna claw", clientId = 31561, sell = 950 },
		{ itemName = "goanna meat", clientId = 31560, sell = 190 },
		{ itemName = "lamassu hoof", clientId = 31441, sell = 330 },
		{ itemName = "lamassu horn", clientId = 31442, sell = 240 },
		{ itemName = "life crystal", clientId = 3061, sell = 85 },
		{ itemName = "lizard heart", clientId = 31340, sell = 530 },
		{ itemName = "manticore ear", clientId = 31440, sell = 310 },
		{ itemName = "manticore tail", clientId = 31439, sell = 220 },
		{ itemName = "mind stone", clientId = 3062, sell = 170 },
		{ itemName = "old girtablilu carapace", clientId = 36972, sell = 570 },
		{ itemName = "red goanna scale", clientId = 31558, sell = 270 },
		{ itemName = "scorpion charm", clientId = 36822, sell = 620 },
		{ itemName = "sphinx feather", clientId = 31437, sell = 470 },
		{ itemName = "sphinx tiara", clientId = 31438, sell = 360 },
	},
	["shields"] = {
		{ itemName = "spellbook", clientId = 3059, buy = 150 },
		{ itemName = "spellbook of enlightenment", clientId = 8072, sell = 4000 },
		{ itemName = "spellbook of lost souls", clientId = 8075, sell = 19000 },
		{ itemName = "spellbook of mind control", clientId = 8074, sell = 13000 },
		{ itemName = "spellbook of warding", clientId = 8073, sell = 8000 },
	},
	["others"] = {
		{ itemName = "spellwand", clientId = 651, sell = 299 },
	},
}

npcConfig.shop = {}
for _, categoryTable in pairs(itemsTable) do
	for _, itemTable in ipairs(categoryTable) do
		table.insert(npcConfig.shop, itemTable)
	end
end

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local items = {
	[VOCATION.BASE_ID.SORCERER] = 3074,
	[VOCATION.BASE_ID.DRUID] = 3066,
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local categoryTable = itemsTable[message:lower()]
	local itemId = items[player:getVocation():getBaseId()]
	if MsgContains(message, "first rod") or MsgContains(message, "first wand") then
		if player:isMage() then
			if player:getStorageValue(Storage.FirstMageWeapon) == -1 then
				npcHandler:say("So you ask me for a {" .. ItemType(itemId):getName() .. "} to begin your adventure?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			else
				npcHandler:say("What? I have already gave you one {" .. ItemType(itemId):getName() .. "}!", npc, creature)
			end
		else
			npcHandler:say("Sorry, you aren't a druid either a sorcerer.", npc, creature)
		end
	elseif MsgContains(message, "yes") then
		if npcHandler:getTopic(playerId) == 1 then
			player:addItem(itemId, 1)
			npcHandler:say("Here you are young adept, take care yourself.", npc, creature)
			player:setStorageValue(Storage.FirstMageWeapon, 1)
		end
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "no") and npcHandler:getTopic(playerId) == 1 then
		npcHandler:say("Ok then.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif categoryTable then
		local remainingCategories = npc:getRemainingShopCategories(message:lower(), itemsTable)
		npcHandler:say("Of course, just browse through my wares. You can also look at " .. remainingCategories .. ".", npc, player)
		npc:openShopWindowTable(player, categoryTable)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. Or do you want to look only at " .. GetFormattedShopCategoryNames(itemsTable) .. ".")
npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)

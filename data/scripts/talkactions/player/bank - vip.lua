-- Configurações globais
local config = {
    enabled = true,
    messageStyle = MESSAGE_LOOK,
}

if not config.enabled then
    return
end

-- Função para verificar se o jogador é VIP
local function checkVip(player)
    if not player:isVip() then
        player:sendTextMessage(config.messageStyle, "You need to be PREMIUM to use this command.")
        return false
    end
    return true
end

-- TalkAction para !balance
local balance = TalkAction("!balance")

function balance.onSay(player, words, param)
    if not checkVip(player) then
        return true
    end

    player:sendTextMessage(config.messageStyle, "Your current bank balance is " .. FormatNumber(Bank.balance(player)) .. ".")
    return true
end

balance:separator(" ")
balance:groupType("normal")
balance:register()

-- TalkAction para !deposit
local deposit = TalkAction("!deposit")

function deposit.onSay(player, words, param)
    if not checkVip(player) then
        return true
    end

    local amount
    if param == "all" then
        amount = player:getMoney()
    else
        amount = tonumber(param)
        if not amount or amount <= 0 or not isValidMoney(amount) then
            player:sendTextMessage(config.messageStyle, "Invalid amount.")
            return true
        end
    end

    if not Bank.deposit(player, amount) then
        player:sendTextMessage(config.messageStyle, "You don't have enough money.")
        return true
    end

    player:sendTextMessage(config.messageStyle, "You have deposited " .. FormatNumber(amount) .. " gold coins.")
    return true
end

deposit:separator(" ")
deposit:groupType("normal")
deposit:register()

-- TalkAction para !withdraw
local withdraw = TalkAction("!withdraw")

function withdraw.onSay(player, words, param)
    if not checkVip(player) then
        return true
    end

    local amount = tonumber(param)
    if not amount or amount <= 0 or not isValidMoney(amount) then
        player:sendTextMessage(config.messageStyle, "Invalid amount.")
        return true
    end

    if not Bank.withdraw(player, amount) then
        player:sendTextMessage(config.messageStyle, "You don't have enough money.")
        return true
    end

    player:sendTextMessage(config.messageStyle, "You have withdrawn " .. FormatNumber(amount) .. " gold coins.")
    return true
end

withdraw:separator(" ")
withdraw:groupType("normal")
withdraw:register()

-- TalkAction para !transfer
local transfer = TalkAction("!transfer")

function transfer.onSay(player, words, param)
    if not checkVip(player) then
        return true
    end

    local split = param:split(",")
    local amount = tonumber(split[2])
    if not amount or amount <= 0 or not isValidMoney(amount) then
        player:sendTextMessage(config.messageStyle, "Invalid amount.")
        return true
    end

    local name = split[1]
    if not name then
        player:sendTextMessage(config.messageStyle, "Invalid name.")
        return true
    end
    name = name:trim()
    local normalizedName = Game.getNormalizedPlayerName(name)
    if not normalizedName then
        player:sendTextMessage(config.messageStyle, "A player with name " .. name .. " does not exist.")
        return true
    end
    name = normalizedName

    if not player:transferMoneyTo(name, amount) then
        player:sendTextMessage(config.messageStyle, "You don't have enough money.")
        return true
    end

    player:sendTextMessage(config.messageStyle, "You have transferred " .. FormatNumber(amount) .. " gold coins to " .. name .. ".")
    return true
end

transfer:separator(" ")
transfer:groupType("normal")
transfer:register()
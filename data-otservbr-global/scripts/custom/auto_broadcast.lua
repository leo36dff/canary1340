local AutoBroadCast = GlobalEvent("text")
function AutoBroadCast.onThink(interval, lastExecution)
    local messages = {

    "[Premmium Account]: +25% exp | +50% training skill speed | +25% loot | !bank, !aol, !blessing, !autoloot.",
    "[Report/Help]: Acess 'Gamemaster channel' and wait patiently for our staff reply.",
}
    Game.broadcastMessage(messages[math.random(#messages)], MESSAGE_GAME_HIGHLIGHT) 
    return true
end
AutoBroadCast:interval(900000)
AutoBroadCast:register()
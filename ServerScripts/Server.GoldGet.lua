---@diagnostic disable: undefined-global
Server.GetTopic("GetGold").Add(function()

    unit.FireEvent("UpdateGold", unit.gameMoney)
    
end)

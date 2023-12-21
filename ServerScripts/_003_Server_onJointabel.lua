---@diagnostic disable: undefined-global

function onJoinPlayer(s)

    if s.unit.GetStringVar(CONFIG.DUPLICATE_ITEMS_VAR) == nil or s.unit.GetStringVar(CONFIG.DUPLICATE_ITEMS_VAR) == '' then -- 아이템 중복 테이블
        local list = {}
        s.unit.SetStringVar(CONFIG.DUPLICATE_ITEMS_VAR, json.serialize(list))
    end




end

Server.onJoinPlayer.Add(onJoinPlayer)

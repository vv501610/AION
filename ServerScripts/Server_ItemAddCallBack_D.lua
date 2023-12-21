---@diagnostic disable: undefined-global


-- Server.onAddItem.Add(function(unit, titem) 

--     if unit.GetStringVar(var) == nil or unit.GetStringVar(var) == '' then
--         local list = {}
--         unit.SetStringVar(var, json.serialize(list))
--     end
--     local data = json.parse(unit.GetStringVar(var))

--     for i = 1, #data do
--         if data[i] == titem.dataID then
--                 print'존재한다!'
--             return false
--         end
--     end 
    
--     data[#data + 1] = titem.dataID
--     unit.SetStringVar(var, json.serialize(data))


-- end)


Server.onAddItem.Add(function(unit, titem) 
    local new = "true"
    local data = json.parse(unit.GetStringVar(CONFIG.DUPLICATE_ITEMS_VAR))
    if data[tostring(titem.dataID)] == 1 then
        new = "flase"
        unit.FireEvent("AddItemCallBack", titem.dataID, new)
        return false
    end
    data[tostring(titem.dataID)] = 1
    unit.SetStringVar(CONFIG.DUPLICATE_ITEMS_VAR, json.serialize(data))
    unit.FireEvent("AddItemCallBack", titem.dataID, new)
end)



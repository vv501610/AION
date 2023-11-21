---@diagnostic disable: undefined-global


local data = require('DataBase/Monster_DataBase')

local MoveDataList = require('DataBase/Move_DataBase')




-- a = json.serialize(MoveDataList)
-- print(a)

-- b = json.parse(a)




-- for key, value in pairs(b) do
--     for k, v in pairs(value) do
--         for kk, vv in pairs(v) do
--             print(kk, vv)
--             if type(vv) == 'table' then
--                 for kkk, vvv in pairs(vv) do
--                     print(kkk, vvv)
--                     for kkkk, vvvv in pairs(vvv) do
--                         print(kkkk, vvvv)
                        
--                     end
--                 end
--             end
--         end
--     end
-- end


Server.GetTopic("Stage:PanelUp").Add(function()

    unit.FireEvent("Client:Stage:ServerDataUp", json.serialize(MoveDataList))

    -- json.serialize
    
end)




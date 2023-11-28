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
end)



local function MoveFunction(list, value)
    local data = json.parse(list)


    if not data.type then
        unit.customData.FieldDataId = Server.CreateField(data.MapData.m)
        unit.customData.FieldDataId.JoinUnit(unit, Point(data.MapData.x*32, data.MapData.y*-32))
        unit.SendCenterLabel('잠시후 몬스터가 스폰 됩니다.')
        local unit = unit
            Server.RunLater(function()  
                for _ = 1, data.MonsterCount[value] do
                    unit.customData.FieldDataId.SpawnEnemy(data.MonsterDataID[value], rand(data.MapData.rmx, data.MapData.mmx)*32, rand(data.MapData.rmy, data.MapData.mmy)*-32)
                end
            end, 3)

    else
        unit.SpawnAtFieldID(data.MapData[value].m, data.MapData[value].x*32, data.MapData[value].y*-32)



    end




    -- print(json.serialize(data))



end


Server.GetTopic("Stage:ServerMoveDataup").Add(MoveFunction)




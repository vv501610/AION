---@diagnostic disable: param-type-mismatch, undefined-global


local data = require('DataBase/Monster_DataBase')

function onUnitDead(b, a)
    if not a or not b then return false end
    if a.type == 0 and b.type == 2 then
        if data[b.monsterID] ~= nil then
            local rect = a.customData.FieldRect


            a.customData.FieldDataId.SpawnEnemy(b.monsterID, rand(rect[1], rect[2])*32, rand(rect[3], rect[4])*-32)
            -- Server.RunLater(function()
            --     local result = pcall(a.customData.FieldDataId.SpawnEnemy, b.monsterID, rand(rect[1], rect[2])*32, rand(rect[3], rect[4])*-32)
            --     if not result then
            --         return false
            --     end
                
            -- end, 3)


        end
        -- questlistvarplus(target.monsterID, attacker, 'kill')
    end
    -- if attacker.type == 2 and target.type == 0 then
    --     if target.party then
    --         target.party.LeaveParty(target.player)
    --         -- target.customData.DungeonUnitTegar = 0
    --         target.customData.DungeonUnitTegar = nil
    --         target.customData.DungeonData = nil
    --         target.customData.dungeonIng = nil
    --         target.SendCenterLabel("사망하셨기에 파티에서 제외 됩니다.")
    --     else
    --         target.customData.DungeonUnitTegar = nil
    --         target.customData.DungeonData = nil
    --         target.customData.dungeonIng = nil
    --     end
    -- end
    -- if target.type == 0 and attacker.type == 0 then
    --     target.teamTag = 1
    -- end

    -- if userdata:unitvarnil(target, attacker) then return false end
    
    -- if attacker.type == 0 and target.type == 2 then
        
    --     -- if not target.monsterID then
    --     --     print'dd'
    --     --     -- DiscordUpErrorServer('onUnitDead 서버 함수부분의 target인자에 target.monsterID가 존재하지 않습니다.')
    --     --     return false
    --     -- end
    --     questlistvarplus(target.monsterID, attacker, 'kill')
    -- end

end
Server.onUnitDead.Add(onUnitDead)




-- function FieldJoinPVP(monster)

--     if monsterlist[monster] then
--         -- local rect =  monsterlist[monster][2]
--         unit.SpawnAtFieldID(monsterlist[monster].pvp, 10*32, 10*-32)
--     end


-- end
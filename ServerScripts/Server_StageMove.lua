---@diagnostic disable: undefined-global


local data = require('DataBase/MonsterDataBase')


local MoveDataList = {
    ['개인 사냥터'] = {

        ['초심자의 숲'] = {
            MapDataId = 4,
            explanation = "강력한 몬스터들을 주의하세요!",
            img = "사냥터 (14).png",
            bool = 0,

            data = {
                ['쉬움'] = {
                    MonsterDataID = {1, 2},
                    MonsterCount = {5, 5},
                }
            }
        },
        ['아시아 대륙'] = {
            MapDataId = 4,
            explanation = "으악",
            img = "사냥터 (22).png",
            bool = 1500,
        
            data = {
                ['쉬움'] = {
                    MonsterDataID = {1, 2},
                    MonsterCount = {5, 5},
                }
            }
        },
        ['심연'] = {
            MapDataId = 4,
            explanation = "으악",
            img = "사냥터 (12).png",
            bool = 2000,
        
            data = {
                ['쉬움'] = {
                    MonsterDataID = {1, 2},
                    MonsterCount = {5, 5},
                }
            }
        },
        ['마법공학 도시'] = {
            MapDataId = 4,
            explanation = "으악",
            img = "사냥터 (18).png",
            bool = 3000,
        
            data = {
                ['쉬움'] = {
                    MonsterDataID = {1, 2},
                    MonsterCount = {5, 5},
                }
            }
        },
    },
    
    ['컨텐츠'] = {

        data = {
            ['낚시터'] = {
                type = true, -- type이 true일경우 인스턴트맵 생상하지 말고 기존 오픈월드로 이동
                MoveData = {4, 5, 5},
                

                -- MonsterDataID = {1, 2},
                -- MonsterCount = {5, 5},
            },
            ['방치'] = {
                type = true, -- type이 true일경우 인스턴트맵 생상하지 말고 기존 오픈월드로 이동
                MoveData = {4, 8, 8},

                -- MonsterDataID = {1, 2},
                -- MonsterCount = {5, 5},
            },
        }
    }
}

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




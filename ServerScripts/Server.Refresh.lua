-- ATTACK = 0
-- DEFENSE = 1
-- MAGIC_ATTACK = 2
-- MAGIC_DEFENSE = 3
-- AGILITY = 4
-- LUCKY = 5
-- HP = 6
-- MP = 7

-- [사용자 설정 능력치 (커스텀 스탯)]

-- CUSTOM_1 = 101
-- ...
-- CUSTOM_50 = 150



local function UnitStatsUpdata(unit)

    -- local def = unit.def

    -- local defs = 15000 -- 방어 상수


    -- unit.customData.DamageReductionRate = math.ceil(1000*(1-def/(def+defs)))/1000

    -- print((math.floor(def/(def+defs)*100*10)/10)..' %피해를 덜 받습니다.')

    -- print(unit.customData.DamageReductionRate..'커스텀 스텟')

    unit.FireEvent("BattlePowerUpdate",
        unit.GetStat(0),
        unit.GetStat(1),
        unit.GetStat(6),
        unit.GetStat(7),
        unit.GetStat(102),
        unit.GetStat(103),
        unit.GetStat(104),
        unit.GetStat(105),
        unit.GetStat(106),
        unit.GetStat(107),
        unit.GetStat(108),
        unit.GetStat(109)
        )

        -- unit.StartGlobalEvent(1)
     
        
end



Server.onRefreshStats.Add(UnitStatsUpdata)


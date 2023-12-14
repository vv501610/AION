local function UnitStatsUpdata(unit)

    -- local def = unit.def

    -- local defs = 15000 -- 방어 상수


    -- unit.customData.DamageReductionRate = math.ceil(1000*(1-def/(def+defs)))/1000

    -- print((math.floor(def/(def+defs)*100*10)/10)..' %피해를 덜 받습니다.')

    -- print(unit.customData.DamageReductionRate..'커스텀 스텟')

end



Server.onRefreshStats.Add(UnitStatsUpdata)


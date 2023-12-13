local function UnitStatsUpdata(unit)

    local def = unit.def


    -- def = 310000

    defs = 100000

--print( ((def)/(def + 200)) * 100)


unit.customData.DamageReductionRate = math.ceil(1000*(1-def/(def+defs)))/1000




print((math.floor(def/(def+defs)*100*10)/10)..' %피해를 덜 받습니다.')

print(unit.customData.DamageReductionRate)

end



Server.onRefreshStats.Add(UnitStatsUpdata)

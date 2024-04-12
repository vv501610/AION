---@diagnostic disable: undefined-global
-- local monsterCount = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11}
--0.0001 까지 작성 가능



local data = require('DataBase/Monster_DataBase')


Server.rewardCallback = function(unit, monster, damage) --플레이어,몬스터,데미지
	if not unit and not monster then return false end

	local partybunus = 1


	if data[monster.monsterID] then
		local monsterset = {gold = unit.GetStat(111), exp = unit.GetStat(110), itdr = unit.GetStat(112)}
		local MonsterData = data[monster.monsterID]
		local rewardlist = rand(MonsterData.gold[1], MonsterData.gold[2])


		-- unit.FireEvent("itemlogup", true, MonsterData.exp, monsterset.exp, rewardlist, monsterset.gold)

		unit.AddGameMoney((rewardlist + math.floor(rewardlist*monsterset.gold/100)))
		unit.AddEXP((MonsterData.exp + math.floor(MonsterData.exp*monsterset.exp/100)))


		-- unit.AddEXP((MonsterData.exp))

		for n = 1 ,#MonsterData.dropitem.percentage do 
			local Probability = (MonsterData.dropitem.percentage[n] * 1000)
			if rand(1, 100001) <= (Probability+(Probability*(monsterset.itdr/100)))*partybunus then -- 0.01
				local count1 = rand(MonsterData.dropitem.count[n][1], MonsterData.dropitem.count[n][2])
				-- local text2 = Server.GetItem(MonsterData.dropitem.dataid[n]).name..' 을(를)'..count1..'개 획득 하였습니다.'
				unit.AddItem(MonsterData.dropitem.dataid[n], count1)
				-- unit.FireEvent("itemlogup", false, text2)
			end
		end
	end
end


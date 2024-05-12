---@diagnostic disable: param-type-mismatch, undefined-global



local but_name = {index = {}}
but_name.main = {'주괴, 상자', '인첸트'}

but_name.index['1'] = {'주괴', '스킬석 상자'}

but_name.index['2'] = {'고급'}


local ItemCreateMenu = {
	
	[but_name.main[1]] = {
		
		[but_name.index['1'][1]] = {dataID = {4, 10},
			gold = {50, 1500},
			chance = {100, 100},
			itemdataID = {['1'] = {4}, ['2'] = {10}},
			itemcount = {['1'] = {90}, ['2'] = {100}}},

		[but_name.index['1'][2]] = {dataID = {8},
			gold = {1000},
			chance = {100},
			itemdataID = {['1'] = {4}},
			itemcount = {['1'] = {50}}},
	},
-------------------------------------------------------------------------------------------------
	[but_name.main[2]] = {
		
		[but_name.index['2'][1]] = {dataID = {1, 2},
			gold = {10000, 10000},
			chance = {100, 100},
			itemdataID = {['1'] = {4, 4}, ['2'] = {4, 4}},
			itemcount = {['1'] = {3, 5}, ['2'] = {3, 5}}},

	}
}


Server.GetTopic("make:Up").Add(function()

	unit.FireEvent("make:down", json.serialize(but_name), json.serialize(ItemCreateMenu))
end)

  
Server.GetTopic("make:MakeUp").Add(function(menu, count, mincount, var, nn)

	local countitem = unit.CountItem

	local data = {}
	data.up = 0
	data.down = 0

	if var <= 0 or var >= 1001 then
		unit.SendCenterLabel("알 수 없는 오류가 발생 하였습니다.")
		return
	end
	
	if unit.gameMoney < ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].gold[mincount]*var then
		unit.SendCenterLabel("골드가 모자랍니다.")
		return false
	end

	for i = 1, #ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].itemdataID[tostring(mincount)] do
		if countitem(ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].itemdataID[tostring(mincount)][i]) < ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].itemcount[tostring(mincount)][i]*var then
			unit.SendCenterLabel("재료가 부족 합니다.")
			return false
		end

		if unit.IsEquippedItemByDataID(ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].itemdataID[tostring(mincount)][i]) then
			unit.SendCenterLabel('재료가 될 아이템이 장착 상태입니다.\n<color=#F78181>아이템을 창고에 넣어두고 제작하세요.</color>')
			return false
		end
	end

	unit.UseGameMoney(ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].gold[mincount]*var)

	for i = 1, #ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].itemdataID[tostring(mincount)] do
		unit.RemoveItem(ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].itemdataID[tostring(mincount)][i], ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].itemcount[tostring(mincount)][i]*var, false)
	end

	for i = 1, var do
		if rand(1, 101) <= ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].chance[mincount] then
			data.up = data.up + 1
		else
			data.down = data.down + 1
		end
	end


	unit.FireEvent("UpdateGold", unit.gameMoney)
	unit.FireEvent("ItemMakeUpData", var, data.up, data.down, ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].dataID[mincount], json.serialize({menu, mincount, nn, count}))
	
	unit.AddItem(ItemCreateMenu[but_name.main[menu]][but_name.index[tostring(menu)][count]].dataID[mincount], data.up, false)
end)

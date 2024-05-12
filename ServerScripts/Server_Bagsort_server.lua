---@diagnostic disable: undefined-global
Server.GetTopic("Bagsort").Add(
	function(number) -- HP 신호를 텍스트와 함께 받으면
		--print(number)
		local p = unit.player

		p.SortBagItems(
			function(item1, item2)
				local a = Server.GetItem(item1.dataID)
				local b = Server.GetItem(item2.dataID)

				if p.unit.IsEquippedItem(item1.id) then
					return false
				else
					return a.type >= b.type
				end
			end
		)
	end
)

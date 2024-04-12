
-- local panelTest = {}

-- --패널 초기 생성
-- function panelTest : makePanel ()

-- 	self.basePanel = Panel(Rect(Client.width - 270, 182.5, 0, 0))
--     self.basePanel.setOpacity(0)
-- 	self.showOnTop = true

-- 	for i = 1, 7 do
-- 		local txt = Text('', Rect(0, (i*15)-20, 265, 15))
--       	txt.textSize = 11
--       	txt.textAlign = 2
-- 		-- txt.color = Color(255,0,0,255)
-- 		self.basePanel.AddChild(txt)
-- 	end
-- end


-- -- 패널에 메시지 추가 후 자식객체 내부 text 수정
-- function panelTest : addMsg (msg)

-- 	for i, v in pairs(self.basePanel.children) do
-- 		if i < #self.basePanel.children then
-- 		   v.text = self.basePanel.children[i+1].text
-- 		else
-- 		   v.text = msg
-- 		end
-- 	end
-- end

-- panelTest:makePanel ()




-- Client.GetTopic("itemlogup").Add(function(type, reexp, exp, rgold, gold)
-- --    panelTest:addMsg(type == true and 'EXP +'..math.floor(reexp*party)..(0 < exp  and '('..math.floor((reexp*exp/100)*party)..')' or '')..', Gold +'..math.floor(rgold*party)..(0 < gold and '('..math.floor((rgold*gold/100)*party)..')' or '') or reexp)
-- 	panelTest:addMsg(type == true and 'EXP +'..math.floor(reexp)..(0 < exp  and '('..math.floor((reexp*exp/100))..')' or '')..', Gold +'..math.floor(rgold)..(0 < gold and '('..math.floor((rgold*gold/100))..')' or '') or reexp)

-- end)
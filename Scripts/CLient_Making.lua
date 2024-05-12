-- -@diagnostic disable: param-type-mismatch, undefined-global, redundant-parameter, undefined-field, missing-parameter



local Class = require("Utils/_001_midclass")

local Main = require("_005_Client_MainGui")

local CallBack = require("Utils/_002_Client_CallBackFunction")

Making = Class('Making', Main)




Making.Rect = Rect(Client.width/2 - 385, Client.height/2 - 190, 770, 360)

Making.PanelName = "제작"


-- Making.TopYellowPanelTrgre = '개인 사냥터' -- 매개인수 자료타입이 키값


Making.HelpTitleText = '도움말'
Making.HelpTextext = '아이템을 제작 할 수 있습니다.'


Making.TopPanelData = {
    Image = {"Icons/Item_0091.png"},
    value = {
        [1] = function ()
                return CallBack:C_commaValue(CallBack.GameGold)
            
        end,

    }
}



function Making:initialize()
    self:BackGrundPanelUp()
    self:MakingUp()
    self:Close()
end



function Making:MakingUp()
	Client.FireEvent("make:Up")
    self.BlackPanel.AddChild(Panel(Rect(10, 88, Client.width-20, 2)) {color = Color(132, 132, 132, 255)})
	self.BlackPanel.AddChild(Panel(Rect(135, 120, 2, Client.height-150)) {color = Color(132, 132, 132, 255)})





    -- self.blick = Panel(Rect(0, 0, 0, 0))
    -- self.BlackPanel.AddChild(self.blick)
end

function Making:MakingGetTopicUp(MenuName, MenuList)
	---@diagnostic disable-next-line: undefined-global
	self.MenuName = json.parse(MenuName)
	---@diagnostic disable-next-line: undefined-global
	self.MenuList = json.parse(MenuList)
	self:BaseGui()
end


function Making:BaseGui() -- 바탕이 되는 gui들
	self.ItemCount = {}
	self.ItemCoeuntText = {}
	self.NowItemCoeuntText  = {}

	self.MainMenuScrollPanel = ScrollPanel(Rect(10, 50, Client.width-20, 40))
	self.BlackPanel.AddChild(self.MainMenuScrollPanel)
	self.MainMenuScrollPanel.setOpacity(0)
	self.MainMenuScrollPanel.vertical = false

	self.mainMenuSon = Panel(Rect(0, 0, 105*(#self.MenuName.main), 32))
	self.MainMenuScrollPanel.AddChild(self.mainMenuSon)
	self.mainMenuSon.setOpacity(0)
	self.MainMenuScrollPanel.content = self.mainMenuSon


	self.menwscroll_panel = ScrollPanel(Rect(10, 103, 115, 320)) --왼쪽 카테고리 스크롤패널
	self.menwscroll_panel.setOpacity(0)
	self.menwscroll_panel.horizontal = false

	self.BlackPanel.AddChild(self.menwscroll_panel)

    self.WHfektnPanel = Panel(Rect(0, 0, 90, 90))
	self.WHfektnPanel.setOpacity(0)

	self.menwscroll_panel.AddChild(self.WHfektnPanel)
	self.menwscroll_panel.content = self.WHfektnPanel

    self.CategoleyellowP = Panel(Rect(0, 0, 2, 37)) { -- 두번째 카테고리 옐로우 패널
        color = Color(255, 189, 0)
    }
    self.WHfektnPanel.AddChild(self.CategoleyellowP)
    
    self.scroll_panel = ScrollPanel(Rect(140, 103, self.BlackPanel.width*0.239375, 320))-- 두번째 카테고리 배경화면
	self.scroll_panel.SetOpacity(0)
	self.scroll_panel.horizontal = false

    self.BlackPanel.AddChild(self.scroll_panel)

    self.MidlePanel = Image('Pictures/Gui/메인 패널.png', Rect((self.scroll_panel.x+self.scroll_panel.width+self.BlackPanel.width-self.BlackPanel.width*0.2875-10)/2-(self.scroll_panel.width*1.1/2), 103, self.scroll_panel.width*1.22, 320)){ -- 중간패널
        imageType = 1
    }
    self.BlackPanel.AddChild(self.MidlePanel)

    self.ItemPanel = Panel(Rect(self.MidlePanel.width/2-30, 10, 60, 60))
    self.MidlePanel.AddChild(self.ItemPanel)


    self.ItemText = Text("", Rect(-64, 63, 190, 25))
    self.ItemText.textAlign = 1
    self.ItemText.textSize = 14
    self.ItemPanel.AddChild(self.ItemText)
    

    self.ItemImage = Image("", Rect(5, 5, 50, 50))
    self.ItemPanel.AddChild(self.ItemImage)


    self.sendPanelscroll_panel = ScrollPanel(Rect(5, 95, self.MidlePanel.width-10, 167))
	self.sendPanelscroll_panel.setOpacity(0)
	self.sendPanelscroll_panel.horizontal = false
	self.MidlePanel.AddChild(self.sendPanelscroll_panel)

	self.ItemTextPanel = Panel(Rect(0, 0, self.MidlePanel.width-10, 500))
	self.sendPanelscroll_panel.AddChild(self.ItemTextPanel)
	self.sendPanelscroll_panel.content = self.ItemTextPanel


	self.ItemDescText = Text('종류:', Rect(5, 5, self.MidlePanel.width-10, 500))
	self.ItemDescText.textSize = 13.5
	self.ItemDescText.textAlign = 0

	self.ItemTextPanel.AddChild(self.ItemDescText)


	-- self.BlackPanel.AddChild(Image('Pictures/Gui/메인 패널 세로.png',Rect(self.BlackPanel.width-self.BlackPanel.width*0.2575-10, 103, self.BlackPanel.width*0.2575, 320)))

	self.itemScrollPanel = ScrollPanel(Rect(self.BlackPanel.width-self.BlackPanel.width*0.2575-10, 103, self.BlackPanel.width*0.2575, 320)) -----아이템
	self.itemScrollPanel.horizontal = false
	self.itemScrollPanel.setOpacity(0)
	self.BlackPanel.AddChild(self.itemScrollPanel)


	self.itemScrollPaneladd = Panel(Rect(0, 0, self.itemScrollPanel.width, 0))-----아이템 자식패널
	-- self.itemScrollPaneladd.setOpacity(0)
	self.itemScrollPanel.AddChild(self.itemScrollPaneladd)
	self.itemScrollPanel.content = self.itemScrollPaneladd


	self.ItemCount[1] = Panel(Rect(5, 5, self.itemScrollPanel.width-10, 60))
	self.ItemCount[1].setOpacity(255)
	self.itemScrollPaneladd.AddChild(self.ItemCount[1])

	self.ItemCount[1].AddChild(Image('Pictures/Gui/ChoicePanel.png',Rect(0, 0, self.ItemCount[1].width, 60)))

	local img = Image("Icons/Item_0091.png", Rect(10, 12.5, 35, 35))
	self.ItemCount[1].AddChild(img)

	local ItemText = Text("골드",Rect(50, 10, 139, 30))
	ItemText.textAlign = 0
	ItemText.textSize = 12
	self.ItemCount[1].AddChild(ItemText)


	self.ItemCoeuntText[1] = Text('소지:' ,Rect(50, 25, 139, 30))
	self.ItemCoeuntText[1].textAlign = 0
	self.ItemCoeuntText[1].textSize = 11
	self.ItemCount[1].AddChild(self.ItemCoeuntText[1])

	self.NowItemCoeuntText[1] = Text('필요:', Rect(50, 40, 139, 30))
	self.NowItemCoeuntText[1].textAlign = 0
	self.NowItemCoeuntText[1].textSize = 11
	self.ItemCount[1].AddChild(self.NowItemCoeuntText[1])
		


	self.ItemCount[2] = Panel(Rect(5, 67, self.itemScrollPanel.width-10, 60))
	self.ItemCount[2].setOpacity(255)
	self.itemScrollPaneladd.AddChild(self.ItemCount[2])

	self.ItemCount[2].AddChild(Image('Pictures/Gui/ChoicePanel.png',Rect(0, 0, self.ItemCount[2].width, 60)))

	local ItemText = Text("제작 성공 확률",Rect(50, 10, 139, 30))
	ItemText.textAlign = 0
	ItemText.textSize = 12
	self.ItemCount[2].AddChild(ItemText)

	local img = Image("Pictures/Gui/heder.png", Rect(7.5, 13, 35, 35))  -- 재작모영
	self.ItemCount[2].AddChild(img)


	self.ItemCoeuntTextPer = Text('성공 확률:', Rect(50, 25, 139, 30))
	self.ItemCoeuntTextPer.textAlign = 0
	self.ItemCoeuntTextPer.textSize = 11
	self.ItemCount[2].AddChild(self.ItemCoeuntTextPer)


	local MakerButtonImg =  Image('Pictures/Gui/밝버튼.png', Rect(self.BlackPanel.width-75, self.BlackPanel.height-40, 65, 25))
	self.BlackPanel.AddChild(MakerButtonImg)

	self.MakerButton = Button("제작", Rect(MakerButtonImg.x, MakerButtonImg.y, 65, 25))
	self.MakerButton.setOpacity(0)

	self.BlackPanel.AddChild(self.MakerButton)

	self.MakerButton.onClick.Add(function ()
		self.MakerButtonOnF()
	end)


	self.CountPanel = Panel(Rect(self.MakerButton.x-110,  MakerButtonImg.y, 100, 25))
	self.BlackPanel.AddChild(self.CountPanel)

	self.CountPanel.setOpacity(120)

	self.CountPanelText = Text("", Rect(10, 5, 80, 25))
	self.CountPanel.AddChild(self.CountPanelText)
	self.CountPanelText.textSize = 12
	self.CountPanelText.textAlign = 1

	local PlusButtonX10Img =  Image('Pictures/Gui/밝버튼.png',Rect(self.MakerButton.x-185, MakerButtonImg.y, 65, 25))
	self.BlackPanel.AddChild(PlusButtonX10Img)

	self.PlusButtonX10 = Button('+10', Rect(self.MakerButton.x-185, MakerButtonImg.y, 65, 25))
	self.BlackPanel.AddChild(self.PlusButtonX10)
	self.PlusButtonX10.setOpacity(0)
	self.PlusButtonX10.textSize = 12


	self.PlusButtonX10.onClick.Add(function()
		self.PlusButtonX10Onf()
	end)

	self.PlusButtonX100 = Button('+100', Rect(self.MakerButton.x-260, MakerButtonImg.y, 65, 25))
	local PlusButtonX100 =  Image('Pictures/Gui/밝버튼.png',Rect(self.MakerButton.x-260, MakerButtonImg.y, 65, 25))
	self.BlackPanel.AddChild(PlusButtonX100)
	self.PlusButtonX100.setOpacity(0)
	self.PlusButtonX100.textSize = 12
	self.BlackPanel.AddChild(self.PlusButtonX100)

	self.PlusButtonX100.onClick.Add(function()
		self.PlusButtonX100Onf()
	end)

	self.ResetButton = Button('Reset', Rect(self.MakerButton.x-335, MakerButtonImg.y, 65, 25))
	local ResetButton =  Image('Pictures/Gui/밝버튼.png', Rect(self.MakerButton.x-335, MakerButtonImg.y, 65, 25))
	self.BlackPanel.AddChild(ResetButton)
	self.ResetButton.setOpacity(0)
	self.ResetButton.textSize = 12
	self.BlackPanel.AddChild(self.ResetButton)

	self.ResetButton.onClick.Add(function()
		self.ResetButtonOnf()
	end)

	self.PlusButton = Button('+', Rect(self.CountPanel.x+75, MakerButtonImg.y, 25, 25))
	self.PlusButton.setOpacity(20)
	self.BlackPanel.AddChild(self.PlusButton)

	self.PlusButton.onClick.Add(function()
		self.PlusButtonOnf()
	end)


	self.DownButton = Button('-', Rect(self.CountPanel.x, MakerButtonImg.y, 25, 25))
	self.DownButton.setOpacity(20)
	self.BlackPanel.AddChild(self.DownButton)

	self.DownButton.onClick.Add(function()
		self.DownButtonOnf()
	end)


	self:TopCategole()
end


function Making:TopCategole() -- 맨위 상단 카테고리

	-- data.happy_panel = {} data.Choice_but = {} data.happy_butSetimG = {} data.PanelColor = {}

	self.TopYellowPanel = Panel(Rect(0, 38, 110, 2)) {
		color = Color(255, 189, 0)
		
	 }
	 self.mainMenuSon.AddChild(self.TopYellowPanel)
	 for key, i in pairs(self.MenuName.main) do
        local TopCategole = Button('', Rect(110*(key-1), 0, 110, 38)) {
            textSize = 16,
            autoTranslate = true,
            text = i,
        }
		
        self.mainMenuSon.AddChild(TopCategole)
        TopCategole.setOpacity(0)

        TopCategole.onClick.Add(function()
            self.TopYellowPanel.rect = Rect(TopCategole.x, 38, 110, 2)
            self:LeftInforMation(key)
		end)
    end
	self:LeftInforMation(1)

end



function Making:LeftInforMation(i) --왼쪽 하위 카테고리
    if self.WHfektnPanel ~= nil then
        self.WHfektnPanel.Destroy()
        self.WHfektnPanel = nil
    end

    self.WHfektnPanel = Panel(Rect(0, 0, 90, 5+37*(#self.MenuName.index[tostring(i)])))
	self.WHfektnPanel.setOpacity(0)

	self.menwscroll_panel.AddChild(self.WHfektnPanel)
	self.menwscroll_panel.content = self.WHfektnPanel

    self.CategoleyellowP = Panel(Rect(0, 0, 2, 37)) { -- 두번째 카테고리 옐로우 패널
        color = Color(255, 189, 0)
    }
    self.WHfektnPanel.AddChild(self.CategoleyellowP)

	local temp = nil

    for n, value in pairs(self.MenuName.index[tostring(i)]) do
        local Choice_but =  Button(self.MenuName.index[tostring(i)][n], Rect(0, 37*(n-1), 109, 37)) {
            textSize = 15.5,
            autoTranslate = true,
            text = value,
        }

        if n == 1 then
            self.CategoleyellowP.rect = Rect(0, Choice_but.y, 2, 37)
            Choice_but.DOColor(Color(128, 128, 128, 255), 0.3)
            Choice_but.DOMove(Point(6, Choice_but.y), 0.3)
            temp = Choice_but
        end

        Choice_but.setOpacity(0)
        self.WHfektnPanel.AddChild(Choice_but)

        Choice_but.onClick.Add(function()
			if Choice_but ~= temp then
				if temp ~= nil then
					temp.setOpacity(0)
					temp.DOMove(Point(0, temp.y), 0.3)
				end
				temp = Choice_but
			else
				return
			end
			
            self.CategoleyellowP.rect = Rect(0, Choice_but.y, 2, 37)

            Choice_but.DOColor(Color(128, 128, 128, 255), 0.3)
            Choice_but.DOMove(Point(6, Choice_but.y), 0.3)
			self:ItemListF(n, i)
			return
		end)
    end
    self:ItemListF(1, i)
	
end

function Making:ItemListF(n , i)
	
    if self.inL ~= nil then
        self.inL.Destroy()
        self.inL = nil
    end
    
    self.inL = Panel(Rect(0, 0, self.scroll_panel.width, 45*#self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][n]].dataID)) -- 285 -- 190
    -- self.inL.setOpacity(0)
    self.scroll_panel.content = self.inL


    local temp = nil


    for j, k in pairs(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][n]].dataID) do
		local CPanel = Button('', Rect(0, 5+45*(j-1), self.inL.width, 40)) {
			color = Color(76, 78, 85, 255)
		}

        if j == 1 then
            CPanel.color = Color(255, 189, 0)
            temp = CPanel
        end

		local inpanel = Panel(Rect(2.5, 2.5, self.inL.width-5, 35)) {
			color = Color(29, 30, 31, 255)
		}
		CPanel.AddChild(inpanel)
		
		self.inL.AddChild(CPanel)

        local icon_panel = Panel(Rect(3, 3, CPanel.height-6, CPanel.height-6))
		icon_panel.setOpacity(100) --- 0
		CPanel.AddChild(icon_panel)


        local happy_image = Image('', Rect(0, 0, icon_panel.width, icon_panel.height))
		happy_image.SetImageID(Client.GetItem(k).imageID)
		icon_panel.AddChild(happy_image)

        local happy_text = Text(Client.GetItem(k).name, Rect(icon_panel.width+7, 0, CPanel.width-icon_panel.width-10, CPanel.height)){
            textSize = 14,
            textAlign = 3
        }

		CPanel.AddChild(happy_text)

        CPanel.onClick.Add(function()

            if CPanel ~= temp then
				if temp ~= nil then
					temp.setOpacity(0)
					temp.DOMove(Point(0, temp.y), 0.3)
				end
				temp = CPanel
			else
				return
			end
			

			temp.color = Color(29, 30, 31, 255)
			CPanel.color = Color(255, 189, 0)
			-- callback:ClickUpTest(data.happy_butSetimG[j])
			--j = 1
			self:ItemMakingFinel(i, j, k, n)
			-- b = j
		end)
	end
	self:ItemMakingFinel(i, 1, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][n]].dataID[1], n) ----------------------------여기수정했음
end


function Making:ItemMakingFinel(i, j, n, bb)
	self.nowdata = {i, j, n, bb}
	self.ItemMakerVar = 1
	self.myitem = Client.myPlayerUnit.GetItemCount
	for k = 3, 2+#self.ItemCount do
		if self.ItemCount[k] ~= nil then
			self.ItemCount[k].Destroy() 
			self.ItemCount[k] = nil
		end
		if self.NowItemCoeuntText[k-1] ~= nil then
			self.NowItemCoeuntText[k-1].Destroy()
			self.NowItemCoeuntText[k-1] = nil
		end
	end

    self.ItemImage.SetImageID(Client.GetItem(n).imageID)

    self.ItemText.text = Client.GetItem(n).name

    self.ItemDescText.text = "종류:"..CallBack.ItemType[Client.GetItem(n).type+1].."\n"..(Client.GetItem(n).canTrade == false and "<color=#FF0000>거래 불가능</color>\n" or "<color=#FF0000>거래 가능</color>\n")..Client.GetItem(n).desc


	self.itemScrollPaneladd.rect = Rect(0, 0, 210, 5+(2+#self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)])*62)


	local NowItemCount = CallBack.GameGold >= self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].gold[j] and CallBack:C_commaValue(CallBack.GameGold) or "<color=#FF0000>"..CallBack:C_commaValue(CallBack.GameGold).."</color>"
	self.ItemCoeuntText[1].text = '소지:'..NowItemCount

	self.NowItemCoeuntText[1].text = '필요:'..CallBack:C_commaValue(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].gold[j])

	self.ItemCoeuntTextPer.text = ('성공 확률:'..'<color=#74DF00>'..self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].chance[j]..'%'..'</color>')


	for k = 3, 2+#self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)] do

		self.ItemCount[k] = Button('', Rect(5, 5+((k-1)*60)+((k-1)*2), self.itemScrollPanel.width-10, 60))
		self.ItemCount[k].SetOpacity(0)
		self.ItemCount[k].onClick.Add(function()
			-- ItemDocePanelUp(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2], CallBack:C_commaValue(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)][k-2]))
		end)
		self.ItemCount[k].AddChild(Image('Pictures/Gui/ChoicePanel.png',Rect(0, 0, self.ItemCount[k].width, 60)))
		self.itemScrollPaneladd.AddChild(self.ItemCount[k])

		local img = Image("", Rect(10, 12.5, 35, 35))
		img.SetImageID(Client.GetItem(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2]).imageID)
		self.ItemCount[k].AddChild(img)

		local ItemText = Text(Client.GetItem(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2]).name, Rect(50, 10, 159, 30))
		ItemText.textAlign = 0
		ItemText.textSize = 12
		self.ItemCount[k].AddChild(ItemText)
		
		local NowItemCount = self.myitem(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2]) >= self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)][k-2] and CallBack:C_commaValue(self.myitem(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2])) or "<color=#FF0000>"..CallBack:C_commaValue(self.myitem(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2])).."</color>"

		self.ItemCoeuntText[k-1] = Text('소지:'..NowItemCount ,Rect(50, 25, 139, 30))
		self.ItemCoeuntText[k-1].textAlign = 0
		self.ItemCoeuntText[k-1].textSize = 11
		self.ItemCount[k].AddChild(self.ItemCoeuntText[k-1])

		self.NowItemCoeuntText[k-1] = Text('필요:'..CallBack:C_commaValue(self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)][k-2]), Rect(50, 40, 139, 30))
		self.NowItemCoeuntText[k-1].textAlign = 0
		self.NowItemCoeuntText[k-1].textSize = 11
		self.ItemCount[k].AddChild(self.NowItemCoeuntText[k-1])
	end

	self.MakerButtonOnF = function()
		Client.ShowYesNoAlert(Client.GetItem(n).name..' 아이템을'..self.ItemMakerVar..'개 제작 하시겠습니까?'..'\n제작 성공 확률:'..'<color=#74DF00>'..self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].chance[j]..'%'..'</color>',function(result)
			if result == 1 then
				Client.FireEvent("make:MakeUp",i, bb, j, self.ItemMakerVar, n)
				-- LoadingPanelUp()
				-- Client.FireEvent("make:Up")
			end
		end)
	end

	self.CountPanelText.text = self.ItemMakerVar


	self.PlusButtonX10Onf = function()
		if self.ItemMakerVar >= 990 then
			return false
		end
		self.ItemMakerVar = self.ItemMakerVar + 10
		self.CountPanelText.text = self.ItemMakerVar
		
		self:CountUpData(self.NowItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].gold[j], self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], CallBack.GameGold, self.ItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)])
	end
	

	self.PlusButtonX100Onf = function()
		if self.ItemMakerVar >= 900 then
			return false
		end
		self.ItemMakerVar = self.ItemMakerVar + 100
		self.CountPanelText.text = self.ItemMakerVar
		self:CountUpData(self.NowItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].gold[j], self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], CallBack.GameGold, self.ItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)])
	end

	self.ResetButtonOnf = function()
		self.ItemMakerVar = 1
		self.CountPanelText.text = self.ItemMakerVar
		
		self:CountUpData(self.NowItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].gold[j], self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], CallBack.GameGold, self.ItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)])
	end

	self.PlusButtonOnf = function()
		if self.ItemMakerVar >= 1000 then
			return false
		end
		self.ItemMakerVar = self.ItemMakerVar + 1
		self.CountPanelText.text = self.ItemMakerVar
		self:CountUpData(self.NowItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].gold[j], self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], CallBack.GameGold, self.ItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)])
	end


	self.DownButtonOnf = function()

		if self.ItemMakerVar <= 1 then
			return false
		end
		self.ItemMakerVar = self.ItemMakerVar - 1
		self.CountPanelText.text = self.ItemMakerVar
		self:CountUpData(self.NowItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].gold[j], self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], CallBack.GameGold, self.ItemCoeuntText, self.MenuList[self.MenuName.main[i]][self.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)])
	end



end

function Making:CountUpData(data, gold, itemcount, nowgold, data2, nowitem)
	data2[1].text = '소지:'..(nowgold >= gold*self.ItemMakerVar and CallBack:C_commaValue(nowgold) or "<color=#FF0000>"..CallBack:C_commaValue(nowgold).."</color>")

	data[1].text = '필요:'..CallBack:C_commaValue(gold*self.ItemMakerVar)
	
	for i = 2, #data do
		data2[i].text = '소지:'..(self.myitem(nowitem[i-1]) >=itemcount[i-1]*self.ItemMakerVar and CallBack:C_commaValue(self.myitem(nowitem[i-1])) or "<color=#FF0000>"..CallBack:C_commaValue(self.myitem(nowitem[i-1])).."</color>")
		data[i].text = '필요:'..(CallBack:C_commaValue(itemcount[i-1]*self.ItemMakerVar))
	end
end





Client.GetTopic("make:down").Add(function(MenuName, MenuList)
    Making:MakingGetTopicUp(MenuName, MenuList)
end)


Client.GetTopic("ItemMakeUpData").Add(function(var, up, down, dataID, data)
	local datae = json.parse(data)
	Client.ShowAlert(Client.GetItem(dataID).name..var..'개 제작 시도하여\n'..up..'개 제작 성공\n'..down..'개 실패 하였습니다')
	Making:ItemMakingFinel(datae[1], datae[2], datae[3], datae[4])
	Making:ShowAnimationTotal()
end)





function Making:ShowAnimationTotal()
	self:ItemMakingFinel(self.nowdata[1], self.nowdata[2], self.nowdata[3], self.nowdata[4])
	
    self:ShowAnimation()
end



Client.RunLater(function()
	Making:initialize()
end, 0.5)



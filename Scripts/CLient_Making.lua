---@diagnostic disable: param-type-mismatch, undefined-global, redundant-parameter, undefined-field, missing-parameter



local Class = require("Utils/_001_midclass")

local Main = require("_005_Client_MainGui")

local CallBack = require("Utils/_002_Client_CallBackFunction")

Making = Class('Making', Main)




Making.Rect = Rect(Client.width/2 - 385, Client.height/2 - 190, 770, 360)

Making.PanelName = "제작"


Making.TopYellowPanelTrgre = '개인 사냥터' -- 매개인수 자료타입이 키값


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

local data = {}
local a, b, c, d = 1, 1, 1, 1



function Making:initialize()
    self:BackGrundPanelUp()
    self:MakingUp()
    self:Close()
end



function Making:MakingUp()
    self.a = 1
    self.b = 1
    self.c = 1
    self.d = 1
    self.TdTopLeftCategoleButtonTrgar = 1




    self.cw = Client.width
	self.ch = Client.height

    self.BlackPanel.AddChild(Panel(Rect(10, 88, Client.width-20, 2)) {color = Color(132, 132, 132, 255)})


	self.BlackPanel.AddChild(Panel(Rect(135, 120, 2, Client.height-150)) {color = Color(132, 132, 132, 255)})


    -- self.blick = Panel(Rect(0, 0, 0, 0))
    -- self.BlackPanel.AddChild(self.blick)
end


function Making:MakingGetTopicUp(MenuName, MenuList, ItemCount, UnitGold)

    if data.blick ~= nil then
        data.blick.Destroy() data = nil data = {}
    end


    
	data.ItemMakerMenu = nil
	data.ItemMakerCount = nil
	data.ItemMakerCountMin = nil
	data.ItemMakerDataID = nil
	data.ItemMakerVar = nil

	data.MenuName = json.parse(MenuName)
	data.MenuList = json.parse(MenuList)
	data.ItemCount = json.parse(ItemCount)
	data.Gold = UnitGold


	data.cw = self.cw
	data.ch = self.cw

	data.Garo = 780 --650
	data.Sero = 330

	data.blick = Panel(Rect(0, 0, data.cw, data.ch))
    data.blick.setOpacity(0)

    self.BlackPanel.AddChild(data.blick)
	-- data.blick.showOnTop = true

	data.Make_Panel = Panel(Rect(10, 103,self.cw-20, data.Sero))-----------------------------------------------------
	data.Make_Panel.setOpacity(0)
	-- data.Make_Panel.color = Color(0, 0, 0, 255)
	data.blick.AddChild(data.Make_Panel)

	data.Make_Panel2 = Panel(Rect(0, 0, data.Make_Panel.width, data.Make_Panel.height))
	data.Make_Panel2.setOpacity(0)
	-- data.Make_Panel2.color = Color(66, 66, 66, 255)
	data.Make_Panel.AddChild(data.Make_Panel2)


	data.main_panel = Panel(Rect(100, 0, 643, 308)) -- 553
	-- data.main_panel.color = Color(77, 77, 77, 100)
	data.main_panel.setOpacity(0)
	data.Make_Panel2.AddChild(data.main_panel)

	data.sendPanel = Panel(Rect(0, 5, 0, 0)) -- 190 -----------------------------------------------------
	data.sendPanel.setOpacity(0)
	data.Make_Panel2.AddChild(data.sendPanel)

	local MakerButtonImg =  Image('Pictures/Gui/밝버튼.png', Rect(data.Make_Panel2.width-70, 330, 65, 25))
	data.Make_Panel.AddChild(MakerButtonImg)

	data.MakerButton = Button("제작", Rect(data.Make_Panel2.width-70, 330, 65, 25))
	data.MakerButton.setOpacity(0)

	data.Make_Panel.AddChild(data.MakerButton)

    data.MakerButton.onClick.Add(function()
		-- callback:ClickUpTest(makebutton)
		if data.ItemMakerMenu ~= nil or data.ItemMakerCount ~= nil or data.ItemMakerCountMin ~= nil or 	data.ItemMakerDataID ~= nil then
			Client.ShowYesNoAlert(Client.GetItem(data.ItemMakerDataID).name..' 아이템을'..data.ItemMakerVar..'개 제작 하시겠습니까?'..'\n제작 성공 확률:'..'<color=#74DF00>'..data.MenuList[data.MenuName.main[data.ItemMakerMenu]][data.MenuName.index[tostring(data.ItemMakerMenu)][data.ItemMakerCount]].chance[data.ItemMakerCountMin]..'%'..'</color>',function(result)
				if result == 1 then
					Client.FireEvent("make:MakeUp", data.ItemMakerMenu, data.ItemMakerCount, data.ItemMakerCountMin, data.ItemMakerDataID, data.ItemMakerVar)
					data.blick.Destroy() data = nil data = {}
					LoadingPanelUp()
					Client.FireEvent("make:Up")
				end
			end)
		end
	end)

	data.inP = Panel(Rect(data.main_panel.width-213, 5, 210, 268)) --253 -- 258
	-- data.inP.AddChild(Image('Pictures/내부1.png', Rect(0, 0, 210, 268)))
	data.inP.SetOpacity(0)
	data.main_panel.AddChild(data.inP)
	
	-- local itempaneling = Image('Pictures/내부1.png', Rect(5, 5, 205, 298))
	-- data.main_panel.AddChild(itempaneling)
	

	data.scroll_panel = ScrollPanel(Rect(31, 0, data.Make_Panel2.width*0.440625-141, 320))-- 190
	data.scroll_panel.SetOpacity(0)
	data.scroll_panel.horizontal = false

	

    data.main_panel.AddChild(data.scroll_panel)

	
    -- data.inL = Panel(Rect(0, 0, 205, data.inP.height+30)) -- 285 -- 190
	-- data.scroll_panel.content = data.inL


	data.Choice_Panel = Panel(Rect(5, 0, 90, 308))
	data.Choice_Panel.setOpacity(0)
	-- data.Choice_Panel.color = Color(77, 77, 77, 255)
	
	data.Make_Panel2.AddChild(data.Choice_Panel)

    data.menwscroll_panel = ScrollPanel(Rect(0, 0, 115, 320)) --왼쪽 카테고리 스크롤패널
	data.menwscroll_panel.setOpacity(0)
	data.menwscroll_panel.horizontal = false

	data.Choice_Panel.AddChild(data.menwscroll_panel)



	-- data.WHfektnPanel = Panel(Rect(0, 0, 90, 100 ))
	-- data.WHfektnPanel.setOpacity(0)

	-- data.menwscroll_panel.AddChild(data.WHfektnPanel)
	-- data.menwscroll_panel.content = data.WHfektnPanel

	data.itemScrollPanel = ScrollPanel(Rect(0, 0, 190, 268)) -----아이템 패널 
	data.itemScrollPanel.horizontal = false
	data.itemScrollPanel.setOpacity(0)
	data.inP.AddChild(data.itemScrollPanel)

    
	data.itemScrollPaneladd = Panel(Rect(0, 0, 190, 268))-----아이템
	data.itemScrollPaneladd.setOpacity(0)

	data.itemScrollPanel.AddChild(data.itemScrollPaneladd)

	data.itemScrollPanel.content = data.itemScrollPaneladd



    
	data.mainMenuScrollPanel = ScrollPanel(Rect(10, 50, Client.width-20, 40))
	data.blick.AddChild(data.mainMenuScrollPanel)


	data.mainMenuScrollPanel.setOpacity(0)
	data.mainMenuScrollPanel.vertical = false

	data.mainMenuSon = Panel(Rect(0, 0, 105*(#data.MenuName.main), 32))
	data.mainMenuSon.setOpacity(0)

	data.mainMenuScrollPanel.AddChild(data.mainMenuSon)

	data.mainMenuScrollPanel.content = data.mainMenuSon
	data.happy_panel = {} data.Choice_but = {} data.happy_butSetimG = {} data.PanelColor = {}

	-- data.bagic2 = Color(111, 111, 111, 255)

    self.TopYellowPanel = Panel(Rect(110*(d-1), 38, 110, 2)) {
        color = Color(255, 189, 0)
        
     }
     data.mainMenuSon.AddChild(self.TopYellowPanel)


     


    for key, i in pairs(data.MenuName.main) do

        local TopCategole = Button('', Rect(110*(key-1), 0, 110, 38)) {
            textSize = 16,
            autoTranslate = true,
            text = i,
        }
        data.mainMenuSon.AddChild(TopCategole)
        TopCategole.setOpacity(0)

        TopCategole.onClick.Add(function()
            self.TopYellowPanel.rect = Rect(TopCategole.x, 38, 110, 2)
			c = key
			d = key
			a = 1
			b = 1
            self.TdTopLeftCategoleButtonTrgar = 1
			-- text3(data, i, UnitGold)
            self:LeftInforMation(key)
			return
		end)


    end


	-- text3(data, d, UnitGold)
	-- LoadingPanelDestroy()


    self:LeftInforMation(d)
	LoadingPanelDestroy()

end


function Making:LeftInforMation(i)

    

	-- data.WHfektnPanel.rect = Rect(0, 0, 90, 5+37*(#data.MenuName.index[tostring(i)]))

	data.ItemMakerMenu = nil
	data.ItemMakerCount = nil


    if data.WHfektnPanel ~= nil then
        data.WHfektnPanel.Destroy() data.WHfektnPanel = nil

    end


    data.WHfektnPanel = Panel(Rect(0, 0, 90, 5+37*(#data.MenuName.index[tostring(i)])))
	data.WHfektnPanel.setOpacity(0)

	data.menwscroll_panel.AddChild(data.WHfektnPanel)
	data.menwscroll_panel.content = data.WHfektnPanel



    local CategoleyellowP = Panel(Rect(0, 0, 2, 37)) {
        color = Color(255, 189, 0)
    }

    data.WHfektnPanel.AddChild(CategoleyellowP)

	if asd then asd.Destroy() asd = nil  end

    for n, value in pairs(data.MenuName.index[tostring(i)]) do

        data.Choice_but[n] =  Button(data.MenuName.index[tostring(i)][n], Rect(0, 37*(n-1), 109, 37)) {
            textSize = 15.5,
            autoTranslate = true,
            text = value,
        }
        data.Choice_but[n].setOpacity(0)
        data.WHfektnPanel.AddChild(data.Choice_but[n])

        data.Choice_but[n].onClick.Add(function()
			a = n
			c = i
			b = 1

            CategoleyellowP.rect = Rect(0, data.Choice_but[n].y, 2, 37)
            data.Choice_but[self.TdTopLeftCategoleButtonTrgar].setOpacity(0)
            data.Choice_but[self.TdTopLeftCategoleButtonTrgar].DOMove(Point(0, data.Choice_but[self.TdTopLeftCategoleButtonTrgar].y), 0.3)
            data.Choice_but[n].DOColor(Color(128, 128, 128, 255), 0.3)
            data.Choice_but[n].DOMove(Point(6, data.Choice_but[n].y), 0.3)
            self.TdTopLeftCategoleButtonTrgar = n



			self:ItemListF(n, i)
			return
		end)

    end

    CategoleyellowP.rect = Rect(0, 37*(self.TdTopLeftCategoleButtonTrgar-1), 2, 37)

    data.Choice_but[self.TdTopLeftCategoleButtonTrgar].color = Color(128, 128, 128, 255)
    data.Choice_but[self.TdTopLeftCategoleButtonTrgar].x = 6

    
	self:ItemListF(a, c)
end



function CountCheck(text)
	if text <= 0 then
		return false
	end
end


function Making:ItemListF(bb, i)
	if not data.MenuName.index[tostring(i)][bb] then
		a = 1
		b = 1
		bb = 1
	end

	data.ItemMakerMenu = nil
	data.ItemMakerCount = nil
	data.ItemMakerCountMin = nil
	data.ItemMakerDataID = nil
	if asd then asd.Destroy() asd = nil end


	-- for k, n in pairs(data.happy_but) do
	-- 	data.happy_butSetimG[k].Destroy()
	-- 	n.Destroy()
	-- end

    if data.inL ~= nil then
        data.inL.Destroy()
        data.inL = nil
    end

    data.inL = Panel(Rect(0, 0, data.scroll_panel.width, 45*#data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].dataID)) -- 285 -- 190
	data.inL.setOpacity(0)
	data.scroll_panel.content = data.inL


	-- data.inL.rect = Rect(0, 0, 205, 45*#data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].dataID)

	for j, n in pairs(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].dataID) do
		data.PanelColor[j] = Button('', Rect(0, 5+45*(j-1), data.inL.width, 40)) {
			color = Color(76, 78, 85, 255)
		}


		local inpanel = Panel(Rect(2.5, 2.5, data.inL.width-5, 35)) {
			color = Color(29, 30, 31, 255)
		}
		data.PanelColor[j].AddChild(inpanel)

		
		data.inL.AddChild(data.PanelColor[j])

		local icon_panel = Panel(Rect(3, 3, data.PanelColor[j].height-6, data.PanelColor[j].height-6))
		icon_panel.setOpacity(100) --- 0
		data.PanelColor[j].AddChild(icon_panel)

		local happy_image = Image('', Rect(0, 0, icon_panel.width, icon_panel.height))
		happy_image.SetImageID(Client.GetItem(n).imageID)
		icon_panel.AddChild(happy_image)

		local happy_text = Text(Client.GetItem(n).name, Rect(icon_panel.width+7, 0, data.PanelColor[j].width-icon_panel.width-10, data.PanelColor[j].height))
		happy_text.textSize = 14
		happy_text.textAlign = 3
		data.PanelColor[j].AddChild(happy_text)

		data.PanelColor[j].onClick.Add(function()
			data.PanelColor[b].color = Color(29, 30, 31, 255)
			data.PanelColor[j].color = Color(255, 189, 0)
			-- callback:ClickUpTest(data.happy_butSetimG[j])
			--j = 1
			self:ItemMakingFinel(i, j, n, bb)
			b = j
		end)
		if j == b then
			self:ItemMakingFinel(i, b, n, bb)
		end
	end

	data.PanelColor[b].color = Color(255, 189, 0)
end




function Making:ItemMakingFinel(i, j, n, bb)

	--data.happy_but[j].setOpacity(0)

	--print(i, j, n)
	local ItemCountVar = 1

	data.ItemMakerMenu = i
	data.ItemMakerCount = bb
	data.ItemMakerCountMin = j
	data.ItemMakerDataID = n
	data.ItemMakerVar = ItemCountVar

	local data2 = {}
	data2.ItemCount = {}
	data2.NowItemCoeuntText = {}
	data2.ItemCoeuntText = {}

	if asd then asd.Destroy() asd = nil  end
	asd = Panel(Rect(0, 0, 0, 0))
	-- asd.setOpacity(0)

	local aaasd = Panel(Rect(data.Make_Panel2.width*0.440625, 0, data.Make_Panel2.width*0.2625, 268))
	aaasd.setOpacity(255)
	asd.AddChild(aaasd)
	aaasd.AddChild(Image('Pictures/Gui/메인 패널.png', Rect(0, 0, aaasd.width, aaasd.height)))
	data.sendPanel.AddChild(asd)

	data2.ItemPanel = Panel(Rect(75, 10, 60, 60))

	-- 428125
	-- data2.ItemPanel.AddChild(Image('Pictures/아이템.png', Rect(0, 0, 60, 60)))

	aaasd.AddChild(data2.ItemPanel)

	data2.ItemImage = Image("", Rect(5, 5, 50, 50))
	data2.ItemImage.SetImageID(Client.GetItem(n).imageID)
	data2.ItemPanel.AddChild(data2.ItemImage)

	data2.ItemText = Text(Client.GetItem(n).name,Rect(-64, 63, 190, 25))
	data2.ItemText.textAlign = 1
	data2.ItemText.textSize = 14
	data2.ItemPanel.AddChild(data2.ItemText)

	----------아이템 정보창

	-- local a = Image('Pictures/내부1.png', Rect(5, 95, 200, 167))
	-- asd.AddChild(a)

	data2.sendPanelscroll_panel = ScrollPanel(Rect(5, 95, 200, 167))
	data2.sendPanelscroll_panel.setOpacity(0)
	data2.sendPanelscroll_panel.horizontal = false
	aaasd.AddChild(data2.sendPanelscroll_panel)

	data2.ItemTextPanel = Panel(Rect(0, 0, 204, 500))
	data2.sendPanelscroll_panel.AddChild(data2.ItemTextPanel)
	data2.sendPanelscroll_panel.content = data2.ItemTextPanel


	data2.ItemDescText = Text('종류:'..ItemType[Client.GetItem(n).type+1].."\n"..(Client.GetItem(n).canTrade == false and "<color=#FF0000>거래 불가능</color>\n" or "<color=#FF0000>거래 가능</color>\n")..Client.GetItem(n).desc, Rect(5, 5, 204, 500))
	data2.ItemDescText.textSize = 13.5
	data2.ItemDescText.textAlign = 0

	data2.ItemTextPanel.AddChild(data2.ItemDescText)
		
	----------아이템 정보창

	data2.itemScrollPanel = ScrollPanel(Rect(data.Make_Panel2.width*0.7125, 0, data.Make_Panel2.width*0.2875, 320)) -----아이템
	data2.itemScrollPanel.horizontal = false
	data2.itemScrollPanel.setOpacity(0)
	asd.AddChild(data2.itemScrollPanel)

	-- print(data2.itemScrollPanel.x, data2.itemScrollPanel.width)

	-- print(data2.itemScrollPanel.x)


	-- local a = Image('Pictures/아이템1.png', Rect(215, 0, 300, 268))

	-- data.itemScrollPanel.AddChild(a)
	

	--print(json.serialize(data.MenuList[data.MenuName[i]]))

	--print(json.serialize(data.MenuList[data.MenuName.index[tostring(i)]]))

	
--print(json.serialize(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][b]].itemdataID))
	--print(json.serialize(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][j]]))
	-- print(json.serialize(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][j]].itemdataID[tostring(j)]))
	

	data2.itemScrollPaneladd = Panel(Rect(0, 0, 210, 5+(2+#data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)])*62))-----아이템
	data2.itemScrollPaneladd.setOpacity(0)
	data2.itemScrollPanel.AddChild(data2.itemScrollPaneladd)
	data2.itemScrollPanel.content = data2.itemScrollPaneladd

	data2.ItemCount[1] = Panel(Rect(5, 5, data2.itemScrollPanel.width-10, 60))
	data2.ItemCount[1].setOpacity(255)
	data2.itemScrollPaneladd.AddChild(data2.ItemCount[1])

	data2.ItemCount[1].AddChild(Image('Pictures/Gui/ChoicePanel.png',Rect(0, 0, data2.ItemCount[1].width, 60)))
	
	local img = Image("Icons/Item_0091.png", Rect(10, 12.5, 35, 35))
	data2.ItemCount[1].AddChild(img)

	local ItemText = Text("골드",Rect(50, 10, 139, 30))
	ItemText.textAlign = 0
	ItemText.textSize = 12
	data2.ItemCount[1].AddChild(ItemText)

	local NowItemCount = data.Gold >= data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].gold[j] and CallBack:C_commaValue(data.Gold) or "<color=#FF0000>"..C_commaValue(data.Gold).."</color>"

	data2.ItemCoeuntText[1] = Text('소지:'..NowItemCount ,Rect(50, 25, 139, 30))
	data2.ItemCoeuntText[1].textAlign = 0
	data2.ItemCoeuntText[1].textSize = 11
	data2.ItemCount[1].AddChild(data2.ItemCoeuntText[1])


	data2.NowItemCoeuntText[1] = Text('필요:'..CallBack:C_commaValue(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].gold[j]), Rect(50, 40, 139, 30))
	data2.NowItemCoeuntText[1].textAlign = 0
	data2.NowItemCoeuntText[1].textSize = 11
	data2.ItemCount[1].AddChild(data2.NowItemCoeuntText[1])

	data2.ItemCount[2] = Panel(Rect(5, 67, data2.itemScrollPanel.width-10, 60))
	data2.ItemCount[2].setOpacity(255)
	data2.itemScrollPaneladd.AddChild(data2.ItemCount[2])

	data2.ItemCount[2].AddChild(Image('Pictures/Gui/ChoicePanel.png',Rect(0, 0, data2.ItemCount[2].width, 60)))

	local ItemText = Text("제작 성공 확률",Rect(50, 10, 139, 30))
	ItemText.textAlign = 0
	ItemText.textSize = 12
	data2.ItemCount[2].AddChild(ItemText)

	local img = Image("Pictures/Gui/heder.png", Rect(7.5, 13, 35, 35))  -- 재작모영
	--img.textSize = 30
	data2.ItemCount[2].AddChild(img)


	local ItemCoeuntText = Text('성공 확률:'..'<color=#74DF00>'..data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].chance[j]..'%'..'</color>', Rect(50, 25, 139, 30))
	ItemCoeuntText.textAlign = 0
	ItemCoeuntText.textSize = 11
	data2.ItemCount[2].AddChild(ItemCoeuntText)
	

	for k = 3, 2+#data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)] do

		data2.ItemCount[k] = Button('', Rect(5, 5+((k-1)*60)+((k-1)*2), data2.itemScrollPanel.width-10, 60))
		data2.ItemCount[k].SetOpacity(0)
		data2.ItemCount[k].onClick.Add(function()
			ItemDocePanelUp(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2], CallBack:C_commaValue(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)][k-2]))
		end)
		data2.ItemCount[k].AddChild(Image('Pictures/Gui/ChoicePanel.png',Rect(0, 0, data2.ItemCount[k].width, 60)))
		data2.itemScrollPaneladd.AddChild(data2.ItemCount[k])

		local img = Image("", Rect(10, 12.5, 35, 35))
		img.SetImageID(Client.GetItem(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2]).imageID)
		data2.ItemCount[k].AddChild(img)

		local ItemText = Text(Client.GetItem(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemdataID[tostring(j)][k-2]).name,Rect(50, 10, 159, 30))
		ItemText.textAlign = 0
		ItemText.textSize = 12
		data2.ItemCount[k].AddChild(ItemText)

		local NowItemCount = data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)][k-2] >= data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)][k-2] and CallBack:C_commaValue(data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)][k-2]) or "<color=#FF0000>"..CallBack:C_commaValue(data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)][k-2]).."</color>"

		data2.ItemCoeuntText[k-1] = Text('소지:'..NowItemCount ,Rect(50, 25, 139, 30))
		data2.ItemCoeuntText[k-1].textAlign = 0
		data2.ItemCoeuntText[k-1].textSize = 11
		data2.ItemCount[k].AddChild(data2.ItemCoeuntText[k-1])

		data2.NowItemCoeuntText[k-1] = Text('필요:'..CallBack:C_commaValue(data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)][k-2]), Rect(50, 40, 139, 30))
		data2.NowItemCoeuntText[k-1].textAlign = 0
		data2.NowItemCoeuntText[k-1].textSize = 11
		data2.ItemCount[k].AddChild(data2.NowItemCoeuntText[k-1])
	end
	data2.CountPanel = Panel(Rect(data.MakerButton.x-110, 325, 100, 25))
	data2.CountPanel.setOpacity(120)
	asd.AddChild(data2.CountPanel)

	data2.CountPanelText = Text(ItemCountVar, Rect(10, 5, 80, 25))
	data2.CountPanelText.textSize = 12
	data2.CountPanelText.textAlign = 1

	data2.CountPanel.AddChild(data2.CountPanelText)

	data2.PlusButtonX10 = Button('+10', Rect(data.MakerButton.x-185, 325, 65, 25))
	local PlusButtonX10Img =  Image('Pictures/Gui/밝버튼.png',Rect(data.MakerButton.x-185, 325, 65, 25))
	asd.AddChild(PlusButtonX10Img)
	data2.PlusButtonX10.setOpacity(0)
	data2.PlusButtonX10.textSize = 12
	asd.AddChild(data2.PlusButtonX10)

	data2.PlusButtonX10.onClick.Add(function()
		-- callback:ClickUpTest(PlusButtonX10Img)
		if ItemCountVar >= 990 then
			return false
		end
		ItemCountVar = ItemCountVar + 10
		data2.CountPanelText.text = ItemCountVar
		data.ItemMakerVar = ItemCountVar
		self:CountUpData(data2.NowItemCoeuntText, data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].gold[j], data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], ItemCountVar, data.Gold, data2.ItemCoeuntText, data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)])
	end)

	data2.PlusButtonX100 = Button('+100', Rect(data.MakerButton.x-260, 325, 65, 25))
	local PlusButtonX100 =  Image('Pictures/Gui/밝버튼.png',Rect(data.MakerButton.x-260, 325, 65, 25))
	asd.AddChild(PlusButtonX100)
	data2.PlusButtonX100.setOpacity(0)
	data2.PlusButtonX100.textSize = 12
	asd.AddChild(data2.PlusButtonX100)

	data2.PlusButtonX100.onClick.Add(function()
		-- callback:ClickUpTest(PlusButtonX100)
		if ItemCountVar >= 900 then
			return false
		end
		ItemCountVar = ItemCountVar + 100
		data2.CountPanelText.text = ItemCountVar
		data.ItemMakerVar = ItemCountVar
		self:CountUpData(data2.NowItemCoeuntText, data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].gold[j], data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], ItemCountVar, data.Gold, data2.ItemCoeuntText, data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)])
	end)

	data2.ResetButton = Button('Reset', Rect(data.MakerButton.x-335, 325, 65, 25))
	local ResetButton =  Image('Pictures/Gui/밝버튼.png', Rect(data.MakerButton.x-335, 325, 65, 25))
	asd.AddChild(ResetButton)
	data2.ResetButton.setOpacity(0)
	data2.ResetButton.textSize = 12
	asd.AddChild(data2.ResetButton)

	data2.ResetButton.onClick.Add(function()
		-- callback:ClickUpTest(ResetButton)
		ItemCountVar = 1
		data2.CountPanelText.text = ItemCountVar
		data.ItemMakerVar = ItemCountVar
		self:CountUpData(data2.NowItemCoeuntText, data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].gold[j], data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], ItemCountVar, data.Gold, data2.ItemCoeuntText, data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)])
	end)

	data2.PlusButton = Button('+', Rect(data2.CountPanel.x+75, 325, 25, 25))
	data2.PlusButton.setOpacity(20)
	asd.AddChild(data2.PlusButton)

	data2.PlusButton.onClick.Add(function()
		if ItemCountVar >= 1000 then
			return false
		end
		ItemCountVar = ItemCountVar + 1
		data2.CountPanelText.text = ItemCountVar
		data.ItemMakerVar = ItemCountVar
		self:CountUpData(data2.NowItemCoeuntText, data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].gold[j], data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], ItemCountVar, data.Gold, data2.ItemCoeuntText, data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)])
	end)

	data2.DownButton = Button('-', Rect(data2.CountPanel.x, 325, 25, 25))
	data2.DownButton.setOpacity(20)
	asd.AddChild(data2.DownButton)

	data2.DownButton.onClick.Add(function()
		if ItemCountVar <= 1 then
			return false
		end
		ItemCountVar = ItemCountVar - 1
		data2.CountPanelText.text = ItemCountVar
		data.ItemMakerVar = ItemCountVar
		self:CountUpData(data2.NowItemCoeuntText, data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].gold[j], data.MenuList[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].itemcount[tostring(j)], ItemCountVar, data.Gold, data2.ItemCoeuntText, data.ItemCount[data.MenuName.main[i]][data.MenuName.index[tostring(i)][bb]].data[tostring(j)])
	end)
	
end

function Making:CountUpData(data, gold, itemcount, var, nowgold, data2, nowitem)
	data2[1].text = '소지:'..(nowgold >= gold*var and CallBack:C_commaValue(nowgold) or "<color=#FF0000>"..CallBack:C_commaValue(nowgold).."</color>")

	data[1].text = '필요:'..CallBack:C_commaValue(gold*var)
	
	for i = 2, #data do
		data2[i].text = '소지:'..(nowitem[i-1] >=itemcount[i-1]*var and CallBack:C_commaValue(nowitem[i-1]) or "<color=#FF0000>"..CallBack:C_commaValue(nowitem[i-1]).."</color>")
		data[i].text = '필요:'..(CallBack:C_commaValue(itemcount[i-1]*var))
	end
end





Client.GetTopic("make:down").Add(function(MenuName, MenuList, ItemCount, UnitGold)
    Making:MakingGetTopicUp(MenuName, MenuList, ItemCount, UnitGold)
end)



function Making:ShowAnimationTotal()
    self:ShowAnimation()
	-- LoadingPanelUp()
    Client.FireEvent("make:Up")
end



Making:initialize()



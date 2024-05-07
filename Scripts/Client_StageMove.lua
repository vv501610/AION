---@diagnostic disable: undefined-global
local Mdata = require('DataBase/MonsterDataBase')

local Class = require("Utils/_001_midclass")
local Main = require("_005_Client_MainGui")
local CallBack = require("Utils/_002_Client_CallBackFunction")

Stage = Class('Stage', Main)




Stage.Rect = Rect(Client.width/2 - 385, Client.height/2 - 190, 770, 360)

Stage.PanelName = "이동"


Stage.TopYellowPanelTrgre = '개인 사냥터' -- 매개인수 자료타입이 키값


Stage.HelpTitleText = '도움말'
Stage.HelpTextext = '개인 사냥터및 공용 공간으로 이동할 수 있습니다.'


Stage.TopPanelData = {
    Image = {"Pictures/Gui/BattlePower.png"},
    value = {
        [1] = function ()
                return CallBack:C_commaValue(CallBack.BattlePower)
            
        end,

    }
}


Stage.StageGroundData = {MainPanelLoock = {a1 = {}}}

Stage.MainPanelLoock = {a1 = {}, a2 = {}}


function Stage:initialize()
    self:BackGrundPanelUp()
    self:DungeonUp()
    self:Close()
end



function Stage:DungeonUp()
    Client.FireEvent("Stage:PanelUp")

    self.BlackPanel.AddChild(Panel(Rect(10, 88, Client.width-20, 2)) {color = Color(132, 132, 132, 255)})

    self.menwscroll_panel = ScrollPanel(Rect(10, 50, Client.width-20, 40)) {
        vertical = false,
    }

    self.menwscroll_panel.setOpacity(0)
	self.BlackPanel.AddChild(self.menwscroll_panel)

	self.WHfektnPanel = Panel(Rect(0, 0, 0, 0))
	self.WHfektnPanel.setOpacity(0)

	self.menwscroll_panel.AddChild(self.WHfektnPanel)
	self.menwscroll_panel.content = self.WHfektnPanel

end


function Stage:DungeonGetTopicUp(list)
    self.data = json.parse(list)

    self.TopYellowPanel = Panel(Rect(0, 38, 90, 2)) {
        color = Color(255, 189, 0)
        
     }
     self.WHfektnPanel.AddChild(self.TopYellowPanel)

    local categorycount = 0
    for key, _ in pairs(self.data) do
        categorycount = categorycount + 1

        local TopCategole = Button('', Rect(110*(categorycount-1), 0, 110, 38)) {
            textSize = 16,
            autoTranslate = true,
            text = key,

            -- borderDistance = Point(1, 1),
            -- borderEnabled = true,
        }
        self.WHfektnPanel.AddChild(TopCategole)
        TopCategole.setOpacity(0)

        TopCategole.onClick.Add(function()
            self.TopYellowPanel.rect = Rect(TopCategole.x, 38, 110, 2)
            self:TopCaTegoleClick(key)
        end)
    end
    self:TopCaTegoleClick('개인 사냥터')
    self.WHfektnPanel.rect = Rect(0, 0, 2+110*categorycount, 32)
end

function Stage:TopCaTegoleClick(name) -- 맨 위 카테고리 버튼 클릭시
    if self.TopTempPanel ~= nil then
        self.TopTempPanel.Destroy()
        self.TopTempPanel = nil
    end
    self.TopTempPanel = Panel(Rect(5, 83, 790, 397))

    self.TopTempPanel.setOpacity(0)
    self.BlackPanel.AddChild(self.TopTempPanel)

    if name == '개인 사냥터' then
        self:StageGround(name)
        return false
    end
    self:ClickPublicReturn(self.data[name]) -- 개인사냥터 제외 표준 이동 데이터 
end




function Stage:StageGround(name) -- 개인 사냥터 따로 처리 -----------------------------------------maingui


    self.StageGroundData.menwscroll_panel = ScrollPanel(Rect(3, 40, Client.width-16, 295)) {
        showHorizontalScrollbar = true,
        vertical = false,
    }
    
    self.StageGroundData.menwscroll_panel.horizontalScrollbar.color = Color(27, 32, 39, 255)
    self.StageGroundData.menwscroll_panel.horizontalScrollbar.handlerColor = Color(100, 100, 100, 255)
    self.StageGroundData.menwscroll_panel.horizontalScrollbar.scaleY = 0.8
    self.StageGroundData.menwscroll_panel.setOpacity(0)
	self.TopTempPanel.AddChild(self.StageGroundData.menwscroll_panel)



    self.StageGroundData.WHfektnPanel = Panel(Rect(0, 0, 0, 0))
	self.StageGroundData.WHfektnPanel.setOpacity(0)

	self.StageGroundData.menwscroll_panel.AddChild(self.StageGroundData.WHfektnPanel)
	self.StageGroundData.menwscroll_panel.content = self.StageGroundData.WHfektnPanel

    local count = 0

    for i, value in pairs(self.data[name]) do

        count = count + 1

        self.StageGroundData.MainPanelLoock.a1[i] = Image("Pictures/Gui/메인 패널.png", Rect(3.5+(252.5*(count-1)), 0, 248, 275))
        self.StageGroundData.WHfektnPanel.AddChild(self.StageGroundData.MainPanelLoock.a1[i])

        self.StageGroundData.MainPanelLoock.a1[i].AddChild(Image("Pictures/Dungeon/"..value.img, Rect(1.25, 2.5, 245, 270)))

        local bildpanel = Panel(Rect(1.25, 197.5, 245, 75.5))
        bildpanel.SetOpacity(150)
        self.StageGroundData.MainPanelLoock.a1[i].AddChild(bildpanel)

        local teane2 = Text('', Rect(0, 5, 245, 100)) {
            autoTranslate = true,
            text = i,
            textSize = 17,
            textAlign = 1,
            borderDistance = Point(1, 1),
            borderEnabled = true,
        }
        bildpanel.AddChild(teane2)

        local tean3 = Text('', Rect(0, 30, 240, 100)){
            autoTranslate = true,
            text = value.explanation,
            color = Color(220, 220, 220, 255),
            textSize = 13,
            textAlign = 1,
            borderDistance = Point(1, 1),
            borderEnabled = true,
        }
        bildpanel.AddChild(tean3)

        local a = Button('', Rect(0, 0, 248, 275))
        a.SetOpacity(0)
        self.StageGroundData.MainPanelLoock.a1[i].AddChild(a)

        a.onClick.Add(function()
            if value.bool > Client.myPlayerUnit.level then
                Client.ShowCenterLabel("해당 지역은 Lv:"..CallBack:C_commaValue(value.bool)..'부터 이동 가능합니다.')
                return false
            end
            self:ClickPublicReturn(self.data[name][i])
        end)


        Client.RunLater(function ()
            if value.bool > Client.myPlayerUnit.level then
                local MainPanelLoocka2 = Panel(Rect(0, 0, 248, 275))
                MainPanelLoocka2.SetOpacity(190)
                a.AddChild(MainPanelLoocka2)
    
                MainPanelLoocka2.AddChild(Image('Pictures/Gui/premium-icon-padlock-3934062.png', Rect(94, 60, 60, 60)))
    
                local text = Text('', Rect(0, 175, 248, 100)){
                    borderDistance = Point(1, 1),
                    borderEnabled = true,
                    color = Color(255, 51, 51, 255),
                    textSize = 18,
                    textAlign = 1,
                    autoTranslate = true,
                    text = 'Lv: '..CallBack:C_commaValue(value.bool)..'부터 이용 가능합니다.',
                }
                MainPanelLoocka2.AddChild(text)
            end
            
        end, 0.5)
    end

    self.StageGroundData.WHfektnPanel.rect = Rect(0, 0, 2+253*count, 270)
end


function Stage:ClickPublicReturn(name) -- 표준 이동 함수
    self.TdTopLeftCategoleButtonTrgar = next(name.data) -- 첫번째 문자열을 가져와서 저장

    self.TopLeftCategoleButton = {}

    if self.TopTempPanel ~= nil then
        self.TopTempPanel.Destroy()
        self.TopTempPanel = nil
    end
    self.TopTempPanel = Panel(Rect(5, 83, 790, 397))
    self.TopTempPanel.setOpacity(0)
    self.BlackPanel.AddChild(self.TopTempPanel)



    local data = {}
    data.count = 0

    data.TopleftScrollPanel = ScrollPanel(Rect(5, 20, 115, Client.height-120)) {
        horizontal = false,
    }
    data.TopleftScrollPanel.setOpacity(0)
    self.TopTempPanel.AddChild(data.TopleftScrollPanel)

    data.TopleftScrollPanelChild = Panel(Rect(0, 0, 0, 0))
	data.TopleftScrollPanelChild.setOpacity(0)

	data.TopleftScrollPanel.AddChild(data.TopleftScrollPanelChild)
	data.TopleftScrollPanel.content = data.TopleftScrollPanelChild
    -- print(Utility.JSONParse(name.data))


    local CategoleyellowP = Panel(Rect(0, 0, 2, 37)) {
        color = Color(255, 189, 0)
     }
     data.TopleftScrollPanelChild.AddChild(CategoleyellowP)
    
    for key, value in pairs(name.data) do
        data.count  = data.count + 1
        -- local c = data.count
        -- print(key, value)

        self.TopLeftCategoleButton[key] = Button('', Rect(0, 37*(data.count-1), 109, 37)) {
            textSize = 15.5,
            autoTranslate = true,
            text = key,
        }
        self.TopLeftCategoleButton[key].setOpacity(0)
        data.TopleftScrollPanelChild.AddChild(self.TopLeftCategoleButton[key])

        self.TopLeftCategoleButton[key].onClick.Add(function()

            CategoleyellowP.rect = Rect(0, self.TopLeftCategoleButton[key].y, 2, 37)

            self.TopLeftCategoleButton[self.TdTopLeftCategoleButtonTrgar].setOpacity(0)
            -- self.TopLeftCategoleButton[key].setOpacity(180)
            self.TopLeftCategoleButton[self.TdTopLeftCategoleButtonTrgar].DOMove(Point(0, self.TopLeftCategoleButton[self.TdTopLeftCategoleButtonTrgar].y), 0.3)


            self.TopLeftCategoleButton[key].DOColor(Color(128, 128, 128, 255), 0.3)
            self.TopLeftCategoleButton[key].DOMove(Point(6, self.TopLeftCategoleButton[key].y), 0.3)
            self.TdTopLeftCategoleButtonTrgar = key

            self:SecendCategoleClick(value)
        end)

    end

    self.TopLeftCategoleButton[self.TdTopLeftCategoleButtonTrgar].color = Color(128, 128, 128, 255)
    self.TopLeftCategoleButton[self.TdTopLeftCategoleButtonTrgar].x = 6

    self.NameScrollPanel = ScrollPanel(Rect(130, 20, self.BlackPanel.width-145, self.BlackPanel.height - 120)) {
        horizontal = false
    }

    self.NameScrollPanel .setOpacity(0)
    self.TopTempPanel.AddChild(self.NameScrollPanel)

    self:SecendCategoleClick(name.data[self.TdTopLeftCategoleButtonTrgar]) -- 변수값 추가

end


function Stage:SecendCategoleClick(data) -- 하위 두번째 카테고리 클릭시
    self.SecendCategoleInButtonImg = {}
    self.SecendCategoleInButtonTrgger = 1


    if self.NameScrollPanelcontent ~= nil then
        self.NameScrollPanelcontent.Destroy()
    end

    self.NameScrollPanelcontent = Panel(Rect(0, 0, self.NameScrollPanel.width, 105*#data.MonsterDataID)) 
    self.NameScrollPanelcontent.setOpacity(0)
    self.NameScrollPanel.AddChild(self.NameScrollPanelcontent)
    self.NameScrollPanel.content = self.NameScrollPanelcontent

    -- print(Utility.JSONSerialize(data))

    
    
    local GetMonster = Client.GetMonster

    local GetItem = Client.GetItem

    for key, value in ipairs(data.MonsterDataID) do
 
        self.SecendCategoleInButtonImg[key] = Panel(Rect(0, 105*(key-1), self.NameScrollPanel.width, 100))
        self.NameScrollPanelcontent.AddChild(self.SecendCategoleInButtonImg[key])

        self.SecendCategoleInButtonImg[key].setOpacity(150)


        local characterImg = Image('Pictures/Gui/투명.png', Rect(0, 0, 100, 100))
        characterImg.SetTargetSprite(GetMonster(value).imageID, 0)
        self.SecendCategoleInButtonImg[key].AddChild(characterImg)

        local MonstenameText = Text('', Rect(120, 10, 180, 45)) {
            textAlign = 0,
            textSize = 18,
            autoTranslate = true,
            text = GetMonster(value).name,
            borderDistance = Point(1, 1),
            borderEnabled = true,
        }
        self.SecendCategoleInButtonImg[key].AddChild(MonstenameText)

        local PowerText = Text('', Rect(120, 34, 180, 45)) {
            textAlign = 0,
            textSize = 14,
            text = '전투력:'..CallBack:C_commaValue(MonsterCombatPower(value)),

            color = Color(255, 0, 0, 255)
        }

        self.SecendCategoleInButtonImg[key].AddChild(PowerText)

        local atk = Text('', Rect(120, 50, 245, 20)) {
            textAlign = 0,
            textSize = 14,
            autoTranslate = true,
            text = '공격력:'..CallBack:C_commaValue(Client.GetMonster(value).attack),
            color = Color(128, 128, 128, 255)
        }
        self.SecendCategoleInButtonImg[key].AddChild(atk)
    
        local def = Text('', Rect(120, 66, 245, 20)) {
            textAlign = 0,
            textSize = 14,
            autoTranslate = true,
            text = '방어력:'..CallBack:C_commaValue(Client.GetMonster(value).defense),
            color = Color(128, 128, 128, 255)
        }
        self.SecendCategoleInButtonImg[key].AddChild(def)

        local inimg = Image("Pictures/Gui/ChoicePanel.png", Rect(300, 25, self.BlackPanel.width - 550, 50))
        inimg.imageType = 1

        self.SecendCategoleInButtonImg[key].AddChild(inimg)


        
        local ScrollDropPanel = ScrollPanel(Rect(300, 25, self.BlackPanel.width - 550, 50))

        ScrollDropPanel.setOpacity(0)
        ScrollDropPanel.vertical = false
        self.SecendCategoleInButtonImg[key].AddChild(ScrollDropPanel)

        

        local TempPanel = Panel(Rect(0, 0, 45*(#Mdata[value].dropitem.dataid + (data.type and 0 or 2)), 70))
        TempPanel.setOpacity(0)

        ScrollDropPanel.AddChild(TempPanel)
        ScrollDropPanel.content = TempPanel

        local iii = 0

        if Mdata[value].exp ~= 0 then
            for i = 5, 6 do
                iii = iii + 1

                local a = Button('', Rect(5+45*(iii-1), 5, 40, 40))
                a.setOpacity(0)
                TempPanel.AddChild(a)
                a.onClick.Add(function()
                    ItemDocePanelUp(i)
                end)
                a.AddChild(Image("Pictures/Gui/slot_new.png", Rect(0, 0, 40, 40)))

                local PanelImage = Image('', Rect(2.5, 2.5, 35, 35))
                PanelImage.SetImageID(GetItem(i).imageID)
                a.AddChild(PanelImage)
                
            end
        end

        for _, v in pairs(Mdata[value].dropitem.dataid) do
            iii = iii + 1

            local a = Button('', Rect(5+45*(iii-1), 5, 40, 40))
            a.setOpacity(0)
            TempPanel.AddChild(a)
            a.onClick.Add(function()
                ItemDocePanelUp(v)
            end)
            a.AddChild(Image("Pictures/Gui/slot_new.png", Rect(0, 0, 40, 40)))
            local PanelImage = Image('', Rect(2.5, 2.5, 35, 35))
            PanelImage.SetImageID(GetItem(v).imageID)
            a.AddChild(PanelImage)
        end

        if #TempPanel.children == 0 then
            local t = Text("", Rect(5, 17, 200, 25)) {
                textAlign = 0,
                autoTranslate = true,
                borderDistance = Point(1, 1),
                borderEnabled = true,
                text = "보상 정보를 확인 할 수 없습니다.",
            }
            TempPanel.AddChild(t)
        end


        self.SecendCategoleInButtonImg[key].AddChild(Image("Pictures/Gui/밝버튼.png", Rect(ScrollDropPanel.x + ScrollDropPanel.width +10, 35, 80, 30)))

        local FinishB = Button('이동', Rect(ScrollDropPanel.x + ScrollDropPanel.width +10, 35, 80, 30))
        FinishB.onClick.Add(function()
            Client.FireEvent("Stage:ServerMoveDataup", json.serialize(data), key)
            self:CloseAnimation()
        end)
        FinishB.setOpacity(0)
        self.SecendCategoleInButtonImg[key].AddChild(FinishB)
    end
end


-- function Stage:LevelUpStageReset() --- 레벨업시 레벨부분 초기화

--     for n = 1, #self.MainPanelLoock.a1 do
--         if self.DunGeonData.bool[n] <= Client.myPlayerUnit.level then
--             if self.MainPanelLoock.a2[n] ~= 0 then
--                 self.MainPanelLoock.a2[n].Destroy()
--                 self.MainPanelLoock.a2[n] = 0
--             end
--         end
--     end
-- end



Client.GetTopic("Client:Stage:ServerDataUp").Add(function(list)
    Stage:DungeonGetTopicUp(list)
end)


Stage:initialize()


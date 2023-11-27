---@diagnostic disable: undefined-global
local data = require('DataBase/MonsterDataBase')

local Class = require("_001_midclass")

Stage = Class('Stage', MainGui)




Stage.Rect = Rect(Client.width/2 - 385, Client.height/2 - 190, 770, 360)

Stage.PanelName = "이동"


Stage.TopYellowPanelTrgre = '개인 사냥터' -- 매개인수 자료타입이 키값

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




function MainGui:StageGround(name) -- 개인 사냥터 따로 처리


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
                Client.ShowCenterLabel("해당 지역은 Lv:"..C_commaValue(value.bool)..'부터 이동 가능합니다.')
                return false
            end
            self:ClickPublicReturn(self.data[name][i])
        end)


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
                text = 'Lv: '..C_commaValue(value.bool)..'부터 이용 가능합니다.',
            }
            MainPanelLoocka2.AddChild(text)
        end
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

    data.TopleftScrollPanel = ScrollPanel(Rect(5, 20, 115, Client.height-135)) {
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

    self.NameScrollPanel = ScrollPanel(Rect(130, 20, self.BlackPanel.width*0.275, 300)) {
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

    self.NameScrollPanelcontent = Panel(Rect(0, 0, self.NameScrollPanel.width, 50*#data.MonsterDataID)) 
    self.NameScrollPanelcontent.setOpacity(0)
    self.NameScrollPanel.AddChild(self.NameScrollPanelcontent)
    self.NameScrollPanel.content = self.NameScrollPanelcontent

    -- print(Utility.JSONSerialize(data))

    
    
    local GetMonster = Client.GetMonster

    for key, value in ipairs(data.MonsterDataID) do
        local button = Button('', Rect(0, 50*(key-1), self.NameScrollPanel.width, 45))
        button.setOpacity(0)
        self.NameScrollPanelcontent.AddChild(button)

        self.SecendCategoleInButtonImg[key] = Image('Pictures/Gui/ChoicePanel(255, 45).png',Rect(0, 0, self.NameScrollPanel.width, 45))
        button.AddChild(self.SecendCategoleInButtonImg[key])


        local characterImg = Image('Pictures/Gui/투명.png', Rect(2.5, 2.5, 40, 40))
        characterImg.SetTargetSprite(GetMonster(value).imageID, 0)
        self.SecendCategoleInButtonImg[key].AddChild(characterImg)

        local MonstenameText = Text('', Rect(50, 15, 180, 45)) {
            textAlign = 0,
            textSize = 15,
            autoTranslate = true,
            text = GetMonster(value).name,
            borderDistance = Point(1, 1),
            borderEnabled = true,
        }



        self.SecendCategoleInButtonImg[key].AddChild(MonstenameText)
        
        button.onClick.Add(function()
            self.SecendCategoleInButtonImg[self.SecendCategoleInButtonTrgger].image = 'Pictures/Gui/ChoicePanel(255, 45).png'
            self.SecendCategoleInButtonImg[key].image = 'Pictures/Gui/ChoicePanelYellow(255, 45).png'
            self.SecendCategoleInButtonTrgger = key

            self:MonSterDataDetailed(data, key)
            
        end)
    end


    self.SecendCategoleInButtonImg[self.SecendCategoleInButtonTrgger].image = 'Pictures/Gui/ChoicePanelYellow(255, 45).png'
    self:MonSterDataDetailed(data, self.SecendCategoleInButtonTrgger)
    

    
end


function Stage:MonSterDataDetailed(data, number)

    if self.FinalPanel ~= nil then
        self.FinalPanel.Destroy()
    end
    self.FinalPanel = Image('Pictures/Gui/메인 패널 세로.png', Rect(self.NameScrollPanel.width+140, 20, 250, 300))
    self.TopTempPanel.AddChild(self.FinalPanel)


    local backimgpael = Panel(Rect(90, 10, 70, 70))
    backimgpael.setOpacity(180)
    self.FinalPanel.AddChild(backimgpael)

    local characterImg = Image('Pictures/Gui/투명.png', Rect(2.5, 2.5, 65, 65))
    characterImg.SetTargetSprite(Client.GetMonster(data.MonsterDataID[number]).imageID, 0)
    backimgpael.AddChild(characterImg)

    local UnitName = Text('', Rect(0, 85, 250, 45)) {
        textAlign = 1,
        textSize = 16,
        autoTranslate = true,
        text = Client.GetMonster(data.MonsterDataID[number]).name,
        borderDistance = Point(1, 1),
        borderEnabled = true,
    }
    self.FinalPanel.AddChild(UnitName)

    local inpanel = Panel(Rect(1.2, 105, 247, 150))

    inpanel.setOpacity(180)
    self.FinalPanel.AddChild(inpanel)

    local Porwer = Text('', Rect(5, 5, 245, 20)) {
        textAlign = 0,
        autoTranslate = true,
        text = '전투력:'..C_commaValue(MonsterCombatPower(0))
    }
    inpanel.AddChild(Porwer)

    local hp = Text('', Rect(5, 22, 245, 20)) {
        textAlign = 0,
        autoTranslate = true,
        text = '체력:'..C_commaValue(Client.GetMonster(data.MonsterDataID[number]).maxHP)
    }
    inpanel.AddChild(hp)
    

    local atk = Text('', Rect(5, 39, 245, 20)) {
        textAlign = 0,
        autoTranslate = true,
        text = '공격력:'..C_commaValue(Client.GetMonster(data.MonsterDataID[number]).attack)
    }
    inpanel.AddChild(atk)

    local def = Text('', Rect(5, 56, 245, 20)) {
        textAlign = 0,
        autoTranslate = true,
        text = '방어력:'..C_commaValue(Client.GetMonster(data.MonsterDataID[number]).defense)
    }
    inpanel.AddChild(def)



    print(data.MonsterDataID[number])


    


    -- local characterPath = "Characters/몬스터/Monster_0003.png" -- 캐릭터 스프라이트 파일 경로
    -- local actionName = "left" -- 가져올 액션 이름

    -- local spriteAction = Client.GetSpriteAction(characterPath, actionName)

    -- print(spriteAction.image[1])

    
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



---@diagnostic disable: undefined-global
local data = require('DataBase/MonsterDataBase')

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

    self.BlackPanel.AddChild(Panel(Rect(10, 81, Client.width-20, 2)) {color = Color(132, 132, 132, 255)})

    self.menwscroll_panel = ScrollPanel(Rect(10, 50, Client.width-20, 33)) {
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

    self.TopYellowPanel = Panel(Rect(0, 31, 90, 2)) {
        color = Color(255, 189, 0)
     }
     self.WHfektnPanel.AddChild(self.TopYellowPanel)

    local categorycount = 0
    for key, _ in pairs(self.data) do
        categorycount = categorycount + 1

        local TopCategole = Button('', Rect(90*(categorycount-1), 0, 90, 31)) {
            autoTranslate = true,
            text = key,

            -- borderDistance = Point(1, 1),
            -- borderEnabled = true,
        }
        self.WHfektnPanel.AddChild(TopCategole)
        TopCategole.setOpacity(0)

        TopCategole.onClick.Add(function()
            self.TopYellowPanel.rect = Rect(TopCategole.x, 31, 90, 2)
            self:TopCaTegoleClick(key)
        end)
    end
    self:TopCaTegoleClick('개인 사냥터')
    self.WHfektnPanel.rect = Rect(0, 0, 2+253*categorycount, 32)
end

function Stage:TopCaTegoleClick(name) -- 맨 위 카테고리 버튼 클릭시
    if self.TopTempPanel ~= nil then
        self.TopTempPanel.Destroy()
        self.TopTempPanel = nil
    end
    self.TopTempPanel = Panel(Rect(5, 85, Client.width-10, Client.height-85))
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
    self.TopTempPanel = Panel(Rect(5, 83, Client.width-10, Client.height-83))
    self.TopTempPanel.setOpacity(0)
    self.BlackPanel.AddChild(self.TopTempPanel)


    local data = {}
    data.count = 0

    data.TopleftScrollPanel = ScrollPanel(Rect(5, 40, 90, Client.height-135)) {
        horizontal = false,
    }
    self.TopTempPanel.AddChild(data.TopleftScrollPanel)

    data.TopleftScrollPanelChild = Panel(Rect(0, 0, 0, 0))
	data.TopleftScrollPanelChild.setOpacity(0)

	data.TopleftScrollPanel.AddChild(data.TopleftScrollPanelChild)
	data.TopleftScrollPanel.content = data.TopleftScrollPanelChild
    -- print(Utility.JSONParse(name.data))

    
    for key, value in pairs(name.data) do
        data.count  = data.count + 1
        print(key, value)

        self.TopLeftCategoleButton[key] = Button('', Rect(0, 29*(data.count-1), 90, 29)) {
            autoTranslate = true,
            text = key,
        }
        self.TopLeftCategoleButton[key].setOpacity(0)
        data.TopleftScrollPanelChild.AddChild(self.TopLeftCategoleButton[key])

        self.TopLeftCategoleButton[key].onClick.Add(function()
            self.TopLeftCategoleButton[self.TdTopLeftCategoleButtonTrgar].setOpacity(0)
            self.TopLeftCategoleButton[key].setOpacity(255)
            self.TdTopLeftCategoleButtonTrgar = key

            self:SecendCategoleClick(value)
        end)

    end


    self:SecendCategoleClick(name.data[self.TdTopLeftCategoleButtonTrgar]) -- 변수값 추가/ 

    self.TopLeftCategoleButton[self.TdTopLeftCategoleButtonTrgar].setOpacity(255)


end


function Stage:SecendCategoleClick(data) -- 하위 두번째 카테고리 클릭시

    print(data)
    -- Client.ShowCenterLabel("클릭됨")


    print'깃테스트' -- 이부분 깃허브에서 수정한 부분임

    print'이건 노트북에서 수정한 부분임'
    print'2차로 노트으로 가져오는지 확인'
	



    
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

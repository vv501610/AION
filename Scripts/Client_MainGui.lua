---@diagnostic disable: undefined-global, inject-field, undefined-field

local Class = require("_001_midclass")
MainGui = Class('MainGui'):include(Singleton)



-- MainGui.Rect = Rect(0, 0, 600, 300)

MainGui.PanelName = "채널 이동"



MainGui.TopPanelData = {
    Image = {"Icons/Item_0089.png", "Icons/Item_0090.png", "Icons/Item_0091.png"},
    value = {'2/3', 1, 2}

}
-- MainGui.Ysize = {}

MainGui.TopPanelTable = {P = {}, I = {}, T = {}}



-- function MainGui:GetAllChildren(parent) -- 자식들 다 가져오는 함수
--     local children = {}
--     local function RecursiveGetChildren(obj)
--         for i, child in ipairs(obj.children) do
--             table.insert(children, child)
--             -- child.y = child.y - 50
--             -- table.insert(self.Ysize, child.y)
--             RecursiveGetChildren(child)
--         end
--     end
--     RecursiveGetChildren(parent)
--     return children
-- end


function MainGui:initialize()
    self:BackGrundPanelUp()
    self:Close()
end


function MainGui:BackGrundPanelUp()

    self.BackGrundPanel = Panel(Rect(0, 0, Client.width, Client.height))

    self.BackGrundPanel.showOnTop = true
    self.BackGrundPanel.visible = false

    self.BackWhitekPanel = Image("Pictures/EntireScrean/NomalPanel2.png", Rect(0, 0, Client.width, Client.height))

    self.BackGrundPanel.AddChild(self.BackWhitekPanel)

    self.BlackPanel = Panel(Rect(0, -self.BackWhitekPanel.height+50, self.BackGrundPanel.width, self.BackWhitekPanel.height)) -- 부모패널
    self.BlackPanel.SetOpacity(0)
    self.BackWhitekPanel.AddChild(self.BlackPanel)

    self.PanelName = Text('', Rect(40, -30, 100, 25)){
        autoTranslate = true,
        text = self.PanelName,
        textAlign = 0,
        textSize = 20,
        borderDistance = Point(1, 1),
        borderEnabled = true,
    }

    self.BackWhitekPanel.AddChild(self.PanelName)

    self:TopPanel()
end

function MainGui:TopPanel()

    for key = 1, #self.TopPanelData.Image do
        local rr = Client.width - 200 -((1-key)*-120)
        self.TopPanelTable.P[key] = Image('Pictures/EntireScrean/골드패널2.png',Rect(rr, -20, 110, 20))
        self.BackWhitekPanel.AddChild(self.TopPanelTable.P[key])

        self.TopPanelTable.I[key] = Image(self.TopPanelData.Image[key], Rect(rr, -20, 20, 20))
        self.BackWhitekPanel.AddChild(self.TopPanelTable.I[key])

        self.TopPanelTable.T[key] = Text(self.TopPanelData.value[key], Rect(rr, -20, 110, 20)) {
            textAlign = 1,
            pivotY = -0.1,
            borderDistance = Point(1, 1),
            borderEnabled = true,
        }
        self.BackWhitekPanel.AddChild(self.TopPanelTable.T[key])
    end
    


    self.HelpButton = Button('', Rect(self.BackWhitekPanel.width - 75, -20, 0, 0)) -- 도움버튼
    self.BackGrundPanel.AddChild(self.HelpButton)
    self.HelpImg = Image('Pictures/EntireScrean/help2.png', Rect(0, 0, 25, 25))

    self.HelpButton.AddChild(self.HelpImg)



end



function MainGui:Close()

    self.CloseButton = Button('', Rect(self.BackWhitekPanel.width - 40, -30, 40, 40))
    self.CloseButton.SetOpacity(0)
    self.CloseButtonText = Text('✕', Rect(0, 0, 40, 40)) {
        textAlign = 0,
        textSize = 31
    }

    self.CloseButton.AddChild(self.CloseButtonText)
    self.BackWhitekPanel.AddChild(self.CloseButton)

    self.CloseButton.onClick.Add(function()
        self:CloseAnimation()
    end)

    self.LeftCloseButton = Button('', Rect(5, -30, 30, 50))
    self.LeftCloseButton.SetOpacity(0)
    self.LeftCloseButtonText = Text('◀', Rect(0, 0, 30, 50)) {
        textAlign = 0,
        textSize = 26
    }

    self.LeftCloseButton.AddChild(self.LeftCloseButtonText)
    self.BackWhitekPanel.AddChild(self.LeftCloseButton)
    self.LeftCloseButton.onClick.Add(function()
        self:CloseAnimation()
    end)
end


function MainGui:CloseAnimation() -- 닫기 애니메이션

    self.PanelName.DOMove(Point(40, -30), 0.3).DONumber(255, 0, 0.3, function(value) ---GUi이름 이동, 투명
        self.PanelName.SetOpacity(value)
    end)


    self.CloseButton.DOMove(Point(self.BlackPanel.width - 40, -30), 0.3).DONumber(255, 0, 0.3, function(value) --닫기 버튼 이동, 투명
        self.CloseButtonText.SetOpacity(value)
    end)

    self.LeftCloseButton.DOMove(Point(5, -30), 0.3).DONumber(255, 0, 0.3, function(value) --왼쪽 닫기 버튼 이동, 투명
        self.LeftCloseButtonText.SetOpacity(value)
    end)


    for key, value in pairs(self.TopPanelTable) do
        for k, v in pairs(value) do
            v.DOMove(Point(v.x, -20), 0.3).DONumber(255, 0, 0.3, function(vvs) --위 전투력, 골드패널
                v.SetOpacity(vvs)
            end)
        end
    end


    self.HelpButton.DOMove(Point(self.BackWhitekPanel.width - 75, -30), 0.3).DONumber(255, 0, 0.3, function(value) --위 도움말 버튼
        -- self.LeftCloseButtonText.SetOpacity(value)
        self.HelpImg.SetOpacity(value)
    end)



    self.BlackPanel.DOMove(Point(0, -self.BackGrundPanel.width+50), 0.3)

    self.BackWhitekPanel.DOColor(Color(255, 255, 255, 0), 0.3) --배경 사진 투명도

    Client.RunLater(function()
        self.BackGrundPanel.visible = false
    end, 0.3)

end


function MainGui:ShowAnimation() -- 열기 애니메이션
    self.BackGrundPanel.visible = true

    self.PanelName.DOMove(Point(40, 10), 0.3).DONumber(0, 255, 0.3, function(value) --GUi이름 이름, 투명
        self.PanelName.SetOpacity(value)
    end)


    self.CloseButton.DOMove(Point(self.BlackPanel.width - 40, 2), 0.3).DONumber(0, 255, 0.3, function(value) -- 닫기 버튼 이동, 투명
        self.CloseButtonText.SetOpacity(value)
    end)


    self.LeftCloseButton.DOMove(Point(5, 5), 0.3).DONumber(0, 255, 0.3, function(value) --왼쪽닫기 버튼 이동, 투명
        self.LeftCloseButtonText.SetOpacity(value)
    end)


    for key, value in pairs(self.TopPanelTable) do
        for k, v in pairs(value) do
            v.DOMove(Point(v.x, 10), 0.3).DONumber(0, 255, 0.3, function(vvs) --위 전투력, 골드패널
                v.SetOpacity(vvs)
            end)
        end
    end

    self.HelpButton.DOMove(Point(self.BackWhitekPanel.width - 75, 7), 0.3).DONumber(0, 255, 0.3, function(value) --위 도움말 버튼
        -- self.LeftCloseButtonText.SetOpacity(value)
        self.HelpImg.SetOpacity(value)
    end)
    
    self.BlackPanel.DOMove(Point(0, 0), 0.3) -- 위 상단 패널제외 자식패널 이동
    self.BackWhitekPanel.DOColor(Color(255, 255, 255, 255), 0.4) -- 배경 사진 투명도
end







MainGui:initialize()


-- function MainGui:Close()

--     local b = Image("Pictures/Gui/close.png", Rect(5+(105*(i-1)), 65, 35, 35))


--     self.CloseButton = Button('닫기', Rect(self.BlackPanel.width - 65, 5, 60, 25))
--     self.CloseButton.textSize = 15
--     self.BlackPanel.AddChild(self.CloseButton)   
    
--     self.CloseButton.color = Color(76, 81, 90, 255)

--     self.CloseButton.onClick.Add(function()
--         self.BackGrundPanel.visible = false
--     end)
-- end


-- for i = 1, #self.DataList do
        
--     local a = Button(self.DataList[i], Rect(75*(i-1), 50, 70, 70))
--     self.BlackPanel.AddChild(a)

--     a.onClick.Add(function()
--         print(i..'번 클릭')
--     end)
-- end



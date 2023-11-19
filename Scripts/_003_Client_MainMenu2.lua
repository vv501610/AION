---@diagnostic disable: missing-parameter
MainMenu = {}

MainMenu.MainPanel = Panel(Rect(-6, 0, 208, 266))
MainMenu.MainPanel.SetOpacity(0)
MainMenu.MainPanel.anchor = 2
MainMenu.MainPanel.pivotX = 1
MainMenu.MainPanel.pivotY = 0


MainMenu.frame = VerticalPanel(Rect(0, 0, 208, 266))

MainMenu.MainPanel.AddChild(MainMenu.frame)
-- MainMenu.frame.anchor = 2
-- MainMenu.frame.pivotX = 1
-- MainMenu.frame.pivotY = 0
MainMenu.frame.childControlWidth = true
MainMenu.frame.childControlHeight = true
MainMenu.frame.childForceExpandWidth = true
MainMenu.frame.childForceExpandHeight = true
MainMenu.frame.SetSizeFit(false, true)

MainMenu.frame_bg = Image("Pictures/mainmenu/icon_bg2.png", Rect(0, 0, 0, 0))
MainMenu.frame_bg.anchor = 15
MainMenu.frame_bg.imageType = 1
MainMenu.frame_bg.ignoreLayout = true
MainMenu.frame.AddChild(MainMenu.frame_bg)

local a = Panel(Rect(9, 63, 190, 1))
a.color = Color(255 ,255 ,255,  60)
a.SetOpacity(50)


MainMenu.menu_grid = GridPanel(Rect(0, 0, 0, 0))
MainMenu.menu_grid.contentSizeFitterEnabled = false
MainMenu.menu_grid.padding = RectOff(13, 13, 10, 10)
MainMenu.menu_grid.spacing = Point(2, 16)
MainMenu.menu_grid.cellSize = Point(44, 46)
MainMenu.menu_grid.childAlign = 0
MainMenu.menu_item = {}

MainMenu.menu_icon = {
    "Pictures/mainmenu/icon_bag.png",
    "Pictures/mainmenu/icon_notice.png",
    "Pictures/mainmenu/icon_cube.png",
    "Pictures/mainmenu/icon_menu.png",
    "Pictures/mainmenu/icon_profile.png",
    "Pictures/mainmenu/icon_skill.png",
    "Pictures/mainmenu/Icon_player.png",
    "Pictures/mainmenu/icon_message.png",
    "Pictures/mainmenu/icon_party.png",
    "Pictures/mainmenu/icon_guild.png",
    "Pictures/mainmenu/icon_mail.png",
    "Pictures/mainmenu/icon_book.png",
    "Pictures/mainmenu/icon_nft_storage.png",
    "Pictures/mainmenu/icon_play_setting.png",
    "Pictures/mainmenu/icon_smith.png",
    "Pictures/mainmenu/icon_setting.png",
    "Pictures/mainmenu/icon_end_game.png"
}

MainMenu.menu_text = {
    "가방",
    "공지",
    "큐브샵",
    "",
    "프로필",
    "스킬",
    "플레이어",
    "메세지",
    "파티",
    "클랜",
    "우편함",
    "성장",
    "NFT",
    "플레이",
    "제작",
    "설정",
    "게임종료"
}

MainMenu.BottomOnClick = {
    'ScreenUI.ShowPopup("Bag") MainMenu:hide()', 'ScreenUI.ShowPopup("EventPage") MainMenu:hide()', 'ScreenUI.ShowPopup("CubeShop") MainMenu:hide()', --- 가방, 공지, 큐브

    'MainMenu:hide()', 'ScreenUI.ShowPopup("PlayerInfo") MainMenu:hide()', 'ScreenUI.ShowPopup("Skills") MainMenu:hide()', --- 닷기, 프로필, 스킬

    'ScreenUI.ShowPopup("Players") MainMenu:hide()', 'ScreenUI.ShowPopup("Messages") MainMenu:hide()', ' ScreenUI.ShowPopup("Party") MainMenu:hide()', ---플레이어, 메시지,  파티'

    'ScreenUI.ShowPopup("Clan") MainMenu:hide()', 'ScreenUI.ShowPopup("Mailbox") MainMenu:hide()', 'Client.ShowCenterLabel("업데이트 예정입니다. 창고")', ---클랜, 우편함, 창고

    'Client.ShowCenterLabel("업데이트 예정입니다.nft창고")', 'Client.ShowCenterLabel("업데이트 예정입니다. 플레이")', 'Client.ShowCenterLabel("업데이트 예정입니다.제작")',--- bft창고, 플레이창고, 제작

    'ScreenUI.ShowPopup("GameSettings")', 'Client.ShowYesNoAlert("정말 종료 하시겠습니까?", function(isYes) if isYes == 1 then Client.Quit() else end end)' --- 게임 설정, 게임
}


MainMenu.icon = {}

MainMenu.label = {}

MainMenu.lockicon = {}

MainMenu.LevelRedText = {}

MainMenu.menu_level = {0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 450, 5000, 0, 0, 0, 0, 0, 0 }

for i = 1, #MainMenu.menu_icon, 1 do
    MainMenu.menu_item[i] = Button("", Rect(0, 0, 44, 46))
    MainMenu.menu_item[i].SetOpacity(0)

    MainMenu.menu_item[i].onClick.Add(function()
        if MainMenu.menu_level[i] > Client.myPlayerUnit.level then
            Client.ShowCenterLabel("해당 탭은 Lv:"..C_commaValue(MainMenu.menu_level[i])..'부터 사용 가능합니다.')
            return false
        end
        Client.DoString(MainMenu.BottomOnClick[i])
    end)
    
    
    MainMenu.icon[i] = Image(MainMenu.menu_icon[i], Rect(0, 0, 32, 32))
    MainMenu.icon[i].anchor = 1
    MainMenu.icon[i].pivotX = 0.5
    MainMenu.icon[i].pivotY = 0
    MainMenu.menu_item[i].AddChild(MainMenu.icon[i])

    MainMenu.label[i] = Text('', Rect(0, 0, 44, 14))
    MainMenu.label[i].autoTranslate = true
    MainMenu.label[i].text = MainMenu.menu_text[i]

    MainMenu.label[i].anchor = 7
    MainMenu.label[i].pivotX = 0.5
    MainMenu.label[i].pivotY = 1
    MainMenu.label[i].textAlign = 4
    MainMenu.label[i].textSize = 11
    MainMenu.label[i].borderDistance = Point(1, 1)
    MainMenu.label[i].borderEnabled = true
    MainMenu.menu_item[i].AddChild(MainMenu.label[i])
    MainMenu.menu_grid.AddChild(MainMenu.menu_item[i])

    MainMenu.lockicon[i] = 0


    Client.RunLater(function()
        if MainMenu.menu_level[i] > Client.myPlayerUnit.level then

            local BlackBackPanel = Panel(Rect(0, 0, 44, 46))
            BlackBackPanel.SetOpacity(0)
            MainMenu.menu_item[i].AddChild(BlackBackPanel)
    
            MainMenu.icon[i].color = Color(160, 160, 160, 255)
            MainMenu.label[i].color = Color(160, 160, 160, 255)
    
            MainMenu.lockicon[i] = Image('Pictures/Gui/whitepremium-icon-padlock-3934062.png', Rect(12, 4, 20, 20))
             
            BlackBackPanel.AddChild(MainMenu.lockicon[i])
    


            MainMenu.LevelRedText[i] = Text('Lv:'..C_commaValue(MainMenu.menu_level[i]), Rect(0, 24, 44, 20)) {
                textAlign = 1,
                textSize = 10,
                borderDistance = Point(1, 1),
                borderEnabled = true,
                color = Color(255, 51, 51, 255)
            }
            MainMenu.menu_item[i].AddChild(MainMenu.LevelRedText[i])
        end
    end, 1)

end
MainMenu.frame.AddChild(MainMenu.menu_grid)

MainMenu.MainPanel.AddChild(a)

MainMenu.MainPanel.visible = false

function MainMenu:show()
    MainMenu.MainPanel.visible = true
    MainMenu.MainPanel.showOnTop = true
end

function MainMenu:hide()
    MainMenu.MainPanel.visible = false
end





function LevelUpDataReset()

    for n = 1, #MainMenu.menu_icon do
        if MainMenu.menu_level[n] <= Client.myPlayerUnit.level then
            if MainMenu.lockicon[n] ~= 0 then
                MainMenu.lockicon[n].Destroy()
                MainMenu.lockicon[n] = 0
                MainMenu.icon[n].color = Color(255, 255, 255, 255)
                MainMenu.label[n].color = Color(255, 255, 255, 255)
                MainMenu.LevelRedText[n].Destroy()
            end
        end
    end

    -- for i = 1, #MainMenu.menu_icon do

    --     if MainMenu.menu_level[i] > Client.myPlayerUnit.level then

    --         local BlackBackPanel = Panel(Rect(0, 0, 44, 46))
    --         BlackBackPanel.SetOpacity(0)
    --         MainMenu.menu_item[i].AddChild(BlackBackPanel)

    --         MainMenu.icon[i].color = Color(160, 160, 160, 255)
    --         MainMenu.label[i].color = Color(160, 160, 160, 255)

    --         MainMenu.lockicon[i] = Image('Pictures/Gui/whitepremium-icon-padlock-3934062.png', Rect(12, 4, 20, 20))
            
    --         BlackBackPanel.AddChild(MainMenu.lockicon[i])

    --         MainMenu.LevelRedText[i] = Text('Lv.'..MainMenu.menu_level[i], Rect(0, 24, 44, 20)) {
    --             textAlign = 1,
    --             textSize = 10,
    --             borderDistance = Point(1, 1),
    --             borderEnabled = true,
    --             color = Color(255, 51, 51, 255)
    --         }
    --         MainMenu.menu_item[i].AddChild(MainMenu.LevelRedText[i])
    --     end
    -- end
end
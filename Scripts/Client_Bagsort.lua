local bag = {}

function sortbag()


    bag.sw = Button("가방 정렬", Rect(0, 60, 80, 40))
    bag.sw.pivotX = 0
    bag.sw.pivotY = 0
    bag.sw.anchor = 1
    bag.sw.color = Color(0, 0, 0)
    bag.sw.SetOpacity(200)
    bag.sw.visible = false
    -- print(bag.sw.visible)
    bag.Dtime = 0
    bag.sw.onClick.Add(function()

        if (os.time() - bag.Dtime) <= 10 then

            Client.ShowCenterLabel(10-math.ceil((-1*(bag.Dtime - os.time())))..'초 후 시도해 주세요')
            return false
        end
        bag.Dtime = os.time()


        Client.FireEvent("Bagsort", 1)
        Client.ShowCenterLabel("정렬 완료")
        -- 
        --     Client.ShowYesNoAlert(
        --         "가방을 정렬할까요?",
        --         function(IsYes)
        --             if IsYes == 1 then
        --                 Client.FireEvent("Bagsort", 1)
        --             end
        --         end
        --     )
        -- end
    end)
end
sortbag()

Client.RunLater(
    function()
        Client.onTick.Add(
            function(dt)
                if ScreenUI.IsShowPopup("Bag") == false then -- 가방이 닫혔다면 가방정렬 버튼 제거
                    bag.sw.visible = false
                else
                    bag.sw.visible = true
                end
            end
        )
    end,
    0.5
)



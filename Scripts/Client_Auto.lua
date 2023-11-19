---@diagnostic disable: missing-parameter, param-type-mismatch, undefined-field
-------------------------------------------------
-- <자동사냥 기초 스크립트>
-- 제작: 파밍RPG 개발자

-- *사용법*
-- Pictures 폴더 및 Script 폴더를 복붙해주세요.
-- 이미지가 하얗게 표시될경우 리소스관리자 버튼 클릭(폴더의 음표표시)후 재실행

-- *유의사항*
-- 잘못된 사용으로 인한 책임은 게임 개발자에게 있습니다.
-- 기초적인 자동사냥만 포함된 스크립트입니다.
-- 마나가 없을경우 스킬이 사용되지 않습니다.

-- *문의*
-- 안받습니다.

-- *기타사항*
-- 수정은 가능하나, 재판매는 금지합니다.
-------------------------------------------------

Auto = {}
-------------------------------------------------
-- 설정하기
-------------------------------------------------

--활용할 퀵슬롯 개수 (4또는 8 권장)
Auto.quickSlot = 8

---------------------------------------------
-- 아래는 건들지 마세요
---------------------------------------------
Auto.cnt = 0
Auto.rndStopCount = 5
function Auto:Tick(t)
    if self.object.mode == 0 then
        return
    end

    local me = Client.myPlayerUnit

    if not me then
        return
    end

    self.cnt = self.cnt + t
    if self.cnt > self.rndStopCount then
        me.StopMove()
        self.target = nil
        self.cnt = 0
    end

    local target = self.target

    if target and target.valid and not target.dead then
        local dist = (me.x - target.x) * (me.x - target.x) + (me.y - target.y) * (me.y - target.y)
        if dist < 50 * 50 then
            me.StopMove()
        else
            if self.object.mode == 1 then
                me.MoveToPosition(target.x, target.y)
            end
        end
        for i, quickSlot in pairs(Client.myPlayerUnit.quickSlots) do
            if i > self.quickSlot then
                break
            end
            local skillData = Client.GetSkill(quickSlot.skillDataID)
            if skillData then
                if me.mp >= skillData.consumeMP then
                    me.UseSkill(quickSlot.skillDataID, target and Point(target.x - me.x, target.y - me.y) or nil)
                end
            end
        end
    else
        self.target = Client.field.FindNearUnit(me.x, me.y, 2000, 2, me)
    end

end

function Auto:Show()

    local cw = Client.width
    local ch = Client.height

    if self.object then
        return
    end

    self.object = {}

    local o = self.object

    o.body = Button("", Rect(cw-265, ch-190,64,58))
    o.body.SetOpacity(0)

    o.buttonImage = {}
    for i=1, 3, 1 do
        o.buttonImage[i] = Image("Pictures/Gui/Auto/auto"..i..".png",Rect(0,0,64,58))
        local ob = o.buttonImage[i]
        ob.visible = i==1 and true or false
        ob.SetOpacity(150)
        o.body.AddChild(ob)
    end
    o.mode = 0
    o.body.onClick.Add(function()
        -- Client.FireEvent("AutoType")
        if o.mode == 0 then
            o.mode = 1
            o.buttonImage[1].visible = false
            o.buttonImage[2].visible = true
            print('[#] 자동사냥을 시작 합니다.')
            return
        end
        if o.mode == 1 then
            o.mode = 2
            o.buttonImage[2].visible = false
            o.buttonImage[3].visible = true
            print('[#] 제자리 자동사냥을 시작 합니다.')
            return
        end
        if o.mode == 2 then
            o.mode = 0
            o.buttonImage[1].visible = true
            o.buttonImage[3].visible = false
            print('[#] 자동사냥을 종료 합니다.')
            return
        end

        Client.myPlayerUnit.StopMove()
    end)
    Client.onTick.Add(function(t) Auto:Tick(t) end)
end
Client.RunLater(function() Auto:Show() end, 0.5)

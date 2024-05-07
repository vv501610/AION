local CallBack = require("Utils/_002_Client_CallBackFunction")


local HPMPbg = Image("Pictures/gage/HP_MP_bg.png", Rect(86, 9, 152, 28)) -- HP, MP 게이지 뒷배경
local HP = Image("Pictures/gage/HP.png", Rect(87, 10, 150, 12.5)) -- HP 게이지 이미지
local MP = Image("Pictures/gage/MP.png", Rect(87, 23.5, 150, 12.5)) -- MP 게이지 이미지

local HPtxt = Text("", Rect(0, -0.5, 150, 15)) -- HP 텍스트
HPtxt.borderDistance = Point(1, 1)
HPtxt.borderEnabled = true
HPtxt.textAlign = 1
HPtxt.textSize = 12 -- HP 텍스트 크기를 13으로 설정
HP.AddChild(HPtxt)

local MPtxt = Text("", Rect(0, -0.5, 150, 15)) -- mP 텍스트
MPtxt.borderDistance = Point(1, 1)
MPtxt.borderEnabled = true
MPtxt.textAlign = 1
MPtxt.textSize = 12 -- MP 텍스트 크기를 13으로 설정

MP.AddChild(MPtxt)


local maxHP, maxMP = 0, 0
local me = nil


local exp_text = Text("",Rect(5, 435, 300, 50))
exp_text.borderDistance = Point(1, 1)
exp_text.borderEnabled = true
exp_text.textSize = 13





local xp = Panel()
xp.rect = Rect(0, Client.height-10, Client.width , 10)
xp.masked = true
xp.setOpacity(0)



Image("Pictures/Gui/exp_bar_bot.png", Rect(0, Client.height-10, Client.width , 10))

local xp_orb22 = Image("Pictures/Gui/BAR_EXP.png", Rect(0, 0, Client.width , 10))

xp.AddChild(xp_orb22)

xp.showOnTop = true

exp_text.showOnTop = true


local BattlePowewPanel = Panel(Rect(-130, -35, 120, 20)) {
    anchor = 8
}
BattlePowewPanel.setOpacity(150)

BattlePowewPanel.AddChild(Image("Pictures/Gui/BattlePower.png", Rect(5, 2.5, 15, 15)))

local BattlePowewDownText = Text("044343", Rect(20, 2.6, 100, 20)) {
    textAlign = 1,
    textSize = 11
}
BattlePowewPanel.AddChild(BattlePowewDownText)





local delay = 0

function Orb(dt)

    delay = delay + dt
    if delay > 0.01 then
        me = Client.myPlayerUnit

        xp.DOScale(Point(me.exp/me.maxEXP, 1), 0.9)
    
        local per = string.format("%.2f", me.exp / me.maxEXP * 100)
    
        if Client.myPlayerUnit.maxEXP == 0 then
            exp_text.text = "최대 레벨 달성" 
        else
    
    
        exp_text.text = 'EXP: '..CallBack:C_commaValue(me.exp).."/"..CallBack:C_commaValue(me.maxEXP).." ("..per.."%)"
    
        end
    
        maxHP = math.floor(me.hp / me.maxHP * 100)
        maxMP = math.floor(me.mp / me.maxMP * 100)
        Thp = 150 * maxHP / 100
        Tmp = 150 * maxMP / 100
        HP.rect = Rect(87, 10, Thp, 12.5)
        MP.rect = Rect(87, 23.5, Tmp, 12.5)
        HPtxt.text = CallBack:C_commaValue(Client.myPlayerUnit.hp) .. " / " ..CallBack:C_commaValue(Client.myPlayerUnit.maxHP)
        MPtxt.text = CallBack:C_commaValue(Client.myPlayerUnit.mp).." / "..CallBack:C_commaValue(Client.myPlayerUnit.maxMP)

        BattlePowewDownText.text = CallBack:FormatNumber(CallBack.BattlePower)
        delay = 0
    end
    


    -- BattlePower


end


Client.RunLater(function()
    Client.onTick.Add(Orb)
end, 0.5)


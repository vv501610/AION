


local HPMPbg = Image("Pictures/gage/HP_MP_bg.png", Rect(86, 9, 152, 26)) -- HP, MP 게이지 뒷배경
local HP = Image("Pictures/gage/HP.png", Rect(87, 10, 150, 17)) -- HP 게이지 이미지
local MP = Image("Pictures/gage/MP.png", Rect(87, 28, 150, 6)) -- MP 게이지 이미지
local HPtxt = Text("", Rect(100, 3, 100, 30)) -- HP 텍스트
HPtxt.borderDistance = Point(1, 1)
HPtxt.borderEnabled = true
HPtxt.textSize = 13 -- HP 텍스트 크기를 13으로 설정

local maxHP, maxMP = 0, 0
local me = nil



--경험치 텍스트 위치 및 크기 설정
local xp_x_pos = 5              --기본 0
local xp_y_pos = 435            --기본 435
local xp_text_size = 13         --기본 15


local exp_text1 = Text("",Rect(xp_x_pos-1, xp_y_pos, 300, 50))
local exp_text2 = Text("",Rect(xp_x_pos, xp_y_pos-1, 300, 50))
local exp_text3 = Text("",Rect(xp_x_pos+1, xp_y_pos, 300, 50))
local exp_text4 = Text("",Rect(xp_x_pos, xp_y_pos+1, 300, 50))
local exp_text5 = Text("",Rect(xp_x_pos, xp_y_pos, 300, 50))


exp_text1.textSize = xp_text_size
exp_text2.textSize = xp_text_size
exp_text3.textSize = xp_text_size
exp_text4.textSize = xp_text_size
exp_text5.textSize = xp_text_size

exp_text1.color = Color(0,0,0) 
exp_text2.color = Color(0,0,0)
exp_text3.color = Color(0,0,0) 
exp_text4.color = Color(0,0,0) 




local xp = Panel()
xp.rect = Rect(0, Client.height-10, Client.width , 10)
xp.masked = true
xp.setOpacity(0)



Image("Pictures/Gui/exp_bar_bot.png", Rect(0, Client.height-10, Client.width , 10))

local xp_orb22 = Image("Pictures/Gui/BAR_EXP.png", Rect(0, 0, Client.width , 10))

xp.AddChild(xp_orb22)

xp.showOnTop = true


exp_text1.showOnTop = true
exp_text2.showOnTop = true
exp_text3.showOnTop = true
exp_text4.showOnTop = true
exp_text5.showOnTop = true

function Orb(dt)

    me = Client.myPlayerUnit

    xp.DOScale(Point(me.exp/me.maxEXP, 1), 0.9)

    local per = string.format("%.2f", me.exp / me.maxEXP * 100)

    if Client.myPlayerUnit.maxEXP == 0 then
        exp_text1.text = "최대 레벨 달성" 
        exp_text2.text = "최대 레벨 달성"
        exp_text3.text = "최대 레벨 달성" 
        exp_text4.text = "최대 레벨 달성" 
        exp_text5.text = "최대 레벨 달성"
    else


    exp_text1.text = 'EXP: '..C_commaValue(me.exp).."/"..C_commaValue(me.maxEXP).." ("..per.."%)"
    exp_text2.text = 'EXP: '..C_commaValue(me.exp).."/"..C_commaValue(me.maxEXP).." ("..per.."%)" 
    exp_text3.text = 'EXP: '..C_commaValue(me.exp).."/"..C_commaValue(me.maxEXP).." ("..per.."%)"
    exp_text4.text = 'EXP: '..C_commaValue(me.exp).."/"..C_commaValue(me.maxEXP).." ("..per.."%)" 
    exp_text5.text = 'EXP: '..C_commaValue(me.exp).."/"..C_commaValue(me.maxEXP).." ("..per.."%)" 
    end


    maxHP = math.floor(me.hp / me.maxHP * 100)
    maxMP = math.floor(me.mp / me.maxMP * 100)
    Thp = 150 * maxHP / 100
    Tmp = 150 * maxMP / 100
    HP.rect = Rect(87, 10, Thp, 17)
    MP.rect = Rect(87, 28, Tmp, 6)
    HPtxt.text = Client.myPlayerUnit.hp .. " / " .. Client.myPlayerUnit.maxHP
    --MPtxt.text = Client.myPlayerUnit.mp.." / "..Client.myPlayerUnit.maxMP



end


Client.RunLater(function()
    Client.onTick.Add(Orb)
end, 0.5)


---@diagnostic disable: need-check-nil, undefined-field

CallBack = {}


CallBack.BattlePower = 0 -- 전투력변수

CallBack.GameGold = 0 -- 현재 내 게임 골드

Client.GetTopic("UpdateGold").Add(function(money)
   CallBack.GameGold = money
end)




Client.GetTopic("BattlePowerUpdate").Add(function(atk, def, maxHP, maxMP, cri, criDamage, bossDamage, perHp, perMp, MoveSpeed, neverDef, PenetrationDef)

   -- BattlePower = math.ceil(atk + def + (maxHP/10) + (maxMP/5) + cri + criDamage + bossDamage + perHp + perMp + MoveSpeed + neverDef + PenetrationDef)


   CallBack.NextbattlePower = math.ceil(atk + def + (maxHP/10) + (maxMP/5) + (cri*3) + (criDamage*3) + bossDamage + perHp + perMp + (MoveSpeed*10) + (neverDef*50) + (PenetrationDef*15))


   BattlePowerUpdatePanel:ShowUp(CallBack.BattlePower, CallBack.NextbattlePower)


end)


ItemType = {'모자', '갑옷', '무기', '방패', '신발', '반지', '악세서리', '날개', '포션', '재료', '소모품'}

AtkItemType = {'모자', '갑옷', '무기', '방패', '신발', '반지', '악세서리'} --'날개'}


function CallBack:C_commaValue(n) ---숫자 컴마 찍기

   local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')

   return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right

end


function CallBack:FormatNumber(number) -- print(formatNumber(100321100)) -- retrue 1억32만1100
   local units = {"", "만", "억", "조"}
   local result = ""
   local unitIndex = 1
 
   while number > 0 do
     local part = number % 10000
     if part > 0 then
       result = part .. units[unitIndex] .. ' '..result
     end
     number = math.floor(number / 10000)
     unitIndex = unitIndex + 1
   end
 
   return result
 end



 
local BackLoadingpanel, LoadingImg, garfatext  = nil, nil, nil


function LoadingPanelUp() ---로딩창, 삭제는 LoadingPanelDestroy 함수 실행

   local del = 0
   local i = 1


   BackLoadingpanel = Panel(Rect(0, 0,  Client.width, Client.height))
	BackLoadingpanel.showOnTop = true
	BackLoadingpanel.color = Color(000, 000, 000, 150)

	garfatext = Text("Loading",Rect(0, 260, Client.width, 50))
	garfatext.textSize = 24
   garfatext.textAlign = 1
   BackLoadingpanel.AddChild(garfatext)

   LoadingImg = Image("Pictures/Gui/Loading/Loading ("..i..").png", Rect(0, 0, 441, 291))
   BackLoadingpanel.AddChild(LoadingImg)
   LoadingImg.anchor = 4
   LoadingImg.pivotX =  0.5
   LoadingImg.pivotY =  0.6

   function LoadingFuntion(dt)
      del = del + dt

      if del > 0.025 then

         if i == 25 then
            i = 1
         end
         LoadingImg.image = "Pictures/Gui/Loading/Loading ("..i..").png"
         i = i + 1
         del = 0
      end
  end
  Client.onTick.Add(LoadingFuntion)
end



function LoadingPanelDestroy()
   if not BackLoadingpanel then
      return false
   end
   Client.onTick.Remove(LoadingFuntion)
   BackLoadingpanel.Destroy()
   LoadingImg.Destroy()
   garfatext.Destroy()
end



function HelpNote(title, text) -- HelpButtonClick  --도움말 버튼
   local HelpNote = {}
   HelpNote.BlackPanel = Panel(Rect(0, 0, Client.width, Client.height))
   HelpNote.BlackPanel.SetOpacity(200)
   HelpNote.BlackPanel.showOnTop = true

   HelpNote.MainPanel = Panel(Rect(Client.width/2 - 241.5, Client.height/2 - 161, 483, 322))
   HelpNote.MainPanel.SetOpacity(0)
   HelpNote.BlackPanel.AddChild(HelpNote.MainPanel)
   HelpNote.MainPanel.AddChild(Image("Pictures/Gui/메인 패널.png", Rect(0, 0, 483, 322)))


   HelpNote.qimg = Image("Pictures/Gui/밝버튼.png", Rect(HelpNote.MainPanel.width/2-50, 282, 100, 30))
   HelpNote.MainPanel.AddChild(HelpNote.qimg)

   -- HelpNote.TopBlackPanel = Panel(Rect(1, 1, 482, 60))
   -- HelpNote.MainPanel.AddChild(HelpNote.TopBlackPanel)
   -- HelpNote.TopBlackPanel.SetOpacity(200)

   HelpNote.TitleText = Text("", Rect(0, 15, 483, 30)) {
      textAlign = 1,
      textSize = 22,
      autoTranslate = true,
      text = title,
      borderDistance = Point(1, 1),
      borderEnabled = true,
      color = Color(255, 189, 0)
   }
   HelpNote.MainPanel.AddChild(HelpNote.TitleText)



   HelpNote.Ttext = Text("", Rect(10, 65, 483, 300)) {
      textAlign = 0,
      textSize = 15,
      autoTranslate = true,
      text = text,
      borderDistance = Point(1, 1),
      borderEnabled = true,
   }
   HelpNote.MainPanel.AddChild(HelpNote.Ttext)


   HelpNote.questblindConfirmtext = Button('확인', Rect(HelpNote.MainPanel.width/2-50, 282, 100, 30))
   HelpNote.MainPanel.AddChild(HelpNote.questblindConfirmtext)
   HelpNote.questblindConfirmtext.SetOpacity(0)
   HelpNote.questblindConfirmtext.onClick.Add(function()
      HelpNote.BlackPanel.Destroy()
   end)


   
end


function MonsterCombatPower(id) --- 전투력 공식 나중에 수정 해야함!!

   local monster = Client.GetMonster(id)



   local total = math.ceil(monster.attack + monster.defense + (monster.maxHP/10))

   -- print(monster.attack, monster.defense, monster.maxHP)

   
   return total
end


function ItemDocePanelUp(dataID, count)
   local object = {}
   object.questblindbutton = Panel(Rect(0, 0, Client.width, Client.height))
   object.questskinny = Panel(Rect(Client.width/2-120, Client.height/2-135, 240, 275))

   object.questskinny.AddChild(Image("Pictures/Gui/메인 패널.png", Rect(0, 0, 240, 275)))

   object.questskinny2 = Panel(Rect(1, 1, 238, 38))
   object.questblindbuttonimg = Image("", Rect(2.5, 2.5, 35, 35))
   object.questblindbuttonimg.SetImageID(Client.GetItem(dataID).imageID)

   object.questblindnametext = Text('', Rect(45, 0, 240, 30))

   if count ~= nil then
       object.questblindnametext.text = Client.GetItem(dataID).name..'x'..count
   end
       object.questblindnametext.text = Client.GetItem(dataID).name

   object.questblinddesctext=Text(Client.GetItem(dataID).desc, Rect(5, 45, 230, 230))
   object.qimg = Image("Pictures/Gui/밝버튼.png", Rect(object.questskinny.width/2-50 ,230, 100, 30))
   object.questskinny2.AddChild(object.qimg)

   object.questblindConfirmtext = Button('확인', Rect(object.questskinny.width/2-50, 230, 100, 30))
   object.questblindConfirmtext.SetOpacity(0)
   object.questblindConfirmtext.onClick.Add(function() object.questblindbutton.Destroy() object.questblindbutton = nil end)

   object.questblindnametext.textSize = 15.5
   object.questblinddesctext.textAlign = 0
   object.questskinny2.SetOpacity(100)
   object.questskinny.SetOpacity(0)
   object.questblindbutton.SetOpacity(200)

   object.questskinny2.AddChild(object.questblinddesctext)
   object.questskinny2.AddChild(object.questblindnametext)
   object.questskinny2.AddChild(object.questblindConfirmtext)
   object.questskinny.AddChild(object.questskinny2)
   object.questskinny.AddChild(object.questblindbuttonimg)
   object.questblindbutton.AddChild(object.questskinny)
   object.questblindbutton.showOnTop=true
end


function MoveHome()
   Client.ShowYesNoAlert('마을로 이동하시겠습니까? 파티에 속해있을 경우 자동 탈퇴합니다.', function(result)
      if result == 1 then
          Client.FireEvent("MoveHome")
      end
   end)
end


return CallBack

-- callback.ttype = {"", "직업", "직업", "아이템", "아이템"}

-- callback.statName = {"공격력","방어력","경험치 획득량(%)","골드 획득량","회피율","명중률","체력","마력"}

-- callback.statName2 = {Client.GetStrings().custom1,Client.GetStrings().custom2,Client.GetStrings().custom3,Client.GetStrings().custom4,Client.GetStrings().custom5,Client.GetStrings().custom6,Client.GetStrings().custom7,Client.GetStrings().custom8,Client.GetStrings().custom9,Client.GetStrings().custom10,Client.GetStrings().custom11,Client.GetStrings().custom12,Client.GetStrings().custom13,Client.GetStrings().custom14,Client.GetStrings().custom15,Client.GetStrings().custom16,Client.GetStrings().custom17,Client.GetStrings().custom18,Client.GetStrings().custom19,Client.GetStrings().custom20,Client.GetStrings().custom21,Client.GetStrings().custom22,Client.GetStrings().custom23,Client.GetStrings().custom24,Client.GetStrings().custom25,Client.GetStrings().custom26,Client.GetStrings().custom27,Client.GetStrings().custom28,Client.GetStrings().custom29,Client.GetStrings().custom30,Client.GetStrings().custom31,Client.GetStrings().custom32}




-- texty = Text('', Rect(100, 0, 200, 200))

-- Tween.DONumber(0, 100, 3, function(value)
--       texty.text = "전투력 " .. value
-- end)
---@diagnostic disable: need-check-nil, undefined-field


function C_commaValue(n) ---숫자 컴마 찍기

   local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')

   return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right

end


function formatNumber(number) -- print(formatNumber(100321100)) -- retrue 1억32만1100
   local units = {"", "만", "억", "조"}
   local result = ""
   local unitIndex = 1
 
   while number > 0 do
     local part = number % 10000
     if part > 0 then
       result = part .. units[unitIndex] .. result
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
   Client.onTick.Remove(LoadingFuntion)
   BackLoadingpanel.Destroy()
   LoadingImg.Destroy()
   garfatext.Destroy()
end



function HelpNote(title, text) -- HelpButtonClick
   local HelpNote = {}
   HelpNote.BlackPanel = Panel(Rect(0, 0, Client.width, Client.height))
   HelpNote.BlackPanel.showOnTop = true

   HelpNote.MainPanel = Panel(Rect(Client.width/2 - 241.5, Client.height/2 - 161, 483, 322))
   HelpNote.MainPanel.SetOpacity(255)
   HelpNote.BlackPanel.AddChild(HelpNote.MainPanel)

   print(title, text)
   
end


function MonsterCombatPower(id) --- 전투력 공식 나중에 수정 해야함!!

   local monster = Client.GetMonster(id)

   
   return 10000
end
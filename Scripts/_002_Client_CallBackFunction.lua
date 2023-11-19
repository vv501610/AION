---@diagnostic disable: need-check-nil, undefined-field


function C_commaValue(n) ---숫자 컴마 찍기

   local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')

   return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right

end


local BackLoadingpanel, LoadingImg, garfatext  = nil, nil, nil


function LoadingPanelUp() ---로딩창, 삭제는 LoadingPanelDestroy 함수 실행

print'ddd'
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
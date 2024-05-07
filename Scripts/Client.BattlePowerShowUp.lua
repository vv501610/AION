BattlePowerUpdatePanel = {}



function BattlePowerUpdatePanel:initialize()

    self.Image = Image("Pictures/Gui/BattelPowerPanel.png", Rect(Client.width/2-75, 35, 150, 25))
    self.Image.visible = false

    self.BattlePowerText = Text('', Rect(0, 5, 150, 200)) {
        textAlign = 1
    }
    self.Image.AddChild(self.BattlePowerText)

end



function BattlePowerUpdatePanel:ShowUp(battlenumber, nextnumber)
    self.Image.visible = true
    Tween.DONumber(battlenumber, nextnumber, 1.5, function(value)
        self.BattlePowerText.text = "전투력:" .. math.ceil(value)..(battlenumber < nextnumber and  "<color=#04B404>▲"..nextnumber- battlenumber.."</color>" or "<color=#DF0101>▼"..battlenumber- nextnumber.."</color>")
    end)


    Client.RunLater(function ()
        self.Image.visible = false
    end, 2)

    CallBack.BattlePower = nextnumber
end



BattlePowerUpdatePanel:initialize()






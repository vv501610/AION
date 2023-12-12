titem = Server.players[1].GetItems()[1]




titem.options[1].value = titem.options[1].value -1

-- Utility.AddItemOption(titem, 3, 101, 5)
        

Server.players[1].SendItemUpdated(titem)




-- Server.players[1].unit.AddItemByTItem(titem)
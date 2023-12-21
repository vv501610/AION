---@diagnostic disable: undefined-global, undefined-field
local ITemTable = {dataID = {}, neww = {}}
-- dataTable = {}
-- dataTable.time = true
Client.GetTopic("AddItemCallBack").Add(function(dataID, new)
    ITemTable.dataID[#ITemTable.dataID + 1] = dataID
    ITemTable.neww[#ITemTable.neww + 1] = new
end)



local dle = 5
local data = {}

function ItemFoo()
    if #ITemTable.dataID >= 1 then
        if dle < 1 then
            local color = {rand(1, 256), rand(1, 256), rand(1, 256)}
            if data.ItemPanel ~= nil then
                data.ItemPanel.DOMove(Point(0, 215), 0.3)
                local count = 140

                local function TextOprsdd()
                    count = count - 12
                    data.ItemPanel.SetOpacity(count) data.ItemImg.SetOpacity(count) data.ItemBackPanel.SetOpacity(count)
                    data.ItemPanelText.SetOpacity(count) --data.ScrollPanell.SetOpacity(count)
                    data.itemDecoText.SetOpacity(count)

                    if data.ItemNewImg then
                        data.ItemNewImg.SetOpacity(count)
                    end
                    if count < 0 then
                        Client.RunLater.Remove(TextOprsdd)
                    end
                    Client.RunLater(TextOprsdd, 0.01)
                end
                TextOprsdd()


                Client.RunLater(function()
                    data.ItemPanel.Destroy()
                    data = nil
                    data = {}
                    table.remove(ITemTable.dataID, 1)
                    table.remove(ITemTable.neww, 1)
                end, 0.3)
            end
            Client.RunLater(function()
                if #ITemTable.dataID >= 1 then
                    local count = 0
                    data.ItemPanel = Panel(Rect(10, 215, 225, 60))
                    --data.ItemPanel.SetOpacity(0)
                    data.ItemPanel.color = Color(color[1],color[2],color[3], 0)
                    data.ItemPanel.DOMove(Point(30, 215), 0.2)


                    data.ItemPanelText = Text(Client.GetItem(ITemTable.dataID[1]).name, Rect(5, 5, 200, 50))
                    data.ItemPanelText.SetOpacity(0)
                    data.ItemPanelText.textAlign = 0
                    data.ItemPanelText.textSize = 13
                    data.ItemPanel.AddChild(data.ItemPanelText)

                    data.ItemBackPanel = Panel(Rect(170, 5, 50, 50))
                    data.ItemBackPanel.SetOpacity(150)
                    data.ItemPanel.AddChild(data.ItemBackPanel)

                    data.ItemImg = Image('', Rect(2.5, 2.5, 45, 45))
                    data.ItemImg.SetOpacity(0)
                    data.ItemImg.SetImageID(Client.GetItem(ITemTable.dataID[1]).imageID)
                    data.ItemBackPanel.AddChild(data.ItemImg)

                    data.ScrollPanell = ScrollPanel(Rect(0, 20, 170, 35))
                    data.ScrollPanell.color = Color(0, 0, 0, 0)
                    data.ScrollPanell.horizontal = false
                    data.ItemPanel.AddChild(data.ScrollPanell)

                    data.ScrollPanelChild = Panel(Rect(0, 0, 155, 200))
                    data.ScrollPanelChild.SetOpacity(0)
                    data.ScrollPanell.content = data.ScrollPanelChild
                    data.ScrollPanell.AddChild(data.ScrollPanelChild)

                    data.itemDecoText = Text(Client.GetItem(ITemTable.dataID[1]).desc, Rect(5, 5, 150, 200))
                    data.ScrollPanelChild.AddChild(data.itemDecoText)
                    data.itemDecoText.SetOpacity(0)
                    data.itemDecoText.textAlign = 0
                    data.itemDecoText.textSize = 10
                    -- data.ItemNewImg = Image("Pictures/My Post (1).jpg", Rect(182.5, 2.5, 35, 15))
                    if ITemTable.neww[1] == "true" then
                        data.ItemNewImg = Image("Pictures/Gui/newI.jpg", Rect(192.5, 2.5, 30, 13))
                        data.ItemNewImg.SetOpacity(0)
                        data.ItemPanel.AddChild(data.ItemNewImg)
                    end

                    local function TextOprsdd()
                        count = count + 12
                        data.itemDecoText.SetOpacity(count)
                        data.ItemImg.SetOpacity(count)
                        data.ItemPanelText.SetOpacity(count)
                        if data.ItemNewImg then
                            data.ItemNewImg.SetOpacity(count)
                        end
                        if count < 150 then
                            data.ItemBackPanel.SetOpacity(count)
                        end

                        -- if count < 50 then
                        --     data.ScrollPanell.color = Color(0, 0, 0, count)
                        -- end

                        if count < 170 then
                            data.ItemPanel.SetOpacity(count)
                            data.ItemPanel.color = Color(color[1],color[2],color[3], count)
                        end

                        if count > 254 then
                            Client.RunLater.Remove(TextOprsdd)
                        end
                        Client.RunLater(TextOprsdd,0.01)
                    end
                    TextOprsdd()
                end
                dle = 5
            end, 0.4)
        else
            dle = dle - 1
        end
    end
    Client.RunLater(ItemFoo,1)
end

ItemFoo()
















-- -- local ITemTable = {}
-- -- -- dataTable = {}
-- -- -- dataTable.time = true
-- -- Client.GetTopic("AddItemCallBack").Add(function(dataID)
    
-- --     ITemTable[#ITemTable + 1] = dataID
-- -- end)


-- -- local dle = 5
-- -- local data = {}

-- -- local function foo()
-- --     if #ITemTable >= 1 then
-- --         if dle < 1 then
-- --             local color = {rand(1, 256), rand(1, 256), rand(1, 256)}
-- --             if data.ItemPanel ~= nil then
-- --                 data.ItemPanel.DOMove(Point(0, 220), 0.3)
-- --                 local count = 100
-- --                 local function TextOprsdd()
-- --                     count = count - 12
-- --                     data.ItemPanel.SetOpacity(count) data.ItemImg.SetOpacity(count) data.ItemBackPanel.SetOpacity(count)
-- --                     data.ItemPanelText.SetOpacity(count) data.ScrollPanell.SetOpacity(count)

-- --                     data.itemDecoText.SetOpacity(count) data.ItemNewImg.SetOpacity(count)
-- --                     --data.ItemPanel.color = Color(color[1],color[2],color[3], count)
-- --                     if count < 0 then
-- --                         Client.RunLater.Remove(TextOprsdd)
-- --                     end
-- --                     Client.RunLater(TextOprsdd,0.01)
-- --                 end
-- --                 TextOprsdd()

-- --                 Client.RunLater(function()
-- --                     data.ItemPanel.Destroy()
-- --                     data = nil
-- --                     data = {}
-- --                     table.remove(ITemTable, 1)
-- --                 end, 0.3)
-- --             end
-- --             Client.RunLater(function()
-- --                 if #ITemTable >= 1 then
-- --                     local count = 0
-- --                     data.ItemPanel = Panel(Rect(15, 220, 220, 55))
-- --                     --data.ItemPanel.SetOpacity(0)
-- --                     data.ItemPanel.color = Color(color[1],color[2],color[3], 0)
-- --                     data.ItemPanel.DOMove(Point(35, 220), 0.2)


-- --                     data.ItemPanelText = Text(Client.GetItem(ITemTable[1]).name, Rect(5, 5, 200, 50))
-- --                     data.ItemPanelText.SetOpacity(0)
-- --                     data.ItemPanelText.textAlign = 0
-- --                     data.ItemPanelText.textSize = 11
-- --                     data.ItemPanel.AddChild(data.ItemPanelText)

-- --                     data.ItemBackPanel = Panel(Rect(170, 5, 45, 45))
-- --                     data.ItemBackPanel.SetOpacity(150)
-- --                     data.ItemPanel.AddChild(data.ItemBackPanel)

-- --                     data.ItemImg = Image('', Rect(2.5, 2.5, 40, 40))
-- --                     data.ItemImg.SetOpacity(0)
-- --                     data.ItemImg.SetImageID(Client.GetItem(ITemTable[1]).imageID)
-- --                     data.ItemBackPanel.AddChild(data.ItemImg)

                    
-- --                     data.ScrollPanell = ScrollPanel(Rect(0, 20, 170, 35))
-- --                     data.ScrollPanell.color = Color(0, 0, 0, 0)
-- --                     data.ScrollPanell.horizontal = false
-- --                     data.ItemPanel.AddChild(data.ScrollPanell)

-- --                     data.ScrollPanelChild = Panel(Rect(0, 0, 155, 200))
-- --                     data.ScrollPanelChild.SetOpacity(0)
-- --                     data.ScrollPanell.content = data.ScrollPanelChild
-- --                     data.ScrollPanell.AddChild(data.ScrollPanelChild)

-- --                     data.itemDecoText = Text(Client.GetItem(ITemTable[1]).desc, Rect(5, 5, 150, 200))
-- --                     data.ScrollPanelChild.AddChild(data.itemDecoText)
-- --                     data.itemDecoText.SetOpacity(0)
-- --                     data.itemDecoText.textAlign = 0
-- --                     data.itemDecoText.textSize = 10
-- --                     -- data.ItemNewImg = Image("Pictures/My Post (1).jpg", Rect(182.5, 2.5, 35, 15))

-- --                     data.ItemNewImg = Image("Pictures/My Post (1).jpg", Rect(192.5, 2.5, 25, 12))
-- --                     data.ItemNewImg.SetOpacity(0)
-- --                     data.ItemPanel.AddChild(data.ItemNewImg)

-- --                     local function TextOprsdd()
-- --                         count = count + 12
-- --                         data.itemDecoText.SetOpacity(count)
-- --                         data.ItemImg.SetOpacity(count)
-- --                         data.ItemPanelText.SetOpacity(count)
-- --                         data.ItemNewImg.SetOpacity(count)
-- --                         if count < 150 then
-- --                             data.ItemBackPanel.SetOpacity(count)
-- --                         end

-- --                         if count < 50 then
-- --                             data.ScrollPanell.color = Color(0, 0, 0, count)
-- --                         end

-- --                         if count < 130 then
-- --                             data.ItemPanel.SetOpacity(count)
-- --                             data.ItemPanel.color = Color(color[1],color[2],color[3], count)
-- --                         end

-- --                         if count > 254 then
-- --                             Client.RunLater.Remove(TextOprsdd)
-- --                         end
-- --                         Client.RunLater(TextOprsdd,0.01)
-- --                     end
-- --                     TextOprsdd()
-- --                 end
-- --                 dle = 5
-- --             end, 0.4)
-- --         else
-- --             dle = dle - 1
-- --         end
-- --     end
-- --     Client.RunLater(foo,1)
-- -- end

-- -- foo()


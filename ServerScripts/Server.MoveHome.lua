---@diagnostic disable: undefined-global
Server.GetTopic("MoveHome").Add(function()

	if unit.party then
		unit.party.LeaveParty(unit.player)
	end

	unit.teamTag = 1
	unit.SpawnAtFieldID(2, 32*42, 32*-30)
end)

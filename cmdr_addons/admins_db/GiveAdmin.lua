local DataStoreService = game:GetService("DataStoreService")
local admins_database = DataStoreService:GetDataStore("admins")

game.Players.PlayerAdded:Connect(function(plr)
	local key = "plr_"..plr.UserId
	
	if admins_database:GetAsync(key) then
		plr:SetAttribute("admin", true)
	end
end)
local DataStoreService = game:GetService("DataStoreService")
local whitelisted_database = DataStoreService:GetDataStore("whitelisted")

game.Players.PlayerAdded:Connect(function(plr)
	local key = "plr_"..plr.UserId
	
	if whitelisted_database:GetAsync(key) then
		print("@"..plr.Name.." | plr_"..plr.UserId.." -> Accès Autorisé")
	else
		plr:Kick("Vous n'êtes pas autorisé à rejoindre le jeu.")
		print("@"..plr.Name.." | plr_"..plr.UserId.." -> Accès Refusé")
	end
end)
local DataStoreService = game:GetService("DataStoreService")
local admins_database = DataStoreService:GetDataStore("admins")

return function (context, ptw)
	local key = "plr_"..game:GetService("Players"):GetUserIdFromNameAsync(ptw)
	
	if admins_database:GetAsync(key) then
		return "Le joueur est déjà inscrit dans la base de données."
	else
		local succes, errormessage = pcall(function()
			admins_database:SetAsync(key, true)
		end)
		
		if succes then
			return "Le joueur à bien été ajouté dans la base de données."
		else
			warn(errormessage)
			return "Une erreur est survenue."
		end
	end
end
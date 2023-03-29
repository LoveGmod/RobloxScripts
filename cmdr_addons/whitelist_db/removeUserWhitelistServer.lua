local DataStoreService = game:GetService("DataStoreService")
local whitelisted_database = DataStoreService:GetDataStore("whitelisted")

return function (context, ptw)
	local key = "plr_"..game:GetService("Players"):GetUserIdFromNameAsync(ptw)
	
	if not whitelisted_database:GetAsync(key) then
		return "Le joueur n'est pas inscrit dans la base de données."
	else
		local succes, errormessage = pcall(function()
			whitelisted_database:SetAsync(key, false)
		end)
		
		if succes then
			return "Le joueur à bien été retiré de la base de données."
		else
			warn(errormessage)
			return "Une erreur est survenue."
		end
	end
end
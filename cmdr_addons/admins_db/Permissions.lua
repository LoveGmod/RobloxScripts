return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		if context.Group == "DefaultAdmin" and context.Executor:GetAttribute("admin") == false then
			return "Vous n'avez pas accès à cette commande."
		end
	end)
end
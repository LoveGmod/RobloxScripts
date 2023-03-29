return {
	Name = "addUserWhitelist";
	Aliases = {"whitelist", "wl"};
	Description = "Autorise un joueur à se connecter au jeu.";
	Group = "Admin";
	Args = {
		{
			Type = "string";
			Name = "Nom";
			Description = "Le nom du joueur.";
		},
	};
}
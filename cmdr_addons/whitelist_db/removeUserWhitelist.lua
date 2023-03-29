return {
	Name = "removeUserWhitelist";
	Aliases = {"rwhitelist", "rwl"};
	Description = "Refuse un joueur à se connecter au jeu.";
	Group = "Admin";
	Args = {
		{
			Type = "string";
			Name = "Nom";
			Description = "Le nom du joueur.";
		},
	};
}
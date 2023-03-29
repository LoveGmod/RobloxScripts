return {
	Name = "removeUserAdmin";
	Aliases = {"unrank"};
	Description = "Enlève les permissions à un joueur d'éxécuter les commandes.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "Nom";
			Description = "Le nom du joueur.";
		},
	};
}
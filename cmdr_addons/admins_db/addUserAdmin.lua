return {
	Name = "addUserAdmin";
	Aliases = {"setrank"};
	Description = "Donne les permissions d'éxécuter des commandes à un joueur.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "Nom";
			Description = "Le nom du joueur.";
		},
	};
}
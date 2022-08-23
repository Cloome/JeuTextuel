// Lance le jeu Monster Hunter New World
program monsterHunterNewWorld ;

uses inventaire, GestionEcran, marchand,
  creationperso, equipement, menuVilleUnit, menuUnit;

begin
  // Initialisations : d'équipement, d'inventaire et du joueur
  initEquipement;
  inventaireInitialisation;
  initialisationJoueur;

  // Lancement du menu principal
  menu(menuIHM);

end.

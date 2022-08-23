unit menuVilleIHM;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Classes, SysUtils, GestionEcran, Inventaire, creationPerso, chasseUnit;

//IHM du menu ville
procedure fondVille();
procedure forgeVille();
procedure boutiqueVille();
procedure cantineVille();
procedure chambreVille();
procedure chasseVille();

//IHM de l'encart PV et de l'encart Ville
procedure pvIHM();
procedure argentIHM();

//IHM de l'Inventaire
procedure inventaireConsoIHM; //avec juste les consommables
procedure inventaireIHM; //Tout

//IHM de la forge
procedure ForgeIHM(); //Forge quand on entre dans la forge
procedure ForgeSansRessources;//Forge quand on a pas les ressources

//IHM cantine
procedure cantineIHM();//Intérieur de la cantine
procedure messageCantineOui(ajoutPVRepas, prixRepas : integer); //Affiche qu'on a gagne des pv et perdu des sous
procedure messageCantineNon(); //Affiche qu'on peut pas manger

//IHM choix à l'entrée de la chambre
procedure chambreChoixIHM();
procedure messageDodoOui(ajoutPVRepos:integer); //Affiche qu'on a gagné des pv
procedure messageDodoNon; //Affiche qu'on peut pas dormir

//choix à l'entrée de la boutique
procedure BoutiqueChoixIHM();

//affiche retour à la ville
procedure retourVilleIHM();

//IHM Chasse
// Monstres
procedure dragonIHM(); //Affichage du dragon
procedure loupIHM(); //Affichage du loup
procedure grizzlyIHM(); //Affichage du grizzly
procedure monstreIHM(idCreature:integer);

procedure PerduIHM(); //Affiche perdu quand le combat est perdu


implementation
procedure personnage;
begin

  dessinerCadreXY(0, 6, 2, 10, simple, white, black);//bras gauche
  dessinerCadreXY(10, 6  , 12, 10, simple, white, black);//bras droit
  dessinerCadreXY(2, 10, 6, 13, simple, white, black); //jambe gauche
  dessinerCadreXY(6, 10, 10, 13, simple, white, black);//jambe droite
  dessinerCadreXY(2, 13, 6, 14, simple, white, black);//pied gauche
  dessinerCadreXY(6, 13, 10, 14, simple, white, black);//pied droite
  dessinerCadreXY(0, 10, 2, 11, simple, white, black);//main gauche
  dessinerCadreXY(10, 10, 12, 11, simple, white, black);//main droite
  dessinerCadreXY(2, 6, 10, 10, simple, white, black);//cuirasse
  dessinerCadreXY(2, 3, 10, 6, simple, white, black); //tete
  dessinerCadreXY(2, 2, 10, 3, simple, white, black); //cheveux
   dessinerCadreXY(3, 4, 5, 5, simple, white, black);
  dessinerCadreXY(7, 4, 9, 5, simple, white, black);
end;

//PV
procedure pvIHM();
begin
  dessinerCadreXY(106,0,119,2,simple,white,black);
  deplacerCurseurXY(109,1);
  write ('PV : ', player1.vieP)
end;
//argent
procedure argentIHM();
begin
  dessinerCadreXY(106,3,119,5,simple,white,black);
  deplacerCurseurXY(108,4);
  write ('Or : ', player1.argentP)
end;

///////
procedure fondVille;
begin
  pvIHM();
  argentIHM();
  dessinerCadreXY(2,20,119,28,simple,white,black);
  dessinerCadreXY(1,0,12,2,simple,white,black);
  dessinerCadreXY(43,25,74,27,simple,white,black);
  deplacerCurseurXY(2,1);
  write('0/ quitter');
  deplacerCurseurXY(44,26);
  write('Ou souhaitez-vous aller ? : ');
end;


//PROCEDURE qui affiche le batiment forge et la commande pour aller à la forge
procedure forgeVille;
begin
  dessinerCadreXY(3,6,23,20,simple,white,black);
  deplacerCurseurXY(9,21);
  write('1/ Forge');
  //Pour écrire forge
  deplacerCurseurXY(4,9);
  write ('||||| |||||| ||||||');
  deplacerCurseurXY(4,10);
  write ('||    ||  || ||  ||');
  deplacerCurseurXY(4,11);
  write ('||||  ||  || ||||  ');
  deplacerCurseurXY(4,12);
  write ('||    |||||| ||  ||');
  deplacerCurseurXY(7,14);
  write ('||||||  ||||||');
  deplacerCurseurXY(7,15);
  write ('||      ||||');
  deplacerCurseurXY(7,16);
  write ('|| |||  ||');
  deplacerCurseurXY(7,17);
  write ('||||||  ||||||');

end;

//PROCEDURE qui affiche le batiment boutique et la commande pour aller à la boutique
procedure boutiqueVille;
begin
  dessinerCadreXY(25,6,46,20,simple,white,black);
  deplacerCurseurXY(30,21);
  write('2/ Boutique');
  deplacerCurseurXY(26,7);
  //Pour écrire boutique
  write ('||||| |||||| ||  ||');
  deplacerCurseurXY(26,8);
  write ('|| // ||  || ||  ||');
  deplacerCurseurXY(26,9);
  write ('|| \\ ||  || ||  ||');
  deplacerCurseurXY(26,10);
  write ('||||| |||||| ||||||');
  deplacerCurseurXY(31,12);
  write ('|||||| ||');
  deplacerCurseurXY(31,13);
  write ('  ||   ||');
  deplacerCurseurXY(31,14);
  write ('  ||   ||');
  deplacerCurseurXY(26,16);
  write ('|||||| ||  || ||||||');
  deplacerCurseurXY(26,17);
  write ('||  || ||  || ||||  ');
  deplacerCurseurXY(26,18);
  write ('||\\|| ||  || ||    ');
  deplacerCurseurXY(26,19);
  write ('|||\\| |||||| ||||||');
end;

//PROCEDURE qui affiche le batiment cantine et la commande pour aller à la cantine
procedure cantineVille();
begin
  dessinerCadreXY(48,6,69,20,simple,white,black);
  deplacerCurseurXY(54,21);
  write('3/ Cantine');
  //Pour écrire cantine
  deplacerCurseurXY(49,7);
  write ('||||||   ||   |\  ||');
  deplacerCurseurXY(49,8);
  write ('||     ||  || | \ ||');
  deplacerCurseurXY(49,9);
  write ('||     |||||| || \\|');
  deplacerCurseurXY(49,10);
  write ('|||||| ||  || ||  \|');
  deplacerCurseurXY(54,12);
  write ('|||||| ||');
  deplacerCurseurXY(54,13);
  write ('  ||   ||');
  deplacerCurseurXY(54,14);
  write ('  ||   ||');
  deplacerCurseurXY(52,16);
  write ('|\  || ||||||');
  deplacerCurseurXY(52,17);
  write ('| \ || ||||  ');
  deplacerCurseurXY(52,18);
  write ('|| \\| ||    ');
  deplacerCurseurXY(52,19);
  write ('||  \| ||||||');
end;

//PROCEDURE qui affiche le batiment chambre et la commande pour aller à la chambre
procedure chambreVille;
begin
  dessinerCadreXY(71,6,91,20,simple,white,black);
  deplacerCurseurXY(76,21);
  write('4/ Chambre');
  //Pour écrire chambre
  deplacerCurseurXY(74,9);
  write ('|||| |  |   |   ');
  deplacerCurseurXY(74,10);
  write ('|    |||| |   | ');
  deplacerCurseurXY(74,11);
  write ('|    |  | ||||| ');
  deplacerCurseurXY(74,12);
  write ('|||| |  | |   | ');
  deplacerCurseurXY(72,14);
  write ('|\  /| ||| ||  ||||');
  deplacerCurseurXY(72,15);
  write ('| \/ | | / | | |||');
  deplacerCurseurXY(72,16);
  write ('||\/|| | \ ||  |');
  deplacerCurseurXY(72,17);
  write ('||  || ||| | | ||||');
end;

//PROCEDURE qui affiche le panneau chasse et la commande pour aller à la chasse
procedure chasseVille;
begin
  dessinerCadreXY(103,16,106,20,simple,white,black);
  dessinerCadreXY(93,12,118,16,simple,white,black);
  deplacerCurseurXY(96,21);
  write('5/ Aller a la chasse');
  //Pour écrire chasse
  deplacerCurseurXY(94,13);
  write ('||| | | /|\ \\\ \\\ ||||');
  deplacerCurseurXY(94,14);
  write ('|   ||| |||  \   \  |||');
  deplacerCurseurXY(94,15);
  write ('||| | | | | \\\ \\\ ||||');
end;

//PROCEDURE qui affiche l'inventaire
procedure inventaireIHM;
begin
  effacerEcran;
  dessinerCadreXY(1,0,119,28, simple, white, black); //Cadre de repérage (et qui fait joli)
  dessinerCadreXY(2,1,60,27, simple, white, black);  //Cadre Consommables
  dessinerCadreXY(61,1,118,27, simple, white, black);//Cadre Ressources
  argentIHM();
  pvIHM();

  deplacerCurseurXY(4,3);
  write ('||| |||| |\  | \\\ |||| |\/| |\/|  |  ||\ |   |||| \\\');
  deplacerCurseurXY(4,4);
  write ('|   |  | | \ |  \  |  | |\/| |\/| ||| | < |   |||   \');
  deplacerCurseurXY(4,5);
  write ('||| |||| |  \| \\\ |||| |  | |  | | | ||/ ||| |||| \\\');
  deplacerCurseurXY(62,3);
  write ('||\ |||| \\\ \\\ |||| | | ||\ ||| |||| \\\');
  deplacerCurseurXY(62,4);
  write ('||/ |||   \   \  |  | | | ||/ |   |||   \');
  deplacerCurseurXY(62,5);
  write ('| \ |||| \\\ \\\ |||| ||| | \ ||| |||| \\\');
  end;

//PROCEDURE qui affiche l'inventaire avec juste les consommables
procedure inventaireConsoIHM;
begin
  effacerEcran;
  dessinerCadreXY(2,1,60,28, simple, white, black); //Cadre Consommables
  deplacerCurseurXY(4,3);
  write ('||| |||| |\  | \\\ |||| |\/| |\/|  |  ||\ |   |||| \\\');
  deplacerCurseurXY(4,4);
  write ('|   |  | | \ |  \  |  | |\/| |\/| ||| | < |   |||   \');
  deplacerCurseurXY(4,5);
  write ('||| |||| |  \| \\\ |||| |  | |  | | | ||/ ||| |||| \\\');
end;

//IHM Cantine
procedure cantineIHM();
begin
  pvIHM();
  argentIHM();
  dessinerCadreXY(15, 5, 100, 25, simple, white, black); //Cadre du menu (repérage et esthétique)
  dessinerCadreXY(34, 8, 35+length('Voulez-vous manger un repas et gagner 10PV ?'), 12, simple, white, black); //Cadre de la question (repérage et esthétique)
  deplacerCurseurXY(35, 9);
  write('Voulez-vous manger un repas et gagner 10PV ?'); //Question posée au joueur
  deplacerCurseurXY(48, 11);
  write('Prix du repas : 20');
  deplacerCurseurXY(50, 14);
  write ('1/ Oui'); //Choix affiché à l'utilisateur de manger
  deplacerCurseurXY(50, 16);
  write ('0/ Non, retour à la ville');         //Choix affiché de retourner à la ville
  deplacercurseurXY(40,22);
  write('Votre choix :');       //Lieu où on demande à l'utilisateur de faire son choix
end;

//IHM Choix à l'entrée de la chambre
procedure chambreChoixIHM();
begin
  pvIHM();
  argentIHM();
  dessinerCadreXY(15, 5, 100, 25, simple, white, black); //Cadre du menu (repérage et esthétique)
  dessinerCadreXY(44, 8, 45+length('Que souhaitez vous faire ?'), 10, simple, white, black); //Cadre de la question (repérage et esthétique)
  deplacerCurseurXY(45, 9);
  write('Que souhaitez vous faire ?'); //Question posée au joueur
  deplacerCurseurXY(45, 14);
  write ('1/ Dormir et gagner 2 PV'); //Choix affiché à l'utilisateur de dormir pour regagner des pv
  deplacerCurseurXY(45, 16);
  write ('2/ Changer l''equipement'); //Choix affiché à l'utilisateur de changer l'equipement
  deplacerCurseurXY(45, 18);
  write ('0/ Retour à la ville');         //Choix affiché de retour à la ville
  deplacercurseurXY(40,22);
  write('Votre choix :');       //Lieu où on demande à l'utilisateur de faire son choix.
end;

//IHM Choix à l'entrée de la boutique
procedure BoutiqueChoixIHM();
begin
  pvIHM();
  argentIHM();
  dessinerCadreXY(15, 5, 100, 25, simple, white, black); //Cadre du menu (repérage et esthétique)
  dessinerCadreXY(38, 8, 39+length('Bonjour et bienvenue dans la boutique.?'), 12, simple, white, black); //Cadre de la question (repérage et esthétique)
  deplacerCurseurXY(39, 9);
  write('Bonjour et bienvenue dans la boutique.'); //Question posée au joueur
  deplacerCurseurXY(45, 11);
  write('Que souhaitez vous faire ?'); //Question posée au joueur
  deplacerCurseurXY(45, 14);
  write ('1/ Acheter'); //Choix affiché à l'utilisateur d'acheter
  deplacerCurseurXY(45, 16);
  write ('2/ Vendre'); //Choix affiché à l'utilisateur de vendre
  deplacerCurseurXY(45, 18);
  write ('0/ Retour à la ville');         //Choix affiché de retour à la ville
  deplacercurseurXY(40,22);
  write('Votre choix :');       //Lieu où on demande à l'utilisateur de faire son choix.
end;

procedure messageCantineOui(ajoutPVRepas, prixRepas : integer); //Affiche qu'on a gagne des pv et perdu des sous en mangeant
begin
  effacerEcran;
  dessinerCadreXY(30, 12, 90, 16, simple, white, black);  //cadre (repérage)
  deplacerCurseurXY((60-length('Vous avez obtenu 10 PV et perdu 20 argent') div 2),14);
  write('Vous avez obtenu ', ajoutPVRepas, ' PV ', 'et perdu ', prixRepas, ' or');
end;

procedure messageCantineNon(); //Affiche qu'on peut pas manger
  begin
  effacerEcran;
  dessinerCadreXY(19, 12, 101, 16, simple, white, black);  //cadre (repérage)
  deplacerCurseurXY((60-length('Vous n''avez pas suffisament d''argent pour vous nourrir ou vous l''avez déjà pris') div 2),14);
  write('Vous n''avez pas suffisament d''argent pour vous nourrir ou vous l''avez déjà pris');
end;
procedure messageDodoOui(ajoutPVRepos:integer); //Affiche qu'on a gagné des pv en dormant
   begin
  effacerEcran;
  dessinerCadreXY(30, 12, 90, 16, simple, white, black);  //cadre (repérage)
  deplacerCurseurXY((60-length('Vous avez obtenu 2 PV') div 2),14);
  write('Vous avez obtenu ', ajoutPVRepos, ' PV');
end;
procedure messageDodoNon; //Affiche qu'on peut pas dormir
  begin
  effacerEcran;
  dessinerCadreXY(30, 12, 90, 16, simple, white, black);  //cadre (repérage)
  deplacerCurseurXY((60-length('Vous avez déjà dormi') div 2),14);
  write('Vous avez déjà dormi');
end;

procedure retourVilleIHM(); //Affiche un truc pour retourner à la ville
begin
   dessinerCadreXY(118-length('0/ Retour à la ville.')-1, 25, 118, 27, simple, white, black);  //cadre (repérage)
   deplacerCurseurXY((118-length('0/ Retour à la ville.')),26);
   write('0/ Retour à la ville.');
end;

//Monstres :
procedure dragonIHM(); //Affichage du dragon
begin
    deplacerCurseurXY(40,6);
    write ('<>=======()');
    deplacerCurseurXY(40,7);
    write ('(/\___   /|\\          ()==========<>_');
    deplacerCurseurXY(40,8);
    write ('     \_/ | \\        //|\   ______/ \)');
    deplacerCurseurXY(40,9);
    write ('       \_|  \\      // | \_/');
    deplacerCurseurXY(40,10);
    write ('         \|\/|\_   //  /\/');
    deplacerCurseurXY(40,11);
    write ('           (oo)\ \_//  /');
    deplacerCurseurXY(40,12);
    write ('          //_/\_\/ /  |');
    deplacerCurseurXY(40,13);
    write ('         @@/  |=\  \  |');
    deplacerCurseurXY(40,14);
    write ('              \_=\_ \ |');
    deplacerCurseurXY(40,15);
    write ('               \==\ \|\_');
    deplacerCurseurXY(40,16);
    write ('            ___(\===\(  )\');
    deplacerCurseurXY(40,17);
    write ('            (((~) __(_/   |');
    deplacerCurseurXY(40,18);
    write ('                 (((~) \  /');
    deplacerCurseurXY(40,19);
    write ('                _______/ /');
    deplacerCurseurXY(40,20);
    write ('                ''------''');
    dessinerCadreXY(5,21,115,29,simple,white,black);
  end;

procedure loupIHM(); //Affichage du loup
begin
    deplacerCurseurXY(47,6);
    write ('        __........__ ');
    deplacerCurseurXY(47,7);
    write ('     .-''            ''-.');
    deplacerCurseurXY(47,8);
    write ('   .''                  ''.');
    deplacerCurseurXY(47,9);
    write ('  /                      \');
    deplacerCurseurXY(47,10);
    write (' /                        \');
    deplacerCurseurXY(47,11);
    write (';          |\              ;');
    deplacerCurseurXY(47,12);
    write ('|         |V \_            ;');
    deplacerCurseurXY(47,13);
    write (';         |  '' \           |');
    deplacerCurseurXY(47,14);
    write (';         )   ,_\          ;');
    deplacerCurseurXY(47,15);
    write (' \       /    |           /');
    deplacerCurseurXY(47,16);
    write ('  \     /      \         /');
    deplacerCurseurXY(47,17);
    write ('   ''.  |        \      .''');
    deplacerCurseurXY(47,18);
    write ('     ''-.\_|       \ __-''');
    deplacerCurseurXY(47,19);
    write ('          | |\    |');
    deplacerCurseurXY(47,20);
    write ('_________/  |_''.  /_______');
    dessinerCadreXY(5,21,115,29,simple,white,black);
  end;

procedure grizzlyIHM(); //Affichage du grizzly
begin
    deplacerCurseurXY(50,9);
    write ('   (''_"-----"_'')');
    deplacerCurseurXY(50,10);
    write ('   /           \');
    deplacerCurseurXY(50,11);
    write ('  /    .    .   \');
    deplacerCurseurXY(50,12);
    write ('  \    ( ° )    /');
    deplacerCurseurXY(50,13);
    write (' _''=_..__ __ __..=''_');
    deplacerCurseurXY(50,14);
    write ('/'';#''#''#. .#''#''#; ''\');
    deplacerCurseurXY(50,15);
    write ('\_)      ''       (_/');
    deplacerCurseurXY(50,16);
    write ('  #.            .#');
    deplacerCurseurXY(50,17);
    write ('  ''#.          .#''');
    deplacerCurseurXY(50,18);
    write ('  / ''#.      .#'' \');
    deplacerCurseurXY(50,19);
    write ('  \  \''#. .#''/  /');
    deplacerCurseurXY(50,20);
    write ('  (___) ''#'' (___)');
    dessinerCadreXY(5,21,115,29,simple,white,black);
  end;


procedure ForgeIHM(); //affiche l'etat initial de la forge quand on entre
begin
    effacerEcran;
    dessinerCadreXY(2,1,47,22,simple,white, black);
    dessinerCadreXY(48,1,105,22,simple,white, black);
    dessinerCadreXY(4,23,34,25,simple,white, black);
    dessinerCadreXY(105-length('0/ Retour à la ville.')-1, 23, 105, 25, simple, white, black);  //cadre (repérage)
    deplacerCurseurXY((105-length('0/ Retour à la ville.')),24);
    write('0/ Retour à la ville.');
end;

//Forge quand on a pas les ressources
procedure ForgeSansRessources;
begin
    effacerEcran;
    dessinerCadreXY(2,1,49,15,simple,white,black);    //cadre de gauche
    dessinerCadreXY(50,1,100,15,simple,white,black);  //cadre de droite
    dessinerCadreXY(7,16,79,18,simple,white,black);   //cadre du message système
    //Retour à la ville
    dessinerCadreXY(29-length('0/ Retour au menu Forge.')-1, 19, 29, 21, simple, white, black);  //cadre (repérage)
    deplacerCurseurXY((29-length('0/ Retour au menu Forge.')),20);
    write('0/ Retour au menu Forge.');
end;

//PROCEDURE qui affiche perdu quand un combat est perdu
procedure PerduIHM();
begin
     effacerEcran;
     dessinerCadreXY(17,11,103,15,double,white,black);
     deplacerCurseurXY(18,13);
     Write('Vous avez perdu cette bataille, mais vous réussissez à rejoindre la ville en rampant');
end;

//PROCEDURE qui affiche le bon monstre
procedure monstreIHM(idCreature:integer);
begin
     case idCreature of
          0:loupIHM;
          1:grizzlyIHM;
          2:dragonIHM;
     end;
end;


end.


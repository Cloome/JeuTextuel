unit menuVilleUnit;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Classes, SysUtils, GestionEcran;

function menuVilleAffichage (): integer; //Affiche le menuVille et renvoie le choix saisi
procedure menuVille(); //Gere le choix saisi par l'utilisateur dans menuVilleIHM
procedure quitterJeu(); //Procedure pour quitter le jeu depuis la ville
procedure quitterJeuIHM(); //Procédure qui affiche un message de au revoir
function quitterJeuSurIHM():integer; //Demande à l'utilisateur s'il est bien sur de vouloir quitter


procedure chasse(); // LANCE LA CHASSE
procedure cantine(); // LANCE LA CANTINE : MANGE UN REPAS SI SUFFISAMENT D ARGENT ET REPAS PAS PRIS
procedure chambre(); // LANCE LA CHAMBRE : CHOIX REPOS SI PAS DEJA DORMI OU GESTION EQUIPEMENT
procedure boutique(); // LANCE LA BOUTIQUE : MODE ACHAT OU VENTE
procedure forgeMenu(); // LANCE LA FORGE : CREATION EQUIPEMENT


procedure repasCantine(); // REPAS DE LA CANTINE : DONNE 10PV CONTRE 20ARGENT
procedure reposChambre(); // REPOS CHAMBRE : DONNE 2 PV SANS CONTREPARTIE

implementation
uses
  marchand, creationperso, menuVilleIHM, inventaire, chasseUnit, equipement;

//Affiche le menuVille et renvoie le choix saisi
function menuVilleAffichage ():integer;
begin
  effacerEcran;
  fondVille();
  forgeVille();
  boutiqueVille();
  cantineVille();
  chambreVille();
  chasseVille();
  deplacerCurseurXY(73,26);
  readln(menuVilleAffichage);

end;

// LANCE LA CHASSE
procedure chasse();
begin
  // Passe la variable repasPris et faitDodo a false pour pouvoir reprendre des repas et redormir
  player1.repasPris:= false;
  player1.faitDodo:=false ;
  effacerEcran;
  // appel procedure combat
  combat;

end;

// LANCE LA FORGE : CREATION EQUIPEMENT
procedure forgeMenu();
begin
  effacerEcran;
  // Affichage choix de l'utilisateur
  writeln ('Bienvenue dans la forge');

  // appel procedure forge
  forge;

end;


// REPOS CHAMBRE : DONNE 2 PV SANS CONTREPARTIE
procedure reposChambre();
const
  ajoutPVRepos= 2; // points de vie ajouter après repos
begin
     // Le personnage n'a pas encore dormi avant la chasse
  if player1.faitDodo=false then
     begin
     player1.vieP:=player1.vieP+ajoutPVRepos; // Ajoute les PV
     messageDodoOui(ajoutPVRepos);
     player1.faitDodo:=true; // le repos a maintenant été pris donc faitDodo passe à true
     end
     // Le personnage a déjà dormi avant la chasse
  else
      begin
      messageDodoNon;
      retourVilleIHM();
      end;
end;


// LANCE LA CHAMBRE : CHOIX REPOS OU GESTION EQUIPEMENT
procedure chambre();
var
   choixChambre:integer; // choix dans la chambre repos/gestion/quitter

begin
  effacerEcran;

  // Affichage choix de l'utilisateur
  chambreChoixIHM();
  readln(choixChambre);

  // Lance le mode repos
  if (choixChambre=1) then
     begin
     reposChambre;
     retourVilleIHM();
     readln(choixChambre);
  if (choixChambre=0) then menuVille();
  end;

  // Lance la gestion d'équipement
  if (choixChambre=2) then
     begin
     effacerEcran;
     gestionEquipement;
     end;

  // Quitte la chambre si choix Q
  if (choixChambre=0) then menuVille();

end;


// LANCE LA BOUTIQUE : MODE ACHAT OU VENTE
procedure boutique();
var
  choixBoutique:integer; // choix dans la boutique : achat/vente/ quitter
begin
  effacerEcran;

  // Affichage choix de l'utilisateur
  BoutiqueChoixIHM();
  readln(choixBoutique);

  // Lance le mode achat
  if (choixBoutique= 1) then
     begin
     effacerEcran;
     marchandAchat();
     end;

  // Lance le mode vente
  if (choixBoutique= 2) then
     begin
     effacerEcran;
     marchandVente();
     end;

  // Quitte la boutique
  if (choixBoutique=0) then menuVille();
  readln;
end;


// REPAS DE LA CANTINE : DONNE 10PV CONTRE 20ARGENT
procedure repasCantine();
const
  prixRepas= 20 ; // prix d'un repas
  ajoutPVRepas= 10; // nombre de PV ajouter après la consommation d'un repas

begin
     // Si le perso a suffisament d'argent et n'a pas pris de repas
     if (player1.argentP >= prixRepas) and (player1.repasPris=false) then
        begin
        // Ajoute les 10 PV
        player1.vieP:= player1.vieP+ ajoutPVRepas;

        // Enleve de l'argent
        player1.argentP:= player1.argentP - prixRepas;

        // Passe la variable repasPris a true
        player1.repasPris:= true;

        // Affiche un message
        messageCantineOui(ajoutPVRepas,prixRepas);
        retourVilleIHM();
        end

     // Affichage si le perso n'a pas suffisament d'argent
     else
     begin
       messageCantineNon();

     end;

end;

// LANCE LA CANTINE : MANGE UN REPAS ET GAGNE PV
procedure cantine();
var
  choixCantine: integer; // choix dans la cantine

begin
  effacerEcran;
  // Affichage choix
  cantineIHM();
  readln(choixCantine);

  // Lance le repas si choix 1
  if (choixCantine=1) then
     begin
     repasCantine;
     // Retour ville
     retourVilleIHM();
     readln(choixCantine);
          if (choixCantine=0) then menuVille();
     end;

  // Quitte la cantine si choix 0
  if (choixCantine=0) then menuVille();
  readln;
end;

//Demande à l'utilisateur s'il est bien sur de vouloir quitter
function quitterJeuSurIHM(): integer;
begin
  effacerEcran;
  dessinerCadreXY(30,11,90,15,double,white,black);
  deplacerCurseurXY(41,12);
  write('Voulez vous vraiment quitter le jeu ? ');
  deplacerCurseurXY(41,13);
  write('0/ Oui, quitter.');
  deplacerCurseurXY(41,14);
  write('1/ Non, rester sur le jeu.');
  readln(quitterJeuSurIHM);
end;


//Procédure qui affiche un message de au revoir
procedure quitterJeuIHM();
begin
   effacerEcran;
   dessinerCadreXY(40,11,80,15,double,white,black);
   deplacerCurseurXY(55,13);
   write('AU REVOIR !');
   readln;
end;

//Procedure pour quitter le jeu depuis la ville
procedure quitterJeu();
 var
   quit : integer; //Variable de confirmation de bien vouloir quitter
 begin
   quit:=quitterJeuSurIHM();
   if (quit=0) then quitterJeuIHM()
   else menuVille();
 end;

//Gere le choix saisi par l'utilisateur dans menuVilleIHM
procedure menuVille ();
var
  lieu : integer; //Choix de lieu où l'utilisateur choisi d'aller
begin
  lieu:=menuVilleAffichage();
  if (lieu= 1) then forgeMenu()
  else if (lieu=2) then boutique()
       else if (lieu=3) then cantine()
            else if (lieu=4) then chambre()
                 else if (lieu=5) then chasse()
                      else if (lieu=0) then quitterJeu()
end;

end.


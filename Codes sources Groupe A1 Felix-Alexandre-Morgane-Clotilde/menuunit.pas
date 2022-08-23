unit menuUnit;

{$mode objfpc}{$H+}

interface
uses
  Classes, SysUtils;

var
  choix:string;
function menuIHM():string; //Affiche le menu et renvoie le choix saisi
procedure quitterIHM (); //Affiche un truc pour dire au revoir
procedure quitter(); //Affiche un truc pour dire au revoir et quitte.
procedure menu(menuIHM:string); //Gere le choix saisi par l'utilisateur dans menuIHM

implementation
uses GestionEcran, inventaire, creationperso, menuVilleUnit;

//FONCTION qui affiche le menu et récupère le choix utilisateur
function menuIHM():string;
begin
   dessinerCadreXY(15, 5, 100, 25, double, white, black); //Cadre du menu (repérage et esthétique)
   deplacerCurseurXY(40, 6);
   write('-----------------------------------');
   deplacerCurseurXY(40, 7);
   write('--  MONSTER HUNTER ~ NEW WORLD   --'); //Titre du jeu encadré par des tirets
   deplacerCurseurXY(40, 8);
   write('-----------------------------------');
   deplacerCurseurXY(50, 14);
   write ('1/ Nouvelle partie'); //Choix affiché à l'utilisateur de commencer une nouvelle partie
   deplacerCurseurXY(50, 16);
   write ('0/ Quitter');         //Choix affiché de quitter le jeu
   deplacercurseurXY(40,22);
   write('Votre choix :');       //Lieu où on demande à l'utilisateur de faire son choix
   readln(menuIHM);
end;

//PROCEDURE qui affiche un joli message pour dire au revoir à l'utilisateur
procedure quitterIHM ();
begin
   effacerEcran;
   dessinerCadreXY(35, 10, 80, 12, double, white, black);  //Joli cadre (repérage)
   deplacerCurseurXY(53,11);
   write('AU REVOIR');                                     //Message au revoir
   readln;
end;
//PROCEDURE qui quitte le jeu
procedure quitter();
begin
   quitterIHM();                                           //Affiche le joli message qui dit au revoir avant de quitter
end;


//PROCEDURE qui gere le menu logique
procedure menu(menuIHM:string);
var
  choix:string; //Variable qui récupère le choix de l'utilisateur
begin
     choix:=menuIHM;
     if (choix= '1') then  //Si le choix est 1 (nouvelle partie) alors on lance les procédures de création de personnage et le menuVille
        begin
        saisieP ();
        menuVille;
        end
     else quitter();      //Si le choix est 0 ou autre (quitter) alors on lance le message et la procédure qui permettent de quitter

end;

end.

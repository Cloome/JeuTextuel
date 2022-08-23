//Unité qui permet de créer son personnage
unit creationperso;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

type
    player=record     //Type joueur
 //Variables Descriptives  (n'infuent pas sur le jeu)
 nomP:string;      //Nom du personnage
 sexeP:string;     //Sexe du personnage  (‘Homme’, ‘Femme’, ’Non binaire’)
 tailleP:real;    //Taille en mètres
 corpsP:string;     //Corpulence          (‘Svelte’, ’Muscle’, ’Massif’)
 ageP:integer;      //Age en années
 cheveuxP:string;   //Couleur des cheveux (‘Bruns’, ‘Blonds’, ‘Roux’, ‘Bicolores’)
 yeuxP:string;      //Couleur des yeux    (‘Bruns’, ‘Bleus’, ‘Verts’, Rouges’)

 //Variables de jeu  (prises en compte dans le jeu)
 vieP:integer;
 argentP:integer;
 repasPris: boolean; // indique si le perso a pris un repas, permet de ne prendre qu'un repas avant chaque chasse
 faitDodo: boolean; // indique si le perso a dormi, permet de ne dormir qu'une fois avant chaque chasse
 end;

 var
   player1:player;     //Profil du joueur 1

procedure initialisationJoueur; //Procedure d'initialisation du joueur 1
procedure saisieP;     //Procedure de saisie des caractèristiques du joueur 1

implementation
uses gestionEcran;
 var
   nSaisi:integer;     //Numéro saisi par l'utilisateur lors de choix restreints par les fonctions

 //Fonction de choix du sexe
function quelSexe (n:integer):string;
  var
   sexe : string;

 begin
   sexe := '';
   case n of
     1 : sexe:= 'Femme';
     2 : sexe:= 'Homme';
     3 : sexe:= 'Non binaire';
   else sexe:= 'Asexue';
   end;
   result := sexe;
 end;

//Fonction de choix de la corpulence
function quelCorps (n:integer):string;
 var
   corps : string;

 begin
   corps := '';
   case n of
     1 : corps:= 'Svelte';
     2 : corps:= 'Muscle';
     3 : corps:= 'Massif';
   else corps:= 'Inexistant';
   end;
   result := corps;
 end;

function quelsCheveux (n:integer):string; //Fonction de choix de la couleur de cheveux
   var
   coulCheuv : string;

 begin
   coulCheuv := '';
   case n of
     1 : coulCheuv:= 'Bruns';
     2 : coulCheuv:= 'Blonds';
     3 : coulCheuv:= 'Roux';
     4 : coulCheuv:= 'Bi-colores';
   else coulCheuv:= 'Chauve';
   end;
   result := coulCheuv;
 end;

function quelsYeux (n:integer):string; //Fonction de choix de la couleur des yeux
   var
   coulYeux : string;

 begin
   coulYeux := '';
   case n of
     1 : coulYeux:= 'Bruns';
     2 : coulYeux:= 'Bleus';
     3 : coulYeux:= 'Verts';
     4 : coulYeux:= 'Rouges';
   else coulYeux:= 'Aveugle';
   end;
   result := coulYeux;
 end;

//Procedure d'initialisation du joueur
procedure initialisationJoueur;

begin
  player1.nomP:='';
  player1.sexeP:='';
  player1.tailleP:=0;
  player1.corpsP:='';
  player1.ageP:=0;
  player1.cheveuxP:='';
  player1.yeuxP:='';
  player1.vieP:=100;
  player1.argentP:=0;
  player1.repasPris:=false;
  player1.faitDodo:=false;
end;

//Procedure de saisie des caractéristiques du joueur 1
procedure saisieP;

begin
  //Initialisation des variables de travail
  nSaisi:=0;

  //Saisie par l'utilisateur
  //Cadre IHM
  effacerEcran;
  dessinerCadreXY(20,4,100,25, simple,white, black);
           //Saisie du nom
           deplacerCurseurXY(22,8);
           write ('Quel est ton nom? ');
           readln (player1.nomP);

           //Saisie du sexe
           deplacerCurseurXY(22,10);
           write ('Quel est ton sexe? (1.Femme 2.Homme 3.Non binaire) ');
           readln (nSaisi) ;
           player1.sexeP:=quelSexe(nSaisi);

           //Saisie de la taille
           deplacerCurseurXY(22,12);
           write ('Quelle est ta taille? (Entre 100cm et 300cm) ');
           readln (player1.tailleP);

           //Saisie de la corpulence
           deplacerCurseurXY(22,14);
           write ('Quelle est ta corpulence? (1.Svelte 2.Muscle 3.Massif) ');
           readln (nSaisi);
           player1.corpsP:=quelCorps(nSaisi);

           //Saisie de l'age
           deplacerCurseurXY(22,16);
           write ('Quel age as-tu? (Entre 1an et 999ans) ');
           readln (nSaisi);
           player1.ageP:=(nSaisi);

           //Saisie de la couleur des cheveux
           deplacerCurseurXY(22,18);
           write ('Quelle est la couleur de tes cheveux? (1.Bruns 2.Blonds 3.Roux 4.Bi-colores) ');
           readln (nSaisi);
           player1.cheveuxP:=quelsCheveux(nSaisi);

           //Saisie de la couleur des yeux
           deplacerCurseurXY(22,20);
           write ('De quelle couleur sont tes yeux? (1.Bruns 2.Bleus 3.Verts 4.Rouges) ');
           readln (nSaisi);
           player1.yeuxP:=quelsYeux(nSaisi);

//Affichage du résumé du profil du joueur 1
effacerEcran;
dessinerCadreXY(20,4,100,25, simple,white, black);

  deplacerCurseurXY(35,5);
  writeln
         ('Resume de ton profil:');

  //Affichage du nom
  deplacerCurseurXY(50,8);
  writeln
         ('Nom: ',player1.nomP);

  //Affichage du sexe
  deplacerCurseurXY(50,10);
  writeln
         ('Sexe: ',player1.sexeP);

  //Affichage taille
  deplacerCurseurXY(50,12);
  begin
         if ((player1.tailleP>0) and (player1.tailleP<=300)) then
            begin
              writeln
              ('Taille: ',player1.tailleP:1:0,' cm')
            end
         else if (player1.tailleP<=0) then
            begin
              writeln
              ('Taille: Nanoscopique')
            end
         else if (player1.tailleP>3) then
            begin
              writeln
              ('Taille: Geant');
            end;
  end;

  //Affichage de la corpulence
  deplacerCurseurXY(50,14);
  writeln
         ('Corpulence: ',player1.corpsP);

  //Affichage de l'age
  deplacerCurseurXY(50,16);
  begin
              if((player1.ageP>0) and (player1.ageP<999)) then
              begin
              writeln
              ('Age: ',player1.ageP,' ans')
              end
         else if (player1.ageP=0) then
              begin
              writeln
              ('Age: pas ne(e)')
              end
         else if (player1.ageP>999) then
              begin
         writeln
         ('Age: deja mort(e)');
              end;
  end;

  //Affichage de la couleur des cheveux
  deplacerCurseurXY(50,18);
  writeln
         ('Cheveux ',player1.cheveuxP);

  //Affichage de la couleur des yeux
  deplacerCurseurXY(50,20);
  writeln
         ('Yeux ',player1.yeuxP);

  //Affichage des point de vie
  deplacerCurseurXY(50,22);
  writeln
         ('Points de vie: ',player1.vieP);

  //Affichage de l'argent
  deplacerCurseurXY(50,24);
  writeln
         ('Or: ',player1.argentP);

  deplacerCurseurXY(68,27);
  write('Appuyez sur entrée pour continuer');


  readln;


end;

end.


unit testUnitaireCreationPerso;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Classes, SysUtils, gestionEcran;

procedure initialisationJoueur_test();
procedure testUnitairePerso();
implementation
uses
  creationperso,TestUnitaire;

    
//Teste l'initialisation de joueur (début de partie) -> creationperso
procedure initialisationJoueur_test();
var
  initialisationFaite: boolean; // vérifie si l'initialisation a été faite

begin
     //Tests d'initialisation du joueur
     newTestsSeries('Initialisation du joueur') ;

     //Test d'initialisation du nom
     newTest('Initialisation du joueur','Initialisation du nom du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.nomP,'');

     //Test d'initialisation  du sexe
     newTest('Initialisation du joueur','Initialisation du sexe du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.sexeP,'');

     //Test d'initialisation de la taille
     newTest('Initialisation du joueur','Initialisation de la taille du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.tailleP,0);

     //Test d'initialisation de la corpulence
     newTest('Initialisation du joueur','Initialisation de la corpulence du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.corpsP,'');

     //Test d'initialisation de l'age
     newTest('Initialisation du joueur','Initialisation de l''age du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.ageP,0);

     //Test d'initialisation des cheveux
     newTest('Initialisation du joueur','Initialisation des cheveux du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.cheveuxP,'');

     //Test d'initialisation des yeux
     newTest('Initialisation du joueur','Initialisation des yeux du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.yeuxP,'');

     //Test d'initialisation de la vie
     newTest('Initialisation du joueur','Initialisation de la vie du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.vieP,100);

     //Test d'initialisation de l'argent
     newTest('Initialisation du joueur','Initialisation de l''argent du joueur') ;
     initialisationJoueur() ;
     testIsEqual(player1.argentP,0);

     // Test d'initialisation du repasPris
     newTest('Initialisation du joueur','Initialisation du repasPris du joueur') ;
     initialisationJoueur() ;
     initialisationFaite:=true;

     if (player1.repasPris = true) then initialisationFaite:= false; // rend l'initialisation fausse si le repas est indiqué comme true donc pris
     testIsEqual(initialisationFaite);

     // Test d'initialisation de faitDodo
     newTest('Initialisation du joueur', 'Initialisation de faitDodo');
     initialisationJoueur();
     initialisationFaite:=true;

     if (player1.faitDodo=true) then initialisationFaite:=false; // rend l'initialisation fausse si faitDodo est indiqué comme true donc si le perso a dormi
     testIsEqual(initialisationFaite);
end;

//Procedure résumé

procedure testUnitairePerso();

begin
     initialisationJoueur_test();

     summary();
     readln;
end;
end.


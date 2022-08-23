// test si la procédure reposChambre fonctionne bien
unit testUnitaireChambre;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Classes, SysUtils, GestionEcran;

// test unitaire quand le personnage n'a pas dormi
procedure testDodoPasFait;

// test unitaire quand le personnage a dormi
procedure testDodoFait;

// résume la procédure
procedure testChambre;


implementation
uses
  menuVilleUnit, creationPerso, TestUnitaire;

// test unitaire quand le personnage n'a pas dormi
procedure testDodoPasFait;
var
   modifFaites: boolean; // renvoie si les pv ajoutés
const
   ajoutPVRepos= 2; // points de vie ajouter après repos

begin
     newTestsSeries('Chambre : personnage pas encore dormi');

     // Test ajout PV
     newTest('Chambre : personnage pas encore dormi', 'Ajout PV');
     initialisationJoueur; // Mettre les PV à 100, argent à 0 et faitDodo : pas encore
     modifFaites:= true; // initialisation de modifFaites
     reposChambre; // lance la procedure
     effacerEcran;

     if (player1.vieP <> 100+ajoutPVRepos) then modifFaites:= false; // conditions qui fait que le test échoue, les PV doivent être ajoutés
     testIsEqual(modifFaites);

     // Test modification faitDodo
     newTest('Chambre : personnage pas encore dormi', 'Modification faitDodo');
     initialisationJoueur; // Mettre les PV à 100, argent à 0 et faitDodo : pas encore
     modifFaites:= true; // initialisation de modifFaites
     reposChambre; // lance la procedure
     effacerEcran;

     if (player1.faitDodo=false) then modifFaites:= false; // conditions qui fait que le test échoue, faitDodo doit être passé à vrai
     testIsEqual(modifFaites);

end;

// test unitaire quand le personnage a dormi
procedure testDodoFait;
var
   modifFaites: boolean; // renvoie si les pv ajoutés
const
   ajoutPVRepos= 2; // points de vie ajouter après repos

begin
     newTestsSeries('Chambre : personnage a déjà dormi');

     // Test ajout PV
     newTest('Chambre : personnage a déjà dormi', 'Pas d''ajout PV');
     initialisationJoueur; // Mettre les PV à 100, argent à 0 et faitDodo : pas encore
     modifFaites:= true; // initialisation de modifFaites
     player1.faitDodo:=true; // indique que le joueur a déjà dormi
     reposChambre; // lance la procedure
     effacerEcran;

     testIsEqual(player1.vieP, 100); // conditions qui fait que le test échoue, les PV ne doivent pas être ajoutés

     // Test modification faitDodo
     newTest('Chambre : personnage a déjà dormi', 'Pas de modification faitDodo');
     initialisationJoueur; // Mettre les PV à 100, argent à 0 et faitDodo : pas encore
     modifFaites:= true; // initialisation de modifFaites
     player1.faitDodo:=true; // indique que le joueur a déjà dormi
     reposChambre; // lance la procedure
     effacerEcran;

     if (player1.faitDodo=false) then modifFaites:= false; // conditions qui fait que le test échoue, faitDodo doit rester à vrai
     testIsEqual(modifFaites);

end;

// résume la procédure
procedure testChambre;
begin
     testDodoFait;
     testDodoPasFait;
     effacerEcran;

     Summary();
     readln;
end;

end.


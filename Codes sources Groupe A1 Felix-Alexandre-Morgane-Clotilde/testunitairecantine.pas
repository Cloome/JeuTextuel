// test si la procédure repasCantine fonctionne bien
unit testUnitaireCantine;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Classes, SysUtils;

// test unitaire quand le repas est pris
procedure testRepasPris;

// test unitaire quand le repas n'est pas pris
procedure testRepasPasPris;

// réuni toutes les procédures et fait un résumé
procedure testCantine;


implementation
uses
  menuVilleUnit, creationPerso, TestUnitaire, gestionEcran;

// test unitaire quand le repas est pris
procedure testRepasPris;
var
  modifFaites: boolean; // vérifie si les modifs ont été faites
const
  prixRepas= 20 ; // prix d'un repas
  ajoutPVRepas= 10; // nombre de PV ajouter après la consommation d'un repas

begin
     newTestsSeries('Repas à la cantine assez d''argent');

     // Test argent
     newTest('Repas à la cantine assez d''argent', 'Enlève l''argent');
     initialisationJoueur; // Mettre les PV à 100 et argent à 0
     player1.argentP:= player1.argentP+(prixRepas+30); // les repas coûtent 20 donc je donne 50 au joueur pour vérifier par la suite qu'il en reste 30
     repasCantine; // lance la procedure

     testIsEqual(player1.argentP, 30); // test si argent = 30

     
     // Test PV
     newTest('Repas à la cantine assez d''argent', 'Ajout PV');
     initialisationJoueur; // Mettre les PV à 100 et argent à 0
     player1.argentP:= player1.argentP+(prixRepas); // donne suffisament d'argent pour prendre un repas
     repasCantine; // lance la procedure

     testIsEqual(player1.vieP, (100+ajoutPVRepas)); // test si PV = 100 + ajoutPVRepas

     // Test si la variable repasPris repasse à true
     newTest('Repas à la cantine assez d''argent', 'Repas a été pris');
     initialisationJoueur; // Mettre les PV à 100 et argent à 0
     player1.argentP:= player1.argentP+(prixRepas); // donne suffisament d'argent pour prendre un repas
     modifFaites:= true; // initialisation de modifFaites
     repasCantine; // lance la procedure

     if (player1.repasPris = false) then modifFaites:= false; // test si la variable repas pris n'a pas bougé
     testIsEqual(modifFaites);

end;

// test unitaire quand le repas n'est pas pris
procedure testRepasPasPris;
var
  modifFaites: boolean; // vérifie si les modifs ont été faites


begin
     newTestsSeries('Repas à la cantine pas assez d''argent');

     // Test argent
     newTest('Repas à la cantine pas assez d''argent', 'N''enlève pas l''argent');
     initialisationJoueur; // Mettre les PV à 100 et argent à 0
     player1.argentP:= player1.argentP + 10; // les repas coûtent 20 donc je donne 10 au joueur pour qu'il n'ait pas assez
     repasCantine; // lance la procedure

     testIsEqual(player1.argentP, 10); // test si argent = 10

     // Test PV
     newTest('Repas à la cantine pas assez d''argent', 'N''ajoute pas de PV');
     initialisationJoueur; // Mettre les PV à 100 et argent à 0
     repasCantine; // lance la procedure

     testIsEqual(player1.vieP, 100); // test si PV = 100

     // Test si la variable repasPris repasse à true
     newTest('Repas à la cantine pas assez d''argent', 'Le repas n''a pas été pris');
     initialisationJoueur; // Mettre les PV à 100 et argent à 0 et repasPris à false
     modifFaites:= true; // initialisation de modifFaites
     repasCantine; // lance la procedure

     if (player1.repasPris = true) then modifFaites:= false; // test si la variable repas pris n'a pas bougé
     testIsEqual(modifFaites);

end;

// Réuni toutes les procédures et fait un résumé
procedure testCantine;
begin
     testRepasPasPris;
     testRepasPris;
     effacerEcran;

     Summary;
     readln;
end;


end.


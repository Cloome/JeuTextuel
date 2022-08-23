unit testUnitaireChasse;
// tests unitaire des procédure testable de l'unité chasseUnit
{$codepage utf8}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,TestUnitaire,inventaire,chasseUnit,equipement,creationperso,GestionEcran;

// PROCEDURE LANCANT TOUT LES TEST
procedure chasse_Test;

// test initialisation creature
procedure initCreature_Test;

//test initialisation joueur
procedure initPersoCombat_Test;

// test la procedure de combat pendant le tour de la créature
procedure toursCreature_Test;

// test la procedure de combat pendant le tour du joueur
procedure toursJoueur_Test;



implementation

// test initialisation creature
procedure initCreature_Test;

var
  nom:string;
  pv,
  degat,
  armure,
  affichageCreature:integer;
  testReussi:boolean;

  i:integer;
begin                                 //--Verification des bons renvois de variable lors de la procedure initCréature (100 fois par attribut puisque léger aléatoire)
  initCompteurEnnemi;
  newTestsSeries('Initialisation créature');
  newTest('Initialisation créature','nom');           // --NOM-- //
  testReussi:=true;
  for i:=0 to 100 do
  begin
  initCreature(nom, pv, degat, armure,affichageCreature);
  if (nom<>'Loup enragé') and (nom<>'Grizzli furieux') and (nom<>'Jeune Dragon') then testReussi:=false;
  end;
  testIsEqual(testReussi);

  newTest('Initialisation créature','PV');            // --PV-- //
  testReussi:=true;
  for i:=0 to 100 do
  begin
  initCreature(nom, pv, degat, armure,affichageCreature);
  if (pv<9) or (pv>24) then testReussi:=false;
  end;
  testIsEqual(testReussi);

  newTest('Initialisation créature','degat');         // --DEGAT-- //
  testReussi:=true;
  for i:=0 to 100 do
  begin
  initCreature(nom, pv, degat, armure,affichageCreature);
  if (degat<4) or (degat>9) then  testReussi:=false;
  end;
  testIsEqual(testReussi);

  newTest('Initialisation créature','armure');        // --ARMURE-- //
  testReussi:=true;
  for i:=0 to 100 do
  begin
  initCreature(nom, pv, degat, armure,affichageCreature);
  if (armure<0) or (armure>2) then  testReussi:=false;
  end;
  testIsEqual(testReussi);

end;

//test initialisation joueur
procedure initPersoCombat_Test;
var
  pv,                          //--Verification des bons renvois de variable lors de la procedure initPersoCombat
  degat,
  armure:integer;
begin
  newTestsSeries('Initialisation joueur');
  newTest('Initialisation joueur','degat');
  initEquipement;
  initPersoCombat(pv, degat, armure);
  testIsEqual(degat=4);
  newTest('Initialisation joueur','armure');
  initEquipement;
  initPersoCombat(pv, degat, armure);
  testIsEqual(armure=2);


end;

// test la procedure de combat pendant le tour de la créature
procedure toursCreature_Test;
var
  creaNom:string;
  creaPV,
  creaDegat,
  creaArmure,
  affichageCreature:integer;

  persoPVEntrant,
  persoPVSortant,
  persoDegat,
  persoArmure:integer;

  i:integer;
  testReussi:boolean;

begin                       //--Verification des bons renvois de variable lors de la procedure toursCreature
                            //--(100 test car aléatoire)(réuni en un seul pour la lisibilité lors de l'éxécution du test)
newTestsSeries('Tour créature');
newTest('Tour créature','degat');
testReussi:=true;

for i:=0 to 100 do
begin
  initEquipement;
  initialisationJoueur;
  initCreature(creaNom, creaPV, creaDegat, creaArmure,affichageCreature);
  initPersoCombat(persoPVEntrant,persoDegat,persoArmure);
  toursCreature (persoPVEntrant,persoArmure,creaDegat,affichageCreature, persoPVSortant);
  if (persoPVSortant<persoPVEntrant-16) then testReussi:=false;
end;
testIsEqual(testReussi);
end;

// test la procedure de combat pendant le tour du joueur
procedure toursJoueur_Test;
var
  creaNom:string;
  creaPVEntrant,
  creaPVSortant,
  creaDegat,
  creaArmure,
  affichageCreature:integer;

  persoPV,
  persoDegat,
  persoArmure:integer;

  i:integer;
  testReussi:boolean;

begin                     //--Verification des bons renvois de variable lors de la procedure toursJoueur
                          //--(100 test car aléatoire)(réuni en un seul pour la lisibilité lors de l'éxécution du test)
newTestsSeries('Tour joueur');
newTest('Tour joueur','degat');
testReussi:=true;

for i:=0 to 100 do
begin
  initEquipement;
  initialisationJoueur;
  initCreature(creaNom, creaPVEntrant, creaDegat, creaArmure,affichageCreature);
  initPersoCombat(persoPV,persoDegat,persoArmure);
  toursJoueur (persoDegat,creaPVEntrant,creaArmure,creaPVSortant);
  if (creaPVSortant<creaPVEntrant-8) then testReussi:=false;
end;
testIsEqual(testReussi);
end;

// PROCEDURE LANCANT TOUT LES TEST
procedure chasse_Test;
begin
  initCreature_Test;
  initPersoCombat_Test;
  toursCreature_Test;
  toursJoueur_Test;
  effacerEcran;
  Summary();
  readln;
end;

end.


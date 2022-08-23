// Reuni tous les test unitaires
program testUnitaireMonsterHunter;

{$mode objfpc}{$H+}
{$codepage utf8}

uses testUnitaire, testUnitaireInventaire, testUnitaireCreationPerso,
  gestionEcran, testUnitaireCantine, testUnitaireChambre, testUnitaireEquipementEtForge,testUnitaireChasse;

begin

  //--Test unitaire inventaire
  testInventaire;

  //--Test unitaire création perso
  testUnitairePerso;

  //--Test unitaire repas cantine
   testCantine;

  //--Test unitaire repos chambre
  testChambre;

  //--Test unitaire equipement forge
  equipementEtForge_Test;
  effacerEcran;

  //--Test unitaire chasse
  chasse_Test;

  readln;

end.


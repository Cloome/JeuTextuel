// test si l'unité inventaire fonctionne correctemment
unit testUnitaireInventaire;

{$mode objfpc}{$H+}
{$codepage utf8}

interface

uses
  Classes, SysUtils, inventaire, testUnitaire, gestionEcran, creationperso;


// TEST INITIALISATION INVENTAIRE
procedure testInitialisationInventaire;

// TEST AJOUT QUANTITE INVENTAIRE
procedure testAjoutQInventaire;

// TEST ENLEVE QUANTITE INVENTAIRE
procedure testSupprQInventaire;

// LANCE TOUS LES TESTS
procedure testInventaire;


implementation

procedure testInitialisationInventaire;
var
  estInitialise: boolean; // renvoi si le resultat echoue (false) ou s'il est bon (true)
  i: integer;  // variable de boucle

begin
   newTestsSeries('Initialisation Inventaire');
      // Quantité
      newTest('Initialisation Inventaire', 'Initialisation Quantité');
      inventaireInitialisation;
      estInitialise := True;
      for i:=0 to TAILLEINVENTAIRE do
           begin
            if inventaireI[i].quantiteItem <> 0  then estInitialise:= False;
           end;
      testIsEqual(estInitialise);

      // Nom
      newTest('Initialisation Inventaire', 'Initialisation Nom');
      inventaireInitialisation;
      estInitialise := True;
      for i:=0 to TAILLEINVENTAIRE do
          begin
          if (inventaireI[i].nomItem= '') or (inventaireI[i].nomItem=' ') then estInitialise:= False;
          end;
      testIsEqual(estInitialise);

       // Valeur
       newTest('Initialisation Inventaire', 'Initialisation Valeur');
       inventaireInitialisation;
       estInitialise := True;
       for i:=0 to TAILLEINVENTAIRE do
           begin
           if (inventaireI[i].valeurItem = 0)  then estInitialise:= False;
           end;
        testIsEqual(estInitialise);

   // Effet : seulement consommables
   newTest('Initialisation Inventaire', 'Initialisation Effet consommable');
   inventaireInitialisation;
   estInitialise := True;
   for i:=0 to (NOMBRECONSO-1) do
        begin
         if (inventaireI[i].effetItem = 0)  then estInitialise:= False;
        end;
   testIsEqual(estInitialise);


end;


procedure testAjoutQInventaire;

var
  estVide : boolean;
  itemChoisi: integer; // item que l'on choisi pour modifier sa quantité
  ajout: boolean;// renvoi si la quantite a été ajouté (true) ou non (false)

begin
   newTestsSeries('Ajout de quantité à l''inventaire');

   // Ajout de plusieurs quantites
      newTest('Ajout de quantité à l''inventaire', 'Ajout de plusieurs quantités');
      inventaireInitialisation;  // pour partir d'un inventaire avec des quantités = 0
      inventaireI[0].numAssoItem:=9-1; // pour choisir l'itemChoisi : mettre son numero+1 et enlever 1 --> ici item 8
      player1.argentP:=500;
      inventaireAjoutQ(itemChoisi, 2); // demande d'ajout de 2 quantité pour l'item 8 (choisi avant), initialisation de l'argent à 500 pour ne pas avoir de problèmes d'ajout
      ajout := True;

      if (inventaireI[inventaireI[0].numAssoItem].quantiteItem < 2) then ajout:= False;
      testIsEqual(ajout);
end;


procedure testSupprQInventaire;
var
  suppr : boolean; // renvoi si la quantite a été supprimé (true) ou non (false
  itemChoisi: integer; // item que l'on choisi pour modifier sa quantité

begin
   newTestsSeries('Suppression de quantité à l''inventaire');

   // Suppression de plusieurs quantites
      newTest('Suppression de quantité à l''inventaire', 'Supprime des quantités');
      inventaireInitialisation; // pour partir d'un inventaire avec des quantités = 0
      inventaireI[0].numAssoItem:=6-1; // pour choisir l'itemChoisi : mettre son numero+1 et enlever 1
      player1.argentP:=800;
      inventaireAjoutQ(itemChoisi, 3);  // ajoute 3 quantité à l'item 5, initialisation de l'argent à 800 pour ne pas avoir de problèmes d'ajout
      inventaireSupprQ(itemChoisi, 2); // supprime une quantité à l'item 5
      suppr := True;

      if (inventaireI[inventaireI[0].numAssoItem].quantiteItem <> 3-2) then suppr:= False;
      testIsEqual(suppr);
end;

{Les autres procédures et fonctions de l'unité inventaires ne seront pas testés puisqu'elles font
les mêmes choses que les autres mais en laissant le choix à l'utilisateur (de la quantite ou de l'item) ou il s'agit de procédure d'affichage}

procedure testInventaire;
begin
     testInitialisationInventaire;
     testAjoutQInventaire;
     testSupprQInventaire;
     effacerEcran;

     Summary();
     readln;
end;


end.


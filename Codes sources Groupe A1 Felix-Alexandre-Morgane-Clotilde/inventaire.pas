// Unité contenant les fonctionnalités liées à l'inventaire
unit inventaire;
{$mode objfpc}{$H+}
{$codepage utf8}

interface
         uses Classes, SysUtils, GestionEcran;

// Déclaration des variables, constantes et types qui seront utiles à toute l'unité
  const
    TAILLEINVENTAIRE=11;
    NOMBRECONSO=6; // nombre consommables

  type
  objetInventaire = Record // type record pour objet de l'inventaire
    quantiteItem : integer; // variable qui affiche la quantite de chaque item
    nomItem : string;  // nom de l'item
    cibleEffet : char; // cible de l'effet de chaque item : J joueur ou E ennemi
    effetItem : integer; // effet de l'item
    numAssoItem : integer; // numero associé à chaque item
    valeurItem: integer; // prix de chaque item
  end;

  inventaireItem = array [0..TAILLEINVENTAIRE] of  objetInventaire;  // type tableau pour l'inventaire

  var
    inventaireI :inventaireItem;

     // ------------- FONCTIONS ET PROCEDURES -------------
     // PROCÉDURE D'INITIALISATION DE CHAQUE ITEMS
     procedure inventaireInitialisation;

     // PROCÉDURE D'AFFICHAGE DES ITEMS CONSOMMABLES AVEC EFFETS ET QUANTITE(CONSOMMABLE : potions et bombes)
     procedure inventaireAffichageConsommable;

     // PROCÉDURE D'AFFICHAGE DES ITEMS RESSOURCES AVEC QUANTITE (RESSOURCE : parties de monstre)
     procedure inventaireAffichageRessource;

     // PROCEDURE POUR AFFICHER INVENTAIRE AVEC VALEUR SANS QUANTITE
     procedure inventaireAffichageMarchandAchat;

     // PROCEDURE POUR AFFICHER INVENTAIRE AVEC VALEUR AVEC QUANTITE
     procedure inventaireAffichageMarchandVente;

     // PROCÉDURE POUR AJOUTER LA QUANTITE VOULU D'ITEM
     procedure inventaireAjoutQ(itemChoisi, QChoisi: integer);

     // PROCÉDURE POUR ENLEVER LA QUANTITE VOULU D'ITEM
     procedure inventaireSupprQ(itemChoisi, QChoisi : integer);

     // FONCTION POUR DEMANDER L'ITEM CHOISI
     function inventaireItemChoisi():integer;

     // FONCTION POUR DEMANDER LA QUANTITE CHOISI
     function inventaireQChoisi():integer;


implementation
uses
    creationperso, menuVilleUnit;

  // PROCÉDURE D'INITIALISATION DE CHAQUE ITEMS
  procedure inventaireInitialisation;

    begin
  // Items consommables avec leurs effets
  inventaireI[0].quantiteItem:=0;
  inventaireI[0].nomItem:= 'Potion PV' ;
  inventaireI[0].effetItem:=100; //  donne 100 PV au joueur
  inventaireI[0].valeurItem:=200;  // utile pour la partie marchand

  inventaireI[1].quantiteItem:=0;
  inventaireI[1].nomItem:= 'Potion PV haute' ;
  inventaireI[1].effetItem:=200; //  donne 200 PV au joueur
  inventaireI[1].valeurItem:=400;

  inventaireI[2].quantiteItem:=0;
  inventaireI[2].nomItem:= 'Potion PV faible' ;
  inventaireI[2].effetItem:=50; //  donne 50 PV au joueur
  inventaireI[2].valeurItem:=100;

  inventaireI[3].quantiteItem:=0;
  inventaireI[3].nomItem:= 'Bombe' ;
  inventaireI[3].effetItem:=100; //  enleve 100 PV au monstre
  inventaireI[3].valeurItem:=100;

  inventaireI[4].quantiteItem:=0;
  inventaireI[4].nomItem:= 'Bombe forte' ;
  inventaireI[4].effetItem:=200; //  enleve 200 PV au monstre
  inventaireI[4].valeurItem:=200;

  inventaireI[5].quantiteItem:=0;
  inventaireI[5].nomItem:= 'Bombe faible' ;
  inventaireI[5].effetItem:=50; //  enleve 50 PV au monstre
  inventaireI[5].valeurItem:=50;

  // Items ressources sans effets
  inventaireI[6].quantiteItem:=0;
  inventaireI[6].nomItem:= 'Cuir' ;
  inventaireI[6].valeurItem:=75;

  inventaireI[7].quantiteItem:=0;
  inventaireI[7].nomItem:= 'Dents' ;
  inventaireI[7].valeurItem:=80;

  inventaireI[8].quantiteItem:=0;
  inventaireI[8].nomItem:= 'Ecaille de dragon' ;
  inventaireI[8].valeurItem:=200;

  inventaireI[9].quantiteItem:=0;
  inventaireI[9].nomItem:= 'Fourrure' ;
  inventaireI[9].valeurItem:=25;

  inventaireI[10].quantiteItem:=0;
  inventaireI[10].nomItem:= 'Femur' ;
  inventaireI[10].valeurItem:=100;

  inventaireI[11].quantiteItem:=0;
  inventaireI[11].nomItem:= 'Griffe' ;
  inventaireI[11].valeurItem:=60;

    end;


  // PROCÉDURE D'AFFICHAGE DES ITEMS CONSOMMABLES AVEC EFFETS ET QUANTITE(CONSOMMABLE : potions et bombes)
  procedure inventaireAffichageConsommable;

var
    i: integer; // variable de boucle et choix de l'utilisateur
    sdl1: integer; //variable qui permet de sauter une ligne à l'affichage
    sdl2: integer; //Variable qui permet de sauterr une ligne bis
begin

     // Affichage consommables
     for i:= 0 to (NOMBRECONSO-1) do
        begin
             sdl1:=i+1;//permet de sauter une ligne
             sdl2:=i+1;//permet de sauter une ligne bis
             deplacerCurseurXY(5,sdl1+sdl2+i+6); //pour l'affichage ca saute une ligne et ca reste sur la meme colonne.
             write (i+1,'.');
             if (inventaireI[i].effetItem <> 0) then // Affichage des consommables
                begin
                writeln (' Nom du consommable: ',inventaireI[i].nomItem);
                deplacerCurseurXY(7,sdl1+sdl2+i+7);
                writeln (' Effet: ',inventaireI[i].effetItem, ' | Quantite: ', inventaireI[i].quantiteItem);
                end
        end;

end;

    // PROCÉDURE D'AFFICHAGE DES ITEMS RESSOURCES AVEC QUANTITE (RESSOURCE : parties de monstre)
  procedure inventaireAffichageRessource;
  var
    i: integer; // variable de boucle et choix de l'utilisateur
    sdl1: integer; //variable qui permet de sauter une ligne à l'affichage
    sdl2 : integer; //variable qui permet de sauter une ligne bis
begin

     // Affichage ressources
     for i:=NOMBRECONSO to TAILLEINVENTAIRE do
        begin
             sdl1:=i+1-6;//permet de sauter une ligne
             sdl2:=i+1-6;//permet de sauter une ligne bis
             deplacerCurseurXY(64,sdl1+sdl2+i); //pour l'affichage ca saute une ligne et ca reste sur la meme colonne.
             write (i+1,'.');
             if (inventaireI[i].effetItem = 0) then
                begin
                 writeln (' Nom de la ressource: ',inventaireI[i].nomItem);
                 deplacerCurseurXY(64,sdl1+sdl2+i+1);
                 writeln (' Quantite: ', inventaireI[i].quantiteItem);
                end
        end;

end;



  // FONCTION POUR DEMANDER L'ITEM CHOISI
  function inventaireItemChoisi():integer;
  var
      choixItem: integer; // numéro d'item choisi par l'utilisateur

  begin
       deplacerCurseurXY(10,27);
       write('Choisissez un item d''apres son numero ou retourner à la ville avec 0 : ');
       readln(choixItem);
         if choixItem = 0 then menuVille
         else
         begin
          inventaireI[0].numAssoItem:=choixItem-1;
          inventaireItemChoisi:=inventaireI[0].numAssoItem;
         end;
  end;

  // FONCTION POUR DEMANDER LA QUANTITE CHOISI
  function inventaireQChoisi():integer;
  var
      QChoisi: integer; // quantite d'item choisi par l'utilisateur

  begin
       dessinerCadreXY(7,25,90,28,simple,white,black);
       deplacerCurseurXY(10,27);
       write('Choisissez une quantite : ');
       readln(QChoisi);
       inventaireQChoisi:=QChoisi;
  end;


  /// -- Marchand --

// PROCÉDURE POUR AJOUTER LA QUANTITE VOULU D'ITEM
  procedure inventaireAjoutQ(itemChoisi, QChoisi: integer);

  begin
      // ajout quantite si l'argent est suffisant par rapport au prix de l'item
  if player1.argentP -(inventaireI[inventaireI[0].numAssoItem].valeurItem * QChoisi) >= 0 then
     begin
      player1.argentP:=player1.argentP -(inventaireI[inventaireI[0].numAssoItem].valeurItem * QChoisi) ;
      inventaireI[inventaireI[0].numAssoItem].quantiteItem:=(inventaireI[inventaireI[0].numAssoItem].quantiteItem)+QChoisi;
      // argent restant
      writeln;
      deplacerCurseurXY(5,26);
      writeln('Vous possedez desormais : ', player1.argentP, ' or');
      writeln;
     end

  // pas assez d'argent : message erreur
  else writeln('Vous n''avez pas assez d''or');
  writeln;

  end;


// PROCÉDURE POUR ENLEVER LA QUANTITE VOULU D'ITEM
  procedure inventaireSupprQ(itemChoisi, QChoisi: integer);

  begin
    // baisse de quantite
       // quantité suffisante pour être vendu ou utilisé
  if inventaireI[inventaireI[0].numAssoItem].quantiteItem <> 0 then
     begin
     inventaireI[inventaireI[0].numAssoItem].quantiteItem:=inventaireI[inventaireI[0].numAssoItem].quantiteItem-QChoisi;
     writeln;
     player1.argentP:=player1.argentP + inventaireI[inventaireI[0].numAssoItem].valeurItem * QChoisi;
     deplacerCurseurXY(5,26);
     writeln('Vous possedez desormais : ', player1.argentP, ' or');
     end

       // quantité insuffisante pour être vendu ou utilisé
  else
      begin
      deplacerCurseurXY(5,26);
      writeln('Vous ne disposez pas d''assez de quantite de cet objet');
      writeln;
      end;
 end;


 // PROCEDURE POUR AFFICHER INVENTAIRE AVEC VALEUR SANS QUANTITE
 procedure inventaireAffichageMarchandAchat;
 var
    i: integer; // variable de boucle
    sdl1: integer; // variable qui permet de sauter une ligne à l'affichage
    sdl2: integer; //Variable qui permet de sauterr une ligne bis
 begin
        for i:= 0 to (NOMBRECONSO-1) do
        begin
             sdl1:=i+1;//permet de sauter une ligne
             sdl2:=i+1;//permet de sauter une ligne bis
             deplacerCurseurXY(5,sdl1+sdl2+i+6); //pour l'affichage ca saute une ligne et ca reste sur la meme colonne.
             write (i+1,'.');
             if (inventaireI[i].effetItem <> 0) then // Affichage des consommables
                begin
                writeln (' Nom du consommable: ',inventaireI[i].nomItem);
                deplacerCurseurXY(7,sdl1+sdl2+i+7);
                write (' Prix: ',inventaireI[i].valeurItem);
                end
        end;
         for i:=NOMBRECONSO to TAILLEINVENTAIRE do
        begin
             sdl1:=i+1-6;//permet de sauter une ligne
             sdl2:=i+1-6;//permet de sauter une ligne bis
             deplacerCurseurXY(64,sdl1+sdl2+i); //pour l'affichage ca saute une ligne et ca reste sur la meme colonne.
             write (i+1,'.');
             if (inventaireI[i].effetItem = 0) then
                begin
                 writeln (' Nom de la ressource: ',inventaireI[i].nomItem);
                 deplacerCurseurXY(64,sdl1+sdl2+i+1);
                 write(' Prix: ',inventaireI[i].valeurItem);
                end
        end;
end;


// PROCEDURE POUR AFFICHER INVENTAIRE AVEC VALEUR AVEC QUANTITE
 procedure inventaireAffichageMarchandVente;
 var
    i: integer; // variable de boucle
    sdl1: integer; // variable qui permet de sauter une ligne à l'affichage
    sdl2: integer; //Variable qui permet de sauterr une ligne bis
 begin
        for i:= 0 to (NOMBRECONSO-1) do
        begin
             sdl1:=i+1;//permet de sauter une ligne
             sdl2:=i+1;//permet de sauter une ligne bis
             deplacerCurseurXY(5,sdl1+sdl2+i+6); //pour l'affichage ca saute une ligne et ca reste sur la meme colonne.
             write (i+1,'.');
             if (inventaireI[i].effetItem <> 0) then // Affichage des consommables
                begin
                writeln (' Nom du consommable: ',inventaireI[i].nomItem);
                deplacerCurseurXY(7,sdl1+sdl2+i+7);
                write('Valeur: ',inventaireI[i].valeurItem, ' - Quantite: ', inventaireI[i].quantiteItem);
                end
        end;
         for i:=NOMBRECONSO to TAILLEINVENTAIRE do
        begin
             sdl1:=i+1-6;//permet de sauter une ligne
             sdl2:=i+1-6;//permet de sauter une ligne bis
             deplacerCurseurXY(64,sdl1+sdl2+i); //pour l'affichage ca saute une ligne et ca reste sur la meme colonne.
             write (i+1,'.');
             if (inventaireI[i].effetItem = 0) then
                begin
                 writeln (' Nom de la ressource: ',inventaireI[i].nomItem);
                 deplacerCurseurXY(64,sdl1+sdl2+i+1);
                 write('Valeur: ',inventaireI[i].valeurItem, ' - Quantite: ', inventaireI[i].quantiteItem);
                end
        end;


end;

end.




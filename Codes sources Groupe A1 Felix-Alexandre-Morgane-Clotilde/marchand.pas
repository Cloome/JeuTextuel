// Permet au joueur d'acheter et vendre des objets : consommables et ressources
unit marchand;

{$mode ObjFPC}{$H+}
{$codepage utf8}

interface

uses
    Classes, SysUtils, gestionEcran;


  // GÈRE LA PARTIE ACHAT CHEZ LE MARCHAND, ÉCHANGE D'ARGENT CONTRE OBJET
  procedure marchandAchat;

  // GÈRE LA PARTIE VENTE CHEZ LE MARCHAND, ÉCHANGE D'OBJET CONTRE ARGENT
  procedure marchandVente;

implementation
uses
     inventaire, creationperso, menuVilleUnit,menuVilleIHM;

// GÈRE LA PARTIE ACHAT CHEZ LE MARCHAND, ÉCHANGE D'ARGENT CONTRE OBJET
procedure marchandAchat;
var
  itemChoisi: integer; // item choisi par l'utilisateur
  QChoisi:integer; // quantité d'item choisi par l'utilisateur
  return: integer; // variable pour retourner à la ville

begin
  // affichage des choses à acheter et de l'argent possédé
  inventaireIHM;
  inventaireAffichageMarchandAchat;
  dessinerCadreXY(7,25,90,28,simple,white,black);
  deplacerCurseurXY(10,26);
  write('Vous possedez : ', player1.argentP, ' or');

  // ajout quantite à un item
  itemChoisi:= inventaireItemChoisi;
  QChoisi:=  inventaireQChoisi;
  effacerEcran;
  inventaireAjoutQ(itemChoisi, QChoisi);


  // affichage de notre inventaire après l'achat
  inventaireIHM;
  inventaireAffichageConsommable;
  inventaireAffichageRessource;


  // Retour à la ville
  retourVilleIHM();
  readln(return);
  if (return=0) then menuVille();


end;

// GÈRE LA PARTIE VENTE CHEZ LE MARCHAND, ÉCHANGE D'OBJET CONTRE ARGENT
procedure marchandVente;
var
  itemChoisi: integer; // item choisi par l'utilisateur
  QChoisi:integer; // quantité d'item choisi par l'utilisateur
  return: integer; // variable pour retourner à la ville

begin
  // affichage des choses à vendre et de l'argent possédé
  inventaireIHM;
  inventaireAffichageMarchandVente;
  dessinerCadreXY(7,25,90,28,simple,white,black);
  deplacerCurseurXY(10,26);
  writeln('Vous possedez : ', player1.argentP, ' or');

  // enleve quantite à un item
  itemChoisi:= inventaireItemChoisi;
  QChoisi:=  inventaireQChoisi;
  effacerEcran;
  inventaireSupprQ(itemChoisi, QChoisi);

  // affichage de notre inventaire après la vente
  inventaireIHM;
  inventaireAffichageConsommable;
  inventaireAffichageRessource;

  // Retour à la ville
  retourVilleIHM();
  readln(return);
  if (return=0) then menuVille();

  readln;
end;

end.


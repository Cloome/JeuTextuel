unit chasseUnit;
// Contient toutes les fonction et procédure lié à la chasse (combat)

{$codepage utf8}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, GestionEcran,inventaire,equipement,creationperso,menuVilleUnit;


type                           // définition de deux type : creature et personnage qui seront utilisé pendant les combats
  creature = record
    nom   : string;
    pv    : integer;
    degat : integer;
    armure: integer;
  end;

  personnageCombat = record
    pv    :integer;
    degat :integer;
    armure:integer;
  end;

  tableauCreature = array [0..2] of creature;   // tableau définissant le nombre de créature éxistant



const


  constTableauCreature : tableauCreature =     // tableau définissant toutes les créatures et leurs carastéristique
 ((nom:'Loup enragé';    pv:12;  degat:6;  armure:1),
  (nom:'Grizzli furieux';pv:20;  degat:6;  armure:0),
  (nom:'Jeune Dragon';   pv:16;  degat:5;  armure:2));

var
  compteurEnnemi:integer;


// Procédure principale du déroulement d'un combat
procedure combat;

// Procédure piochant aléatoirement une créature parmis le tableau des créature puis renvoie les variables de la créature
procedure initCreature(var nom:string; var pv,degat,armure,AffichageCreature:integer);

// Procédure regroupant toutes les variables (notamment d'armure) pour les regrouper dans un record
procedure initPersoCombat(var pv,degat,armure:integer);

// Procédure s'occupant du déroulement d'un tour pour le joueur
procedure toursJoueur (persoDegat,creaturePVEntrant,creatureArmure:integer; var creaturePVSortant:integer);

// Procédure s'occupant du déroulement d'un tour pour la créature
procedure toursCreature (persoPVEntrant,persoArmure,creatureDegat,affichageCreature:integer; var persoPVSortant:integer);

// Procédure si le combat est perdu
procedure perdu;

// Procédure si le combat est gagné
procedure gagne(pvRestant:integer);

// Procédure initialisant le compteur d'ennemi vaincu
procedure initCompteurEnnemi;

// Procédure s'occupant d'incrémenter la variable de compteur d'ennemi vaincu
procedure ajoutCompteurEnnemi;


// Procedure permettant d'utiliser un objet durant le combat
procedure useInventaire(persoPVEntrant,creaturePVEntrant:integer; var persoPVSortant,creaturePVSortant:integer);



implementation
uses menuVilleIHM;
procedure combat;

var
   currentCreature:creature;          // Record contenant les variable de la créature
   perso:personnageCombat;            // Record contenant les variable du personnage
   tour:integer;                      // Determine si tour joueur ou créature grâce à un modulo 2
   choixItemOuCombat:integer;         // Choix du joueur s'il veut utiliser un objet ou combattre
   afficheMonstre:integer;
begin
  effacerEcran;
  randomize;
  tour:=random(2);                                                      // Met tour au hasard sur 0 ou 1 permettant que le joueur ne commence pas toujours le combat
  initCreature(currentCreature.nom,currentCreature.pv,currentCreature.degat,currentCreature.armure,afficheMonstre);// initialisation de la créature
  monstreIHM(AfficheMonstre);
          dessinerCadreXY(10,10,33,15,simple,white,black);        //
          deplacerCurseurXY(12,11);                               //
          write('nom ',currentCreature.nom);                      //
          deplacerCurseurXY(12,12);                               //
          write(' pv ',currentCreature.pv);                       // Affichage des stats du monstre
          deplacerCurseurXY(12,13);                               //
          write(' degat ',currentCreature.degat);                 //
          deplacerCurseurXY(12,14);                               //
          write(' armure ',currentCreature.armure);

          initPersoCombat(perso.pv,perso.degat,perso.armure);     // initialisation du "personnage de combat"

          dessinerCadreXY(108,2,119,6,simple,white,black);       //
          deplacerCurseurXY(109,3);                               //
          write(' pv ',perso.pv);                                 //
          deplacerCurseurXY(109,4);                               // Affichage des stats du joueur
          write(' degat ',perso.degat);                           //
          deplacerCurseurXY(109,5);                               //
          write(' armure ',perso.armure);                         //
          deplacerCurseurXY(60,27);
  readln;
  while (perso.pv>0) and (currentCreature.pv>0) do      // Tant que créature ou joueur est en vie : continue le combat
        begin
          tour:=tour+1;                                 // Augmente de 1 tour
          if (tour mod 2 = 0) then                      // modulo 2 pour savoir qui entre le joueur et la créature joue
             begin
               //effacerEcran;                                                                         //
               dessinerCadreXY(5,21,115,29,simple,white,black);
               deplacerCurseurXY(50,22);                                                               //
               write('C''est à votre tour.');                                                          //
               deplacerCurseurXY(30,24);                                                               //
               write('Que voulez vous faire ?   1. Utiliser un objet   2/ Combattre !');           //
               readln(choixItemOuCombat);                                                              //  Tour du Joueur
               if choixItemOuCombat=1 then                                                             //
                  begin                                                                                //
                    useInventaire(perso.pv,currentCreature.pv,perso.pv,currentCreature.pv);            //
                    effacerEcran;                                                                      //
                    monstreIHM(afficheMonstre);
                  end;                                                                                 //
               toursJoueur (perso.degat,currentCreature.pv,currentCreature.armure,currentCreature.pv); //
             end
          else toursCreature (perso.pv,perso.armure,currentCreature.degat,afficheMonstre,perso.pv);                   //  Tour de la Créature
           dessinerCadreXY(10,10,33,15,simple,white,black);       //
          deplacerCurseurXY(12,11);                               //
          write('nom ',currentCreature.nom);                      //
          deplacerCurseurXY(12,12);                               //
          write(' pv ',currentCreature.pv);                       // Affichage des stats du monstre
          deplacerCurseurXY(12,13);                               //
          write(' degat ',currentCreature.degat);                 //
          deplacerCurseurXY(12,14);                               //
          write(' armure ',currentCreature.armure);               //

          dessinerCadreXY(108,2,119,6,simple,white,black);        //
          deplacerCurseurXY(109,3);                               //
          write(' pv ',perso.pv);                                 //
          deplacerCurseurXY(109,4);                               // Affichage des stats du joueur
          write(' degat ',perso.degat);                           //
          deplacerCurseurXY(109,5);                               //
          write(' armure ',perso.armure);                         //
          deplacerCurseurXY(60,27);
          readln;
        end;
  writeln('fin du combat');       // fin du combat
  if perso.pv<=0 then perdu       //
     else gagne(perso.pv);        //
  readln;                         //
  menuVille;                      //


end;

// Procédure piochant aléatoirement une créature parmis le tableau des créature puis renvoie les variables de la créature
procedure initCreature(var nom:string; var pv,degat,armure, affichageCreature:integer);

var
   rngCreature:integer;

begin

  rngCreature:=random(3);                                  // Piche la créature au hasard
  nom:=constTableauCreature[rngCreature].nom;                       // le nom de la créature
  pv:=(((constTableauCreature[rngCreature].pv*(100+(5*compteurEnnemi))) div 100)*(random(41)+80)) div 100;           // les pv sont affecter (une base est constante, ou vient se rajouter un pourcentage grace au compteur d'ennemi, puis légère partie aléatoire pour finir)
  degat:=(((constTableauCreature[rngCreature].degat*(100+(8*compteurEnnemi))) div 100)*(random(41)+80)) div 100;     // les degats sont affecter (une base est constante, ou vient se rajouter un pourcentage grace au compteur d'ennemi, puis légère partie aléatoire pour finir)
  armure:=(((constTableauCreature[rngCreature].armure*(100+(12*compteurEnnemi))) div 100)*(random(41)+80)) div 100;  // l'armure est affecter (une base est constante, ou vient se rajouter un pourcentage grace au compteur d'ennemi, puis légère partie aléatoire pour finir)
  affichageCreature:=rngCreature;
end;

// Procédure regroupant toutes les variables (notamment d'armure) pour les regrouper dans un record
procedure initPersoCombat(var pv, degat, armure: integer);

begin
  pv:=     player1.vieP;                        // Renvoie les pv

  degat:=  monEquipement.mainArme.degats;       // Renvoie les dégats

  armure:= monEquipement.tete.defense           // Renvoie la somme de toute l'armure des équipements
         + monEquipement.torse.defense          //
         + monEquipement.mainArmure.defense     //
         + monEquipement.jambes.defense         //
         + monEquipement.pieds.defense;         //
end;

// Procédure s'occupant du déroulement d'un tour pour la créature
procedure toursCreature (persoPVEntrant,persoArmure,creatureDegat,affichageCreature:integer; var persoPVSortant:integer);

var
   variationDegat:integer;     // à chaque tour la créature inflige entre 80 et 120 % de sa variable dégat
   coupCritique:integer;       // chance de coup critique possible

begin
  effacerEcran;
  monstreIHM(affichageCreature);
  deplacerCurseurXY(0,0);
  variationDegat:=random(41)+80;     // tirage de la variation de dégat
  coupCritique:=random(100);         // tirage d'un dé de 100 pour le coup critique
  deplacerCurseurXY(30,22);
  write('La creature attaque !');

  creatureDegat:=(creatureDegat*variationDegat) div 100;  // calcule des dégat avant reduction armure
  if coupCritique<5 then                                  // Cout critique si < 5
     begin
       creatureDegat:=creatureDegat*2;                    // si critique alors dégat x 2
       deplacerCurseurXY(30,24);
       writeln('La bête vous assaine un coup critique !')
     end;
  creatureDegat:=creatureDegat-persoArmure;               // dégat - armure
  if creatureDegat<=0 then creatureDegat:=random(2);      // permet d'infliger quand même parfois 1 dégat si les dégats devraient être à 0
  persoPVSortant:=persoPVEntrant-creatureDegat;           // enleve les pv infligé
  deplacerCurseurXY(30,26);
  write('Elle vous inflige ',creatureDegat,' points de dégat.');

end;

// Procédure s'occupant du déroulement d'un tour pour le joueur
procedure toursJoueur (persoDegat,creaturePVEntrant,creatureArmure:integer; var creaturePVSortant:integer);

var
   variationDegat:integer;      // à chaque tour le joueur inflige entre 80 et 120 % de sa variable dégat
   coupCritique:integer;        // chance de coup critique possible

begin

  variationDegat:=random(41)+80;    // tirage de la variation de dégat
  coupCritique:=random(100);        // tirage d'un dé de 100 pour le coup critique

  persoDegat:=(persoDegat*variationDegat) div 100;      // calcule des dégat avant reduction armure
  dessinerCadreXY(5,21,115,29,simple,white,black);
  deplacerCurseurXY(30,22);
  write('Vous attaquez la créature sauvagement !');
  if coupCritique<10 then                               // Cout critique si < 10
     begin
       persoDegat:=persoDegat*2;                        // si critique alors dégat x 2
       deplacerCurseurXY(30,24);
       write('C''est un coup critique !');
     end;
  persoDegat:=persoDegat-creatureArmure;                // dégat - armure
  if persoDegat<=0 then persoDegat:=random(2);          // permet d'infliger quand même parfois 1 dégat si les dégats devraient être à 0
  creaturePVSortant:=creaturePVEntrant-persoDegat;      // enleve les pv infligé
  deplacerCurseurXY(30,26);
  writeln('Vous infligez ',persoDegat,' points de dégat à cette abomination !');

end;

// Procédure si le combat est perdu
procedure perdu;


begin
  PerduIHM();
  player1.vieP:=20;
end;

// Procédure si le combat est gagné
procedure gagne(pvRestant:integer);

var
  lootRess:integer;         //  détermine si une ressource est obtenue et laquelle
  lootOr:integer;           //  quantité d'argent obtenue
  lootRessCb:integer;       //  détermine la quantité de la ressource obtenue

begin
  effacerEcran;
  dessinerCadreXY(40,11,80,15,double,white,black);
  deplacerCurseurXY(55,12);
  write('Victoire !');

  lootOr:=random(4);                                                  //   quantité pouvant aller de x0 à x3
  lootOr:=((lootOr*random(20))*(100+(8*compteurEnnemi))) div 100;     //   quantité d'argent obtenue augmentant avec le compteur d'ennemi vaincu
  player1.argentP:=player1.argentP+lootOr;                            //   renvoie la quantité d'argent obtenu

  lootRess:=random(100);                                              //   Tirage d'un dé de 100
  lootRessCb:=random(100);                                            //   Tirage d'un dé de 100


  case lootRessCb of                                                  //
  0..50:lootRessCb:=1;                                                //
  51..80:lootRessCb:=2;                                               // Quantité de ressource si obtenue
  81..96:lootRessCb:=3;                                               //
  97..99:lootRessCb:=4;                                               //
  end;

  case lootRess of           // détermine si et quelle ressource obtenue puis l'ajoute à l'inventaire éxistant
  0..30:lootRess:=0;
  31..54:begin lootRess:=9;  inventaireI[lootRess].quantiteItem:=inventaireI[lootRess].quantiteItem+((lootRessCb*(100+(2*compteurEnnemi)))div 100); end;
  55..64:begin lootRess:=6;  inventaireI[lootRess].quantiteItem:=inventaireI[lootRess].quantiteItem+((lootRessCb*(100+(2*compteurEnnemi)))div 100); end;
  65..74:begin lootRess:=7;  inventaireI[lootRess].quantiteItem:=inventaireI[lootRess].quantiteItem+((lootRessCb*(100+(2*compteurEnnemi)))div 100); end;
  75..84:begin lootRess:=10; inventaireI[lootRess].quantiteItem:=inventaireI[lootRess].quantiteItem+((lootRessCb*(100+(2*compteurEnnemi)))div 100); end;
  85..94:begin lootRess:=11; inventaireI[lootRess].quantiteItem:=inventaireI[lootRess].quantiteItem+((lootRessCb*(100+(2*compteurEnnemi)))div 100); end;
  95..99:begin lootRess:=8;  inventaireI[lootRess].quantiteItem:=inventaireI[lootRess].quantiteItem+((lootRessCb*(100+(2*compteurEnnemi)))div 100); end;
  end;
  lootRessCb:=(lootRessCb*(100+(2*compteurEnnemi)))div 100;
  if lootRess>0 then                                                             // affiche si une ressource est obtenue
     begin
       deplacerCurseurXY(45,13);
       write('Vous obtenez ',lootRessCb, inventaireI[lootRess].nomItem,'.')
     end;
  if lootOr>0 then                                                               // affiche si de l'argent obtenue
     begin
       deplacerCurseurXY(45,14);
       write('Vous trouvez ',lootOr,' pièces d''or.');
     end;

  player1.vieP:=pvRestant;                                                       // renvoie la quantité de pv restant à la fin du combat
  ajoutCompteurEnnemi;                                                           // augmente le compteur d'ennemi de 1
end;

// Procédure initialisant le compteur d'ennemi vaincu
procedure initCompteurEnnemi;

begin
  compteurEnnemi:=0;
end;

// Procédure s'occupant d'incrémenter la variable de compteur d'ennemi vaincu
procedure ajoutCompteurEnnemi;

begin
  compteurEnnemi:=compteurEnnemi+1;
end;

// Procedure permettant d'utiliser un objet durant le combat
procedure useInventaire(persoPVEntrant,creaturePVEntrant:integer; var persoPVSortant,creaturePVSortant:integer);

var
  choix:integer;
  choixValide:boolean;

begin
  choix:=-1;
  choixValide:=false;
  while (choix<0) or (choix>6) or (choixValide=false) do      // tant que choix non valide et en dehors des limites (0 à 6)
  begin
  effacerEcran;
  inventaireConsoIHM;
  inventaireAffichageConsommable;                             // affiche les consommable disponible
  dessinerCadreXY(19,27,23+length('Choisissez l''objet à utiliser ou appuyer sur 0 pour retourner en arrière'),29,simple, white, black);
  deplacerCurseurXY(20,28);
  write('Choisissez l''objet à utiliser ou appuyer sur 0 pour retourner en arrière ');
  readln(choix);
     case choix of
     1..3: begin                                                                                 //
                if inventaireI[choix-1].quantiteItem>0 then                                      //
                   begin                                                                         //
                     persoPVSortant:=persoPVEntrant+inventaireI[choix-1].effetItem;              // si choix est une potion et valide
                     inventaireI[choix-1].quantiteItem:=inventaireI[choix-1].quantiteItem-1;     //
                     dessinerCadreXY(78,12,104,14,simple, white, black);                          //
                     deplacerCurseurXY(80,13);                                                   //
                     writeln('Vous vous sentez mieux !');                                        //
                     readln;                                                                     //
                     choixValide:=true;                                                          //
                   end                                                                           //
                else
                begin
                   dessinerCadreXY(75,12,108,14,simple, white, black);                           //
                   deplacerCurseurXY(77,13);                                                     //
                   writeln('Vous ne possedez pas cet objet');                                    // choix potion mais invalide
                   readln;                                                                       //
                end;                                                                             //
           end;
     4..6: begin
                if inventaireI[choix-1].quantiteItem>0 then                                      //
                   begin                                                                         //
                     creaturePVSortant:=creaturePVEntrant-inventaireI[choix-1].effetItem;        //
                     inventaireI[choix-1].quantiteItem:=inventaireI[choix-1].quantiteItem-1;     // si choix est une bombe et valide
                     dessinerCadreXY(84,12,99,15,simple, white, black);                         //
                     deplacerCurseurXY(86,13);                                                   //
                     writeln('BOOOUM !');                                                        //
                     deplacerCurseurXY(86,14);                                                   //
                     writeln('Joli lancer !');                                                   //
                     choixValide:=true;                                                          //
                     readln;                                                                     //
                   end                                                                           //
                else
                begin                                                                            //
                   dessinerCadreXY(75,12,108,14,simple, white, black);                           //
                   deplacerCurseurXY(77,13);                                                     //
                   writeln('Vous ne possedez pas cet objet');                                    // choix bombe mais invalide
                   readln;                                                                       //
                end;                                                                             //
           end;
     0: choixValide:=true;                                                                       // retour combat
     end;
  end;
end;

end.


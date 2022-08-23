unit equipement;
// Gere toute la partie équipement (forge, gestion de l'Equipement ainsi que des test et l'initialisation de l'équipement)

{$codepage utf8}
{$mode objfpc}{$H+}

interface
         uses Classes, SysUtils, GestionEcran,inventaire,menuVilleUnit;

  type

  partieEquipement = (arme, casque, cuirasse, gants, jambieres, bottes);        // enumeration pour les différentes partie d'équipement

  tableauEquipement = array [0..1,partieEquipement,0..5] of string;             // tableau contenant le nom de chaque equipement et leur attribut

  composants = (cuir, dents, ecailleDeDragon, fourrure, femur, griffe);         // enumeration des ressources

  tableauCoutAmelioration = array [0..4,partieEquipement,composants] of integer;// tableau contenant tous les couts en ressources en fonction de l'équipement et du lvl


  ////////////////////////////////////////////////////////////////////////////////
  listeEquipement = RECORD                          // record contenant toutes  //
                                                    // les variables necessaire //
         mainArme : RECORD                          // pour l'equipement        //
                  nom : string;                     // du personnage            //
                  degats : integer;                 //////////////////////////////
                  lvl : integer;                                                //
                  maxlvl : boolean;                                             //
         end;                                                                   //
                                                                                //
         tete : RECORD                                                          //
                  nom : string;                                                 //
                  defense : Integer;                                            //
                  lvl : integer;                                                //
                  maxlvl : boolean;                                             //
         end;                                                                   //
                                                                                //
         torse : RECORD                                                         //
               nom : string;                                                    //
               defense : Integer;                                               //
               lvl : integer;                                                   //
               maxlvl : boolean;                                                //
         end;                                                                   //
                                                                                //
                                                                                //
         mainArmure : RECORD                                                    //
                    nom : string;                                               //
                    defense : Integer;                                          //
                    lvl : integer;                                              //
                    maxlvl : boolean;                                           //
         end;                                                                   //
                                                                                //
         jambes : RECORD                                                        //
                nom : string;                                                   //
                defense : Integer;                                              //
                lvl : integer;                                                  //
                maxlvl : boolean;                                               //
         end;                                                                   //
                                                                                //
         pieds : RECORD                                                         //
               nom : string;                                                    //
               defense : Integer;                                               //
               lvl : integer;                                                   //
               maxlvl : boolean;                                                //
         end;                                                                   //
                                                                                //
                                                                                //
  end;                                                                          //
  ////////////////////////////////////////////////////////////////////////////////
  const

  strEquipement : tableauEquipement =
    ///////////////////////////////////////////////////////// TABLEAU DES NOMS ET QUANTITE DEFENSE PAR OBJET ////////////////////////////////////////////////////////////////////
    ((('Petit bâton'                , 'Osselet'                , 'Gros os'           , 'Os aiguisé'      , 'Côte tranchante'               , 'Hachoir fait de dents'        ), //
      ('Bonnet de bain inefficace' , 'Casque en Fourrure'     , 'Casque en Cuir'    , 'Casque en Os'    , 'Casque en Ecaille de Dragon'   , 'Casque des hauts Fourneaux'   ), //
      ('Petit pull en laine'        , 'Cuirasse en Fourrure'   , 'Cuirasse en Cuir'  , 'Cuirasse en Os'  , 'Cuirasse en Ecaille de Dragon' , 'Cuirasse du Géant'            ), //
      ('Sans gants'                 , 'Gants en Fourrure'      , 'Gants en Cuir'     , 'Gants en Os'     , 'Gants en Ecaille de Dragon'    , 'Gants de Xarsaroth'           ), //
      ('Kilt écossais'              , 'Jambieres en Fourrure'  , 'Jambieres en Cuir' , 'Jambieres en Os' , 'Jambieres en Ecaille de Dragon', 'Jambières du Seigneur Cochon' ), //
      ('Sandale chaussettes'        , 'Bottes en Fourrure'     , 'Bottes en Cuir'    , 'Bottes en Os'    , 'Bottes en Ecaille de Dragon'   , 'Bottes ailées'                )),//
                                                                                                                                                                               //
     (('4'  ,'6'  ,'12' ,'24' ,'48' ,'96' ),                                                                                                                                   //
      ('0'  ,'2'  ,'4'  ,'8'  ,'16' ,'32' ),                                                                                                                                   //
      ('1'  ,'4'  ,'8'  ,'16' ,'32' ,'64' ),                                                                                                                                   //
      ('0'  ,'1'  ,'2'  ,'4'  ,'8'  ,'16' ),                                                                                                                                   //
      ('1'  ,'3'  ,'6'  ,'12' ,'24' ,'48' ),                                                                                                                                   //
      ('0'  ,'2'  ,'4'  ,'8'  ,'16' ,'32' )));                                                                                                                                 //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  coutAmelioration : tableauCoutAmelioration =
  ///////////////////////////////// TABLEAU DES COUT POUR AMELIORATION ////////////////////////////////
  /////////////////////////////////////////    niveau 0 à 1     ///////////////////////////////////////
  ///////////////////// Cuir // dents // ecailleDDrag // Fourrure // femur // griffe //////////////////
                   (((    0  ,    1   ,      0        ,     0      ,   0   ,    1     ),// Arme      //
                     (    0  ,    0   ,      0        ,     2      ,   0   ,    0     ),// Casque    //
                     (    0  ,    0   ,      0        ,     3      ,   0   ,    0     ),// Cuirasse  //
                     (    0  ,    0   ,      0        ,     1      ,   0   ,    0     ),// Gants     //
                     (    0  ,    0   ,      0        ,     2      ,   0   ,    0     ),// Jambières //
                     (    0  ,    0   ,      0        ,     1      ,   0   ,    0     )),// Bottes   //
                                                                                                     //
                                                                                                     //
                     //////////////////////    niveau 1 à 2     ///////////////////////              //
                     // Cuir // dents // ecailleDDrag // Fourrure // femur // griffe //              //
                    ((    0  ,    2   ,      0        ,     0      ,   1   ,    2     ),// Arme      //
                     (    2  ,    0   ,      0        ,     3      ,   0   ,    0     ),// Casque    //
                     (    4  ,    0   ,      0        ,     6      ,   0   ,    0     ),// Cuirasse  //
                     (    1  ,    0   ,      0        ,     2      ,   0   ,    0     ),// Gants     //
                     (    3  ,    0   ,      0        ,     4      ,   0   ,    0     ),// Jambières //
                     (    2  ,    0   ,      0        ,     3      ,   0   ,    0     )),// Bottes   //
                                                                                                     //
                                                                                                     //
                     //////////////////////    niveau 2 à 3     ///////////////////////              //
                     // Cuir // dents // ecailleDDrag // Fourrure // femur // griffe //              //
                    ((    1  ,    3   ,      0        ,     0      ,   4   ,    6     ),// Arme      //
                     (    2  ,    4   ,      0        ,     3      ,   1   ,    3     ),// Casque    //
                     (    4  ,    6   ,      0        ,     6      ,   3   ,    4     ),// Cuirasse  //
                     (    1  ,    2   ,      0        ,     2      ,   0   ,    2     ),// Gants     //
                     (    3  ,    4   ,      0        ,     4      ,   4   ,    2     ),// Jambières //
                     (    2  ,    0   ,      0        ,     3      ,   4   ,    0     )),// Bottes   //
                                                                                                     //
                                                                                                     //
                     //////////////////////    niveau 3 à 4     ///////////////////////              //
                     // Cuir // dents // ecailleDDrag // Fourrure // femur // griffe //              //
                    ((    2  ,    0   ,      2        ,     0      ,   6   ,    10    ),// Arme      //
                     (    2  ,    0   ,      4        ,     6      ,   0   ,    0     ),// Casque    //
                     (    4  ,    0   ,      8        ,     8      ,   2   ,    0     ),// Cuirasse  //
                     (    2  ,    4   ,      2        ,     4      ,   0   ,    2     ),// Gants     //
                     (    4  ,    0   ,      6        ,     6      ,   6   ,    0     ),// Jambières //
                     (    3  ,    0   ,      4        ,     6      ,   6   ,    0     )),// Bottes   //
                                                                                                     //
                                                                                                     //
                     //////////////////////    niveau 4 à 5     ///////////////////////              //
                     // Cuir // dents // ecailleDDrag // Fourrure // femur // griffe //              //
                    ((    4  ,    40  ,      16       ,     0      ,   12  ,    20    ),// Arme      //
                     (    8  ,    0   ,      12       ,     20     ,   0   ,    0     ),// Casque    //
                     (    16 ,    0   ,      24       ,     40     ,   8   ,    0     ),// Cuirasse  //
                     (    6  ,    20  ,      10       ,     12     ,   0   ,    10    ),// Gants     //
                     (    12 ,    0   ,      16       ,     16     ,   20  ,    0     ),// Jambières //
                     (    10 ,    0   ,      12       ,     20     ,   12  ,    0     )));// Bottes  //
  /////////////////////////////////////////////////////////////////////////////////////////////////////

  var
    monEquipement : listeEquipement;

////////////////////////////////////////////////////////////////////////////////////
///////////////////////// INTERFACE PROCEDURE //////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
                                                                                ////
// Initialise les variables de l'équipement                                     ////
procedure initEquipement;                                                       ////
                                                                                ////
// Affiche l'équipement                                                         ////
procedure afficheToutEquipement;                                                ////
                                                                                ////
// Verifie pour chaque equipement si lvl=5                                      ////
procedure verificationAmeliorable;                                              ////
                                                                                ////
// Affiche les niveaux suivant de l'équipement                                  ////
procedure afficheToutAmeliorable;                                               ////
                                                                                ////
// Affiche les équipements déjà possèdé d'un type(arme,casque,...)              ////
procedure choixEquipement(equip:integer);                                       ////
                                                                                ////
// Affiche spécifiquement un équipement et son coût ainsi que ressource dispo   ////
procedure afficheAmeliorationSpecifique (partie:integer);                       ////
                                                                                ////
// Renvoie toute les variable utile pour une partie d'équipement(arme,casque,..)////
procedure renvoiVariableEquipementSpecifique                                    ////
(partie:integer; var equipementPartAS:partieEquipement;                         ////
var stringArmeArmure,stringDegatDefense,                                        ////
nomEquipement:string; var attributEquipement,lvlEquipement:integer);            ////
                                                                                ////
// Verifie si un objet peut être améliorer avec l'inventaire dispo              ////
function verifCout(partie:integer):boolean;                                     ////
                                                                                ////
// Ameliore l'équipement voulu et réattribue les valeurs                        ////
// et réduit les ressources restantes                                           ////
procedure amelioration(partie:integer);                                         ////
                                                                                ////
// convertit un string composé uniquement d'entier en integer                   ////
function intoInteger(strDeNombre:string):integer;                               ////
                                                                                ////
// procedure affichant tout le menu de la forge                                 ////
procedure forge;                                                                ////
                                                                                ////
// procedure principale de gestion équipement                                   ////
procedure gestionEquipement;                                                    ////
                                                                                ////
                                                                                ////

/////////////////////////////////////////
/////////// IMPLEMENTATION //////////////
/////////////////////////////////////////
implementation

uses menuVilleIHM;

// Initialise les variables de l'équipement
procedure initEquipement;

begin

   //attribue les variable de niveau, de niveau max atteint, de nom et d'attribut
   //pour chaque équipement
   //arme
   monEquipement.mainArme.lvl:=0;
   monEquipement.mainArme.maxlvl:=false;
   monEquipement.mainArme.nom:=strEquipement[0,arme,monEquipement.mainArme.lvl];
   monEquipement.mainArme.degats:=intoInteger(strEquipement[1,arme,monEquipement.mainArme.lvl]);
   //casque
   monEquipement.tete.lvl:=0;
   monEquipement.tete.maxlvl:=false;
   monEquipement.tete.nom:=strEquipement[0,casque,monEquipement.tete.lvl];
   monEquipement.tete.defense:=intoInteger(strEquipement[1,casque,monEquipement.tete.lvl]);
   //cuirasse
   monEquipement.torse.lvl:=0;
   monEquipement.torse.maxlvl:=false;
   monEquipement.torse.nom:=strEquipement[0,cuirasse,monEquipement.torse.lvl];
   monEquipement.torse.defense:=intoInteger(strEquipement[1,cuirasse,monEquipement.torse.lvl]);
   //gants
   monEquipement.mainArmure.lvl:=0;
   monEquipement.mainArmure.maxlvl:=false;
   monEquipement.mainArmure.nom:=strEquipement[0,gants,monEquipement.mainArmure.lvl];
   monEquipement.mainArmure.defense:=intoInteger(strEquipement[1,gants,monEquipement.mainArmure.lvl]);
   //jambières
   monEquipement.jambes.lvl:=0;
   monEquipement.jambes.maxlvl:=false;
   monEquipement.jambes.nom:=strEquipement[0,jambieres,monEquipement.jambes.lvl];
   monEquipement.jambes.defense:=intoInteger(strEquipement[1,jambieres,monEquipement.jambes.lvl]);
   //bottes
   monEquipement.pieds.lvl:=0;
   monEquipement.pieds.maxlvl:=false;
   monEquipement.pieds.nom:=strEquipement[0,bottes,monEquipement.pieds.lvl];
   monEquipement.pieds.defense:=intoInteger(strEquipement[1,bottes,monEquipement.pieds.lvl]);


end;

// Affiche l'équipement
procedure afficheToutEquipement;

begin

   deplacerCurseurXY(20,2); writeln('Equipement');

   deplacerCurseurXY(13,5); writeln('Arme : ',monEquipement.mainArme.nom);
   deplacerCurseurXY(13,6); writeln('Dégats : ',monEquipement.mainArme.degats);

   deplacerCurseurXY(13,8); writeln('Casque : ',monEquipement.tete.nom);
   deplacerCurseurXY(13,9); writeln('Defense : ',monEquipement.tete.defense);

   deplacerCurseurXY(13,11); writeln('Torse : ',monEquipement.torse.nom);
   deplacerCurseurXY(13,12); writeln('Defense : ',monEquipement.torse.defense);

   deplacerCurseurXY(13,14); writeln('Gants : ',monEquipement.mainArmure.nom);
   deplacerCurseurXY(13,15); writeln('Defense : ',monEquipement.mainArmure.defense);

   deplacerCurseurXY(13,17); writeln('Jambières : ',monEquipement.jambes.nom);
   deplacerCurseurXY(13,18); writeln('Defense : ',monEquipement.jambes.defense);

   deplacerCurseurXY(13,20); writeln('Bottes : ',monEquipement.pieds.nom);
   deplacerCurseurXY(13,21); writeln('Defense : ',monEquipement.pieds.defense);


end;

// Verifie pour chaque equipement si lvl=5
procedure verificationAmeliorable;

begin

   if monEquipement.mainArme.lvl=5 then      // Verifie pour chaque équipement si il est au niveau maximum
      monEquipement.mainArme.maxlvl:=true;

   if monEquipement.tete.lvl=5 then
      monEquipement.tete.maxlvl:=true;


   if monEquipement.torse.lvl=5 then
      monEquipement.torse.maxlvl:=true;


   if monEquipement.mainArmure.lvl=5 then
      monEquipement.mainArmure.maxlvl:=true;


   if monEquipement.jambes.lvl=5 then
      monEquipement.jambes.maxlvl:=true;


   if monEquipement.pieds.lvl=5 then
      monEquipement.pieds.maxlvl:=true;


end;

// Affiche les niveaux suivant de l'équipement
procedure afficheToutAmeliorable;

begin

   verificationAmeliorable; // Verifie le niveau max avant l'affichage de la forge

   deplacerCurseurXY(65,2); writeln('Forge');

   if monEquipement.mainArme.maxlvl=false then
      begin
      deplacerCurseurXY(55,5); write('1.');                                                                     // Affiche les premières informations nécessaire pour le joueur
      deplacerCurseurXY(60,5); writeln('Ameliorable en : ',strEquipement[0,arme,monEquipement.mainArme.lvl+1]); // (quel bouton appuyer, le nom de l'objet, et son attribut)
      deplacerCurseurXY(60,6);writeln('Dégats : ',strEquipement[1,arme,monEquipement.mainArme.lvl+1]);          // pour chaque équipement
      end
      else begin deplacerCurseurXY(60,5); writeln('Niveau max atteint'); end;     // Si niveau max atteint

   if monEquipement.tete.maxlvl=false then
      begin
      deplacerCurseurXY(55,8); write('2.');                                                                     // Affiche les premières informations nécessaire pour le joueur
      deplacerCurseurXY(60,8);writeln('Ameliorable en : ',strEquipement[0,casque,monEquipement.tete.lvl+1]);    // (quel bouton appuyer, le nom de l'objet, et son attribut)
      deplacerCurseurXY(60,9);writeln('Defense : ',strEquipement[1,casque,monEquipement.tete.lvl+1]);           // pour chaque équipement
      end
      else begin deplacerCurseurXY(60,8); writeln('Niveau max atteint'); end;     // Si niveau max atteint


   if monEquipement.torse.maxlvl=false then
      begin
      deplacerCurseurXY(55,11); write('3.');                                                                      // Affiche les premières informations nécessaire pour le joueur
      deplacerCurseurXY(60,11); writeln('Ameliorable en : ',strEquipement[0,cuirasse,monEquipement.torse.lvl+1]); // (quel bouton appuyer, le nom de l'objet, et son attribut)
      deplacerCurseurXY(60,12); writeln('Defense : ',strEquipement[1,cuirasse,monEquipement.torse.lvl+1]);        // pour chaque équipement
      end
      else begin deplacerCurseurXY(60,11); writeln('Niveau max atteint'); end;    // Si niveau max atteint


   if monEquipement.mainArmure.maxlvl=false then
      begin
      deplacerCurseurXY(55,14); write('4.');                                                                        // Affiche les premières informations nécessaire pour le joueur
      deplacerCurseurXY(60,14); writeln('Ameliorable en : ',strEquipement[0,gants,monEquipement.mainArmure.lvl+1]); // (quel bouton appuyer, le nom de l'objet, et son attribut)
      deplacerCurseurXY(60,15); writeln('Defense : ',strEquipement[1,gants,monEquipement.mainArmure.lvl+1]);        // pour chaque équipement
      end
      else begin deplacerCurseurXY(60,14); writeln('Niveau max atteint'); end;    // Si niveau max atteint


   if monEquipement.jambes.maxlvl=false then
      begin
      deplacerCurseurXY(55,17); write('5.');                                                                        // Affiche les premières informations nécessaire pour le joueur
      deplacerCurseurXY(60,17); writeln('Ameliorable en : ',strEquipement[0,jambieres,monEquipement.jambes.lvl+1]); // (quel bouton appuyer, le nom de l'objet, et son attribut)
      deplacerCurseurXY(60,18); writeln('Defense : ',strEquipement[1,jambieres,monEquipement.jambes.lvl+1]);        // pour chaque équipement
      end
      else begin deplacerCurseurXY(60,17); writeln('Niveau max atteint'); end;    // Si niveau max atteint


   if monEquipement.pieds.maxlvl=false then
      begin
      deplacerCurseurXY(55,20); write('6.');                                                                      // Affiche les premières informations nécessaire pour le joueur
      deplacerCurseurXY(60,20); writeln('Ameliorable en : ',strEquipement[0,bottes,monEquipement.pieds.lvl+1]);   // (quel bouton appuyer, le nom de l'objet, et son attribut)
      deplacerCurseurXY(60,21); writeln('Defense : ',strEquipement[1,bottes,monEquipement.pieds.lvl+1]);          // pour chaque équipement
      end
      else begin deplacerCurseurXY(60,20); writeln('Niveau max atteint'); end;    // Si niveau max atteint

   if (monEquipement.mainArme.maxlvl=true)                //
      and (monEquipement.tete.maxlvl=true)                //
      and (monEquipement.torse.maxlvl=true)               // Si tous les équipement sont améliorer au maximum
      and (monEquipement.mainArmure.maxlvl=true)          //
      and (monEquipement.jambes.maxlvl=true)              //
      and (monEquipement.pieds.maxlvl=true) then          //
         begin
         deplacerCurseurXY(6,24); write('Désolé mais vous avez déjà tout amélioré.');
         end

   else
     begin
     deplacerCurseurXY(6,24); write('Que voulez vous forger ?');
     end;

end;

// Affiche les équipements déjà possèdé d'un type(arme,casque,...)
procedure choixEquipement(equip:integer);

var
  equipementPartAS:partieEquipement;    //
  stringArmeArmure:string;              //
  stringDegatDefense:string;            // Jeu de variable renvoyer par la procedure renvoiVariableEquipementSpecifique
  nomEquipement:string;                 //
  attributEquipement:integer;           //
  lvlEquipement:integer;                //

  i:integer;
  choixModifEquipement:integer;         // Choix du joueur de quel équipement il veut équiper

begin
     renvoiVariableEquipementSpecifique                                                                            // Fournis le jeu de variable
     (equip,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);  //

     dessinerCadreXY(1,1,90,25,simple,white,black);
     deplacerCurseurXY(10,2); writeln('Equipement');
     deplacerCurseurXY(6,3); writeln('Choisis parmis ces ',equipementPartAS,' celui que tu souhaites équiper.');

     for i:=0 to lvlEquipement do                                                                                  //
     begin                                                                                                         //
     deplacerCurseurXY(3,5+(3*i)); writeln(i+1,'.');                                                               //  Boucle affichant uniquement les équipements possédés
     deplacerCurseurXY(5,5+(3*i)); writeln(stringArmeArmure,strEquipement[0,equipementPartAS,lvlEquipement-i]);    //
     deplacerCurseurXY(5,6+(3*i)); writeln(stringDegatDefense,strEquipement[1,equipementPartAS,lvlEquipement-i]);  //
     end;

     deplacerCurseurXY(66,3);
     readln(choixModifEquipement);
     if (choixModifEquipement>=1) and (choixModifEquipement<=lvlEquipement+1) then                                                    // Si choix valide
       begin                                                                                                                          // Alors reprends la valeur de equip
       effacerEcran;
       case equip of                                                                                                                  //pour déterminer l'équipement à changer
                 1:begin                                                                                                              //
                         monEquipement.mainArme.nom:=strEquipement[0,arme,(lvlEquipement-choixModifEquipement)+1];                    // Puis attribue les nouvelles valeurs de noms
                         monEquipement.mainArme.degats:=intoInteger(strEquipement[1,arme,(lvlEquipement-choixModifEquipement)+1]);    // et d'attributs
                         gestionEquipement;                                                                                           //
                   end;                                                                                                               //
                 2:begin                                                                                                              //
                         monEquipement.tete.nom:=strEquipement[0,casque,(lvlEquipement-choixModifEquipement)+1];                      //
                         monEquipement.tete.defense:=intoInteger(strEquipement[1,casque,(lvlEquipement-choixModifEquipement)+1]);     //
                         gestionEquipement;                                                                                           //
                   end;                                                                                                               //
                 3:begin                                                                                                              //
                         monEquipement.torse.nom:=strEquipement[0,cuirasse,(lvlEquipement-choixModifEquipement)+1];                   //
                         monEquipement.torse.defense:=intoInteger(strEquipement[1,cuirasse,(lvlEquipement-choixModifEquipement)+1]);  //
                         gestionEquipement;                                                                                           //
                   end;                                                                                                               //
                 4:begin                                                                                                              //
                         monEquipement.mainArmure.nom:=strEquipement[0,gants,(lvlEquipement-choixModifEquipement)+1];                 //
                         monEquipement.mainArmure.defense:=intoInteger(strEquipement[1,gants,(lvlEquipement-choixModifEquipement)+1]);//
                         gestionEquipement;                                                                                           //
                   end;                                                                                                               //
                 5:begin                                                                                                              //
                         monEquipement.jambes.nom:=strEquipement[0,jambieres,(lvlEquipement-choixModifEquipement)+1];                 //
                         monEquipement.jambes.defense:=intoInteger(strEquipement[1,jambieres,(lvlEquipement-choixModifEquipement)+1]);//
                         gestionEquipement;                                                                                           //
                   end;                                                                                                               //
                 6:begin                                                                                                              //
                         monEquipement.pieds.nom:=strEquipement[0,bottes,(lvlEquipement-choixModifEquipement)+1];                     //
                         monEquipement.pieds.defense:=intoInteger(strEquipement[1,bottes,(lvlEquipement-choixModifEquipement)+1]);    //
                         gestionEquipement;                                                                                           //
                   end;

            end;
       end
     else if choixModifEquipement=0 then   // si le joueur change d'avis change reviens en arrière
        begin
        effacerEcran;
        gestionEquipement
        end
     else
         begin                                                     // si entrée invalide alors reboucle
              deplacerCurseurXY(2,26);
              write('Désolé je n''ai pas compris votre requête.');
              readln;
              effacerEcran;
              choixEquipement(equip);
         end;

end;


// Renvoie toute les variable utile pour une partie d'équipement(arme,casque,..)
procedure renvoiVariableEquipementSpecifique
(partie:integer; var equipementPartAS:partieEquipement; var stringArmeArmure,stringDegatDefense,nomEquipement:string; var attributEquipement,lvlEquipement:integer);

begin                // en fonction de la variable partie correspondant à une partie d'équipement
   case partie of    // renvoie toute les variable utiles pour modification ou affichage
   1: begin
           equipementPartAS:=arme;                             // renvoie la catégorie d'équipement
           stringArmeArmure:='Arme : ';                        //         un string de la catégorie d'équipement
           stringDegatDefense:='Dégats : ';                    //         son type d'attribut
           nomEquipement:=monEquipement.mainArme.nom;          //         le nom spécifique de l'équipement
           attributEquipement:=monEquipement.mainArme.degats;  //         sa valeur d'attribut
           lvlEquipement:=monEquipement.mainArme.lvl;          //         son niveau
      end;
   2:
     begin
           equipementPartAS:=casque;
           stringArmeArmure:='Casque : ';
           stringDegatDefense:='Defense : ';
           nomEquipement:=monEquipement.tete.nom;
           attributEquipement:=monEquipement.tete.defense;
           lvlEquipement:=monEquipement.tete.lvl;
     end;
   3:
     begin
           equipementPartAS:=cuirasse;
           stringArmeArmure:='Cuirasse : ';
           stringDegatDefense:='Defense : ';
           nomEquipement:=monEquipement.torse.nom;
           attributEquipement:=monEquipement.torse.defense;
           lvlEquipement:=monEquipement.torse.lvl;
     end;
   4:
     begin
           equipementPartAS:=gants;
           stringArmeArmure:='Gants : ';
           stringDegatDefense:='Defense : ';
           nomEquipement:=monEquipement.mainArmure.nom;
           attributEquipement:=monEquipement.mainArmure.defense;
           lvlEquipement:=monEquipement.mainArmure.lvl;
     end;
   5:
     begin
           equipementPartAS:=jambieres;
           stringArmeArmure:='Jambières : ';
           stringDegatDefense:='Defense : ';
           nomEquipement:=monEquipement.jambes.nom;
           attributEquipement:=monEquipement.jambes.defense;
           lvlEquipement:=monEquipement.jambes.lvl;
     end;
   6:
     begin
           equipementPartAS:=bottes;
           stringArmeArmure:='Bottes : ';
           stringDegatDefense:='Defense : ';
           nomEquipement:=monEquipement.pieds.nom;
           attributEquipement:=monEquipement.pieds.defense;
           lvlEquipement:=monEquipement.pieds.lvl;
     end;
   end;
end;

// Affiche spécifiquement un équipement et son coût ainsi que ressource dispo
procedure afficheAmeliorationSpecifique (partie:integer);

var
  equipementPartAS:partieEquipement;    //
  stringArmeArmure:string;              //
  stringDegatDefense:string;            // Jeu de variable renvoyer par la procedure renvoiVariableEquipementSpecifique
  nomEquipement:string;                 //
  attributEquipement:integer;           //
  lvlEquipement:integer;                //

  choixConfirmation:integer;            // Demande confirmation au joueur s'il veut forger l'équipement

begin
   renvoiVariableEquipementSpecifique                                                                               // Fournis le jeu de variable
   (partie,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);    //

   effacerEcran;
   ForgeSansRessources; // cadre IHM

   deplacerCurseurXY(10,2); writeln('Equipement');
   deplacerCurseurXY(65,2); writeln('Forge');

   deplacerCurseurXY(5,5); writeln(stringArmeArmure,nomEquipement);
   deplacerCurseurXY(5,6); writeln(stringDegatDefense,attributEquipement);


   deplacerCurseurXY(60,5); writeln('Ameliorable en : ',strEquipement[0,equipementPartAS,lvlEquipement+1]);
   deplacerCurseurXY(60,6);writeln(stringDegatDefense,strEquipement[1,equipementPartAS,lvlEquipement+1]);

   deplacerCurseurXY(60,8); writeln('Coût en ressources : ');                                                                      //
   deplacerCurseurXY(64,9); writeln('Fourrure : ', coutAmelioration[lvlEquipement,equipementPartAS,fourrure]);                     //
   deplacerCurseurXY(64,10); writeln('Cuir : ', coutAmelioration[lvlEquipement,equipementPartAS,cuir]);                            //
   deplacerCurseurXY(64,11); writeln('Dents : ', coutAmelioration[lvlEquipement,equipementPartAS,dents]);                          // Affiche le cout de l'équipement
   deplacerCurseurXY(64,12); writeln('Femur : ', coutAmelioration[lvlEquipement,equipementPartAS,femur]);                          // à partir du tableau des couts
   deplacerCurseurXY(64,13); writeln('Griffe : ', coutAmelioration[lvlEquipement,equipementPartAS,griffe]);                        //
   deplacerCurseurXY(64,14); writeln('Ecaille de Dragon : ', coutAmelioration[lvlEquipement,equipementPartAS,ecailleDeDragon]);    //

   deplacerCurseurXY(5,8); writeln('Ressources disponible : ');                                   //
   deplacerCurseurXY(9,9); writeln('Fourrure : ',inventaireI[9].quantiteItem);                    //
   deplacerCurseurXY(9,10); writeln('Cuir : ',inventaireI[6].quantiteItem);                       //
   deplacerCurseurXY(9,11); writeln('Dents : ',inventaireI[7].quantiteItem);                      // Affiche la quantité de ressources possèdé
   deplacerCurseurXY(9,12); writeln('Femur : ',inventaireI[10].quantiteItem);                     //
   deplacerCurseurXY(9,13); writeln('Griffe : ',inventaireI[11].quantiteItem);                    //
   deplacerCurseurXY(9,14); writeln('Ecaille de Dragon : ',inventaireI[8].quantiteItem);          //

   if verifCout(partie) then
      begin                                                                                                //
      deplacerCurseurXY(9,17); write('Voulez vous vraiment forger cet objet ?   1.Oui   2.Non   ');        //
      readln(choixConfirmation);                                                                           // Si suffisement de ressources alors demande confirmation
        if choixConfirmation=1 then                                                                        //
           amelioration(partie);                                                                           //
      end
   else
      begin                                                                                                       //
      deplacerCurseurXY(9,17); writeln('Désolé mais vous n''avez pas les ressources nécessaire pour cet objet.'); // Sinon affiche pas asser de ressources
      readln;                                                                                                     //
      end;                                                                                                        //
end;

// Ameliore l'équipement voulu et réattribue les valeurs
// et réduit les ressources restantes
procedure amelioration(partie:integer);

var
  equipementPartAS:partieEquipement;    //
  stringArmeArmure:string;              //
  stringDegatDefense:string;            // Jeu de variable renvoyer par la procedure renvoiVariableEquipementSpecifique
  nomEquipement:string;                 //
  attributEquipement:integer;           //
  lvlEquipement:integer;                //

  i:integer;

begin

   case partie of     // a partir d'une variable, la partie d'équipement voulu par le joueur se voit attribué de nouvelles variables
   1:begin
         monEquipement.mainArme.lvl:=monEquipement.mainArme.lvl+1;
         monEquipement.mainArme.nom:=strEquipement[0,arme,monEquipement.mainArme.lvl];
         monEquipement.mainArme.degats:=intoInteger(strEquipement[1,arme,monEquipement.mainArme.lvl]);
     end;
   2:begin
         monEquipement.tete.lvl:=monEquipement.tete.lvl+1;
         monEquipement.tete.nom:=strEquipement[0,casque,monEquipement.tete.lvl];
         monEquipement.tete.defense:=intoInteger(strEquipement[1,casque,monEquipement.tete.lvl]);
     end;
   3:begin
         monEquipement.torse.lvl:=monEquipement.torse.lvl+1;
         monEquipement.torse.nom:=strEquipement[0,cuirasse,monEquipement.torse.lvl];
         monEquipement.torse.defense:=intoInteger(strEquipement[1,cuirasse,monEquipement.torse.lvl]);
     end;
   4:begin
         monEquipement.mainArmure.lvl:=monEquipement.mainArmure.lvl+1;
         monEquipement.mainArmure.nom:=strEquipement[0,gants,monEquipement.mainArmure.lvl];
         monEquipement.mainArmure.defense:=intoInteger(strEquipement[1,gants,monEquipement.mainArmure.lvl]);
     end;
   5:begin
         monEquipement.jambes.lvl:=monEquipement.jambes.lvl+1;
         monEquipement.jambes.nom:=strEquipement[0,jambieres,monEquipement.jambes.lvl];
         monEquipement.jambes.defense:=intoInteger(strEquipement[1,jambieres,monEquipement.jambes.lvl]);
     end;
   6:begin
         monEquipement.pieds.lvl:=monEquipement.pieds.lvl+1;
         monEquipement.pieds.nom:=strEquipement[0,bottes,monEquipement.pieds.lvl];
         monEquipement.pieds.defense:=intoInteger(strEquipement[1,bottes,monEquipement.pieds.lvl]);
     end;
   end;

   renvoiVariableEquipementSpecifique                                                                             // Fournis le jeu de variable
   (partie,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);  //

   for i:=0 to 5 do                     // Retire les ressources nécessaire à la forge du nouvel objet
       inventaireI[6+i].quantiteItem:=inventaireI[6+i].quantiteItem-coutAmelioration[lvlEquipement-1,equipementPartAS,composants(0+i)];



end;

// Verifie si un objet peut être améliorer avec l'inventaire dispo
function verifCout(partie:integer):boolean;

var
  equipementPartAS:partieEquipement;   //
  stringArmeArmure:string;             //
  stringDegatDefense:string;           // Jeu de variable renvoyer par la procedure renvoiVariableEquipementSpecifique
  nomEquipement:string;                //
  attributEquipement:integer;          //
  lvlEquipement:integer;               //

  i:integer;

begin
   renvoiVariableEquipementSpecifique                                                                              // Fournis le jeu de variable
   (partie,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);   //

   verifCout:=true;        // Boucle pour savoir si le les ressources disponible sont supérieur ou non au cout
   for i:=0 to 5 do
       if inventaireI[6+i].quantiteItem<coutAmelioration[lvlEquipement,equipementPartAS,composants(0+i)] then
          verifcout:=false;
end;

// convertit un string composé uniquement d'entier en integer
function intoInteger(strDeNombre:string):integer;

var
   i:integer;                                          // variable de boucle

begin

  intoInteger:=0;                                      // initialisation de intoInteger à 0

  for i:=1 to length(strDeNombre) do                   // boucle selon la taille de strDeNombre

  case strDeNombre[i] of                               //
   '0' : intoInteger:=(intoInteger*10);                //
   '1' : intoInteger:=(intoInteger*10)+1;              //
   '2' : intoInteger:=(intoInteger*10)+2;              //
   '3' : intoInteger:=(intoInteger*10)+3;              //
   '4' : intoInteger:=(intoInteger*10)+4;              // Les 10 cas possible pour créer l'integer
   '5' : intoInteger:=(intoInteger*10)+5;              //
   '6' : intoInteger:=(intoInteger*10)+6;              //
   '7' : intoInteger:=(intoInteger*10)+7;              //
   '8' : intoInteger:=(intoInteger*10)+8;              //
   '9' : intoInteger:=(intoInteger*10)+9;              //
  end;

end;

// procedure principale de gestion équipement
procedure gestionEquipement;

var
  choixModifEquipement:integer;      // choix joueur pour quel partie d'équipement il veut changer

begin
  dessinerCadreXY(4,1,85,22,simple,white,black);   //Cadre autour de l'equipement
  afficheToutEquipement;
  deplacerCurseurXY(10,5); write('1.');
  deplacerCurseurXY(10,8); write('2.');
  deplacerCurseurXY(10,11); write('3.');
  deplacerCurseurXY(10,14); write('4.');
  deplacerCurseurXY(10,17); write('5.');
  deplacerCurseurXY(10,20); write('6.');

  dessinerCadreXY(4,23,85,25,simple,white,black);
  deplacerCurseurXY(5,24); write('Choisissez un équipement à changer ou appuyer sur 0 pour revenir en arrière. ');

  readln(choixModifEquipement);
  effacerEcran;
  case choixModifEquipement of
  1..6 : choixEquipement(choixModifEquipement);   // pour les cas 1 à 6 appelle la Procedure choixEquipement
  0: menuVille();                                 // si 0 alors renvoie à menuVille
  else
      begin
          deplacerCurseurXY(5,25); write('Désolé je n''ai pas compris votre requête.');
      end;
  end;

  choixEquipement(choixModifEquipement);
end;

// procedure affichant tout le menu de la forge
procedure forge;

var choixForge:integer;     // choix du joueur sur quel équipement ameliorer

begin
  effacerEcran;
  ForgeIHM(); // cadre IHM
  afficheToutEquipement;   // affiche l'équipement
  afficheToutAmeliorable;  // affiche ce qui est améliorable

  readln(choixForge);
  case choixForge of
  1 : if monEquipement.mainArme.maxlvl=false then
         begin
         afficheAmeliorationSpecifique(choixForge);  // affiche le choix du joueur si l'équipement n'est au niveau maximum
         end
      else
          begin
            deplacerCurseurXY(4,25); write('Désolé je n''ai pas compris votre requête.');
            readln;
          end;


  2 : if monEquipement.tete.maxlvl=false then
         begin
         afficheAmeliorationSpecifique(choixForge);  // affiche le choix du joueur si l'équipement n'est au niveau maximum
         end
      else
        begin
          deplacerCurseurXY(4,25); write('Désolé je n''ai pas compris votre requête.');
          readln;
        end;

  3 : if monEquipement.torse.maxlvl=false then
         begin
         afficheAmeliorationSpecifique(choixForge);  // affiche le choix du joueur si l'équipement n'est au niveau maximum
         end
      else
        begin
          deplacerCurseurXY(4,25); write('Désolé je n''ai pas compris votre requête.');
          readln;
        end;

  4 : if monEquipement.mainArmure.maxlvl=false then
         begin
         afficheAmeliorationSpecifique(choixForge);  // affiche le choix du joueur si l'équipement n'est au niveau maximum
         end
      else
        begin
          deplacerCurseurXY(4,25); write('Désolé je n''ai pas compris votre requête.');
          readln;
        end;

  5 : if monEquipement.jambes.maxlvl=false then
         begin
         afficheAmeliorationSpecifique(choixForge);  // affiche le choix du joueur si l'équipement n'est au niveau maximum
         end
      else
        begin
          deplacerCurseurXY(4,25); write('Désolé je n''ai pas compris votre requête.');
          readln;
        end;

  6 : if monEquipement.pieds.maxlvl=false then
         begin
         afficheAmeliorationSpecifique(choixForge);  // affiche le choix du joueur si l'équipement n'est au niveau maximum
         end
      else
        begin
          deplacerCurseurXY(4,25); write('Désolé je n''ai pas compris votre requête.');
          readln;
        end;

  0 : menuVille();     //retour en ville si choixForge = 0

  else
        begin
          deplacerCurseurXY(4,25); write('Désolé je n''ai pas compris votre requête.');
          readln;
        end;

  end;
  forge;

end;

end.


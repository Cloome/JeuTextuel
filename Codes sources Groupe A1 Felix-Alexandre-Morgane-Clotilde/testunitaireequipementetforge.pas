unit testUnitaireEquipementEtForge;
// tests unitaire pour l'équipement et la forge
{$codepage utf8}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,equipement,TestUnitaire,inventaire,GestionEcran;

// PROCEDURE LANCANT TOUT LES TEST
procedure equipementEtForge_Test;

// test unitaire de l'initialisation de l'équipement
procedure initEquipement_Test;

// test les variable renvoyé
procedure renvoiVariableEquipementSpecifique_Test;

// test le niveau max
procedure verificationAmeliorable_Test;

// test procedure amelioration
procedure amelioration_test;

// test verification des couts
procedure verifCout_Test;

// test le bon fonctionnement de intoInteger
procedure intoInteger_Test;

implementation

// test unitaire de l'initialisation de l'équipement
procedure initEquipement_Test;
                             //--Verification de la bonne attribution de niveau
begin
newTestsSeries('Initialisation de l''equipement');
newtest('Initialisation de l''equipement','Niveau');
initEquipement;
testIsEqual(monEquipement.mainArme.lvl,0);
testIsEqual(monEquipement.tete.lvl,0);
testIsEqual(monEquipement.torse.lvl,0);
testIsEqual(monEquipement.mainArmure.lvl,0);
testIsEqual(monEquipement.jambes.lvl,0);
testIsEqual(monEquipement.pieds.lvl,0);

                             //--Verification de la bonne attribution de niveauMax
newtest('Initialisation de l''equipement','Niveau Max');
testIsEqual(not monEquipement.mainArme.maxlvl);
testIsEqual(not monEquipement.tete.maxlvl);
testIsEqual(not monEquipement.torse.maxlvl);
testIsEqual(not monEquipement.mainArmure.maxlvl);
testIsEqual(not monEquipement.jambes.maxlvl);
testIsEqual(not monEquipement.pieds.maxlvl);

end;

// test les variable renvoyé
procedure renvoiVariableEquipementSpecifique_Test;

var
  equipementPartAS: partieEquipement;
  stringArmeArmure,
  stringDegatDefense,
  nomEquipement: string;
  attributEquipement,
  lvlEquipement: integer;

  i:integer;

begin                        //--Verification du bon renvoi de niveau de la part de la fonction renvoiVariableEquipementSpecifique

newTestsSeries('Renvoi des variable utiles pour equipement');
initEquipement;

newTest('Renvoi des variable utiles pour equipement','Niveau');
monEquipement.mainArme.lvl:=random(6);
monEquipement.tete.lvl:=random(6);
monEquipement.torse.lvl:=random(6);
monEquipement.mainArmure.lvl:=random(6);
monEquipement.jambes.lvl:=random(6);
monEquipement.pieds.lvl:=random(6);
for i:= 1 to 6 do
    begin
      renvoiVariableEquipementSpecifique(i,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);
      case i of
      1:testIsEqual(lvlEquipement,monEquipement.mainArme.lvl);
      2:testIsEqual(lvlEquipement,monEquipement.tete.lvl);
      3:testIsEqual(lvlEquipement,monEquipement.torse.lvl);
      4:testIsEqual(lvlEquipement,monEquipement.mainArmure.lvl);
      5:testIsEqual(lvlEquipement,monEquipement.jambes.lvl);
      6:testIsEqual(lvlEquipement,monEquipement.pieds.lvl);
      end;
    end;
                             //--Verification du bon renvoi de la partie d'équipement de la part de la fonction renvoiVariableEquipementSpecifique
newTest('Renvoi des variable utiles pour equipement','Partie Equipement');

for i:= 1 to 6 do
    begin
      renvoiVariableEquipementSpecifique(i,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);
      case i of
      1:testIsEqual(ord(equipementPartAS),0);
      2:testIsEqual(ord(equipementPartAS),1);
      3:testIsEqual(ord(equipementPartAS),2);
      4:testIsEqual(ord(equipementPartAS),3);
      5:testIsEqual(ord(equipementPartAS),4);
      6:testIsEqual(ord(equipementPartAS),5);
      end;
    end;
                             //--Verification du bon renvoi de nom de la part de la fonction renvoiVariableEquipementSpecifique
newTest('Renvoi des variable utiles pour equipement','Nom');
monEquipement.mainArme.lvl:=0;
monEquipement.tete.lvl:=0;
monEquipement.torse.lvl:=0;
monEquipement.mainArmure.lvl:=0;
monEquipement.jambes.lvl:=0;
monEquipement.pieds.lvl:=0;


for i:= 1 to 6 do
    begin
      renvoiVariableEquipementSpecifique(i,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);
      case i of
      1:testIsEqual(nomEquipement,strEquipement[0,arme,monEquipement.mainArme.lvl]);
      2:testIsEqual(nomEquipement,strEquipement[0,casque,monEquipement.tete.lvl]);
      3:testIsEqual(nomEquipement,strEquipement[0,cuirasse,monEquipement.torse.lvl]);
      4:testIsEqual(nomEquipement,strEquipement[0,gants,monEquipement.mainArmure.lvl]);
      5:testIsEqual(nomEquipement,strEquipement[0,jambieres,monEquipement.jambes.lvl]);
      6:testIsEqual(nomEquipement,strEquipement[0,bottes,monEquipement.pieds.lvl]);
      end;
    end;
                             //--Verification du bon renvoi d'attribut de la part de la fonction renvoiVariableEquipementSpecifique
newTest('Renvoi des variable utiles pour equipement','Attribut');

for i:= 1 to 6 do
    begin
      renvoiVariableEquipementSpecifique(i,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);
      case i of
      1:testIsEqual(attributEquipement,intoInteger(strEquipement[1,arme,monEquipement.mainArme.lvl]));
      2:testIsEqual(attributEquipement,intoInteger(strEquipement[1,casque,monEquipement.tete.lvl]));
      3:testIsEqual(attributEquipement,intoInteger(strEquipement[1,cuirasse,monEquipement.torse.lvl]));
      4:testIsEqual(attributEquipement,intoInteger(strEquipement[1,gants,monEquipement.mainArmure.lvl]));
      5:testIsEqual(attributEquipement,intoInteger(strEquipement[1,jambieres,monEquipement.jambes.lvl]));
      6:testIsEqual(attributEquipement,intoInteger(strEquipement[1,bottes,monEquipement.pieds.lvl]));
      end;
    end;
end;

// test le niveau max
procedure verificationAmeliorable_Test;

begin
newTestsSeries('verificationAmeliorable');
                                     //--Verification des bonnes attributions de niveauMax dans les deux cas possible
newTest('verificationAmeliorable','Niveau non max');
initEquipement;
verificationAmeliorable;
testIsEqual(not monEquipement.mainArme.maxlvl);
testIsEqual(not monEquipement.tete.maxlvl);
testIsEqual(not monEquipement.torse.maxlvl);
testIsEqual(not monEquipement.mainArmure.maxlvl);
testIsEqual(not monEquipement.jambes.maxlvl);
testIsEqual(not monEquipement.pieds.maxlvl);



newTest('verificationAmeliorable','Niveau max');
monEquipement.mainArme.lvl:=5;
monEquipement.tete.lvl:=5;
monEquipement.torse.lvl:=5;
monEquipement.mainArmure.lvl:=5;
monEquipement.jambes.lvl:=5;
monEquipement.pieds.lvl:=5;

verificationAmeliorable;

testIsEqual(monEquipement.mainArme.maxlvl);
testIsEqual(monEquipement.tete.maxlvl);
testIsEqual(monEquipement.torse.maxlvl);
testIsEqual(monEquipement.mainArmure.maxlvl);
testIsEqual(monEquipement.jambes.maxlvl);
testIsEqual(monEquipement.pieds.maxlvl);

end;

// test procedure amelioration
procedure amelioration_test;

var
  equipementPartAS: partieEquipement;
  stringArmeArmure,
  stringDegatDefense,
  nomEquipement: string;
  attributEquipement,
  lvlEquipement: integer;

  i:integer;

begin
                    //--Verification des bonnes attributions de variables par la procedure amelioration pour chaque niveau et chaque équipement
newTestsSeries('Amelioration');
initEquipement;

newTest('Amelioration','Test arme');

for i:=1 to 5 do
begin
amelioration(1);

testIsEqual(monEquipement.mainArme.lvl,i);
testIsEqual(monEquipement.mainArme.nom,strEquipement[0,arme,monEquipement.mainArme.lvl]);
testIsEqual(monEquipement.mainArme.degats,intoInteger(strEquipement[1,arme,monEquipement.mainArme.lvl]));
end;

newTest('Amelioration','Test casque');

for i:=1 to 5 do
begin
amelioration(2);

testIsEqual(monEquipement.tete.lvl,i);
testIsEqual(monEquipement.tete.nom,strEquipement[0,casque,monEquipement.tete.lvl]);
testIsEqual(monEquipement.tete.defense,intoInteger(strEquipement[1,casque,monEquipement.tete.lvl]));
end;

newTest('Amelioration','Test cuirasse');

for i:=1 to 5 do
begin
amelioration(3);

testIsEqual(monEquipement.torse.lvl,i);
testIsEqual(monEquipement.torse.nom,strEquipement[0,cuirasse,monEquipement.torse.lvl]);
testIsEqual(monEquipement.torse.defense,intoInteger(strEquipement[1,cuirasse,monEquipement.torse.lvl]));
end;

newTest('Amelioration','Test gants');

for i:=1 to 5 do
begin
amelioration(4);

testIsEqual(monEquipement.mainArmure.lvl,i);
testIsEqual(monEquipement.mainArmure.nom,strEquipement[0,gants,monEquipement.mainArmure.lvl]);
testIsEqual(monEquipement.mainArmure.defense,intoInteger(strEquipement[1,gants,monEquipement.mainArmure.lvl]));
end;

newTest('Amelioration','Test jambieres');

for i:=1 to 5 do
begin
amelioration(5);

testIsEqual(monEquipement.jambes.lvl,i);
testIsEqual(monEquipement.jambes.nom,strEquipement[0,jambieres,monEquipement.jambes.lvl]);
testIsEqual(monEquipement.jambes.defense,intoInteger(strEquipement[1,jambieres,monEquipement.jambes.lvl]));
end;

newTest('Amelioration','Test bottes');

for i:=1 to 5 do
begin
amelioration(6);

testIsEqual(monEquipement.pieds.lvl,i);
testIsEqual(monEquipement.pieds.nom,strEquipement[0,bottes,monEquipement.pieds.lvl]);
testIsEqual(monEquipement.pieds.defense,intoInteger(strEquipement[1,bottes,monEquipement.pieds.lvl]));
end;

newTest('Amelioration','Couts');
initEquipement;
inventaireInitialisation;
renvoiVariableEquipementSpecifique(1,equipementPartAS,stringArmeArmure,stringDegatDefense,nomEquipement,attributEquipement,lvlEquipement);

inventaireI[7].quantiteItem:=2;
inventaireI[11].quantiteItem:=1;

amelioration(1);

testIsEqual(inventaireI[7].quantiteItem,1);
testIsEqual(inventaireI[11].quantiteItem,0);

end;

// test verification des couts
procedure verifCout_Test;

begin                    //--Verification de la bonne valeur de verifCout en fonction de la situation de l'inventaire
newTestsSeries('Verification des couts');

newTest('Verification des couts','Test negatif');
initEquipement;
inventaireInitialisation;
inventaireI[7].quantiteItem:=1;
inventaireI[11].quantiteItem:=0;

testIsEqual(not verifCout(1));

initEquipement;
inventaireInitialisation;
inventaireI[7].quantiteItem:=0;
inventaireI[11].quantiteItem:=1;

testIsEqual(not verifCout(1));

newTest('Verification des couts','Test positif');
initEquipement;
inventaireInitialisation;
inventaireI[7].quantiteItem:=1;
inventaireI[11].quantiteItem:=1;

testIsEqual(verifCout(1));

end;

// test le bon fonctionnement de intoInteger
procedure intoInteger_Test;

begin
       // Verification d'attribution à 0 si aucun nombre n'est détecté
newTestsSeries('Conversion chaîne de caractère composé d''entier en entier : intoInteger');
newTest('Conversion chaîne de caractère composé d''entier en entier : intoInteger','Test alphabétique');
testIsEqual(intoInteger('azertyui'),0);
       // Verification de bonne attribution si les nombres sont lié à d'autres caractères
newTest('Conversion chaîne de caractère composé d''entier en entier : intoInteger','Test alphanumérique');
testIsEqual(intoInteger('1azer8tyui2'),182);
       // Verification de bonne attribution si il n'y a que des nombres
newTest('Conversion chaîne de caractère composé d''entier en entier : intoInteger','Test numérique');
testIsEqual(intoInteger('789456123'),789456123);

end;

// PROCEDURE LANCANT TOUT LES TEST
procedure equipementEtForge_Test;
begin
  initEquipement_Test;
  renvoiVariableEquipementSpecifique_Test;
  verificationAmeliorable_Test;
  amelioration_test;
  verifCout_Test;
  intoInteger_Test;
  effacerEcran;
  Summary();
  readln;
end;

end.


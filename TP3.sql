if exists (select *from master..sysdatabases where name = 'Universite11')
drop database Universite11
create database Universite11
GO
use Universite11

CREATE TABLE ETUDIANT
(
        Mat CHAR PRIMARY KEY,
        Nom CHAR,
        Prenom CHAR,
)

/* 2. Créer la table*/

CREATE TABLE COURS
(
        CCode INT not null,
        CNom CHAR,
        Enseignant CHAR,
)
-- DROP TABLE COURS

/*3. Créer la table*/

CREATE TABLE EXAMEN(
        CCode INT,
        Mat CHAR,
        Note FLOAT,
        Edate datetime,
        PRIMARY KEY (CCode, Mat)
)

/*
Utiliser les instructions pour modifier le schéma d'une table :
4. Ajouter la définition de la clé primaire à Cours.
5. Ajouter l’attribut DateNais à Etudiant.
6. Ajouter l’attribut Diplôme (type : chaîne) à Etudiant.
7. Supprimer Diplôme de Etudiant.
8. Ajouter l’attribut Diplôme (type : chaîne) à Cours.
9. Ajouter la contrainte de clé étrangère Mat à Examen.
10. Ajouter la contrainte de clé étrangère CCode à Examen.
11. Supprimer la contrainte de clé étrangère sur Ccode.
12. Supprimer l’attribut Note de Examen.
13. Ajouter l’attribut Note à Examen avec valeur par défaut 0.
*/

--4--
ALTER TABLE COURS ADD constraint PK_COURS PRIMARY KEY (CCode);

--5--
ALTER TABLE ETUDIANT ADD DateNais DATETIME DEFAULT NULL;

--6--
ALTER TABLE ETUDIANT ADD Diplome CHAR;

--7--
ALTER TABLE ETUDIANT DROP COLUMN Diplome;

--8--
ALTER TABLE COURS ADD Diplome CHAR;

--9--
ALTER TABLE EXAMEN ADD constraint FK_EXAM_MAT foreign key (Mat) references ETUDIANT (Mat);

--10-
ALTER TABLE EXAMEN ADD constraint FK_EXAM_CCODE foreign key (CCode) references COURS (CCode);

--11--
ALTER TABLE EXAMEN DROP constraint FK_EXAM_CCODE;

--12--
ALTER TABLE EXAMEN DROP column Note;

--13--
ALTER TABLE EXAMEN ADD Note INT DEFAULT 0;

/*En ayant enregistré les définitions de tables dans un fichier :
14. Supprimer la table Cours.
15. Supprimer la table Etudiant. Expliquer l’erreur produite.
16. Supprimer la table Examen.*/

--14--
DROP TABLE Cours;

--15--
Drop Table Etudiant; /*Impossible de supprimer le table 'Etudiant', car il existe une clef étrangère : Impossible de supprimer l'objet 'Etudiant' car il est référencé par une contrainte FOREIGN KEY.*/

--16--
Drop Table Examen;

/*
17. Créer à nouveau les trois tables avec le schéma indiqué ci-dessous,
toutes les contraintes décrites ci-dessous doivent être spécifiées durant la création des tables.
Les contraintes référentielles doivent être nommées.
- Etudiant : le nouveau schéma est
Etudiant(Mat, Nom, Prenom, DateNais).
imposer le contrainte not null sur l’attribut Nom et la contrainte Unique sur la couple des attributs
(Nom, Prenom).
- Cours : le nouveau schéma est
Cours(CCode, CNom, Enseignant, Diplome).
- Examen : le schéma est
Examen(CCode, Mat, Note, Edate)
Imposer la contrainte que la note doit avoir une valeur entre 0 et 20 et que la valeur par défaut est
0. Ccode et Mat sont des clefs étrangères.
*/
CREATE TABLE ETUDIANT
(
        Mat CHAR(100) PRIMARY KEY,
        Nom CHAR(100) NOT NULL,
        Prenom CHAR(100),
        DateNais CHAR(100),
        UNIQUE (Nom, Prenom)
)

CREATE TABLE COURS
(
        CCode INT PRIMARY KEY,
        CNom CHAR(100),
        Enseignant CHAR(100),
        Diplome CHAR(100)
)

CREATE TABLE EXAMEN
(
        CCode INT,
        Mat CHAR(100),
        Note FLOAT CHECK(Note >= 0 AND Note <= 20) DEFAULT 0,
        Edate DATETIME,
        FOREIGN KEY (CCode) REFERENCES COURS (Ccode),
        FOREIGN KEY (Mat) REFERENCES ETUDIANT (Mat),
        PRIMARY KEY (CCode, Mat)
)
/*
18. Insérer dans la table Etudiant les tuples suivants :
'st123', 'Durand', 'Jean', '3-12-84'
'st123', 'Villard', 'Ann', '3-12-84'
Expliquer l’erreur produite.
*/

INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st123', 'Durand', 'Jean', '3-12-84');
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st123', 'Villard', 'Ann', '3-12-84');
/*
Violation de la contrainte PRIMARY KEY « PK__ETUDIANT__C7977BC4E4BAF56D ». Impossible d'insérer une clé en double dans l'objet « dbo.ETUDIANT ». Valeur de clé dupliquée
La clef primaire doit être unique
*/

/*
19. Insérer dans la table Etudiant un tuple avec les seules valeurs de Mat et Nom : 'st124',
'Villard'
*/
INSERT INTO ETUDIANT (Mat,Nom) VALUES ('st124', 'Villard');
/*
20. Insérer dans la table Etudiant le tuples suivants :
'st126', 'Villard', 'Marie', '1-9-87'
'st127', 'Villard', 'Marie', '2-3-86'
Expliquer l’erreur produite.
*/
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st126', 'Villard', 'Marie', '1-9-87');
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st127', 'Villard', 'Marie', '2-3-86');
/*
Violation de la contrainte UNIQUE KEY « UQ__ETUDIANT__060B8EB93A3B0453 ». Impossible d'insérer une clé en double dans l'objet « dbo.ETUDIANT ». Valeur de clé dupliquée
Le couple Nom Prenom doit être unique
*/

/*
21. Insérer dans la table Etudiant  un tuple avec les valeurs  'st128', 'Villard', 'Philippe’, '1-9-87' 
*/
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st128', 'Villard', 'Philippe', '1-9-87');

/*
22.Insérer dans la table Etudiant  un tuple avec les seules valeurs de Mat, Prenom, DateNais : 'st129','Walter','5-11-87' 
Expliquer l’erreur produite. 
*/
INSERT INTO ETUDIANT (Mat,Prenom,DateNais) VALUES ('st129','Walter','5-11-87');
/*
Impossible d'insérer la valeur NULL dans la colonne 'Nom', table 'Universite11.dbo.ETUDIANT'. Cette colonne n'accepte pas les valeurs NULL.
Nom ne peux pas etre null
*/

/*
23. Insérer dans Etudiant :  'st221', 'Dupont', 'Ann', '1-12-85' 
'st222', 'Le Font', 'Walter', '10-12-85' 
'st223', 'Joste', 'Monique', '19-4-85' 
'st224', 'Pardin', 'Hugo', '8-1-86'
*/
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st221', 'Dupont', 'Ann', '1-12-85' );
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st222', 'Le Font', 'Walter', '10-12-85' );
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st223', 'Joste', 'Monique', '19-4-85' );
INSERT INTO ETUDIANT (Mat,Nom,Prenom,DateNais) VALUES ('st224', 'Pardin', 'Hugo', '8-1-86');

/*
24. Insérer dans Cours : 
1, 'BD', 'Milhaud', 'Informatique' 
2, 'Reseaux', 'Milhaud', 'Informatique' 
3, 'Chimie1', 'Bonnet', 'ScienceNat' 
4, 'Chimie2', 'Bonnet', 'ScienceNat' 
5, 'Statistique', 'Barbin', 'ScienceNat' 
6, 'Economie1', 'Conti', 'SciencePo' 
7, 'Statistique', 'Barbin', 'SciencePo' 
*/
INSERT INTO COURS VALUES (1, 'BD', 'Milhaud', 'Informatique');
INSERT INTO COURS VALUES (2, 'Reseaux', 'Milhaud', 'Informatique');
INSERT INTO COURS VALUES (3, 'Chimie1', 'Bonnet', 'ScienceNat');
INSERT INTO COURS VALUES (4, 'Chimie2', 'Bonnet', 'ScienceNat');
INSERT INTO COURS VALUES (5, 'Statistique', 'Barbin', 'ScienceNat');
INSERT INTO COURS VALUES (6, 'Economie1', 'Conti', 'SciencePo');
INSERT INTO COURS VALUES (7, 'Statistique', 'Barbin', 'SciencePo');

/*
25. Insérer dans Examens : 1,'st123',12,'3-2-04' 1,'st124',13,'3-2-04' 2,'st124',14,'1-7-05' 7,'st223',12,'1-2-04' 7,'st224',14,'3-2-04' 7,'st126',14,'3-7-05'
5,'st223',12,'1-2-04' 5,'st224',11,'3-2-04' 1,'st224',13,'19-5-05' 5,'st124',18,'20-2-02' 4,'st124',22,'7-2-02' 
Expliquer l’erreur produite
*/
INSERT INTO EXAMEN VALUES (1,'st123',12,'3-2-04');
INSERT INTO EXAMEN VALUES (1,'st124',13,'3-2-04');
INSERT INTO EXAMEN VALUES (2,'st124',14,'1-7-05');
INSERT INTO EXAMEN VALUES (7,'st223',12,'1-2-04');
INSERT INTO EXAMEN VALUES (7,'st224',14,'3-2-04');
INSERT INTO EXAMEN VALUES (7,'st126',14,'3-7-05');
INSERT INTO EXAMEN VALUES (5,'st223',12,'1-2-04');
INSERT INTO EXAMEN VALUES (5,'st224',11,'3-2-04');
INSERT INTO EXAMEN VALUES (1,'st224',13,'19-5-05');
INSERT INTO EXAMEN VALUES (5,'st124',18,'20-2-02');
INSERT INTO EXAMEN VALUES (4,'st124',22,'7-2-02');
-- Un étudiant avait éja une note à cet examen

-- 26. Insérer dans Examens un tuple avec les valeurs de Ccode et Mat : 3 et 'st124' 
INSERT INTO EXAMEN (Ccode, Mat)
        VALUES (3, 'st124');

/*
27.Créer une table  ResExamen avec attributs : ResExamen(Matricule, NomEtudiant, NomCours Note) 
Remplier la table par une seule opération d’insertion.
*/
CREATE TABLE RESEXAMEN
(
        Mat CHAR(100),
		NomEtudiant CHAR(100),
		NomCours CHAR(100),
        Note FLOAT CHECK(Note >= 0 AND Note <= 20) DEFAULT 0,
)
INSERT INTO RESEXAMEN (Mat,NomEtudiant,NomCours,Note)
SELECT E.Mat, E.Nom, C.CNom, X.Note
FROM ETUDIANT E JOIN EXAMEN X ON E.Mat = X.Mat JOIN COURS C ON X.CCode = C.CCode;

/*
28. Supprimer la table ResExamen.
*/
Drop Table RESEXAMEN;

/*
PARTIE III. Modification des données et intégrité référentielle 
*/

/*
29. Insérer dans Examens  le tuple 8, 'et330', 16, '4-4-04'.  
Expliquer l’erreur produite. 
*/
INSERT INTO EXAMEN VALUES (8, 'et330', 16, '4-4-04');
/*
L'instruction INSERT est en conflit avec la contrainte FOREIGN KEY "FK__EXAMEN__CCode__25869641".
*/

/*
30. Décrémenter de 2 points les notes de Pardin. 
*/
UPDATE EXAMEN SET Note=Note-2
WHERE Mat = (SELECT Mat FROM ETUDIANT WHERE Nom='Pardin');

/*
31. Augmente de 0.5 points les notes des examens de BD et de Reseaux. 
*/
UPDATE EXAMEN SET Note=Note+0.5
WHERE Ccode IN (SELECT Ccode FROM COURS WHERE CNom='BD' OR CNom='Reseaux');

/*
32. Supprimer les examens soutenus par Durand. 
*/
DELETE FROM EXAMEN WHERE Mat = (SELECT Mat FROM ETUDIANT WHERE NOM='Durand');
/*
33. Supprimer Durand de Etudiant. 
*/
DELETE FROM ETUDIANT WHERE Nom='Durand';
/*
34. Supprimer Joste de Etudiant. 
Expliquer l’erreur produite. 
*/
DELETE FROM ETUDIANT WHERE Nom='Joste';
/*
L'instruction DELETE est en conflit avec la contrainte REFERENCE "FK__EXAMEN__Mat__49C3F6B7".
*/

/*
35. Modifier la matricule de Joste dans Etudiant. 
Expliquer l’erreur produite. 
*/
UPDATE ETUDIANT SET Mat='looooooooooooooooooooooooooool' WHERE Nom='Joste';
/*
L'instruction UPDATE est en conflit avec la contrainte REFERENCE "FK__EXAMEN__Mat__49C3F6B7".
*/

/*
36. Remplacer la contrainte de clé étrangère sur Mat avec une contrainte qui permet la suppression et la mis à jours en cascade (spécifier l’option cascade pour les deux opérations). 
La nouvelle contrainte devra avoir un nom différent. 
*/
ALTER TABLE EXAMEN
DROP CONSTRAINT FK__EXAMEN__Mat__49C3F6B7; 
ALTER TABLE EXAMEN ADD CONSTRAINT FK_Mat
FOREIGN KEY (Mat) REFERENCES ETUDIANT (Mat)
ON DELETE CASCADE ON UPDATE CASCADE
/*
37. Supprimer Joste de Etudiant. 
*/
DELETE FROM ETUDIANT WHERE Nom='Joste';

/*
38. Modifier la matricule de Pardin.
*/
UPDATE ETUDIANT SET Mat='looooooooooool' WHERE Nom='Pardin';

/*
PARTIE IV. Vues Créer d'abord une copie privée de la BD  CENTRE SPORTIF :
 - Dans le menu Fichier choisir : Nouveau -> Requête avec la connexion actuelle - 
 Télécharger le script de la BD CENTRE SPORTIF, le fichier : Script-CENTRESPORT.txt 
 - Copier le contenu du fichier dans la fenêtre de la nouvelle requête : - 
 Dans les instructions : create database CENTRE_SPORTIF use CENTRE_SPORTIF renommez CENTRE_SPORTIF en  CENTRE_SPORTIFN où N est votre numéro de login, 
 - Exécuter les instructions du fichier tout entier par une instruction  unique ! 
 Executer Création des Vues sur la base des données du CENTRE SPORTIF: 
 */

 /*Script pour génerer la base de données pour le TD1 et TD2 SQL */

use master 

go

create database CENTRE_SPORTIF11

go

use CENTRE_SPORTIF11

go

create table COURS (
NomCours char(32) primary key,
Enseignant char(32),
Niveau char(32)
constraint Nivcons check(Niveau in ('Facile', 'Moyen', 'Difficile'))
)

go 

create table INSCRIT(
Nocarte char(32) primary key,
Nom char(32),
Age tinyint,
Sexe char check(Sexe ='H' or Sexe = 'F')
)

go

create table PLANNING(
NomCours char(32) references COURS(NomCours),
Jour char(16),
Lieu char(32),
Heure tinyint
primary key (NomCours,Jour)
)

go

create table PARTICIPATION(
Nocarte char(32) references INSCRIT(Nocarte), 
NomCours char(32) references COURS(NomCours),
primary key(Nocarte, NomCours)
)

go 

insert into COURS values ('Aerobic',  'Jean', 'Facile')                                              
insert into COURS values ('Aquagym', 'Marie','Facile')                          
insert into COURS values ('Body Pump',  'Daniel',   'Moyen')                           
insert into COURS values ('Gym Douce',  'Vincent', 'Moyen')                           
insert into COURS values ('Pilates',  'Xavier',  'Difficile')                       
insert into COURS values ('Salsa',   'Laura',   'Moyen')                           
insert into COURS values ('Spinning',   'Marc',  'Difficile')                       
insert into COURS values ('Step', 'Monique',  NULL)                           
insert into COURS values ('StretchingI', 'Jean',  'Facile')
insert into COURS values ('StretchingII', 'Jean',  'Facile')                                                    
insert into COURS values ('Total Body',  'Marc',   'Difficile')                       
insert into COURS values ('Yoga', 'Vincent', 'Facile')
insert into COURS values ('NatationI', 'Marie', 'Facile') 
insert into COURS values ('NatationII', 'David', 'Moyen') 
insert into COURS values ('Tango', NULL, 'Moyen')                                                                                

                           
                                                                                                       
go

insert into INSCRIT values ('A112', 'Canat', 19,	'H')
insert into INSCRIT values ('B381', 'Merlan', 29,	'F')
insert into INSCRIT values ('D123', 'Dupont', 	23,	'F')
insert into INSCRIT values ('D266',  'Dupont', 22,	'H')
insert into INSCRIT values ('D513',  'Bonnard', 31,	'H')
insert into INSCRIT values ('D678', 'Florant', 	28,	'F')
insert into INSCRIT values ('F667',  'Martini', 30,	'H')
insert into INSCRIT values ('G679', 'Flaubert',	45,	'F')
insert into INSCRIT values ('R169', 'Torres',  	22,	'H')
insert into INSCRIT values ('R276', 'Leonard', 	47,	'H')
insert into INSCRIT values ('R392', 'Siegel', 20,	'F')
insert into INSCRIT values ('S207', 'Verlain', 	34,	'F')
insert into INSCRIT values ('U694', 'Florentin', 35,	'F')
insert into INSCRIT values ('U812','Cantini', 24,	'F')
insert into INSCRIT values ('X776','Ghali', 49,	'H')
insert into INSCRIT values ('Y551', 'Schmitt', 	41,	'H')
insert into INSCRIT values ('Z112', 'Durand', 	37,	'H')
insert into INSCRIT values ('Z331', 'Valdes', 	28,	'H')
insert into INSCRIT values ('F671', 'Gonzales', 22,	'F')
insert into INSCRIT values ('K571', 'Kassam', 25,	'F')
insert into INSCRIT values ('B688', 'Kassam', 21,	'H')
insert into INSCRIT values ('U712', 'Tarad', 31, 'H')
insert into INSCRIT values ('I112', 'Giordano', 42, 'F')
insert into INSCRIT values ('S412', 'Outbib', 40, 'H')
insert into INSCRIT values ('R912', 'Cholvy', 51, 'H')
insert into INSCRIT values ('T312', 'Banon', 49, 'H')
insert into INSCRIT values ('G412', 'Lazar', 37, 'F')
insert into INSCRIT values ('W392', 'Kureishi', 37, 'H')
insert into INSCRIT values ('P595', 'Malinski', 30, 'F')
insert into INSCRIT values ('J885', 'Durras', 31, 'F')
insert into INSCRIT values ('J985', 'Gavin', 31, 'H')




insert into PLANNING values ('Aerobic',  'lundi',  'SalleI', 11)    
insert into PLANNING values ('Aerobic',   'mercredi',   'SalleI', 11)   
insert into PLANNING values ('Aquagym',   'jeudi',  'Piscine', 12)  
insert into PLANNING values ('Aquagym',  'mardi',  'Piscine', 12)   
insert into PLANNING values ('Body Pump',   'lundi',  'SalleIII', 18)    
insert into PLANNING values ('Body Pump',  'vendredi',   'SalleIII', 18)   
insert into PLANNING values ('Gym Douce',   'lundi',  'SalleII', 10)  
insert into PLANNING values ('Gym Douce',   'mercredi',   'SalleII', 10)   
insert into PLANNING values ('Gym Douce',  'vendredi',  'SalleII', 10)  
insert into PLANNING values ('Pilates',   'lundi',   'SalleI', 18)   
insert into PLANNING values ('Pilates',   'jeudi',  'SalleI', 18)  
insert into PLANNING values ('Pilates',    'samedi',  'SalleI', 18)  
insert into PLANNING values ('Salsa',  'mardi',  'SalleII', 20)    
insert into PLANNING values ('Salsa',    'vendredi',  'SalleII', 20)    
insert into PLANNING values ('Spinning',  'lundi',  'SalleIV', 19)    
insert into PLANNING values ('Spinning',   'jeudi',  'SalleIV',19)
insert into PLANNING values ('Step',   'lundi',   'SalleIII', 14)  
insert into PLANNING values ('Step',  'mercredi',   'SalleIII', 14)   
insert into PLANNING values ('Step',   'vendredi',  'SalleIII', 14)   
insert into PLANNING values ('StretchingI',   'mardi',   'SalleII', 9)    
insert into PLANNING values ('StretchingI',  'jeudi',   'SalleII', 9)
insert into PLANNING values ('StretchingI',  'samedi',   'SalleII', 9)
insert into PLANNING values ('StretchingII',   'lundi',   'SalleI', 9)    
insert into PLANNING values ('StretchingII',  'mercredi',   'SalleI', 9)
insert into PLANNING values ('StretchingII',  'vendredi',   'SalleI', 9)   
insert into PLANNING values ('Total Body',  'jeudi',  'SalleIII', 19)  
insert into PLANNING values ('Total Body',  'samedi',   'SalleIII', 19)  
insert into PLANNING values ('Yoga',  'mardi',   'SalleI',  10)
insert into PLANNING values ('Yoga',  'jeudi',  'SalleI', 10)  
insert into PLANNING values ('Yoga',   'samedi',  'SalleIII', 10)
insert into PLANNING values ('NatationI',   'lundi',  'Piscine', 18)
insert into PLANNING values ('NatationI',   'mercredi',  'Piscine', 18)
insert into PLANNING values ('NatationII',   'mardi',  'Piscine', 20)
insert into PLANNING values ('NatationII',   'jeudi',  'Piscine', 20)
insert into PLANNING values ('Tango',   'samedi',  'SalleIII', 20)

go

insert into PARTICIPATION values ('A112',       'Aerobic')                         
insert into PARTICIPATION values ('A112',       'Aquagym')                          
insert into PARTICIPATION values ('A112',       'Gym Douce')                        
insert into PARTICIPATION values ('A112',       'Salsa')                            
insert into PARTICIPATION values ('A112',       'Spinning')  
                       
insert into PARTICIPATION values ('B381',       'Aquagym')                          
insert into PARTICIPATION values ('B381',       'Gym Douce')                        
insert into PARTICIPATION values ('B381',       'Salsa')                            
insert into PARTICIPATION values ('B381',       'Spinning')                         
insert into PARTICIPATION values ('B381',       'Step')      
                       
insert into PARTICIPATION values ('D123',       'Body Pump')                        
insert into PARTICIPATION values ('D123',       'Gym Douce')                        
insert into PARTICIPATION values ('D123',       'Salsa')                            
insert into PARTICIPATION values ('D123',       'Spinning')                         
insert into PARTICIPATION values ('D123',       'Step')       
                      
insert into PARTICIPATION values ('D266',       'Aerobic')                          
insert into PARTICIPATION values ('D266',       'Body Pump')                        
insert into PARTICIPATION values ('D266',       'StretchingI')
insert into PARTICIPATION values ('D266',       'NatationII')     
                    
insert into PARTICIPATION values ('D513',       'Aerobic')                          
insert into PARTICIPATION values ('D513',       'Step')                             
insert into PARTICIPATION values ('D513',       'Total Body')  
                     
insert into PARTICIPATION values ('D678',       'Step')                             
insert into PARTICIPATION values ('D678',       'Yoga')      
                       
insert into PARTICIPATION values ('F667',       'Aquagym')                          
insert into PARTICIPATION values ('F667',       'Gym Douce')                        
insert into PARTICIPATION values ('F667',       'Pilates')                          
insert into PARTICIPATION values ('F667',       'Step')        
                     
insert into PARTICIPATION values ('G679',       'Aerobic')                          
insert into PARTICIPATION values ('G679',       'Total Body')                       
insert into PARTICIPATION values ('G679',       'Yoga')      
                       
insert into PARTICIPATION values ('X776',       'Total Body')
insert into PARTICIPATION values ('X776',       'Body Pump')     
                    
insert into PARTICIPATION values ('Y551',       'Salsa')                            
insert into PARTICIPATION values ('Y551',       'StretchingI')    
                   
insert into PARTICIPATION values ('Z112',       'Pilates')                          
insert into PARTICIPATION values ('Z112',       'Salsa')                            
insert into PARTICIPATION values ('Z112',       'StretchingII')                       
insert into PARTICIPATION values ('Z112',       'Yoga')                             
insert into PARTICIPATION values ('Z331',       'Total Body')                       

insert into PARTICIPATION values ('B688',      'Pilates')  
insert into PARTICIPATION values ('B688',      'StretchingI') 
insert into PARTICIPATION values ('B688',      'Aquagym')
insert into PARTICIPATION values ('B688',      'Yoga')

insert into PARTICIPATION values ('K571',      'Total Body')  
insert into PARTICIPATION values ('K571',      'StretchingII') 
insert into PARTICIPATION values ('K571',      'NatationII')
insert into PARTICIPATION values ('K571',      'Yoga')
insert into PARTICIPATION values ('K571',      'Aerobic')

     
insert into PARTICIPATION values ('U712',      'Yoga')
insert into PARTICIPATION values ('U712',      'Salsa')
insert into PARTICIPATION values ('U712',      'Spinning')
insert into PARTICIPATION values ('U712',      'Aerobic')

insert into PARTICIPATION values ('I112',      'NatationI')
insert into PARTICIPATION values ('I112',      'StretchingI')
insert into PARTICIPATION values ('I112',      'Salsa')
insert into PARTICIPATION values ('I112',      'Pilates')
insert into PARTICIPATION values ('I112',      'Gym Douce')
insert into PARTICIPATION values ('I112',      'Aquagym')
 
insert into PARTICIPATION values ('R912',      'Aquagym')
insert into PARTICIPATION values ('R912',      'NatationI')

insert into PARTICIPATION values ('T312',      'Yoga')
insert into PARTICIPATION values ('T312',      'Gym Douce')
insert into PARTICIPATION values ('T312',      'StretchingII')
insert into PARTICIPATION values ('T312',      'NatationI')

insert into PARTICIPATION values ('G412',      'NatationI')
insert into PARTICIPATION values ('G412',      'Spinning')
insert into PARTICIPATION values ('G412',      'Body Pump')
insert into PARTICIPATION values ('G412',      'Salsa')
insert into PARTICIPATION values ('G412',      'Step')
insert into PARTICIPATION values ('G412',      'Yoga')

insert into PARTICIPATION values ('W392',      'Yoga')

insert into PARTICIPATION values ('J885',      'Total Body')
insert into PARTICIPATION values ('J885',      'Body Pump')
insert into PARTICIPATION values ('J885',      'Step')
insert into PARTICIPATION values ('J885',      'StretchingII')
insert into PARTICIPATION values ('J885',      'Salsa')
 
insert into PARTICIPATION values ('J985',      'Yoga')
insert into PARTICIPATION values ('J985',      'Gym Douce')
insert into PARTICIPATION values ('J985',      'StretchingI')
insert into PARTICIPATION values ('J985',      'Aquagym')
insert into PARTICIPATION values ('J985',      'NatationI')

 /*
 39. créer la vue des cours faciles COURSFACILE(Cours, Moniteur) 
 */
 CREATE VIEW COURSFACILE (Cours, Moniteur) AS
        SELECT NomCours, Enseignant
        FROM COURS
        WHERE Niveau = 'Facile'

 /*
 40. Poser une requête sur  la vue: chercheur le moniteur du cours de Yoga 
 */
SELECT Moniteur
FROM COURSFACILE
WHERE Cours = 'Yoga'


 /*
 41. créer la vue des inscrits aux cours faciles: INSCRIT_COURS_FACILE(Cours, Moniteur, Carte, Inscrit, Age) 
 */
  CREATE VIEW INSCRIT_COURS_FACILE (Cours, Moniteur, Carte, Inscrit, Age)  AS
        SELECT C.NomCours, C.Enseignant, I.NoCarte,I.Nom,I.Age
        FROM COURS C JOIN PARTICIPATION P on C.NomCours = P.NomCours JOIN INSCRIT I on P.Nocarte = I.Nocarte
        WHERE Niveau = 'Facile'

 /*
 42. poser des requêtes sur cette vue:  par exemple trouver les inscrits au cours d''aquagym.
 */

SELECT *
FROM INSCRIT_COURS_FACILE
WHERE Cours = 'Aquagym';
-- use CENTRE_SPORTIF

/*
  1. Afficher la liste des cours.
  2. Rechercher nom et age des inscrits. 
  3. Afficher toutes les informations sur les cours (nom du cours, enseignant, niveau). 
  4. Afficher les cours et les enseignants respectifs. Renommer les attributs en Activite et Moniteur. 
  5. Afficher les enseignants. 
  6. Afficher les enseignants sans doublons.
*/

--1
SELECT NomCours FROM COURS;

--2
SELECT Nom,Age FROM INSCRIT;

--3
SELECT * FROM COURS;

--4
SELECT NomCours as Activité,Enseignant as Moniteur FROM COURS;

--5
SELECT Enseignant FROM COURS;

--6
SELECT DISTINCT Enseignant FROM COURS;

/*
7. Afficher les cours de niveau Facile. 
8. Afficher les inscrites (femmes) d'âge inférieure à 30, afficher nom et âge. 
9. Trouver la liste des cours tenus le lundi et de cours tenus le mercredi.
10. Afficher les inscrites (femmes) d'âge inférieure à 30 et des hommes d'âge supérieure ou égal à 25, afficher nom, âge, sexe. 
11. Trouver les cours  tenus  le lundi ou le mercredi ou le vendredi ou le samedi. (utiliser "in".) 
12. Afficher les cours tenus après 12h00, soit le lundi en salle II soit le vendredi en salle III. 
13. Trouver les cours  enseignés par Jean et par Marie.
14. Trouver les cours qui ne sont pas enseignés par Jean et par Marie. 
15. Trouver la liste des inscrits d'une âge comprise entre 25 et 35. Utiliser "between". 
16. Trouver les cours dont l'enseignant est connu. 
17. Trouver les cours dont l'enseignant n'est pas connu. 
18. Donner la liste des cours tel que : si l’enseignant est connu alors il est Jean (soit l'enseignant n'est pas connu, soit il est Jean). 
*/

--7
SELECT * FROM COURS WHERE Niveau='Facile';

--8
SELECT Nom,Age FROM INSCRIT WHERE Age < 30 AND Sexe= 'F';

--9
SELECT * FROM PLANNING WHERE Jour='lundi' OR Jour='mercredi';

--10
SELECT Nom,Age,Sexe FROM INSCRIT WHERE (Age < 30 AND Sexe= 'F') OR (Age > 25 AND Sexe= 'H');

--11
SELECT * FROM PLANNING WHERE Jour IN ('lundi','mercredi','vendredi','Samedi');

--12
SELECT * FROM PLANNING WHERE Heure > 12 AND ((Lieu = 'salleII'  AND Jour='lundi') OR (Lieu = 'salleIII'  AND Jour='Vendredi'));

--13
SELECT * FROM COURS WHERE Enseignant IN ('Jean','Marie');

--14
SELECT * FROM COURS WHERE Enseignant NOT IN ('Jean','Marie');

--15 
SELECT * FROM INSCRIT WHERE Age BETWEEN 25 AND 30;

--16
SELECT * FROM COURS WHERE Enseignant IS NOT NULL;

--17
SELECT * FROM COURS WHERE Enseignant IS NULL;

--18
SELECT * FROM COURS WHERE Enseignant IS NULL OR Enseignant='Jean';

/*
19. Afficher les cours en ordre alphabétique, Afficher tous les attributs. 
20. Afficher les cours de niveau facile en ordre alphabétique, Afficher tous les attributs. 
21. Afficher les enseignants en ordre alphabétique et les cours qu’ils enseignent en ordre alphabétique.
*/

--19
SELECT * FROM COURS ORDER BY NomCours;

--20
SELECT * FROM COURS WHERE Niveau='Facile' ORDER BY NomCours;

--21
SELECT * FROM COURS ORDER BY Enseignant,NomCours;

/*
22. Afficher  les noms, numéro des cartes des inscrits et les cours auxquels ils participent. 
23. Afficher  les noms, numéro des cartes de tous les inscrits et les cours auxquels ils participent, s'ils participent quelque cours. 
24. Trouver  les cours auxquels est enregistré Bonnard. 
25. Trouver  les inscrits au cours de Natation I et les inscrits au cours de Natation II. Afficher tous les attributs des inscrits. 
26. Afficher nom, age des inscrits, nom des cours auxquels ils participent et niveau du cours. 
27. Comme la requête précédente, mais afficher nom et âge aussi pour les inscrits qui ne participent à aucun cours. 
28. Afficher  dans l'ordre: les enseignants, les cours qu'ils enseignent, les noms et sexe des inscrits. En ordre alphabétique par enseignant. 
29. Trouver  les noms des inscrits qui participent à un cours enseigné par Jean. Afficher noms et cours. 
30. Trouver les noms (et age) des inscrits qui ont la même age que Bonnard. 
31. Trouver les noms et age des inscrits plus vieux de Bonnard. 
32. Trouver les noms et numéro de carte des inscrits qui participent à (au moins) un cours auquel participe Bonnard.
*/

--22
SELECT Nom,INSCRIT.Nocarte,NomCours From INSCRIT,PARTICIPATION WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte;

SELECT Nom,INSCRIT.Nocarte,NomCours From INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte;

--23
SELECT Nom,INSCRIT.Nocarte,NomCours From INSCRIT LEFT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte;

--24
SELECT NomCours FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte WHERE Nom='Bonnard';

SELECT NomCours FROM INSCRIT,PARTICIPATION WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte AND Nom='Bonnard';

--25
SELECT INSCRIT.* FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte WHERE NomCours='NatationI' OR NomCours='NatationII';

SELECT INSCRIT.* FROM INSCRIT,PARTICIPATION WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte AND (NomCours='NatationI' OR NomCours='NatationII');

--26
SELECT Nom,Age,PARTICIPATION.NomCours,Niveau 
FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours;

SELECT Nom,Age,PARTICIPATION.NomCours,Niveau 
FROM INSCRIT,PARTICIPATION,COURS 
WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte AND PARTICIPATION.NomCours = COURS.NomCours;

--27
SELECT Nom,Age,PARTICIPATION.NomCours,Niveau 
FROM INSCRIT LEFT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte LEFT JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours;

--28
SELECT Enseignant,PARTICIPATION.NomCours,Nom,Sexe 
FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours
ORDER BY Enseignant;

SELECT Enseignant,PARTICIPATION.NomCours,Nom,Sexe
FROM INSCRIT,PARTICIPATION,COURS 
WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte AND PARTICIPATION.NomCours = COURS.NomCours
ORDER BY Enseignant;

--29
SELECT Nom,PARTICIPATION.NomCours
FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours
WHERE Enseignant='Jean';

SELECT Nom,PARTICIPATION.NomCours
FROM INSCRIT,PARTICIPATION,COURS 
WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte AND PARTICIPATION.NomCours = COURS.NomCours AND( Enseignant='Jean' );

--30
SELECT INSCRIT.Nom,INSCRIT.Age
FROM INSCRIT JOIN INSCRIT AS INSCRIT2 ON INSCRIT.Age = INSCRIT2.Age AND INSCRIT2.Nom='Bonnard';

SELECT INSCRIT.Nom,INSCRIT.Age
FROM INSCRIT,INSCRIT As INSCRIT2
WHERE INSCRIT.Age = INSCRIT2.Age AND INSCRIT2.Nom='Bonnard';

SELECT INSCRIT.Nom,INSCRIT.Age						--avec CROSS JOIN
FROM INSCRIT CROSS JOIN INSCRIT AS INSCRIT2
WHERE INSCRIT.Age = INSCRIT2.Age AND INSCRIT2.Nom='Bonnard';

SELECT Nom,Age										--avec sous requete
FROM INSCRIT
WHERE Age = (SELECT Age FROM INSCRIT WHERE Nom='Bonnard');

--31
SELECT INSCRIT.Nom,INSCRIT.Age						
FROM INSCRIT JOIN INSCRIT AS INSCRIT2 ON INSCRIT.Age > INSCRIT2.Age AND INSCRIT2.Nom='Bonnard';

SELECT INSCRIT.Nom,INSCRIT.Age						
FROM INSCRIT,INSCRIT As INSCRIT2
WHERE INSCRIT.Age > INSCRIT2.Age AND INSCRIT2.Nom='Bonnard';

SELECT INSCRIT.Nom,INSCRIT.Age						--avec CROSS JOIN
FROM INSCRIT CROSS JOIN INSCRIT AS INSCRIT2
WHERE INSCRIT.Age > INSCRIT2.Age AND INSCRIT2.Nom='Bonnard';

SELECT Nom,Age										--avec sous requete
FROM INSCRIT
WHERE Age > (SELECT Age FROM INSCRIT WHERE Nom='Bonnard');
--32

/*
SELECT DISTINCT INSCRIT.Nom,PARTICIPATION.Nocarte
FROM COUR AS COURS2 JOIN PARTICIPATION AS PARTICIPATION2 ON COUR2.NomCours = PARTICIPATION2.NomCours  JOIN INSCRIT AS INSCRIT2 ON INSCRIT2.Nocarte=PARTICIPATION2.Nocarte JOIN INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours,
JOIN INSCRIT
*/

/*
SELECT DISTINCT INSCRIT.Nom,PARTICIPATION.Nocarte
FROM INSCRIT,PARTICIPATION,COURS,INSCRIT AS INSCRIT2,PARTICIPATION AS PARTICIPATION2,COURS AS COURS2

WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte AND PARTICIPATION.NomCours = COURS.NomCours 
AND INSCRIT2.Nocarte = PARTICIPATION2.Nocarte AND PARTICIPATION2.NomCours = COURS2.NomCours AND INSCRIT2.Nom='Bonnard'
ORDER BY INSCRIT.Nom
*/



SELECT Nom,PARTICIPATION.Nocarte
FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours
WHERE COURS.NomCours IN (SELECT COURS.NomCours FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours WHERE INSCRIT.Nom='Bonnard')
ORDER BY INSCRIT.Nom

SELECT Nom,PARTICIPATION.Nocarte
FROM INSCRIT,PARTICIPATION,COURS 
WHERE INSCRIT.Nocarte = PARTICIPATION.Nocarte AND PARTICIPATION.NomCours = COURS.NomCours 
AND(COURS.NomCours IN (SELECT COURS.NomCours FROM INSCRIT JOIN PARTICIPATION ON INSCRIT.Nocarte = PARTICIPATION.Nocarte JOIN COURS ON PARTICIPATION.NomCours = COURS.NomCours WHERE INSCRIT.Nom='Bonnard'));

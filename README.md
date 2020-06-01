# Transport Optimal
 Essai de transport optimal pour le transfert de couleurs dans des images.

## Présentation
 Projet effectué lors de mon cursus en M1 Informatique à l'Université de Bourgogne.
 Le but du projet est de trouver le moyen le plus économique en ressource pour associer la palette de couleur d'une image 1 à une image 2.

 Ce repo contient 2 méthodes différentes pour effectuer cette opération.

##Transport via les niveaux de gris
 Le principe de fonctionnement de cet échange est très simple. Nous avons 2 images de départ, en couleur, que nous convertissons en niveaux de gris. Ensuite nous parcourons les pixels de chaque image classés en fonction de leur niveaux de gris (en partant des valeurs les plus faibles pour aller vers les plus élevées).
 Le code source et les images sources/résultat de cet algorithme sont disponibles dans le dossier “Niveaux_Gris”.

##Transport Optimal
 Ce code se base sur le code déjà existant à cette adresse : http://www.numerical-tours.com/matlab/optimaltransp_1_linprog/?fbclid=IwAR2EH-58NalMx_Fz7y43fG_VeKPtgb58BEMrn3qHgJGa55UWQdQkm6FV9dM
 Le programme de base permet de trouver les permutations optimales entre 2 nuages de point dans un espace 2D.
 J'ai adapté le code pour qu'il fonctionne dans un espace en 3 dimensions (où les axes sont les valeurs des composantes RGB des pixels de nos images).
 Le code source et les images sources/résultat de cet algorithme sont disponibles dans le dossier “Echange_Optimal”.

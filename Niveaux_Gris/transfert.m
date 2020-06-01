function Ires = transfert(I,I2)

%image résultat
Ires=I;
Ires = 0*Ires;

%conversion en NG
IN = rgb2gray(I);
IN2 = rgb2gray(I2);

%on récupère la taille
[m,n] = size(IN);

%création des tableaux couleurs
tabI2 = zeros(m*n, 5);
tabres = zeros(m*n, 3);

%remplissage du tableau 2
for i= 1:m
    for j = 1:n
        tabI2((i-1)*m +j , 1) =  i;
        tabI2((i-1)*m +j , 2) =  j;
        tabI2((i-1)*m +j , 3) =  I2(i,j,1);
        tabI2((i-1)*m +j , 4) =  I2(i,j,2);
        tabI2((i-1)*m +j , 5) =  I2(i,j,3);  
    end
end

%création du vecteur NG pour rechercher le min facilement
vectI = zeros(m*n,1);
vectI2 = zeros(m*n,1);

%remplissage des vecteurs
for i= 1:m
    for j = 1:n
        vectI((i-1)*m +j) =  IN(i,j);  
    end
end

for i= 1:m
    for j = 1:n
        vectI2((i-1)*m +j) =  IN2(i,j);  
    end
end

%boucle principale
for i = 1:m*n
    
    %on récupère les minimas et leurs indices
    minimaI= min(vectI); %plus petit NG dans I
    minimaI2 = min(vectI2); %plus petit NG dans I2
    
    Imin = find(vectI==minimaI);
    I2min = find(vectI2==minimaI2);
    
    %on récupère la couleur correspondante dans I2
    coul2 = zeros(1,3);
    coul2(1,1)= tabI2(I2min(1), 3);
    coul2(1,2)= tabI2(I2min(1), 4);
    coul2(1,3)= tabI2(I2min(1), 5);
    
    %on l'inscrit dans le tableau résultat à l'indice du minima de I
    tabres(Imin(1), 1)= coul2(1);
    tabres(Imin(1), 2)= coul2(2);
    tabres(Imin(1), 3)= coul2(3);
    
    %on passe les 2 ng à des valeurs +++
    vectI(Imin(1))=999;
    vectI2(I2min(1))=999;
    
    
    
end

%reconstruire l'image à partir du tableau résultat
for i = 1:m
    for j = 1:n
        Ires(i,j,1) = tabres((i-1)*m +j , 1);
        Ires(i,j,2) = tabres((i-1)*m +j , 2);
        Ires(i,j,3) = tabres((i-1)*m +j , 3);
    end
end

figure
imshow(Ires);
 
end


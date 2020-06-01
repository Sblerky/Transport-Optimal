I1=imread('images/sprite1_10.jpg');
I2=imread('images/sprite2_10.jpg');
getd = @(p)path(p,path);
getd('toolbox_signal/');
getd('toolbox_general/');
flat = @(x)x(:);
Cols = @(n0,n1)sparse( flat(repmat(1:n1, [n0 1])), ...
             flat(reshape(1:n0*n1,n0,n1) ), ...
             ones(n0*n1,1) );
Rows = @(n0,n1)sparse( flat(repmat(1:n0, [n1 1])), ...
             flat(reshape(1:n0*n1,n0,n1)' ), ...
             ones(n0*n1,1) );
Sigma = @(n0,n1)[Rows(n0,n1);Cols(n0,n1)];

maxit = 1e10; tol = 1e-9;
otransp = @(C,p0,p1)reshape( perform_linprog( ...
        Sigma(length(p0),length(p1)), ...
        [p0(:);p1(:)], C(:), 0, maxit, tol), [length(p0) length(p1)] );

[k1,l1,can1]=size(I1);
[k2,l2,can2]=size(I2);
n0 = k1*l1;
n1 = k2*l2;
[k1,l1,can1]=size(I1);
[k2,l2,can2]=size(I2);
X0=zeros(can1,n0);
X1=zeros(can2,n1);
X2=X0;
res=I1;

for o=1:k1
  for p=1:l1
    X0(1,(o-1)*k1 +p) =  I1(o,p,1);
    X0(2,(o-1)*k1 +p) =  I1(o,p,2);
    X0(3,(o-1)*k1 +p) =  I1(o,p,3);
  end
end

for o=1:k2
  for p=1:l2
    X1(1,(o-1)*k2 +p) =  I2(o,p,1);
    X1(2,(o-1)*k2 +p) =  I2(o,p,2);
    X1(3,(o-1)*k2 +p) =  I2(o,p,3);
  end
end


p0 = ones(n0,1)/n0;
p1 = ones(n1,1)/n1;
C = repmat( sum(X0.^2)', [1 n1] ) + ...
    repmat( sum(X1.^2), [n0 1] ) - 2*X0'*X1;

myplot = @(x,y,z,ms,col)plot3(x,y,z, 'o', 'MarkerSize', ms, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col, 'LineWidth', 2);    

clf; hold on;
myplot(X0(1,:), X0(2,:), X0(3,:), 10, 'b');
myplot(X1(1,:), X1(2,:), X1(3,:), 10, 'r');
axis equal; axis off;

gamma = otransp(C,p0,p1);


clf; hold on;
[I,J,~] = find(gamma);
for k=1:length(I)
    h = plot3( [X0(1,I(k)) X1(1,J(k))], [X0(2,I(k)) X1(2,J(k))],[X0(3,I(k)) X1(3,J(k))], 'k' );
    X2(1,I(k))=X1(1,J(k));
    X2(2,I(k))=X1(2,J(k));
    X2(3,I(k))=X1(3,J(k));
    set(h, 'LineWidth', 2);
end

for o=1:k1
  for p=1:l1
    res(o,p,1)=X2(1,(o-1)*k1 +p);
    res(o,p,2)=X2(2,(o-1)*k1 +p);
    res(o,p,3)=X2(3,(o-1)*k1 +p);
  end
end


myplot(X0(1,:), X0(2,:), X0(3,:), 10, 'b');
myplot(X1(1,:), X1(2,:), X1(3,:), 10, 'r');
axis equal; axis off;
rotate3d on;

figure
imshow(res);
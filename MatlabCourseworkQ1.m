p = 535051919;
a = 255549557;
v = 407518506;

%Q1(a)

X = 20:40; % g is greater than 20
valuesTrueFalse = isPrimitiveRoot(X,p);
values = X(valuesTrueFalse); % Finds all values of primitive roots mod p
g = values(1,1) % returns smallest value only

%Q1(b)

u = powermod(g,a,p) % The number sent to Bob
k = powermod(v,a,p) % The shared key k
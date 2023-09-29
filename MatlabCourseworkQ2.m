%Q2(a)

p = 5519;
q = 89;
g = 2835;
y = 4716; 
H = 41;

r = 0;
s = 1;
total = 0; %variable to hold value of number of valid signatures.

for r = 0:q-1 %iterate s from 1 to q-1 for each value of r (r is between 0 and q-1)
    for s = 1:q-1
        a = powermod(s,-1,q); %calculate the multiplicative inverse
        u1 = a*H; %Solve s*u1 = H mod q
        u2 = a*r;

        v1 = powermod(g,u1,p);% get remainder from g^u1 mod p
        v2 = powermod(y,u2,p);

        %check if value of (g^u1*y^u2 mod p) mod q is equivalent to r
        if mod(mod(v1*v2,p),q) == r
            total = total + 1;
            if r < 6 %output all valid signatures for r = 0:5
                fprintf('(%d,%d)',r,s)
            end
        end

    end
end
%output total number of valid signatures
fprintf('Total number of valid signatures is: %d',total)

%Q2(b): The total number of valid signatures is 87 which is approximately
%equal to the value of q. This could reflect that the number of valid
%signatures is proportional to the value of q.
% Therefore we could state that the probability we find a
%pair (r_i,s) is a valid signature, is 1 as we have approximated
%that each value of r has 1 valid signature. Therefore the probability that
%the pair (r_i,s_i) has a valid signature would be 1/q.
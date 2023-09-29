%Q3(a)
S= sym('10875128'); % My student ID number

p = sym(14*S^4+1); % p is a number larger than 14*S^4
i = 0;

while i == 0 % Iterate through the loop until just one from 2 or 3 is a primitive root.
    p = nextprime(sym(p));
    if isPrimitiveRoot(2,p) == 1 && isPrimitiveRoot(3,p) == 0
        i = 1;
    elseif isPrimitiveRoot(2,p) == 0 && isPrimitiveRoot(3,p) == 1
        i = 1;
    else % If both are primitive roots, find the next prime number.
        p = nextprime(p+1);
    end
end
p % output p

q = sym(12*S^5-1); % q is a number smaller than 12*S^5
j = 0;

while j == 0 % Iterate until prime is found which has the same last 3 digits.
    q = prevprime(sym(q)); % Find prime previous to q
    g = mod(sym(q),1000); % Finds remainder when 1000 divides q
    if mod(sym(q),10) == g/111 % checks if last 3 digits are the same.
        j = 1; % If last 3 digits are the same, exit loop.
    else
        q = q-1;% if last 3 digits are not same, decrease value of q by 1
    end
end
q %output q

e = 65537; % public key
d = powermod(e,-1,(p-1)*(q-1)) % private key

%Q3(b)
% Assigns values of p, q and d (taken from Q3(a))
p = sym('195823831997733803169326096579');
q = sym('1825379347222157845194194547356857333');
d = sym('152783423635126511384430325820209010872333102978376129029237363169');

% Assigns messages from Table 3 to msg1 and msg2
msg1 = sym('249356645873428297827032683554892722514808207900961744929396123041');
msg2 = sym('8845326369659643195951370548553050478080439218964924461046426522');

% Decrypt msg1 and msg2.
dcmsg1 = powermod(msg1,d,p*q)
dcmsg2 = powermod(msg2,d,p*q)








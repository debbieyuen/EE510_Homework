function invs = CreateInverse(p)
%CREATEINVERSE Return a vector invs where invs(a) = a^{-1} mod p for a=1..p-1
% Assumes p is prime.

    invs = zeros(1, p-1);
    for a = 1:p-1
        invs(a) = modInverse(a, p);
    end
end

function inv = modInverse(a, p)
% Extended Euclidean Algorithm to compute modular inverse of a mod p

    t = 0; newt = 1;
    r = p; newr = mod(a, p);

    while newr ~= 0
        q = floor(r / newr);
        [t, newt] = deal(newt, t - q*newt);
        [r, newr] = deal(newr, r - q*newr);
    end

    if r ~= 1
        error('%d has no inverse modulo %d', a, p);
    end

    inv = mod(t, p);
end

function invs = CreateInverse(p)
    invs = zeros(1, p-1);
    for i = 1:p-1
        invs(i) = modInverse(i, p);
    end
end

function inv = modInverse(a, p)
    t = 0; newt = 1;
    r = p; newr = a;
    while newr ~= 0
        q = floor(r / newr);
        [t, newt] = deal(newt, t - q*newt);
        [r, newr] = deal(newr, r - q*newr);
    end
    if r > 1
        error('%d has no inverse modulo %d', a, p);
    end
    if t < 0
        t = t + p;
    end
    inv = t;
end

%% Test Cases for answers (a)–(e)

% (a) p = 5
inv5 = CreateInverse(5);
disp('CreateInverse(5) ='); disp(inv5)

% (b) p = 13
inv13 = CreateInverse(13);
disp('CreateInverse(13) ='); disp(inv13)

% (c) p = 17
inv17 = CreateInverse(17);
disp('CreateInverse(17) ='); disp(inv17)

% Quick verification for a–c:
assert(all(mod((1:4).*inv5,5)==1), 'Check failed for p=5');
assert(all(mod((1:12).*inv13,13)==1), 'Check failed for p=13');
assert(all(mod((1:16).*inv17,17)==1), 'Check failed for p=17');

% (d) In F_101: 2^{-1}, 11^{-1}, 42^{-1}
inv101 = CreateInverse(101);
inv2_101  = inv101(2);    % because invs(i) = i^{-1}
inv11_101 = inv101(11);
inv42_101 = inv101(42);
fprintf('In F_101: 2^{-1}=%d, 11^{-1}=%d, 42^{-1}=%d\n', inv2_101, inv11_101, inv42_101);
assert(mod(2*inv2_101,101)==1 && mod(11*inv11_101,101)==1 && mod(42*inv42_101,101)==1);

% (e) In F_103: 2^{-1}, 11^{-1}, 42^{-1}
inv103 = CreateInverse(103);
inv2_103  = inv103(2);
inv11_103 = inv103(11);
inv42_103 = inv103(42);
fprintf('In F_103: 2^{-1}=%d, 11^{-1}=%d, 42^{-1}=%d\n', inv2_103, inv11_103, inv42_103);
assert(mod(2*inv2_103,103)==1 && mod(11*inv11_103,103)==1 && mod(42*inv42_103,103)==1);

% Export results into a file
fileID = fopen('all_inverses.txt','w');
fprintf(fileID, 'CreateInverse(5)  = [%s]\n', num2str(inv5));
fprintf(fileID, 'CreateInverse(13) = [%s]\n', num2str(inv13));
fprintf(fileID, 'CreateInverse(17) = [%s]\n', num2str(inv17));
fprintf(fileID, 'In F_101: 2^-1=%d, 11^-1=%d, 42^-1=%d\n', inv101(2), inv101(11), inv101(42));
fprintf(fileID, 'In F_103: 2^-1=%d, 11^-1=%d, 42^-1=%d\n', inv103(2), inv103(11), inv103(42));
fclose(fileID);
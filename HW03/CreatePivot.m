function Rnew = CreatePivot(R, i, j, p, invs)
%CREATEPIVOT Perform a single pivot at (i,j) over the finite field F_p.
%   Rnew = CreatePivot(R, i, j, p, invs)
%   - R is the input matrix
%   - (i,j) is the pivot position (1-based)
%   - p is a prime modulus
%   - invs is a row vector where invs(a) = a^{-1} mod p for a = 1..p-1

    Rnew = mod(R, p);                 % reduce entries mod p
    pivot = Rnew(i, j);
    if pivot == 0
        error('Pivot at (%d,%d) is zero modulo %d.', i, j, p);
    end

    % Scale row i so the pivot becomes 1
    theta = invs(pivot);              % modular inverse of pivot
    Rnew(i, :) = mod(theta * Rnew(i, :), p);

    % Eliminate column j in all other rows
    for r = 1:size(Rnew, 1)
        if r ~= i
            f = Rnew(r, j);
            if f ~= 0
                Rnew(r, :) = mod(Rnew(r, :) - f * Rnew(i, :), p);
            end
        end
    end
end

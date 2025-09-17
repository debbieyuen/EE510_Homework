% CreatePivotHW3.m
% Runs the four required cases:
% (a) R=R1, (i,j)=(2,3), p=7
% (b) R=R2, (i,j)=(2,2), p=103
% (c) R=R3, (i,j)=(1,1), p=2
% (d) R=R4, (i,j)=(3,2), p=3
%
% Writes a fresh, timestamped results file with side-by-side output.

clear; clc;

% Load R1..R4 from separate Data.m
Data;

% Make unique output file
filename = ['CreatePivot_results_' datestr(now,'yyyymmdd_HHMMSS') '.txt'];
fileID = fopen(filename,'w');

fprintf('=== PIVOT RESULTS ===\n');
fprintf(fileID, '=== PIVOT RESULTS ===\n');

cases = {
    struct('R', R1, 'i', 2, 'j', 3, 'p',   7, 'label','(a) R1, (i,j)=(2,3), p=7')
    struct('R', R2, 'i', 2, 'j', 2, 'p', 103, 'label','(b) R2, (i,j)=(2,2), p=103')
    struct('R', R3, 'i', 1, 'j', 1, 'p',   2, 'label','(c) R3, (i,j)=(1,1), p=2')
    struct('R', R4, 'i', 3, 'j', 2, 'p',   3, 'label','(d) R4, (i,j)=(3,2), p=3')
};

for k = 1:numel(cases)
    C = cases{k};
    fprintf('\n--- %s ---\n', C.label);
    fprintf(fileID, '\n--- %s ---\n', C.label);

    invs = CreateInverse(C.p);                     % compute inverses 1..p-1
    Rnew = CreatePivot(C.R, C.i, C.j, C.p, invs);  % do the pivot

    % Console
    disp('Original R:'); disp(C.R);
    disp('Rnew:');       disp(Rnew);

    % File (side-by-side)
    printSideBySide(C.R, Rnew, fileID);
end

fclose(fileID);
fprintf('\n✅ All results saved in %s\n', filename);

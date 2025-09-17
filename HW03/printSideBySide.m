function printSideBySide(R, Rnew, fileID)
%PRINTSIDEBYSIDE Write "R  ==>  Rnew" with aligned columns into an open file.

    [m1,n1] = size(R); [m2,n2] = size(Rnew);
    m = max(m1, m2);

    wL = 5;  % width per number on left
    wR = 5;  % width per number on right

    fprintf(fileID, 'R  ==>  Rnew\n');

    for r = 1:m
        % Left row
        if r <= m1
            left = sprintf(['%' num2str(wL) 'd'], R(r,1));
            for c = 2:n1
                left = [left, sprintf(['%' num2str(wL) 'd'], R(r,c))]; %#ok<AGROW>
            end
        else
            left = repmat(' ', 1, n1*wL);
        end

        % Right row
        if r <= m2
            right = sprintf(['%' num2str(wR) 'd'], Rnew(r,1));
            for c = 2:n2
                right = [right, sprintf(['%' num2str(wR) 'd'], Rnew(r,c))]; %#ok<AGROW>
            end
        else
            right = repmat(' ', 1, n2*wR);
        end

        fprintf(fileID, '%s   ==>   %s\n', left, right);
    end
end

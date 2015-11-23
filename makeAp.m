function [res, minuend, answer] = makeAp()
    %out is a cell array consisting of: 1. res (actually correct or not),
    %2. minuend, and 3. answer
    
    rand('twister', 100*sum(clock));
    
    %produces a random odd three-digit integer
    minuend = ceil(449*rand)*2 + 101; 
    wrong = rand < 0.5;
    res = 1;
    subtrahend = 3;
    if wrong == 1
        res = 0;
        dupes = [1, 5, 7, 9, -1, -3, -5, -7, -9];
        randIndx = ceil(length(dupes)*rand);
        subtrahend = dupes(randIndx);
    end
    
    answer = minuend - subtrahend;
end
function [res, minuend, answer] = makeAp()
    %out is a cell array consisting of: 1. res (actually correct or not),
    %2. minuend, and 3. answer
    
    rand('twister', 100*sum(clock));
    
    %produces a random odd three-digit integer
    minuend = ceil(449*rand)*2 + 101; 
    wrong = rand < 0.5;
    res = 1;
    subtrahend = 3;
    if wrong
        res = 0;
        offset = floor(5*rand)*2 + 1;
        if rand < 0.5
            offset = -offset;
        end
        subtrahend = offset;
    end
    
    answer = minuend - subtrahend;
end
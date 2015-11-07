function recallStim = getRecallStim(isCons, NR)
    %Takes in number of recall items and whether they
    %are consonants or not (digits), generates the appropriate
    %list of recall items
    
    %Really mixing it up
    rand('twister', 100*sum(clock));
    
    if isCons == 1
        cons = {'B', 'C', 'D', 'F', 'G', 'H', 'J',...
            'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S',...
            'T', 'V', 'W', 'X', 'Z'};
        [~, len] = size(cons);
        count = 1;
        stimCell = {};
        
        while len > 0 && count <= NR
           indx = ceil(len*rand);
           stimCell{count} = cons{indx};
           cons(:, indx) = [];  %remove the select consonant
           len = len - 1;
           count = count + 1;
        end
        
        recallStim = strjoin(stimCell, ' ');
        return;
    end
    
    %Otherwise the user input the digits
    len = 10;
    count = 1;
    
    stimCell = {};
    dig = {'0', '1', '2', '3', '4', '5',...
        '6', '7', '8', '9'};
        
    while len > 0 && count <= NR
       indx = ceil(len*rand);
       stimCell{count} = dig{indx};
       dig(:, indx) = [];  %remove the select consonant
       len = len - 1;
       count = count + 1;
    end

    recallStim = strjoin(stimCell, ' ');
    
end
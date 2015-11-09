function inputs = loadTestParamsFromFile(file)
%Loads the test params from file to the opening screen
    fid = fopen(file, 'r');
    if fid == -1
        inputs = {};
        %errordlg('Cannot load file!');
        return;
    end
    
    size = 8;
    inputs = cell(1, size);
    for i = 1:size
        inputs{i} = fgetl(fid);
    end
    
    fclose(fid);
end


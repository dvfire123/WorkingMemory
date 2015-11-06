function fileName = saveTestParamsToFile(folder, inputs)
    %Save the inputs into test params file
    fn = inputs{1};
    ln = inputs{2};
    fileName = sprintf('%s-%s.wmtp', fn, ln);
    file = fullfile(folder, fileName);
    
    fid = fopen(file, 'wt+');
    
    for i = 1:8
       fprintf(fid, '%s\n', inputs{i});
    end
    
    fclose(fid);
end
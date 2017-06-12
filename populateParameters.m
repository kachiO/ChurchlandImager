function populateParameters(hlistbx,paramstruct)
%%-obsolete

paramNames = fieldnames(paramstruct); %field names of each parameter
paramVals = struct2cell(paramstruct);  %parameter val

numParams = numel(paramVals);

uflag = isfield(paramstruct,'Units'); 

if uflag
    numParams = numParams - 1;
    units = paramstruct.Units;
end

paramsToPop = cell(numParams,1);



for i = 1:numParams
    
    parameter = paramVals{i};
%     parameter = eval(['paramstruct.' paramNames{i}]);
    
    if uflag
        paramsToPop{i} = [paramNames{i} ':    ' num2str(parameter) ' ' units{i}];
    else
        paramsToPop{i} = [paramNames{i} ':    ' num2str(parameter) ' '];
    end
    
    
end



set(hlistbx,'String',paramsToPop);



end
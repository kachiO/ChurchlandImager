function saveSyncAnalogInput(src,event)
%Kachi version of saveSyncs.m
%Created oct-22-2015

% global Mstate trialno datadirectory sessionDate syncFileID syncFileName
global  syncFileID %syncFileName

% fileName = fullfile(datadirectory,[lower(Mstate.anim) '_' sessionDate '_' Mstate.expt '_' num2str(trialno) '_syncData.bin']); %filename
% if ~isdir(fileName)
%     fileID = fopen(fileName,'a'); %open file to write data & append
%     syncFileID = fileID;
% end

data = [event.TimeStamps, event.Data]'; %add the timestamp and data values
fwrite(syncFileID,data,'double');

% syncFileName = fileName;


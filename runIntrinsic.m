function runIntrinsic
%equivalent to run2.m from Callaway lab

global GUIhandles Mstate trialno  imagerhandles analogIN datadirectory sessionDate syncFileID syncFileName 


vidObj = imagerhandles.vidObj;
P = getParamStruct;

if Mstate.running %otherwise 'getnotrials' won't be defined for play sample
    nt = getnotrials;
    
end

% ISIbit =  get(GUIhandles.main.intrinsicflag,'value');

if Mstate.running && trialno<=nt  %'trialno<nt' may be redundant.
    
    set(GUIhandles.main.showTrial,'string',['Trial ' num2str(trialno) ' of ' num2str(nt)] ), drawnow
      
    [c, r] = getcondrep(trialno);  %get cond and rep for this trialno%
    
%     syncFileName = fullfile(datadirectory,[lower(Mstate.anim) '_' sessionDate '_' Mstate.expt '_' num2str(trialno) '_syncData.bin']); %filename
%     fileID = fopen(syncFileName,'a'); %open file to write data & append
%     syncFileID = fileID;
%     listenerHandle = addlistener(analogIN,'DataAvailable',@(src,event)saveSyncAnalogInput(src,event)); %create listener for acquiring in background
%     analogIN.startBackground  %Start sampling acquistion for stimulus syncs
    
    %%%Organization of commands is important for timing in this part of loop
    buildStimulus(c,trialno)    %Tell stimulus to buffer the images
    waitforDisplayResp   %Wait for serial port to respond from display
   
    startStimulus      %Tell Display to show its buffered images. TTL from stimulus computer "feeds back" to trigger 2ph acquisition
    sendtoIntrinsicImager(sprintf(['S %d' 13],trialno-1)) %start camera acquisition

%     analogIN.stop  %Stop sampling acquistion of stimulus syncs
%     delete(listenerHandle); %delete listener handle
%     fclose(syncFileID); %close file
    
    trialno = trialno+1;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    stop(vidObj);  flushdata(vidObj);  %stop camera if running,clear data and delete callback function
    
    Mstate.running = 0;
    set(GUIhandles.main.runbutton,'string','Run')
    
    error('session terminated')
    
end



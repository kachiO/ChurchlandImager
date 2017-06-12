function sendtoIntrinsicImager(cmd)
%modified from Callaway lab code to send parameters to IntrinsicImager GUI
%similar to sendtoImager.m

%cmd is a string/text

global imagerhandles datadirectory trialno looperInfo Mstate
global TrialFrames TrialTimeStamps sessionDate GUIhandles digitalOut imagingMode

vidObj = imagerhandles.vidObj;

switch(cmd(1))  %switch first letter of stringle
    case 'A'  %% animal
        set(findobj('Tag','animaltxt'),'String',deblank(cmd(3:end)));
        set(findobj('Tag','animaltxt'),'Enable','off');
        
        %         deblank(cmd(3:end))
        
    case 'E' %% expt
        set(findobj('Tag','expttxt'),'String',num2str(deblank(cmd(3:end))));
        set(findobj('Tag','expttxt'),'Enable','off');
        
    case 'I'  %% set acquire time
        acqtime = deblank(cmd(3:end));
        
        %update framesPertrigger
        stop(vidObj);
        framestograb = ceil(Mstate.framerate*str2double(acqtime));
        set(vidObj,'FramesPerTrigger',framestograb);
 
    case 'S'  %% start sampling...
       
        trial = num2str(trialno);
        
        stop(vidObj);
        flushdata(vidObj,'all'); %clear memory 
        
        animal = get(findobj('Tag','animal'),'String');
        expt   = get(findobj('Tag','exptcb'),'String');
        
        cd(datadirectory)
        filename =  [lower(animal) '_' sessionDate '_' expt '_' trial '_data.mat'];
        IntrinsicData = struct;

        start(vidObj);%start acquisition
        
        while islogging(vidObj)
            %wait for camera to finish capturing frames
            set(findobj('Tag','cameraStatus'),'String','Acquiring...');drawnow

        end
        set(findobj('Tag','cameraStatus'),'String','Done Acquiring...');drawnow
        
        P = getParamStruct;
   
        numacquired = get(vidObj,'FramesAcquired');
        %grab data from camera frame grabber
        [ImageData,TimeStamps,meta] = getdata(vidObj,numacquired);
        ImageData = squeeze(ImageData);
        
        %turn off LED
        if strcmpi(imagingMode,'gcamp')
            if ~isempty(digitalOut)
                outputSingleScan(digitalOut,0); %switch blue light off if NI device is available
                pause(P.TrialInterval);
            end
        end
        %ImageData = reBinImageSequence(ImageData,Mstate.framerate,Mstate.binFrameRate);    %bin and average data...this function might not be working 6/23/2015
        %resize image data
        
        if Mstate.spatialBinFactor ~=1
            ImageData = imresize(ImageData,1/Mstate.spatialBinFactor,'bilinear');
            %         ImageData = Widefield_ShrinkStack_v1(ImageData,Mstate.spatialBinFactor,Mstate.binFrameRateFactor);
        end
        
        [c r] = getcondrep(trialno);
        
        stimParameter = looperInfo.conds{c}.symbol;
        stimParamVal = looperInfo.conds{c}.val;
        P = getParamStruct;
            
        %save workspace variables to file
        IntrinsicData.data = ImageData;
        IntrinsicData.timestamps = TimeStamps;
        IntrinsicData.meta = meta;
        IntrinsicData.trialNo = trialno;
        IntrinsicData.stimParam = cell2mat(stimParameter);
        IntrinsicData.stimParamVal = cell2mat(stimParamVal);
        IntrinsicData.preStimTime = P.PreStimDelay;
        IntrinsicData.StimTime =  P.StimDuration;
        IntrinsicData.postStimTime = P.PostStimDelay;
        
        disp(['Trial #:' trial])
        IntrinsicData
        whos('IntrinsicData')
        
        save(filename,'IntrinsicData')  
        
        checkFileSaved = exist(filename,'file') == 2;  %gives one or zero if file is saved 
        
        if ~checkFileSaved || isempty(ImageData)
            %abort session.
            Mstate.running = 0;
            set(GUIhandles.main.runbutton,'string','Run')
            error('Image data from this trial not saved. Please check select size of ROI or reselect ROI again. Aborting session...')
            
        else
            disp (['Trial saved as: ' filename ])
        end
        
        TrialTimeStamps = TimeStamps;
        TrialFrames = ImageData;
        
        flushdata(vidObj,'all'); %clear memory and

        stop(vidObj);
       
end



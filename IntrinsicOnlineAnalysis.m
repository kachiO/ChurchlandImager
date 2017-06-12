function IntrinsicOnlineAnalysis(c,r)

global TrialFrames TrialFrameTimes looperInfo F1 GUIhandles Mstate trialno
 
if get(GUIhandles.main.onlinedIoIFlag,'value')
    
    P = getParamStruct;
    preStimTime = P.PreStimDelay;
    StimTime =  P.StimDuration;
    frameRate = Mstate.binFrameRate;
    
    prestim_ind = 1:floor(preStimTime*frameRate);
    stim_ind = floor(preStimTime*frameRate)+1:floor(preStimTime*frameRate)+ floor(StimTime*frameRate);
    
    rescaleImg = 1.5;
    TrialFrames = imresize(TrialFrames,(1/rescaleImg));
    [imgH,imgW,imgF] = size(TrialFrames);
    thisTrialData = double(reshape(TrialFrames,prod([imgW,imgH]),imgF));
    
    meanbaseline = mean(thisTrialData(:,prestim_ind),2);
    meanbaseline = repmat(meanbaseline,1,imgF);
    dI = thisTrialData - meanbaseline;
    dIoI = 100*(dI ./ meanbaseline);
    meanStimdIoI = mean(dIoI(:,stim_ind),2);
    meanStimdIoIimg= reshape(meanStimdIoI,imgH,imgW);
    figTodisplay = meanStimdIoIimg;
    
    figure(99);
    stimParamName = looperInfo.conds{c}.symbol;
    stimParamVal = looperInfo.conds{c}.val;
    colormap(gray)
    
    conditionTitle = ['Trial #' num2str(trialno) ','];
%     for i = 1:size(stimParamName,2)
%         conditionTitle = [conditionTitle stimParamName '= ' (stimParamVal) ', ']
%     end
%     
    imshow(figTodisplay,[]);drawnow;colorbar;title(conditionTitle);axis off; drawnow

end

if get(GUIhandles.main.onlineFourierFlag,'value')
%     Grabtimes = TrialFrameTimes;
%     %Stimulus starts on 2nd sync, and ends on the second to last.  I also
%     %get rid of the last bar rotation (dispSyncs(end-1)) in case it is not an integer multiple
%     %of the stimulus trial length
%     Disptimes = syncInfo.dispSyncs(2:end-2); 
% 
%     %T = getparam('t_period')/60;
%     T = mean(diff(Disptimes)); %This one might be more accurate
% 
%     fidx = find(Grabtimes>Disptimes(1) & Grabtimes<Disptimes(end));  %frames during stimulus
% 
%     framest = Grabtimes(fidx)-Disptimes(1);  % frame sampling times in sec
%     frameang = framest/T*2*pi;
%     
%     k = 1;
%     for j=fidx(1):fidx(end)
%         
%         img = 4096-double(TrialFrames(:,:,j));
%      
%         if j==fidx(1)
%             acc = zeros(size(img));
%         end
% 
%         acc = acc + exp(1i*frameang(k)).*img;
% 
%         k = k+1;
% 
%     end
%     
%     F0 = 4096-double(mean(TrialFrames(:,:,fidx(1):fidx(2)),3));
%     
%     acc = acc - F0*sum(exp(1i*frameang)); %Subtract f0 leakage
%     acc = 2*acc ./ (k-1);
% 
% 
%     if r == 1
%         F1{c} = acc;
%     else
%         F1{c} = F1{c} + acc;
%     end

%     nc = length(looperInfo.conds);
%     figure(99)
%     subplot(1,nc,c), imagesc(angle(F1{c})), drawnow    

end



TrialFrames = TrialFrames*0;
TrialFrameTimes = TrialFrameTimes*0;
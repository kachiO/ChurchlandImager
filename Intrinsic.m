
function Intrinsic
clc
% fclose(instrfindall)

global IntrinsicFlag  
IntrinsicFlag = 1; %global flag to indicate intrinsic session

%Initialize stimulus parameter structures
configurePstate('DG')
configureMstate
configureLstate

%Host-Host communication
configDisplayCom    %stimulus computer

%NI USB input for ISI acquisition timing from frame grabber
InitializeDaq %no longer needed Oct 21 2015
% configSyncInput  
% configSyncAnalogInput


%configEyeShutter

%Open GUIs
IntrinsicMainWindow
IntrinsicLooper 
IntrinsicparamSelect


% imagerGUIhandle = IntrinsicImager;



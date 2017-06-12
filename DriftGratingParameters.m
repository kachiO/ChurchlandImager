function DriftGratingParameters
%%%obsolete 20-Feb-2014------
%Kachi Odoemene. adapted from Ian Nauhaus
% 19-Feb-2014
% Visual Stimulus parameters - drifting grating

%periodic grater

global VisualParams
%default parameters
VisualParams = struct; %clear it

VisualParams.StimType = 'DG';  
VisualParams.PreStimDelay = 2; %seconds
VisualParams.StimDuration = 1; %seconds
VisualParams.PostStimDelay = 2; %seconds
VisualParams.XPos = 940; %pixels
VisualParams.YPos = 700; %pixels
VisualParams.StimSize = 300; %pixels
VisualParams.Mask = 0; % 0 -no mask, 1-disc, 2-guassian 
VisualParams.Angle = 90; % deg, can specify more than one angle
VisualParams.RotateAngles = 0; %deg, flag for changing angles within stimulus period
VisualParams.RotatePeriod = 1;  %rotate angles every X seconds during stimulus period
VisualParams.SpatialFreq = 0.05; %cycles/deg
VisualParams.TemporalFreq = 2; %cycles/sec
VisualParams.Background = 128;
VisualParams.Contrast = 100; % percent

%Flags for co-presentation of other sensory stimuli
VisualParams.SoundFlag = 0;
VisualParams.WhiskerFlag = 0;

%this is not necessary, more so for aesthetics
%If included, should be at the last item!!
VisualParams.Units = {'';'sec';'sec';'sec';...
                        'pixels';'pixels';'pixels';'';...
                        'deg';'deg';'sec';'cyc/deg';'cyc/sec';...
                        '';'%';'';''};




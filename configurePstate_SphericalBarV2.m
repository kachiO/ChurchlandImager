function configurePstate_SphericalBarV2

%adapted from original author: Ian Nauhaus
%Kachi version

%drifting bar

global Pstate

Pstate = struct; %clear it

Pstate.type = 'SB2';

Pstate.param{1} = {'PreStimDelay'       'float'     2           0          'sec'};
Pstate.param{2} = {'StimDuration '      'float'     306         0          'sec'};
Pstate.param{3} = {'PostStimDelay'      'float'     0           0          'sec'};

Pstate.param{4} = {'NumCycles'          'int'       30          0          ''}; %number of cycles

Pstate.param{5} = {'BarThickness'       'int'       5           0          'degree'};
Pstate.param{6} = {'BarOrient'          'int'       1           0          ''}; %1 = horizontal, 0 = vertical
Pstate.param{7} = {'BarDirection'       'int'       1           0          ''};  %forward=1, reverse = -1


Pstate.param{8} = {'BarType'            'string'    'noise'     0          ''}; %acceptable parameters= 'noise','checks','none'
Pstate.param{9} = {'MaxTFreq'           'float'     5           0          'Hz'}; %temporal frequency cutoff
Pstate.param{10} = {'TFreqSigma'        'float'     5         0          ''}; %sigma for temporal frequency 
Pstate.param{11} = {'MaxSFreq'          'float'     0.16        0          'cpd'}; %spatial frequency cutoff
Pstate.param{12} = {'BinaryNoiseFlag'   'int'       1           0          ''}; %flag for binary noise
Pstate.param{13} = {'CheckSize'         'int'       10          0          'deg'}; %size of checkerboard squares
Pstate.param{14} = {'RandomChecks'      'int'       1          0           ''}; %flag to determine whether to flicker

Pstate.param{15} = {'BackgroundColor'   'int'       128         0          ''}; %128=gray; 0 = black; 255 = whote
Pstate.param{16} = {'eyeXLocation'      'float'     25.922      0          'cm'}; %location of the eye on the x screen location
Pstate.param{17} = {'eyeYLocation'      'float'     16.225      0          'cm'}; %location of the eye on the y screen location 

Pstate.param{18} = {'ScreenScaleFactor' 'int'       1           0          ''}; %scale factor to reduce screen pixels for interpolation 
Pstate.param{19} = {'sphereCorrectON'   'int'       0           0          ''}; %decide whether to implement spherical correction

Pstate.param{20} = {'TrialInterval'     'int'       10          0          'secs'}; 
Pstate.param{21} = {'contrast'          'int'       1           0          ''}; %necessary for blank trials!!!


                    
                    
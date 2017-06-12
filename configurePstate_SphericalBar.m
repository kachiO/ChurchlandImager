function configurePstate_SphericalBar

%adapted from original author: Ian Nauhaus
%Kachi version

%drifting bar

global Pstate

Pstate = struct; %clear it

Pstate.type = 'SB';

Pstate.param{1} = {'PreStimDelay'   'float'     2       0                'sec'};
Pstate.param{2} = {'StimDuration '  'float'     306      0                'sec'};
Pstate.param{3} = {'PostStimDelay'  'float'     0       0                'sec'};

Pstate.param{4} = {'BarThickness'   'float'      5        0               'degree'};
Pstate.param{5} = {'BarOrient'      'int'        1        0                ''}; %1 = horizontal, 0 = vertical
Pstate.param{6} = {'BarDirection'   'int'       1        0                ''};  %start location, 0 equal screen center
Pstate.param{7} = {'NumCycles'      'int'       30        0                ''}; %number of cycles

Pstate.param{8} = {'CheckSize'      'float'       20        0                'deg'}; %size of checkerboard squares
Pstate.param{9} = {'FlickerRate'   'float'       4         0                'Hz'}; 

Pstate.param{10} = {'contrast'      'int'      1        0                ''}; %necessary for blank trials!!!
Pstate.param{11} = {'TrialInterval' 'int'      10       0                'secs'}; 

Pstate.param{12} = {'eyeXLocation' 'int'     25.922        0                'cm'}; %location of the eye on the x screen location
Pstate.param{13} = {'eyeYLocation' 'int'     16.225       0                'cm'}; %location of the eye on the y screen location 

Pstate.param{14} = {'ScreenScaleFactor' 'int'     1       0                ''}; %scale factor to reduce screen pixels for interpolation 
Pstate.param{15} = {'sphereCorrectON'   'int'     0        0                ''}; %decide whether to implement spherical correction



                    
                    
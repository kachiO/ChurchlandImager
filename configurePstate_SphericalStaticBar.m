function configurePstate_SphericalStaticBar

%adapted from original author: Ian Nauhaus
%Kachi version

%static bar version

global Pstate

Pstate = struct; %clear it

Pstate.type = 'SSB';

Pstate.param{1} = {'PreStimDelay'           'float'     2       0                'sec'};
Pstate.param{2} = {'StimDuration '          'float'     4      0                'sec'};
Pstate.param{3} = {'PostStimDelay'          'float'     8       0                'sec'};

Pstate.param{4} = {'BarSize'                'int'       10        0               'degrees'}; %thickness of bar in degrees
Pstate.param{5} = {'BarOrient'              'int'       1        0               ''}; %1 = horizontal, 0 = vertical
Pstate.param{6} = {'Azimuth'       'int'       0        0               'degrees'};  % center X location of bar
Pstate.param{7} = {'Elevation'     'int'       10        0              'degrees'}; % center Y location of bar

Pstate.param{8} = {'CheckSize'              'int'       10        0              'degrees'}; %size of checkerboard squares
Pstate.param{9} = {'FlickerRate'            'int'       4         0                ''}; 

Pstate.param{10} = {'contrast'              'int'       1        0                ''}; %necessary for blank trials!!!
Pstate.param{11} = {'TrialInterval'         'int'       6       0                'secs'}; 
    
Pstate.param{12} = {'eyeXLocation'          'int'       21.5        0                'cm'}; %location of the eye on the x screen location
Pstate.param{13} = {'eyeYLocation'          'int'       8       0                'cm'}; %location of the eye on the y screen location 

Pstate.param{14} = {'ScreenScaleFactor'     'int'       1       0                ''}; %scale factor to reduce screen pixels for interpolation 
Pstate.param{15} = {'SphericalON'           'int'       1       0                ''}; %apply spherical transformation



                    
                    
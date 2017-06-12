function configurePstate_DriftBar

%adapted from original author: Ian Nauhaus
%Kachi version

%drifting bar

global Pstate

Pstate = struct; %clear it

Pstate.type = 'DB';

Pstate.param{1} = {'PreStimDelay'   'float'     5       0                'sec'};
Pstate.param{2} = {'StimDuration '  'float'     30      0                'sec'};
Pstate.param{3} = {'PostStimDelay'  'float'     5       0                'sec'};

Pstate.param{4} = {'BarWidth'       'int'      20        0               'degree'};
Pstate.param{5} = {'BarOrient'     'int'        1        0                ''}; %1 = horizontal, 0 = vertical
Pstate.param{6} = {'BarTravel'     'float'      1       -1                ''};  % amplitude. 
Pstate.param{7} = {'BarStart'       'int'       1        0                ''};  %start location, 0 equal screen center
Pstate.param{8} = {'NumCycles'      'int'       1        0                ''}; %number of cycles

Pstate.param{9} = {'BarType'       'int'       2         0                ''}; %1 = plain; 2 = checkerboard; 3 = noise
Pstate.param{10} = {'CheckSize'     'int'       10        0                'degree'}; %size of checkerboard squares
Pstate.param{11} = {'FlickerRate'   'int'       6         0                'Hz'}; %necessary for blank trials!!!

Pstate.param{12} = {'Noise'         'int'       1        0                ''}; %noisy bar
Pstate.param{13} = {'contrast'       'int'      1        0                ''}; %necessary for blank trials!!!
Pstate.param{14} = {'SphereON'      'int'       0       0               ''}; %flag to transform spherical to coordinates
Pstate.param{15} = {'TrialInterval'  'int'       0       0               'secs'};






                    
                    
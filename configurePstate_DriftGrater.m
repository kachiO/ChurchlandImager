function configurePstate_DriftGrater

%adapted from original author: Ian Nauhaus
%Kachi version

%periodic grater

global Pstate

Pstate = struct; %clear it

Pstate.type = 'DG';

Pstate.param{1} = {'PreStimDelay'   'float'    2       0                'sec'};
Pstate.param{2} = {'StimDuration '  'float'    4       0                'sec'};
Pstate.param{3} = {'PostStimDelay'  'float'    0      0                'sec'};
Pstate.param{4} = {'StimSize'       'int'      25      0                'degrees'};
Pstate.param{5} = {'Orientation'    'int'      90       0                'degrees'};
Pstate.param{6} = {'SFreq'          'float'    0.04    -1              'cyc/degree'}; %spatial freq 
Pstate.param{7} = {'TFreq'          'float'    4       0               'cyc/sec'}; %second temporal frequency for speed ramp up/down
Pstate.param{8} = {'Binary'         'int'      0       0               ''}; %


Pstate.param{9} = {'RotateAngle'    'int'      0        0               'degrees'};
Pstate.param{10} = {'RotatePeriod'   'float'    1        0                'sec'};
Pstate.param{11} = {'Azimuth'       'int'      0      0                 'degrees'}; %position relatie to center of screen
Pstate.param{12} = {'Elevation'     'int'      0      0                  'degrees'};

Pstate.param{13} = {'Background'    'int'      128      0                ''};
Pstate.param{14} = {'contrast'      'int'      1        0                ''}; % made lower case, bc need it in buildStimulus.m...going to use it as flag for blanks
Pstate.param{15} = {'Noise'         'int'      0        0                ''};

%Flags for co-presentation of other sensory stimuli...I suppose user can
%specify stimulus parameters within flag
Pstate.param{16} = {'SoundFlag'     'int'       0       0                'Hz'};
Pstate.param{17} = {'WhiskerFlag'   'int'       0       0                'Hz'};
Pstate.param{18} = {'TrialInterval' 'int'       6       0               'secs'};







                    
                    
function configurePstate_WedgeCheckerboard

global Pstate

Pstate = struct; %clear it

Pstate.type = 'WC';

Pstate.param{1} = {'PreStimDelay'   'float'     10          0       'sec'};
Pstate.param{2} = {'StimDuration '  'float'     30          0       'sec'};
Pstate.param{3} = {'PostStimDelay'  'float'     10          0       'sec'};

Pstate.param{4} = {'NumRings'      'int'        2          0       ''}; %1/2 number of rings that make up the circle
Pstate.param{5} = {'NumChecks'     'int'        4          0       ''}; %1/2 number of checks in a ring
Pstate.param{6} = {'StartAngle'    'int'        45          0       'deg'}; % Start angle (degrees), i.e. location of wedge
Pstate.param{7} = {'WedgeAngle'    'int'        45          0       'deg'}; % Wedge angle (degrees), ie size  of wedge
Pstate.param{8} = {'Rotation'      'int'        1           0       ''}; %rotation flag, -1 = counterCW, 0 no rotation, 1 = CW 
Pstate.param{9} = {'NumCycles'      'int'       3           0       ''}; %number of cycles.
Pstate.param{10} = {'CyclePeriod'  'int'        10          0       'secs'}; %duration of cycle
Pstate.param{11} = {'FlickerRate'   'int'       4           0       'Hz'}; %flicker rate of checkerboard

Pstate.param{12} = {'contrast'       'int'      1           0       ''}; %necessary for blank trials!!!
Pstate.param{13} = {'TrialInterval'  'int'      0           0       'secs'}; 





                  
function configurePstate_WhiskerStim


%Whisker Stimulation

global Pstate

Pstate = struct; %clear it

Pstate.type = 'WS';

Pstate.param{1} = {'PreStimDelay'       'float'     2       0      'sec'};
Pstate.param{2} = {'StimDuration '      'float'     4       0      'sec'}; %sum of off and on duration...needed to determine camera acquisition time
Pstate.param{3} = {'PostStimDelay'      'float'     2      0        'sec'};

Pstate.param{4} = {'OnDuration'         'int'       2       0      'sec'};
Pstate.param{5} = {'Frequency'          'int'      5       0      'Hz'};
Pstate.param{6} = {'SquareThreshold'     'int'      NaN       0      ''};

Pstate.param{7} = {'contrast'      'int'      1        0       ''}; %necessary for blank trials!!!
Pstate.param{8} = {'TrialInterval'  'int'      0       0      'secs'}; 
                
                    
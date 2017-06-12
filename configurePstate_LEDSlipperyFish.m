function configurePstate_LEDSlipperyFish


%SlipperyFish - Poisson-like flashes on LED panel
%Kachi Oct 2015

global Pstate

Pstate = struct; %clear it

Pstate.type = 'LSF';

Pstate.param{1} = {'PreStimDelay'       'float'    2        0                'sec'};
Pstate.param{2} = {'StimDuration '      'float'    1        0                'sec'};
Pstate.param{3} = {'PostStimDelay'      'float'    0        0                'sec'};
Pstate.param{4} = {'EventRate'          'int'      12       0                'events/s'}; %event rates
Pstate.param{5} = {'VisualORAuditory'   'float'    1        0                ''}; %visual = 1, auditory = 2, multisensory = 3
Pstate.param{6} = {'EventDuration'      'float'    0.02     0                'secs'}; %size of event i.e flash 
Pstate.param{7} = {'Brightness'         'int'      40       0                ''}; %LED brightness
Pstate.param{8} = {'Amplitude'          'float'    0.5       0                ''}; %LED brightness
Pstate.param{9} = {'contrast'           'int'      1        0                ''}; %necessary for blank trials!!! made lower case, bc need it in buildStimulus.m...going to use it as flag for blanks
Pstate.param{10} = {'TrialInterval'      'int'      6        0                'secs'}; %

                
                    
function configurePstate_ScreenSlipperyFish


%SlipperyFish - Poisson-like flashes on screen
%Kachi Aug 2016

global Pstate

Pstate = struct; %clear it

Pstate.type = 'SSF';

Pstate.param{1} = {'PreStimDelay'       'float'    2        0                'sec'};
Pstate.param{2} = {'StimDuration '      'float'    1        0                'sec'};
Pstate.param{3} = {'PostStimDelay'      'float'    0        0                'sec'};
Pstate.param{4} = {'EventRate'          'int'      12       0                'events/s'}; %event rates
Pstate.param{5} = {'VisualORAuditory'   'int'      1        0                ''}; %visual = 1, auditory = 2, multisensory = 3
Pstate.param{6} = {'EventDuration'      'float'    0.02     0                'secs'}; %size of event i.e flash 
Pstate.param{7} = {'Intensity'          'int'      1       0                ''}; %LED brightness
Pstate.param{8} = {'contrast'           'int'      1        0                ''}; %necessary for blank trials!!! made lower case, bc need it in buildStimulus.m...going to use it as flag for blanks
Pstate.param{9} = {'TrialInterval'      'int'      6        0                'secs'}; %

                
                    
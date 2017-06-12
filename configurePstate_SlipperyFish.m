function configurePstate_SlipperyFish

%SlipperyFish - Poisson-like flashes on screen
%Kachi Aug 2016

global Pstate

Pstate = struct; %clear it

Pstate.type = 'SF';

Pstate.param{1} = {'PreStimDelay'       'float'    2        0                'sec'};
Pstate.param{2} = {'StimDuration '      'float'    1        0                'sec'};
Pstate.param{3} = {'PostStimDelay'      'float'    0        0                'sec'};

Pstate.param{4} = {'StimSize'           'float'    25        0                'deg'};
Pstate.param{5} = {'Azimuth'            'float'    0        0                'deg'};
Pstate.param{6} = {'Elevation'          'float'    0        0                'deg'};

Pstate.param{7} = {'EventRate'          'int'      15       0                'events/s'}; %event rates
Pstate.param{8} = {'EventDuration'      'float'    0.0167     0                'secs'}; %size of event i.e flash. set equal to single frame duration
Pstate.param{9} = {'VisualORAuditory'   'float'    1        0                ''}; %visual = 1, auditory = 2, multisensory = 3
Pstate.param{10} = {'SyncMultisensory'  'int'      1        0                ''}; %synchronous = 1, asynchronous = 0

Pstate.param{11} = {'Amplitude'          'float'    1       0                ''}; %sound amplitude brightness
Pstate.param{12} = {'contrast'           'int'      1        0                ''}; %necessary for blank trials!!! made lower case, bc need it in buildStimulus.m...going to use it as flag for blanks
Pstate.param{13} = {'Background'         'int'      0        0                ''}; %
Pstate.param{14} = {'TrialInterval'      'int'      6        0                'sec'}; %

                
                    
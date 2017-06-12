function configurePstate_FullCheckerboard


%full field checkerboard

global Pstate

Pstate = struct; %clear it

Pstate.type = 'FC';

Pstate.param{1} = {'PreStimDelay'   'float'    2       0                'sec'};
Pstate.param{2} = {'StimDuration '  'float'    4       0                'sec'};
Pstate.param{3} = {'PostStimDelay'  'float'    2      0                'sec'};
Pstate.param{4} = {'OnDuration'     'float'    2      0                'sec'};
Pstate.param{5} = {'OffDuration'    'float'    2      0                'sec'};
Pstate.param{6} = {'NumCycles'      'int'      1       0                ''};
Pstate.param{7} = {'StimSize'       'int'      1       0                'degrees'}; %1 = full screen, diameter in degrees
Pstate.param{8} = {'Azimuth'        'int'      0       0                'degrees'}; %degrees from center of screen
Pstate.param{9} = {'Elevation'      'int'      0       0                'degrees'}; %degrees from center of monitor
Pstate.param{10} = {'CheckSize'     'int'      10      0              'degrees'};

Pstate.param{11} = {'FlickerRate'    'int'      8       0                'Hz'};

Pstate.param{12} = {'contrast'       'int'      1        0                ''}; %necessary for blank trials!!! made lower case, bc need it in buildStimulus.m...going to use it as flag for blanks
Pstate.param{13} = {'TrialInterval' 'int'      0       0                'secs'}; %

                
                    
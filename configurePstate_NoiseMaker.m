function configurePstate_NoiseMaker

%noise stimulus

global Pstate

Pstate = struct; %clear it

Pstate.type = '';

Pstate.param{1} = {'PreStimDelay'   'float'    2       0                'sec'};
Pstate.param{2} = {'StimDuration '  'float'    4       0                'sec'};
Pstate.param{3} = {'PostStimDelay'  'float'    8      0                'sec'};
Pstate.param{4} = {'StimSize'       'int'      25      0                'deg'};

Pstate.param{5} = {'SFreq'          'float'    0.12    -1              'cpd'}; %cutoff spatial freq in cycles per second
Pstate.param{6} = {'TFreq'          'float'    4       0               'hz'}; %cutoff temporal frequency in cycles per second
Pstate.param{7} = {'SigmaTFreq'     'float'    5       0               ''}; %sigma for temporal frequency filter 
Pstate.param{8} = {'FlickerRate'    'int'      4       0               'hz'}; %movie display rate..i.e. subsample frequency 

Pstate.param{9} = {'Binary'         'int'      1       0               ''}; %binary flag

Pstate.param{10} = {'Azimuth'       'int'      0      0                 'deg'}; %position relative to center of screen
Pstate.param{11} = {'Elevation'     'int'      -12      0                  'deg'};

Pstate.param{12} = {'Background'    'float'    0.5      1                ''};%=0-black; =0.5-gray; =1-white
Pstate.param{13} = {'contrast'      'int'      1        0                ''}; % made lower case, bc need it in buildStimulus.m...going to use it as flag for blanks
Pstate.param{14} = {'TrialInterval' 'int'      6        0                ''}; %






                    
                    
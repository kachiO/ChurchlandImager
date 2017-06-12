function configSyncAnalogInput
%Kachi version of Callaway "configSynchInput.m"

%initalize daq for acquisition of stimulus syncs
global analogIN 

analogIN = daq.createSession('ni'); %%object for communication with NI device - digital lines
addAnalogInputChannel(analogIN,'Dev3','ai0','Voltage'); %add analog channel

analogIN.Rate = analogIN.RateLimit(2)/2;
analogIN.IsContinuous = true;



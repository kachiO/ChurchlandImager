% function [dispSynctimes, acqSynctimes, dsyncwave] = getSyncTimesAnalogInput
function  getSyncTimesAnalogInput

%kachi version of getSyncTimes.m
%created oct-22-2015

global analogIN  syncFileName

fid2 = fopen(syncFileName,'r');
daqData = fread(fid2,[2,inf],'double')'; %load data as two column matrix
fclose(fid2);
time = daqData(:,1);
voltages = daqData(:,2);

figure;plot(time,voltages)


% dispSynctimes = processLCDSyncs(syncs(:,1),Fs); %First channel should be from display
%dispSynctimes = processDaqSyncs(syncs(:,1),Fs); %First channel should be from display
% acqSynctimes = processGrabSyncs(syncs(:,2),Fs); %Second channel should be from parallel port

% dsyncwave = syncs(:,1);

% flushdata(analogIN);
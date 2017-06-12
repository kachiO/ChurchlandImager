function InitializeDaq
global digitalOut

digitalOut = daq.createSession('ni'); %object for communication with NI device - digital lines
addDigitalChannel(digitalOut,'Dev3','port1/line0','OutputOnly'); %output channels for blue and IR LEDs (defualt is line 0.0 for blue and line 0.1 for IR)


%previous DAQ was used to trigger LED on/off. This is no longer the case as
%of Oct 20 2015

% global digitalOutDAQ
% %Start USB-Daq session
% 
% digitalOutDAQ = daq.createSession('ni');
% 
% %add channels : line 0-green, line 1-red, line 2 - blue
% addDigitalChannel(digitalOutDAQ,'Dev1','Port0/Line0:2','OutputOnly');
% outputSingleScan(digitalOutDAQ,[0 0 0]);


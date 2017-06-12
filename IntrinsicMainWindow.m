function varargout = IntrinsicMainWindow(varargin)
% MAINWINDOW M-file for MainWindow.fig
%      MAINWINDOW, by itself, creates a new MAINWINDOW or raises the existing
%      singleton*.
%
%      H = MAINWINDOW returns the handle to a new MAINWINDOW or the handle to
%      the existing singleton*.
%
%      MAINWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINWINDOW.M with the given input arguments.
%
%      MAINWINDOW('Property','Value',...) creates a new MAINWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainWindow

% Last Modified by GUIDE v2.5 23-Jun-2016 12:54:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainWindow_OpeningFcn, ...
    'gui_OutputFcn',  @MainWindow_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MainWindow is made visible.
function MainWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainWindow (see VARARGIN)

% Choose default command line output for MainWindow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainWindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


global GUIhandles Mstate sessionDate

Mstate.running = 0;

%Set GUI to the default established in configureMstate
set(handles.screendistance,'string',num2str(Mstate.screenDist))
set(handles.screenangle,'string',num2str(Mstate.screenAngle));
set(handles.analyzerRoots,'string',Mstate.analyzerRoot)
set(handles.animal,'string',Mstate.anim)
set(handles.exptcb,'string',Mstate.expt)
set(handles.hemisphere,'string',Mstate.hemi)
set(handles.monitor,'string',Mstate.monitor)
set(handles.stimulusIDP,'string',Mstate.stimulusIDP)
set(handles.screenEyeHeight,'string',Mstate.screenEyeHeight)
set(handles.framerate,'string',Mstate.framerate)
set(handles.binFrameRateFactor,'string',Mstate.binFrameRateFactor)
set(handles.screenHeightcm,'string',Mstate.screenYcm)
set(handles.screenWidthcm,'string',Mstate.screenXcm)
Mstate.WidefieldMode = 'gcamp'; %default

%calculate monitor dimensions
Mstate.widthDeg = atand((Mstate.screenXcm/2)/Mstate.screenDist)*2;
Mstate.heightDeg = atand((Mstate.screenYcm/2)/Mstate.screenDist)*2;

set(handles.heightDeg,'string',Mstate.heightDeg)
set(handles.widthDeg,'string',Mstate.widthDeg)

%calculate vertical distance of the eye from center of screen 
difference = Mstate.screenEyeHeight - Mstate.screenYcm/2;
Mstate.screenCenterEyeVerticalDeg = atand(difference/Mstate.screenDist);
set(handles.eyeCenterVertDeg,'string',Mstate.screenCenterEyeVerticalDeg)

Mstate.spatialBinFactor = str2double(get(handles.spatialBinFactor,'string'));
Mstate.binFrameRateFactor = str2double(get(handles.binFrameRateFactor,'string'));

sessionDate = date;
GUIhandles.main = handles;


% --- Outputs from this function are returned to the command line.
function varargout = MainWindow_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function animal_Callback(hObject, eventdata, handles)
% hObject    handle to animal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of animal as text
%        str2double(get(hObject,'String')) returns contents of animal as a double

global Mstate

Mstate.anim = get(handles.animal,'string');

anaroot = get(handles.analyzerRoots,'string');
Mstate.analyzerRoot = anaroot;

roots = parseString(Mstate.analyzerRoot,';');

dirinfo = dir([roots{1} '\' Mstate.anim]); %Use the first root path for the logic below

% if length(dirinfo) > 2 %If the animal folder exists and there are files in it
%     
%     %     lastunit = dirinfo(end).name(6:8);
%     lastexpt = dirinfo(end)
%     
%     %     newunit = lastunit;
%     newexpt = sprintf('%03d',str2double(lastexpt)+1); %Go to next experiment number
%     
% else  %if animal folder does not exist or there aren't any files.  The new folder will
%     %be created when you hit the 'run' button
%     
%     % %     newunit = '000';
    newexpt = '000';
    
% end

% % Mstate.unit = newunit;
Mstate.expt = newexpt;
set(handles.exptcb,'string',newexpt);
% % set(handles.unitcb,'string',newunit);

UpdateACQExptName   %Send expt info to acquisition


% --- Executes during object creation, after setting all properties.
function animal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to animal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hemisphere_Callback(hObject, eventdata, handles)
% hObject    handle to hemisphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hemisphere as text
%        str2double(get(hObject,'String')) returns contents of hemisphere as a double

global Mstate

%This is not actually necessary since updateMstate is always called prior
%to showing stimuli...
Mstate.hemi = get(handles.hemisphere,'string');

% --- Executes during object creation, after setting all properties.
function hemisphere_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hemisphere (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function screendistance_Callback(hObject, eventdata, handles)
% hObject    handle to screendistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of screendistance as text
%        str2double(get(hObject,'String')) returns contents of screendistance as a double

global Mstate

%This is not actually necessary since updateMstate is always called prior
%to showing stimuli...
Mstate.screenDist = str2num(get(handles.screendistance,'string'));

%calculate monitor dimensions
Mstate.widthDeg = round(atand((Mstate.screenXcm/2)/Mstate.screenDist)*2);
Mstate.heightDeg = round(atand((Mstate.screenYcm/2)/Mstate.screenDist)*2);

set(handles.heightDeg,'string',Mstate.heightDeg)
set(handles.widthDeg,'string',Mstate.widthDeg)
%calculate vertical distance of the eye from center of screen 
difference = Mstate.screenEyeHeight - Mstate.screenYcm/2;
Mstate.screenCenterEyeVerticalDeg = atand(difference/Mstate.screenDist);
set(handles.eyeCenterVertDeg,'string',Mstate.screenCenterEyeVerticalDeg)


% --- Executes during object creation, after setting all properties.
function screendistance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to screendistance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function framerate = calculateFrameRate
global Mstate imagerhandles
vidObj = imagerhandles.vidObj;
imagerhandles.vidObj.FramesAcquiredFcn =  {};

disp('calculating frame rate...')
stop(vidObj);
flushdata(vidObj,'all'); %clear memory
set(vidObj,'FramesPerTrigger',100);
start(vidObj);
while islogging(vidObj)
    %wait for camera to finish capturing frames
    set(findobj('Tag','cameraStatus'),'String','calculating frame rate...');drawnow
end
set(findobj('Tag','cameraStatus'),'String','Done...');drawnow
numacq = get(vidObj,'FramesAcquired');

[~,TimeStamps,~] = getdata(vidObj,numacq);

framerate = round(1/median(diff(TimeStamps)));
Mstate.framerate = framerate;

stop(vidObj);
flushdata(vidObj,'all'); %clear memory

set(vidObj,'FramesPerTrigger',Inf);



% --- Executes on button press in runbutton.
function runbutton_Callback(hObject, eventdata, handles)
% hObject    handle to runbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Mstate GUIhandles datadirectory trialno imagerhandles sessionDate analogIN imagingMode digitalOut

%Run it!
if ~Mstate.running
    set(handles.spatialBinFactor,'Enable','off')
    set(handles.binFrameRateFactor,'Enable','off')
    
    %Check if this analyzer file already exists!
    roots = parseString(Mstate.analyzerRoot,';');
    for i = 1:length(roots)  %loop through each root
        %         title = [Mstate.anim '_' sprintf('u%s',Mstate.unit) '_' Mstate.expt];
        
        title = [Mstate.anim '_' Mstate.expt];
        datadirectory  = [roots{i} '\' Mstate.anim '\' sessionDate '\' Mstate.expt];
        dd = [datadirectory '\' title '.analyzer.mat'];
        
        if(exist(dd))
            warndlg('Directory exists!!!  Please advance experiment before running')
            return
        end
    end
    
    framerate = calculateFrameRate;
    set(handles.framerate,'String',framerate);
    
    Mstate.running = 1;  %Global flag for interrupt in real-time loop ('Abort')
    
    %Update states just in case user has not pressed enter after inputing
    %fields:
    updateLstate
    updateMstate
    
    makeLoop;  %makes 'looperInfo'.  This must be done before saving the analyzer file.
    saveExptParams  %Save .analyzer. Do this before running... in case something crashes
    
    set(handles.runbutton,'string','Abort')
    
    %%%%Send initial parameters to display
    sendPinfo
    waitforDisplayResp
    sendMinfo
    waitforDisplayResp
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%Send inital parameters to ISI imager GUI
    P = getParamStruct;
%     if get(GUIhandles.main.intrinsicflag,'value')
        total_time = P.PreStimDelay + P.StimDuration+P.PostStimDelay;
        sendtoIntrinsicImager(sprintf(['I %2.3f' 13],total_time))        
%     end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    trialno = 1;
    
    %In 2 computer version 'runIntrinsic' is no longer a loop, but gets recalled
    %after each trial...
    
    %stop camera if running,clear data and delete callback function
    stop(imagerhandles.vidObj);
    flushdata(imagerhandles.vidObj);
    imagerhandles.vidObj.FramesAcquiredFcn =  {}; %stop live display of IntrinsicImager GUI
    
    %before runIntrinsic, switch on LEDs for duration of session
    imagerhandles.AllLEDState =[get(findobj('Tag','redFlag'),'Value') get(findobj('Tag','greenFlag'),'Value') get(findobj('Tag','blueFlag'),'Value')];
     
    colors = [{'red'};{'green'}; {'blue'}];
    Mstate.LEDColor = colors(logical(imagerhandles.AllLEDState));
    
    if ~isempty(digitalOut)
        outputSingleScan(digitalOut,1); %switch blue light on if NI device is available
        pause(0.25); %pause 250ms for LED to stabilize
    end
    
    %     imaqmem(3.5e+09); %assign memory to camera, can go up to 7GB
    
    %Make sure analogIN is not running
%     stop(analogIN)

    imagingMode = Mstate.WidefieldMode;

    %start intrinsic session loop
%     runIntrinsic    
%     while trialno<=getnotrials
    for trial = 1: getnotrials
        if strcmpi(imagingMode,'gcamp')
            if ~isempty(digitalOut)
                outputSingleScan(digitalOut,1); %switch blue light on if NI device is available
                pause(0.25);
            end
        end
        
        runIntrinsic
    end
    
    Mstate.running = 0;

    set(GUIhandles.main.runbutton,'string','Run')
    set(handles.spatialBinFactor,'Enable','on')
    set(handles.binFrameRateFactor,'Enable','on')

    %%switch off LED
    if ~isempty(digitalOut)
        outputSingleScan(digitalOut,0); %switch blue light off if NI device is available
     end
    
else
    Mstate.running = 0;  %Global flag for interrupt in real-time loop ('Abort')
    set(handles.spatialBinFactor,'Enable','on')
    set(handles.binFrameRateFactor,'Enable','on')

    set(handles.runbutton,'string','Run')
    stop(imagerhandles.vidObj);
    
end

% --- Executes on button press in exptcb.
function exptcb_Callback(hObject, eventdata, handles)
% hObject    handle to exptcb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Mstate

newexpt = sprintf('%03d',str2num(Mstate.expt)+1);
Mstate.expt = newexpt;
set(handles.exptcb,'string',newexpt)

UpdateACQExptName   %Send expt info to acquisition


% --- Executes on button press in closeDisplay.
function closeDisplay_Callback(hObject, eventdata, handles)
% hObject    handle to closeDisplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global DcomState

fwrite(DcomState.serialPortHandle,'C;~')


function analyzerRoots_Callback(hObject, eventdata, handles)
% hObject    handle to analyzerRoots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of analyzerRoots as text
%        str2double(get(hObject,'String')) returns contents of analyzerRoots as a double


%This is not actually necessary since updateMstate is always called prior
%to showing stimuli...
Mstate.analyzerRoot = get(handles.analyzerRoots,'string');

% --- Executes during object creation, after setting all properties.
function analyzerRoots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to analyzerRoots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in REflag.
function REflag_Callback(hObject, eventdata, handles)
% hObject    handle to REflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of REflag

REbit = get(handles.REflag,'value');
% moveShutter(2,REbit)
% waitforDisplayResp



% --- Executes on button press in LEflag.
function LEflag_Callback(hObject, eventdata, handles)
% hObject    handle to LEflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of LEflag

LEbit = get(handles.LEflag,'value');
% moveShutter(1,LEbit)
% waitforDisplayResp



function monitor_Callback(hObject, eventdata, handles)
% hObject    handle to monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of monitor as text
%        str2double(get(hObject,'String')) returns contents of monitor as a double

global Mstate

Mstate.monitor = get(handles.monitor,'string');

updateMonitorValues
sendMonitor

% --- Executes during object creation, after setting all properties.
function monitor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function stimulusIDP_Callback(hObject, eventdata, handles)
% hObject    handle to stimulusIDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimulusIDP as text
%        str2double(get(hObject,'String')) returns contents of stimulusIDP as a double


% --- Executes during object creation, after setting all properties.
function stimulusIDP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimulusIDP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in intrinsicflag.
function intrinsicflag_Callback(hObject, eventdata, handles)
% hObject    handle to intrinsicflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of intrinsicflag


global GUIhandles Mstate

flag = get(handles.intrinsicflag,'value');
set(GUIhandles.main.intrinsicflag,'value',flag)

if flag
    set(handles.gcampFlag,'value',0);
    set(GUIhandles.main.gcampFlag,'value',0)
end
Mstate.WidefieldMode = 'intrinsic';


% --- Executes on button press in blueFlag.
function blueFlag_Callback(hObject, eventdata, handles)
% hObject    handle to blueFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blueFlag

global IntrinsicColorFlag Mstate

% disp('green selected')
set(hObject,'Value',1);
set(findobj('Tag','redFlag'),'Value',0)
set(findobj('Tag','greenFlag'),'Value',0)

IntrinsicColorFlag = 'blue';
handles.IntrinsicColorFlag = IntrinsicColorFlag;
handles.AllLEDState = [get(findobj('Tag','redFlag'),'Value') get(findobj('Tag','greenFlag'),'Value') (get(findobj('Tag','blueFlag'),'Value'))];

Mstate.LEDColor = IntrinsicColorFlag;

guidata(hObject,handles);

% --- Executes on button press in greenFlag.
function greenFlag_Callback(hObject, eventdata, handles)
% hObject    handle to greenFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of greenFlag
global IntrinsicColorFlag Mstate

% disp('green selected')
set(hObject,'Value',1);
set(findobj('Tag','redFlag'),'Value',0)
set(findobj('Tag','blueFlag'),'Value',0)

IntrinsicColorFlag = 'green';
handles.IntrinsicColorFlag = IntrinsicColorFlag;
% handles.GreenRed = [get(findobj('Tag','greenFlag'),'Value') get(findobj('Tag','redFlag'),'Value')];
handles.AllLEDState = [ get(findobj('Tag','redFlag'),'Value') get(findobj('Tag','greenFlag'),'Value') (get(findobj('Tag','blueFlag'),'Value'))];
Mstate.LEDColor = IntrinsicColorFlag;


guidata(hObject,handles);


% --- Executes on button press in redFlag.
function redFlag_Callback(hObject, eventdata, handles)
% hObject    handle to redFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of redFlag
% Hint: get(hObject,'Value') returns toggle state of redFlag
global IntrinsicColorFlag

% disp('red selected')
set(hObject,'Value',1);
set(findobj('Tag','greenFlag'),'Value',0)
set(findobj('Tag','blueFlag'),'Value',0)

IntrinsicColorFlag = 'red';
handles.IntrinsicColorFlag = IntrinsicColorFlag;

% handles.GreenRed = [get(findobj('Tag','greenFlag'),'Value') get(findobj('Tag','redFlag'),'Value')];
handles.AllLEDState = [get(findobj('Tag','redFlag'),'Value') get(findobj('Tag','greenFlag'),'Value') (get(findobj('Tag','blueFlag'),'Value'))];
Mstate.LEDColor = IntrinsicColorFlag;

guidata(hObject,handles);



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function screenangle_Callback(hObject, eventdata, handles)
% hObject    handle to screenangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of screenangle as text
%        str2double(get(hObject,'String')) returns contents of screenangle as a double
global Mstate

Mstate.screenAngle = str2double(hObject);

% --- Executes during object creation, after setting all properties.
function screenangle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to screenangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function framerate_Callback(hObject, eventdata, handles)
% hObject    handle to framerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of framerate as text
%        str2double(get(hObject,'String')) returns contents of framerate as a double
global Mstate

Mstate.framerate = str2double(hObject);

% --- Executes during object creation, after setting all properties.
function framerate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to framerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function binFrameRateFactor_Callback(hObject, eventdata, handles)
% hObject    handle to binFrameRateFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of binFrameRateFactor as text
%        str2double(get(hObject,'String')) returns contents of binFrameRateFactor as a double
global Mstate

Mstate.binFrameRateFactor = str2double(hObject);

% --- Executes during object creation, after setting all properties.
function binFrameRateFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to binFrameRateFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function screenEyeHeight_Callback(hObject, eventdata, handles)
% hObject    handle to screenEyeHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of screenEyeHeight as text
%        str2double(get(hObject,'String')) returns contents of screenEyeHeight as a double
global Mstate

Mstate.screenEyeHeight= str2double(get(hObject,'string'));
difference = Mstate.screenEyeHeight - Mstate.screenYcm/2;
Mstate.screenCenterEyeVerticalDeg = atand(difference/Mstate.screenDist);
set(handles.eyeCenterVertDeg,'string',(Mstate.screenCenterEyeVerticalDeg))


% --- Executes during object creation, after setting all properties.
function screenEyeHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to screenEyeHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in onlinedIoIFlag.
function onlinedIoIFlag_Callback(hObject, eventdata, handles)
% hObject    handle to onlinedIoIFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of onlinedIoIFlag
global GUIhandles

%flag to compute delta I over I per trial
flag = get(hObject,'value');
set(GUIhandles.main.onlinedIoIFlag,'value',flag)

if flag
   figure(99); 
   set(findobj('Tag','onlineFourierFlag'),'value',0);drawnow
end


% --- Executes on button press in onlineFourierFlag.
function onlineFourierFlag_Callback(hObject, eventdata, handles)
% hObject    handle to onlineFourierFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of onlineFourierFlag
global GUIhandles
%flag to compute Fourier phase map per trial 
flag = get(hObject,'value');
set(GUIhandles.main.onlineFourierFlag,'value',flag)

if flag
   figure(99); 
   set(findobj('Tag','onlinedIoIFlag'),'value',0);drawnow
end

function widthDeg_Callback(hObject, eventdata, handles)
% hObject    handle to widthDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of widthDeg as text
%        str2double(get(hObject,'String')) returns contents of widthDeg as a double


% --- Executes during object creation, after setting all properties.
function widthDeg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widthDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function heightDeg_Callback(hObject, eventdata, handles)
% hObject    handle to heightDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heightDeg as text
%        str2double(get(hObject,'String')) returns contents of heightDeg as a double


% --- Executes during object creation, after setting all properties.
function heightDeg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heightDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function screenWidthcm_Callback(hObject, eventdata, handles)
% hObject    handle to screenWidthcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of screenWidthcm as text
%        str2double(get(hObject,'String')) returns contents of screenWidthcm as a double
global Mstate
Mstate.screenXcm = str2double(get(hObject,'String'));

Mstate.widthDeg = atand((Mstate.screenXcm/2)/Mstate.screenDist)*2;
set(handles.widthDeg,'string',Mstate.widthDeg)

% --- Executes during object creation, after setting all properties.
function screenWidthcm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to screenWidthcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function screenHeightcm_Callback(hObject, eventdata, handles)
% hObject    handle to screenHeightcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of screenHeightcm as text
%        str2double(get(hObject,'String')) returns contents of screenHeightcm as a double
global Mstate
Mstate.screenYcm = str2double(get(hObject,'String'));

Mstate.heightDeg = atand((Mstate.screenYcm/2)/Mstate.screenDist)*2;
set(handles.heightDeg,'string',Mstate.heightDeg)


% --- Executes during object creation, after setting all properties.
function screenHeightcm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to screenHeightcm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function spatialBinFactor_Callback(hObject, eventdata, handles)
% hObject    handle to spatialBinFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of spatialBinFactor as text
%        str2double(get(hObject,'String')) returns contents of spatialBinFactor as a double
global Mstate
Mstate.spatialBinFactor = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function spatialBinFactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spatialBinFactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eyeCenterVertDeg_Callback(hObject, eventdata, handles)
% hObject    handle to eyeCenterVertDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eyeCenterVertDeg as text
%        str2double(get(hObject,'String')) returns contents of eyeCenterVertDeg as a double


% --- Executes during object creation, after setting all properties.
function eyeCenterVertDeg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eyeCenterVertDeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gcampFlag.
function gcampFlag_Callback(hObject, eventdata, handles)
% hObject    handle to gcampFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gcampFlag
global GUIhandles Mstate 
flag = get(hObject,'value');
set(GUIhandles.main.intrinsicflag,'value',flag)

if flag
    set(handles.intrinsicflag,'value',0);
    set(GUIhandles.main.intrinsicflag,'value',0)
end

Mstate.WidefieldMode = 'gcamp';

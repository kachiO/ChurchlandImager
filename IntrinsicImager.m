function varargout = IntrinsicImager(varargin)
% INTRINSICIMAGER MATLAB code for IntrinsicImager.fig
%      INTRINSICIMAGER, by itself, creates a new INTRINSICIMAGER or raises the existing
%      singleton*.
%
%      H = INTRINSICIMAGER returns the handle to a new INTRINSICIMAGER or the handle to
%      the existing singleton*.
%
%      INTRINSICIMAGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTRINSICIMAGER.M with the given input arguments.
%
%      INTRINSICIMAGER('Property','Value',...) creates a new INTRINSICIMAGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IntrinsicImager_OpeningFcn gets called.  An
%      unrecognized property animaltxt or invalid value makes property application
%      stop.  All inputs are pas sed to IntrinsicImager_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IntrinsicImager

% Last Modified by GUIDE v2.5 23-Jun-2016 12:21:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @IntrinsicImager_OpeningFcn, ...
    'gui_OutputFcn',  @IntrinsicImager_OutputFcn, ...
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
end



% --- Executes just before IntrinsicImager is made visible.
function IntrinsicImager_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IntrinsicImager (see VARARGIN)
% Device Properties.
% Choose default command line output for IntrinsicImager

handles.output = hObject;

try
    imaqreset
    
    adaptorName = 'bitflow';
    deviceID = 1;
%     vidFormat = 'PhotonFocus-MVD1024-40-W1.r64';  %12-bit file format
        vidFormat = 'PhotonFocus-MVD1024-160-W2.r64';  %12-bit file format for MVD1024-160 camera

    handles.vidObj = videoinput(adaptorName, deviceID, vidFormat);
    
catch
    disp('no camera detected. please turn on camera');
    handles.vidObj = 0;
    guidata(hObject,handles);
    return
end

global imagerhandles IntrinsicFlag digitalOut sessionDate

if isempty(IntrinsicFlag)
    %flag to indicate who calls Imager
    InitializeDaq;
end

handles.USBdaq = digitalOut;
%
%initialize handles
handles.ROIposition = [0 0 1024 1024];  %default ROIposition
handles.datadir = get(findobj('Tag','datatxt'),'String');

handles.framesPerTrigger = Inf;
set(handles.vidObj,'FramesPerTrigger',Inf);

handles.BlueLEDState = 0;
handles.GreenLEDState = 0;
handles.RedLEDState = 0; 
handles.AllLEDState = [handles.RedLEDState handles.GreenLEDState handles.BlueLEDState];

%%set default camera configuration
set(handles.vidObj,'TriggerFrameDelay',0);
set(handles.vidObj,'FrameGrabInterval',1);
set(handles.vidObj,'TriggerRepeat',0);
set(handles.vidObj,'ROIposition',handles.ROIposition);

%setup and display live video feed in preview window
vidRes = get(handles.vidObj,'VideoResolution');
nbands = get(handles.vidObj,'NumberOfBands');
imHeight = vidRes(2);
imWidth = vidRes(1);

hImage = imshow(zeros(imHeight,imWidth,nbands),[0 4096],'parent',handles.previewer);

set(handles.vidObj,'FramesAcquiredFcnCount',1); 
set(handles.vidObj,'FramesAcquiredFcn',{@histogramDisplay});

handles.hImage = hImage;
histax = handles.histogram;

imagerhandles = handles;

vidObj = handles.vidObj;

% start(handles.vidObj);

% Update handles structure
guidata(hObject, handles);

end

% %     %histogram update callback function using preview
function histogramDisplay(vidObj,event)
global imagerhandles

nbins = 4096;
t = 40;

persistent tracer

if ~exist('tracer')
    tracer = zeros(nbins,t);
end

if size(tracer) ~= [nbins t];
    tracer = zeros(nbins,t);
end
if ~exist('vidObj')
    return;
else
    Image = getdata(vidObj,1);
    flushdata(vidObj);
end

scale = max(floor((1024 ./size(Image))));
Image = imresize(Image,scale);

imshow(Image,[],'parent',imagerhandles.previewer);
drawnow;

set(imagerhandles.previewer,'xticklabel',[])
set(imagerhandles.previewer,'yticklabel',[])

[counts,x] = imhist(Image,nbins); %generate histogram of live feed
counts = counts ./ max(counts); %normalize
peak = max(round(x(counts == 1)));
set(imagerhandles.histpeak,'String',num2str(peak(1)));

%store history of histogram
tracer(:,2:t) = tracer(:,1:t-1);
tracer(:,1) = counts;

val = get(imagerhandles.histogramlist,'value');
histax = imagerhandles.histogram;

switch val
    case 1 %regular 2D histogram
        %plot histogram
        plot(histax,x,counts);
        hxlabel = get(histax,'XLabel');
        set(hxlabel,'String','Pixel Intensity')
        set(histax,'XLim',[0 4100]);
        hylabel = get(histax,'YLabel');
        set(hylabel,'String','Normalized Pixel Count')
        
    case 2 %surf plot, 3d histogram
        surf(histax,tracer)
        set(histax,'view',[-37.5 60],'ydir','reverse')
        shading(histax,'interp');
        
        xlabel(histax,'Time (frames)')
        ylabel(histax,'Pixel Brightness')
        zlabel(histax,'Pixel Count')
        
        
end
set(histax,'box','off');

drawnow;

end


% UIWAIT makes IntrinsicImager wait for user response (see UIRESUME)
% uiwait(handles.IntrinsicImagerGUI);


% --- Outputs from this function are returned to the command line.
function varargout = IntrinsicImager_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end


% --- Executes on button press in StopPreview.
function StopPreview_Callback(hObject, eventdata, handles)
% hObject    handle to StopPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%stop preview
if handles.vidObj ==0
    return
else
    stop(handles.vidObj)
    
end

end



% --- Executes on button press in StartPreview.
function StartPreview_Callback(hObject, eventdata, handles)
% hObject    handle to StartPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Start preview
if handles.vidObj == 0
    return
else
    
    if ~isrunning(handles.vidObj)
        set(handles.vidObj,'ROIposition',handles.ROIposition);

        %resume preview if camera is not already running
        start(handles.vidObj);
    end
    
end


end


% --- Executes on button press in SnapShot.
function SnapShot_Callback(hObject, eventdata, handles)
% hObject    handle to SnapShot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global dir
%take snap shot
% snapshot(handles.vidObj)
if handles.vidObj == 0
    return
else
    figure('Toolbar','none',...
        'Menubar','none',...
        'NumberTitle','off',...
        'Name','SnapShot');
    
    snap = getsnapshot(handles.vidObj);
    
    imshow(snap,[]);
    
    start_dir = get(findobj('Tag','datatxt'),'String');
    animal = get(findobj('Tag','animaltxt'),'String');
    exptnum = get(findobj('Tag','expttxt'),'String');
    
    dir = [start_dir '\' animal '\' date '\ROI\'  exptnum '\' ];
    
    if ~isdir(dir)
        mkdir(dir)
    end
    
    cd(dir)
    
    % animaltxt and save image
    uicontrol('String','Save',...
        'Callback','imsave',...
        'units','normalized',...
        'position',[0 0 0.15 0.07]);
    
    uicontrol('String','Close',...
        'Callback','close(gcf)',...
        'units','normalized',...
        'position',[0.17 0 0.15 0.07]);
    
end

end



function datatxt_Callback(hObject, eventdata, handles)
% hObject    handle to datatxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of datatxt as text
%        str2double(get(hObject,'String')) returns contents of datatxt as a double

% % set(handles.datatxt,'String',dir)


end


% --- Executes during object creation, after setting all properties.
function datatxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to datatxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in DirectoryButton.
function DirectoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to DirectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global dir

dir = uigetdir('','Select Directory');

if dir ~= 0
    handles.datadir = dir;
    set(handles.datatxt,'String',dir)
    
    cd(dir)
    
    %set disk logger
    
    %     set(handles.vidObj,'DiskLogger',handles.datadir);
end

guidata(hObject,handles);

end

% --- Executes during object creation, after setting all properties.
function DirectoryButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DirectoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

end

% --- Executes on button press in SelectROI.
function SelectROI_Callback(hObject, eventdata, handles)
% hObject    handle to SelectROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.vidObj == 0
    return
else
    
    [roiPosition] = SelectROI(handles.vidObj);
    
    if ~isempty(roiPosition)
        handles.ROIposition = roiPosition;
        
        %stop camera, and set new ROI position
        stop(handles.vidObj)
        
        set(handles.vidObj,'ROIposition',handles.ROIposition);
        start(handles.vidObj)  %resume camera preview
        
    end
    
end

guidata(hObject,handles);

end


% --- Executes on button press in LastROI.
function LastROI_Callback(hObject, eventdata, handles)
% hObject    handle to LastROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%stop preview
stoppreview(handles.vidObj)

%load previously selected ROI
cd(handles.datadir);
[ROIfilename,pathname,filterindx]=uigetfile('*.mat','Select Previous ROI position');
if ROIfilename
    cd(pathname)
    p = load(ROIfilename);
    lastroipostion = p.ROIposition; %ROIs saved in variable name "ROIposition"
    
    
    [imageROIfilename,~,filterindx]=uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
        '*.*','All Files' },'Select Previous ROI image',pathname);
    
    if imageROIfilename
        
        figure('Toolbar','none','Menubar','none','NumberTitle','off','Name','Last ROI');
        LastROI = imread(imageROIfilename);
        imshow(LastROI,[])
        
        % user buttons
        uicontrol('String','Reuse?',...
            'Callback',{@useLastROI,lastroipostion},...
            'units','normalized',...
            'position',[0 0 0.15 0.07]);
        
        uicontrol('String','Close',...
            'Callback','close(gcf)',...
            'units','normalized',...
            'position',[0.17 0 0.15 0.07]);
        
        % resume preview
        if ~isrunning(handles.vidObj)
            start(handles.vidObj)
        end
        
    end
end

guidata(hObject,handles);

    function useLastROI(obj,event,lastroiposition)
        %stop preview
        stop(handles.vidObj)
        
        handles.ROIposition = lastroiposition;
        set(handles.vidObj,'ROIposition',handles.ROIposition);
        
        %resume preview
        start(handles.vidObj)
        
    end
end

% --- Executes on button press in FullROI.
function FullROI_Callback(hObject, eventdata, handles)
% hObject    handle to FullROI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.vidObj == 0
    return
else
    %stop preview
    stop(handles.vidObj)
    
    %set to default ROI
    handles.ROIposition = [0 0 1024 1024];
    set(handles.vidObj,'ROIposition',handles.ROIposition);
    
    
    %resume preview
    start(handles.vidObj)
    
end

guidata(hObject,handles);

end


function animaltxt_Callback(hObject, eventdata, handles)
% hObject    handle to animaltxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of animaltxt as text
%        str2double(get(hObject,'String')) returns contents of animaltxt as a double

end


% --- Executes during object creation, after setting all properties.
function animaltxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to animaltxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function expttxt_Callback(hObject, eventdata, handles)
% hObject    handle to expttxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of expttxt as text
%        str2double(get(hObject,'String')) returns contents of expttxt as a double
end

% --- Executes during object creation, after setting all properties.
function expttxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expttxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function cameraStatus_Callback(hObject, eventdata, handles)
% hObject    handle to cameraStatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cameraStatus as text
%        str2double(get(hObject,'String')) returns contents of cameraStatus as a double

guidata(hObject,handles)
end

% --- Executes during object creation, after setting all properties.
function cameraStatus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraStatus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in displaySettings.
function displaySettings_Callback(hObject, eventdata, handles)
% hObject    handle to displaySettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get(handles.vidObj,'DiskLogger')
% Fraget(handles.vidObj,'FramesPerTrigger')
% FramesPerTrigger = get(handles.vidObj,'FramesPerTrigger')
CameraSettings;
set(findobj('Tag','disklogger'),'String',get(handles.vidObj,'DiskLogger'));
set(findobj('Tag','framesptrigger'),'String',get(handles.vidObj,'FramesPerTrigger'));
set(findobj('Tag','triggertype'),'String',get(handles.vidObj,'TriggerType'));
set(findobj('Tag','loggingmode'),'String',get(handles.vidObj,'LoggingMode'));
set(findobj('Tag','roiposition'),'String',num2str(get(handles.vidObj,'ROIposition')));

% set(findobj('Tag','camerasettings'),'String',get(handles.vidObj))
guidata(hObject,handles);
end
% --- Executes on button press in switchLED.
function switchLED_Callback(hObject, eventdata, handles)
% hObject    handle to switchLED (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global digitalOut
blueLEDstate = get(hObject,'Value');

if ~isempty(digitalOut)
    outputSingleScan(digitalOut,blueLEDstate); %switch blue light off if NI device is available
end

guidata(hObject,handles);

end

% --- Executes on button press in greenLedon.
function greenLedon_Callback(hObject, eventdata, handles)
% hObject    handle to greenLedon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of greenLedon

%get state of greenledon and redledon
global digitalOut
greenLEDstate = get(hObject,'Value');
blueLEDstate = get(findobj('Tag','blueLedon'),'Value');
redLEDstate = get(findobj('Tag','redLedon'),'Value');


AllLEDState  = [redLEDstate greenLEDstate blueLEDstate];
outputSingleScan(digitalOut, AllLEDState);
handles.AllLEDState = AllLEDState;
guidata(hObject,handles);

end


% --- Executes on button press in redLedon.
function redLedon_Callback(hObject, eventdata, handles)
% hObject    handle to redLedon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of redLedon

global digitalOut

redLEDstate = get(hObject,'Value');
greenLEDstate = get(findobj('Tag','greenLedon'),'Value');
blueLEDstate = get(findobj('Tag','blueLedon'),'Value');


AllLEDState  = [ redLEDstate greenLEDstate blueLEDstate];
outputSingleScan(digitalOut,AllLEDState);

handles.AllLEDState = AllLEDState;
guidata(hObject,handles);

end


% --- Executes when user attempts to close IntrinsicImagerGUI.
function IntrinsicImagerGUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to IntrinsicImagerGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%-->will need a flag to prevent accidently closing when running?
global Mstate digitalOut IntrinsicFlag


if ~isempty(IntrinsicFlag)
    
    stop(handles.vidObj);
    handles.vidObj.FramesAcquiredFcn = {};
    guidata(hObject,handles);
    delete(hObject);
    
else
    
    try
        if isfield(handles,'vidObj')
            
            if handles.vidObj ~=0
                vidObj = handles.vidObj;
                stop(vidObj);
                delete(vidObj);
                
                AllLEDState  = [0 0 0];
                outputSingleScan(digitalOut,AllLEDState);
                delete(digitalOut)
                
                Mstate.running = 0;
            end
        end
        
    catch
        imaqreset
        
    end
    delete(hObject);

end

end


% --- Executes on selection change in histogramlist.
function histogramlist_Callback(hObject, eventdata, handles)
% hObject    handle to histogramlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns histogramlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from histogramlist

end

% --- Executes during object creation, after setting all properties.
function histogramlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to histogramlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



function histpeak_Callback(hObject, eventdata, handles)
% hObject    handle to histpeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of histpeak as text
%        str2double(get(hObject,'String')) returns contents of histpeak as a double
end

% --- Executes during object creation, after setting all properties.
function histpeak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to histpeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

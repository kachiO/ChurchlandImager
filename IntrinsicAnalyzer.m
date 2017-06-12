function varargout = IntrinsicAnalyzer(varargin)
% INTRINSICANALYZER MATLAB code for IntrinsicAnalyzer.fig
%      INTRINSICANALYZER, by itself, creates a new INTRINSICANALYZER or raises the existing
%      singleton*.
%
%      H = INTRINSICANALYZER returns the handle to a new INTRINSICANALYZER or the handle to
%      the existing singleton*.
%
%      INTRINSICANALYZER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTRINSICANALYZER.M with the given input arguments.
%
%      INTRINSICANALYZER('Property','Value',...) creates a new INTRINSICANALYZER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IntrinsicAnalyzer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IntrinsicAnalyzer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IntrinsicAnalyzer

% Last Modified by GUIDE v2.5 15-May-2014 15:14:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IntrinsicAnalyzer_OpeningFcn, ...
                   'gui_OutputFcn',  @IntrinsicAnalyzer_OutputFcn, ...
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


% --- Executes just before IntrinsicAnalyzer is made visible.
function IntrinsicAnalyzer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IntrinsicAnalyzer (see VARARGIN)

global analyzerHandles

% Choose default command line output for IntrinsicAnalyzer
handles.output = hObject;

poststimFlag_Callback(findobj('Tag','poststimFlag'), eventdata, handles)

analyzerHandles.TrialSessionflag = 1; 
hImage = imshow(zeros(1024,1024),[],'parent',handles.axes1);

handles.settingsFig = figure('Name','Session Stimulus Settings','Toolbar','none','Menubar','none','numbertitle','off','Position',[100 50 300 400],'Visible','off');
handles.settingsLbox = uicontrol(handles.settingsFig,'style','listbox','position',[50 50 200 300]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IntrinsicAnalyzer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IntrinsicAnalyzer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function directoryTxt_Callback(hObject, eventdata, handles)
% hObject    handle to directoryTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of directoryTxt as text
%        str2double(get(hObject,'String')) returns contents of directoryTxt as a double


% --- Executes during object creation, after setting all properties.
function directoryTxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to directoryTxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in directoryButton.
function directoryButton_Callback(hObject, eventdata, handles)
% hObject    handle to directoryButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global analyzerHandles 
thisdirectory = uigetdir('','Select Directory');

if thisdirectory ~= 0
    
    analyzerHandles.directoryTxt = thisdirectory;
    set(findobj('Tag','directoryTxt'),'String',thisdirectory)
    
    %change to selected directory and display *.mat data files
    cd(thisdirectory)
    datafiles = ls('*_data.mat');
    set(findobj('Tag','fileListBox'),'String',datafiles)
    analyzerHandles.datafiles = datafiles;
    
    set(findobj('Tag','fileListBox'),'Value',1)
    fileListBox_Callback(hObject, eventdata, handles);
    
    
    %load analyzer file to get stimulus parameters
    analyzerfile  = ls('*.analyzer.mat');
    
    if ~isempty(analyzerfile)
        
        load(analyzerfile);
        params = Analyzer.P.param;
        paramStruct = getParam(params);
        
        analyzerHandles.ParamList = paramStruct;
        names = fieldnames(paramStruct);
        try 
            vals = cell2mat(struct2cell(paramStruct));
            
            prestimtime = vals(strcmpi('prestimdelay',names));
            stimtime = vals(strcmpi('stimduration',names));
            poststimtime = vals(strcmpi('poststimdelay',names));
            
            set(findobj('Tag','prestimTime'),'String',num2str(prestimtime));
            set(findobj('Tag','stimTime'),'String',num2str(stimtime));
            set(findobj('Tag','poststimTime'),'String',num2str(poststimtime));
            
            
        catch
            
        end
        
        s = refreshParamView(params);
        set(handles.settingsLbox,'String',s);
    end
    
end

guidata(hObject,handles);

function s = refreshParamView(params)
 
s = cell(1,length(params));
for i = 1:length(params)
    p = params{i};
    
    s{i} = [' ' p{1} ':   ' num2str(p{3}) ' ' p{5} '     ' ];
    
end

function PStruct = getParam(P)

for i = 1:length(P)
    eval(['PStruct.' P{i}{1} '= P{i}{3} ;'])
    
end


% --- Executes on button press in fileListBox.
function fileListBox_Callback(hObject, eventdata, handles)
% hObject    handle to fileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fileListBox
global analyzerHandles
    set(findobj('Tag','analyzebutton'),'Enable','off');
    set(findobj('Tag','frameNumSlider'),'Enable','on');

%get file position in list
filepointer = get(hObject,'Value');

if ~isempty(analyzerHandles.datafiles)
    %load file
    
    thisfilename = analyzerHandles.datafiles(filepointer,:);
    load(thisfilename);
      set(findobj('Tag','analyzebutton'),'Enable','on');

    data = squeeze(IntrinsicData.data);%store data structure

    numframes = size(data,3);
    analyzerHandles.Data = data;
    analyzerHandles.numframes = numframes;
        
    set(findobj('Tag','frameNumSlider'),'Value',1);
    set(findobj('Tag','frameNo'),'String',num2str(1));
    frameNumSlider_Callback(findobj('Tag','frameNumSlider'),eventdata,handles);
    
    %compute framerate
    avgtimediff = mean(diff(IntrinsicData.timestamps));
    framerate = 1 /avgtimediff;
    
    set(findobj('Tag','frameRate'),'String',num2str(framerate));
    
    if isfield(IntrinsicData,'trialNo')
        trialNo = IntrinsicData.trialNo;
        trialCondition = IntrinsicData.stimParam;
        trialConditionVal = IntrinsicData.stimParamVal;
        
        set(findobj('Tag','trialno'),'String',num2str(trialNo));drawnow
        set(findobj('Tag','stimparam'),'String',num2str(trialCondition));drawnow
        set(findobj('Tag','stimparamval'),'String',num2str(trialConditionVal));drawnow
        
%         set(findobj('Tag','ledColor'),'String',IntrinsicData.LEDcolor);drawnow
    end

end


guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function fileListBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileListBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function frameNumSlider_Callback(hObject, eventdata, handles)
% hObject    handle to frameNumSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global analyzerHandles
if isfield(analyzerHandles,'Data')
    
    set(hObject,'Max',analyzerHandles.numframes);
    frame = round(get(hObject,'Value'));
    set(findobj('Tag','frameNo'),'String',num2str(frame));drawnow
    frametoshow = analyzerHandles.Data(:,:,frame);
    imshow(frametoshow,[],'parent',handles.axes1);
end

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function frameNumSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameNumSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function prestimTime_Callback(hObject, eventdata, handles)
% hObject    handle to prestimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prestimTime as text
%        str2double(get(hObject,'String')) returns contents of prestimTime as a double
global analyzerHandles
analyzerHandles.prestimTime = str2double(get(hObject,'String'));

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function prestimTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prestimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stimTime_Callback(hObject, eventdata, handles)
% hObject    handle to stimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimTime as text
%        str2double(get(hObject,'String')) returns contents of stimTime as a double
global analyzerHandles
analyzerHandles.stimTime = str2double(get(hObject,'String'));

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function stimTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poststimTime_Callback(hObject, eventdata, handles)
% hObject    handle to poststimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poststimTime as text
%        str2double(get(hObject,'String')) returns contents of poststimTime as a double
global analyzerHandles

analyzerHandles.poststimTime = str2double(get(hObject,'String'));
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function poststimTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poststimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in analyzebutton.
function analyzebutton_Callback(hObject, eventdata, handles)
% hObject    handle to analyzebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global analyzerHandles

if get(hObject,'Value')
    
analysisTypeMenu_Callback(findobj('Tag','analysisTypeMenu'), eventdata, handles)
analyzeTrialFlag_Callback(findobj('Tag','analyzeTrialFlag'), eventdata, handles)

framerate  = str2double(get(findobj('Tag','frameRate'),'String'));

if analyzerHandles.TrialSessionflag
    %trial
    data = analyzerHandles.Data;
    
    
else
    %session analysis
    % need to collapse data
    numFiles = size(analyzerHandles.datafiles,1);
    sessionData = [];
    for f = 1:numFiles
        
        thisfilename = analyzerHandles.datafiles(f,:);
        load(thisfilename);
        
        thisdata = squeeze(IntrinsicData.data);
        
        sessionData = cat(4,sessionData,thisdata);
    end
    
    data = uint16(mean((sessionData),4)); %average trial sequence
    disp('done collapsing data')
end

prestim_range = framerate * (str2double(get(findobj('Tag','pre_start'),'String')) : str2double(get(findobj('Tag','pre_end'),'String')));
stim_range = framerate * (str2double(get(findobj('Tag','stim_start'),'String')) : str2double(get(findobj('Tag','stim_end'),'String')));
poststim_range = framerate * (str2double(get(findobj('Tag','post_start'),'String')) : str2double(get(findobj('Tag','post_end'),'String')));

totalNFrames = size(data,3);
prestimNFrames = framerate * str2double(get(findobj('Tag','prestimTime'),'String'));
stimNFrames = framerate * str2double(get(findobj('Tag','stimTime'),'String'));
poststimNFrames = framerate * str2double(get(findobj('Tag','poststimTime'),'String'));

%baseline correct all frames
if get(findobj('Tag','baselinecorrectflag'),'Value')
   
    averageprestim = uint16(mean(data(:,:,min(1+prestim_range):max(prestim_range)),3));
%     keyboard
    data_corrected = bsxfun(@minus,data,averageprestim);
    data = [];
    data = (data_corrected);
end

% select stimulus ON data
stimData = data(:,:,prestimNFrames+1:prestimNFrames+stimNFrames);
stimDataToUse = stimData(:,:,min(1+stim_range):max(stim_range));

%decide which baseline to use for analysis
if analyzerHandles.baselineFlag
    %use post stim as baseline
    baselineData = data(:,:,poststimNFrames+1:totalNFrames);
    baselineDataToUse = baselineData(:,:,min(1+poststim_range):max(poststim_range));
    
else
    %use pre stimulus as baseline
    baselineData = data(:,:,1:prestimNFrames);
    baselineDataToUse = baselineData(:,:,min(1+prestim_range):max(prestim_range));
end

meanStimData = uint16(mean(stimDataToUse,3)) ;
meanBaselineData = uint16( mean(baselineDataToUse,3));

switch(analyzerHandles.analysisType)
    
    case 'Ratio'
        %<stim> / <baseline>
%         disp('ratio analysis')
        analyzed = meanStimData./ meanBaselineData;
        
    case 'Fraction'
        %(<stim> - <baseline>) / <baseline>
%         disp('fration analysis')
        analyzed = (meanBaselineData - meanStimData ) ./ meanBaselineData;

    case 'Subtraction'
        %<stim> - <baseline>
%         disp('subtraction analysis')
        analyzed =  meanBaselineData - meanStimData;

        
end


imagesc(analyzed,'parent',handles.axes1);
    
set(findobj('Tag','frameNumSlider'),'Enable','off');
    
end

set(hObject,'Value',0)

guidata(hObject,handles);



% --- Executes on button press in viewAllSettingsButton.
function viewAllSettingsButton_Callback(hObject, eventdata, handles)
% hObject    handle to viewAllSettingsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(hObject,'Value')
    set(handles.settingsFig,'Visible','on');
    set(handles.settingsFig,'CloseRequestFcn',{@donotdeletefig,handles})
else
    set(handles.settingsFig,'Visible','off')
end
guidata(hObject,handles);

function donotdeletefig(obj,evt,handles)
set(handles.settingsFig,'Visible','off')
set(findobj('Tag','viewAllSettingsButton'),'Value',0)


function frameRate_Callback(hObject, eventdata, handles)
% hObject    handle to frameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frameRate as text
%        str2double(get(hObject,'String')) returns contents of frameRate as a double


% --- Executes during object creation, after setting all properties.
function frameRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in analysisTypeMenu.
function analysisTypeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to analysisTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns analysisTypeMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from analysisTypeMenu
global analyzerHandles
contents = cellstr(get(hObject,'String'));
selection = contents{get(hObject,'Value')};
analyzerHandles.analysisType = selection;

guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function analysisTypeMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to analysisTypeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in analyzeTrialFlag.
function analyzeTrialFlag_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeTrialFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global analyzerHandles
% Hint: get(hObject,'Value') returns toggle state of analyzeTrialFlag
if get(hObject,'Value')
     %analyze trial
    set(findobj('Tag','analyzeSessionFlag'),'Value',0)
    analyzerHandles.TrialSessionflag = 1; 
else
     %analyze session
    analyzerHandles.TrialSessionflag = 0;
end
guidata(hObject,handles)

% --- Executes on button press in analyzeSessionFlag.
function analyzeSessionFlag_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeSessionFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global analyzerHandles

if get(hObject,'Value')
    %analyze session
    set(findobj('Tag','analyzeTrialFlag'),'Value',0)
    analyzerHandles.TrialSessionflag = 0;

else
    %analyze trial
    analyzerHandles.TrialSessionflag = 1;

end
guidata(hObject,handles)

% Hint: get(hObject,'Value') returns toggle state of analyzeSessionFlag


% --- Executes on button press in prestimFlag.
function prestimFlag_Callback(hObject, eventdata, handles)
% hObject    handle to prestimFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global analyzerHandles
% Hint: get(hObject,'Value') returns toggle state of prestimFlag
if get(hObject,'Value')
    set(findobj('Tag','poststimFlag'),'Value',0)
    analyzerHandles.baselineFlag = 0;
else
    analyzerHandles.baselineFlag = 1;
end
guidata(hObject,handles)


% --- Executes on button press in poststimFlag.
function poststimFlag_Callback(hObject, eventdata, handles)
% hObject    handle to poststimFlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global analyzerHandles
% Hint: get(hObject,'Value') returns toggle state of poststimFlag
if get(hObject,'Value')
    set(findobj('Tag','prestimFlag'),'Value',0)
    analyzerHandles.baselineFlag = 1;
else
    analyzerHandles.baselineFlag = 0;
end
guidata(hObject,handles)



function trialno_Callback(hObject, eventdata, handles)
% hObject    handle to trialno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trialno as text
%        str2double(get(hObject,'String')) returns contents of trialno as a double


% --- Executes during object creation, after setting all properties.
function trialno_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trialno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function stimparam_Callback(hObject, eventdata, handles)
% hObject    handle to stimparam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimparam as text
%        str2double(get(hObject,'String')) returns contents of stimparam as a double


% --- Executes during object creation, after setting all properties.
function stimparam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimparam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function stimparamval_Callback(hObject, eventdata, handles)
% hObject    handle to stimparamval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stimparamval as text
%        str2double(get(hObject,'String')) returns contents of stimparamval as a double


% --- Executes during object creation, after setting all properties.
function stimparamval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stimparamval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ledColor_Callback(hObject, eventdata, handles)
% hObject    handle to ledColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ledColor as text
%        str2double(get(hObject,'String')) returns contents of ledColor as a double


% --- Executes during object creation, after setting all properties.
function ledColor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ledColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function frameNo_Callback(hObject, eventdata, handles)
% hObject    handle to frameNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frameNo as text
%        str2double(get(hObject,'String')) returns contents of frameNo as a double


% --- Executes during object creation, after setting all properties.
function frameNo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameNo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pre_start_Callback(hObject, eventdata, handles)
% hObject    handle to pre_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pre_start as text
%        str2double(get(hObject,'String')) returns contents of pre_start as a double


% --- Executes during object creation, after setting all properties.
function pre_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pre_end_Callback(hObject, eventdata, handles)
% hObject    handle to pre_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pre_end as text
%        str2double(get(hObject,'String')) returns contents of pre_end as a double


% --- Executes during object creation, after setting all properties.
function pre_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stim_start_Callback(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_start as text
%        str2double(get(hObject,'String')) returns contents of stim_start as a double


% --- Executes during object creation, after setting all properties.
function stim_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stim_end_Callback(hObject, eventdata, handles)
% hObject    handle to stim_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stim_end as text
%        str2double(get(hObject,'String')) returns contents of stim_end as a double


% --- Executes during object creation, after setting all properties.
function stim_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stim_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function post_start_Callback(hObject, eventdata, handles)
% hObject    handle to post_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of post_start as text
%        str2double(get(hObject,'String')) returns contents of post_start as a double


% --- Executes during object creation, after setting all properties.
function post_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to post_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function post_end_Callback(hObject, eventdata, handles)
% hObject    handle to post_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of post_end as text
%        str2double(get(hObject,'String')) returns contents of post_end as a double


% --- Executes during object creation, after setting all properties.
function post_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to post_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in baselinecorrectflag.
function baselinecorrectflag_Callback(hObject, eventdata, handles)
% hObject    handle to baselinecorrectflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of baselinecorrectflag

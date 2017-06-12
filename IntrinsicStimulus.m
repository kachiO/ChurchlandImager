function varargout = IntrinsicStimulus(varargin)

%-obsolete

% INTRINSICSTIMULUS MATLAB code for IntrinsicStimulus.fig
%      INTRINSICSTIMULUS, by itself, creates a new INTRINSICSTIMULUS or raises the existing
%      singleton*.
%
%      H = INTRINSICSTIMULUS returns the handle to a new INTRINSICSTIMULUS or the handle to
%      the existing singleton*.
%
%      INTRINSICSTIMULUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTRINSICSTIMULUS.M with the given input arguments.
%
%      INTRINSICSTIMULUS('Property','Value',...) creates a new INTRINSICSTIMULUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IntrinsicStimulus_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IntrinsicStimulus_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IntrinsicStimulus

% Last Modified by GUIDE v2.5 19-Feb-2014 20:18:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IntrinsicStimulus_OpeningFcn, ...
                   'gui_OutputFcn',  @IntrinsicStimulus_OutputFcn, ...
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


% --- Executes just before IntrinsicStimulus is made visible.
function IntrinsicStimulus_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IntrinsicStimulus (see VARARGIN)

% Choose default command line output for IntrinsicStimulus
handles.output = hObject;

global VisualParams

DriftGratingParameters;
hVisLbox = findobj('Tag','VisParams');
populateParameters(hVisLbox,VisualParams);

handles.VisualParams = VisualParams;

% Update handles structure
guidata(hObject, handles);




% UIWAIT makes IntrinsicStimulus wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IntrinsicStimulus_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function StimTime_Callback(hObject, eventdata, handles)
% hObject    handle to StimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StimTime as text
%        str2double(get(hObject,'String')) returns contents of StimTime as a double


% --- Executes during object creation, after setting all properties.
function StimTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in VisualStimType.
function VisualStimType_Callback(hObject, eventdata, handles)
% hObject    handle to VisualStimType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns VisualStimType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from VisualStimType


% --- Executes during object creation, after setting all properties.
function VisualStimType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VisualStimType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PreStimTime_Callback(hObject, eventdata, handles)
% hObject    handle to PreStimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PreStimTime as text
%        str2double(get(hObject,'String')) returns contents of PreStimTime as a double


% --- Executes during object creation, after setting all properties.
function PreStimTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PreStimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PostStimTime_Callback(hObject, eventdata, handles)
% hObject    handle to PostStimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PostStimTime as text
%        str2double(get(hObject,'String')) returns contents of PostStimTime as a double


% --- Executes during object creation, after setting all properties.
function PostStimTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PostStimTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numRepeats_Callback(hObject, eventdata, handles)
% hObject    handle to numRepeats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numRepeats as text
%        str2double(get(hObject,'String')) returns contents of numRepeats as a double


% --- Executes during object creation, after setting all properties.
function numRepeats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numRepeats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sendVisButton.
function sendVisButton_Callback(hObject, eventdata, handles)
% hObject    handle to sendVisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in playVisButton.
function playVisButton_Callback(hObject, eventdata, handles)
% hObject    handle to playVisButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function numTrials_Callback(hObject, eventdata, handles)
% hObject    handle to numTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numTrials as text
%        str2double(get(hObject,'String')) returns contents of numTrials as a double


% --- Executes during object creation, after setting all properties.
function numTrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numTrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editVisParam_Callback(hObject, eventdata, handles)
% hObject    handle to editVisParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVisParam as text
%        str2double(get(hObject,'String')) returns contents of editVisParam as a double

global VisualParams

newparamvalue = str2double(get(hObject,'String')); %new parameter value
selection = get(findobj('Tag','VisParams'),'Value'); %user selection

% based on selection find corresponding parameter value
allvisparams = fieldnames(VisualParams);
eval(['VisualParams.' allvisparams{selection} ' = newparamvalue;' ]);

%update parameter list
populateParameters(findobj('Tag','VisParams'),VisualParams);

handles.VisualParams = VisualParams;

%update GUI handles
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function editVisParam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVisParam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in VisParams.
function VisParams_Callback(hObject, eventdata, handles)
% hObject    handle to VisParams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns VisParams contents as cell array
%        contents{get(hObject,'Value')} returns selected item from VisParams

selection  = get(hObject,'Value'); %get index of selected parameter

global VisualParams

% based on selection find corresponding parameter value
allvisparams = fieldnames(VisualParams);
thisvisparam = eval(['VisualParams.' allvisparams{selection}]);

%display parameter in edit box
if selection ~=  1
    set(findobj('Tag','editVisParam'),'Enable','On');
    set(findobj('Tag','editVisParam'),'String',num2str(thisvisparam));
else
    %make the first parameter uneditable
    set(findobj('Tag','editVisParam'),'String','');
    set(findobj('Tag','editVisParam'),'Enable','Off');

end

%update GUI handekes
guidata(hObject,handles)


    


% --- Executes during object creation, after setting all properties.
function VisParams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VisParams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

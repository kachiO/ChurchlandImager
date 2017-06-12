function varargout = CameraSettings(varargin)
% CAMERASETTINGS MATLAB code for CameraSettings.fig
%      CAMERASETTINGS, by itself, creates a new CAMERASETTINGS or raises the existing
%      singleton*.
%
%      H = CAMERASETTINGS returns the handle to a new CAMERASETTINGS or the handle to
%      the existing singleton*.
%
%      CAMERASETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAMERASETTINGS.M with the given input arguments.
%
%      CAMERASETTINGS('Property','Value',...) creates a new CAMERASETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CameraSettings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CameraSettings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CameraSettings

% Last Modified by GUIDE v2.5 20-Jan-2014 15:51:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CameraSettings_OpeningFcn, ...
                   'gui_OutputFcn',  @CameraSettings_OutputFcn, ...
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


% --- Executes just before CameraSettings is made visible.
function CameraSettings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CameraSettings (see VARARGIN)

% Choose default command line output for CameraSettings
handles.output = hObject;

% set(findobj(),'String')

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CameraSettings wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CameraSettings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in camerasettings.
function camerasettings_Callback(hObject, eventdata, handles)
% hObject    handle to camerasettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns camerasettings contents as cell array
%        contents{get(hObject,'Value')} returns selected item from camerasettings


% --- Executes during object creation, after setting all properties.
function camerasettings_CreateFcn(hObject, eventdata, handles)
% hObject    handle to camerasettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disklogger_Callback(hObject, eventdata, handles)
% hObject    handle to disklogger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disklogger as text
%        str2double(get(hObject,'String')) returns contents of disklogger as a double


% --- Executes during object creation, after setting all properties.
function disklogger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disklogger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function framesptrigger_Callback(hObject, eventdata, handles)
% hObject    handle to framesptrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of framesptrigger as text
%        str2double(get(hObject,'String')) returns contents of framesptrigger as a double


% --- Executes during object creation, after setting all properties.
function framesptrigger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to framesptrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function triggertype_Callback(hObject, eventdata, handles)
% hObject    handle to triggertype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of triggertype as text
%        str2double(get(hObject,'String')) returns contents of triggertype as a double


% --- Executes during object creation, after setting all properties.
function triggertype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to triggertype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loggingmode_Callback(hObject, eventdata, handles)
% hObject    handle to loggingmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loggingmode as text
%        str2double(get(hObject,'String')) returns contents of loggingmode as a double


% --- Executes during object creation, after setting all properties.
function loggingmode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loggingmode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function roiposition_Callback(hObject, eventdata, handles)
% hObject    handle to roiposition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of roiposition as text
%        str2double(get(hObject,'String')) returns contents of roiposition as a double


% --- Executes during object creation, after setting all properties.
function roiposition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roiposition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

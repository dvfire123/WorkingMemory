function varargout = openingScreen(varargin)
% OPENINGSCREEN MATLAB code for openingScreen.fig
%      OPENINGSCREEN, by itself, creates a new OPENINGSCREEN or raises the existing
%      singleton*.
%
%      H = OPENINGSCREEN returns the handle to a new OPENINGSCREEN or the handle to
%      the existing singleton*.
%
%      OPENINGSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPENINGSCREEN.M with the given input arguments.
%
%      OPENINGSCREEN('Property','Value',...) creates a new OPENINGSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before openingScreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to openingScreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help openingScreen

% Last Modified by GUIDE v2.5 06-Nov-2015 16:29:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @openingScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @openingScreen_OutputFcn, ...
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


% --- Executes just before openingScreen is made visible.
function openingScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to openingScreen (see VARARGIN)
global latestFile dataFolder;

[folder, ~, ~] = fileparts(mfilename('fullpath'));
if isdeployed
    folder = pwd;
end

dataFolder = fullfile(folder, 'UserData');
if ~exist(dataFolder, 'dir')
    mkdir(dataFolder);
end

latestFile = fullfile(dataFolder, 'latest.txt');
if ~exist(latestFile, 'file')
    fid = fopen(latestFile, 'wt+');
    fclose(fid);
end

%Read the latest test input file, if available
fid = fopen(latestFile, 'r');
latestTestParamsFile = fgetl(fid);
fclose(fid);

%Load the test inputs, if possible
if ischar(latestTestParamsFile)
    %There is latest file path
    %Load it
    inputs = loadTestParamsFromFile(latestTestParamsFile);
    
    if ~isempty(inputs)
        loadInputs(handles, inputs);
    end
end

% Choose default command line output for openingScreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes openingScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = openingScreen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function fn_Callback(hObject, eventdata, handles)
% hObject    handle to fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fn as text
%        str2double(get(hObject,'String')) returns contents of fn as a double


% --- Executes during object creation, after setting all properties.
function fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ln_Callback(hObject, eventdata, handles)
% hObject    handle to ln (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ln as text
%        str2double(get(hObject,'String')) returns contents of ln as a double


% --- Executes during object creation, after setting all properties.
function ln_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ln (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in titleButton.
function titleButton_Callback(hObject, eventdata, handles)
% hObject    handle to titleButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(descriptionBox);



function NR_Callback(hObject, eventdata, handles)
% hObject    handle to NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NR as text
%        str2double(get(hObject,'String')) returns contents of NR as a double
NR = str2double(get(hObject, 'String'));
NR = min(20, max(1, NR));   %max is not shown to the user
set(hObject, 'String', num2str(NR));


% --- Executes during object creation, after setting all properties.
function NR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in consOption.
function consOption_Callback(hObject, eventdata, handles)
% hObject    handle to consOption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of consOption


% --- Executes on button press in digOption.
function digOption_Callback(hObject, eventdata, handles)
% hObject    handle to digOption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of digOption


function DR_Callback(hObject, eventdata, handles)
% hObject    handle to DR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DR as text
%        str2double(get(hObject,'String')) returns contents of DR as a double
DR = str2double(get(hObject, 'String'));
DR = max(1, DR); 
set(hObject, 'String', num2str(DR));


% --- Executes during object creation, after setting all properties.
function DR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function TR2_Callback(hObject, eventdata, handles)
% hObject    handle to TR2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TR2 as text
%        str2double(get(hObject,'String')) returns contents of TR2 as a double
TR = str2double(get(hObject, 'String'));
TR = max(1, TR); 
set(hObject, 'String', num2str(TR));


% --- Executes during object creation, after setting all properties.
function TR2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TR2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function DA_Callback(hObject, eventdata, handles)
% hObject    handle to DA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DA as text
%        str2double(get(hObject,'String')) returns contents of DA as a double
DA = str2double(get(hObject, 'String'));
DA = max(1, DA); 
set(hObject, 'String', num2str(DA));


% --- Executes during object creation, after setting all properties.
function DA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NT_Callback(hObject, eventdata, handles)
% hObject    handle to NT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NT as text
%        str2double(get(hObject,'String')) returns contents of NT as a double
NT = str2double(get(hObject, 'String'));
NT = max(1, NT); 
set(hObject, 'String', num2str(NT));


% --- Executes during object creation, after setting all properties.
function NT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in quitButton.
function quitButton_Callback(hObject, eventdata, handles)
% hObject    handle to quitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in goButton.
function goButton_Callback(hObject, eventdata, handles)
% hObject    handle to goButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataFolder;

%First: save user inputs
inputs = saveToAppData(handles);
fileName = saveTestParamsToFile(dataFolder, inputs);
updateLatest(fileName);

%Next: show recall stimulus
%(TODO)


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dataFolder;
inputs = readInputs(handles);
fileName = saveTestParamsToFile(dataFolder, inputs);
updateLatest(fileName);
msg = sprintf('File saved to:\n%s!', fileName);
msgbox(msg);


% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName, path, ~] = uigetfile('.wmtp', 'Please select a .wmtp file');
if fileName == 0
    return;
end

file = fullfile(path, fileName);
inputs = loadTestParamsFromFile(file);
loadInputs(handles, inputs);
updateLatest(fileName);


% --- Executes on button press in creditButton.
function creditButton_Callback(hObject, eventdata, handles)
% hObject    handle to creditButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(cBox);

%%--Helpers--
function inputs = readInputs(handles)
%outputs what the user input
counter = 1;
fn = get(handles.fn, 'string');
inputs{counter} = fn;
counter = counter + 1;

ln = get(handles.ln, 'string');
inputs{counter} = ln;
counter = counter + 1;

nr = get(handles.NR, 'string');
inputs{counter} = nr;
counter = counter + 1;

isCons = num2str(get(handles.consOption, 'value'));
inputs{counter} = isCons;
counter = counter + 1;

dr = get(handles.DR, 'string');
inputs{counter} = dr;
counter = counter + 1;

tr = get(handles.TR2, 'string');
inputs{counter} = tr;
counter = counter + 1;

da = get(handles.DA, 'string');
inputs{counter} = da;
counter = counter + 1;

nt = get(handles.NT, 'string');
inputs{counter} = nt;


function loadInputs(handles, inputs)
counter = 1;
set(handles.fn, 'string', inputs{counter});
counter = counter + 1;

set(handles.ln, 'string', inputs{counter});
counter = counter + 1;

set(handles.NR, 'string', inputs{counter});
counter = counter + 1;

isCons = str2double(inputs{counter});
if isCons == 1
    set(handles.consOption, 'value', 1);
    set(handles.digOption, 'value', 0);
else
    set(handles.consOption, 'value', 0);
    set(handles.digOption, 'value', 1); 
end
counter = counter + 1;

set(handles.DR, 'string', inputs{counter});
counter = counter + 1;

set(handles.TR2, 'string', inputs{counter});
counter = counter + 1;

set(handles.DA, 'string', inputs{counter});
counter = counter + 1;

set(handles.NT, 'string', inputs{counter});


function inputs = saveToAppData(handles)
%Save the test input params to appdata
%to transfer to other figures
inputs = readInputs(handles);
setappdata(0, 'inputs', inputs);


function updateLatest(fileName)
%Updates the latest file
global dataFolder latestFile;
file = fullfile(dataFolder, fileName);
fid = fopen(latestFile, 'wt+');
fprintf(fid, '%s', file);
fclose(fid);

function varargout = trialScreen(varargin)
% TRIALSCREEN MATLAB code for trialScreen.fig
%      TRIALSCREEN, by itself, creates a new TRIALSCREEN or raises the existing
%      singleton*.
%
%      H = TRIALSCREEN returns the handle to a new TRIALSCREEN or the handle to
%      the existing singleton*.
%
%      TRIALSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRIALSCREEN.M with the given input arguments.
%
%      TRIALSCREEN('Property','Value',...) creates a new TRIALSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trialScreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trialScreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trialScreen

% Last Modified by GUIDE v2.5 07-Nov-2015 13:14:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trialScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @trialScreen_OutputFcn, ...
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


% --- Executes just before trialScreen is made visible.
function trialScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trialScreen (see VARARGIN)
global inputs resultsFolder;
global NR isCons DR TR DA NT;
global isIntro isAp trialCount;
global DRtimer TRtimer DAtimer DRtimeleft TRtimeleft DAtimeleft;
global corrStr totAns percentRight; %for the APs

%A bunch of labels need to be turned off to begin the screen
turnOffNonReadyLabels(handles);

%Making results folder
[folder, ~, ~] = fileparts(mfilename('fullpath'));
if isdeployed
    folder = pwd;
end

resultsFolder = fullfile(folder, 'Results');
if ~exist(resultsFolder, 'dir')
    mkdir(resultsFolder);
end

%Records user inputs for generating trials
inputs = getappdata(0, 'inputs');
if isempty(inputs)
   close;
   errordlg('Test Parameters Missing!');
   return;
end

NR = str2double(inputs{3});
isCons = str2double(inputs{4});
DR = str2double(inputs{5});
TR = str2double(inputs{6});
DA = str2double(inputs{7});
NT = str2double(inputs{8});

%Additional settings
isIntro = 1;
isAp = 0;
trialCount = 1;
corrStr = '--';
totAns = 0;
percentRight = '--';

%display the trialLabel
trialText = sprintf('Trial: %d of %d', trialCount, NT);
set(handles.trialLabel, 'string', trialText);

%%--Timers--%%
DRtimer = timer;
DRtimer.period = 1; %counts down in seconds intervals
set(DRtimer,'ExecutionMode','fixedrate','StartDelay', 0);
set(DRtimer, 'StartFcn', {@showRecallStim, handles});
set(DRtimer, 'TimerFcn', {@countDown, handles, 1});
set(DRtimer, 'StopFcn', {@startAp, handles});
DRtimeleft = DR;

% Choose default command line output for trialScreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trialScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%--Timer Callbacks--%%
%DR start
function showRecallStim(~, ~, handles)
global recallStim;
global isCons NR;
global DR DRtimeleft;

DRtimeleft = DR;
recallStim = getRecallStim(isCons, NR);
set(handles.recallStimLabel, 'string', recallStim);
set(handles.recallStimLabel, 'visible', 'on');

%DR stop
function startAp(~, ~, handles)
global DR DRtimeleft;
global corrStr totAns percentRight res;

DRtimeleft = DR;
set(handles.enterRecall, 'visible', 'off');
set(handles.recallStimLabel, 'visible', 'off');

%creates the AP
[res, minuend, answer] = makeAp();
msg = sprintf('%s: %s\n%s: %d\n%s: %s percent', ...
    'Previous Answer', corrStr, ...
    'Total number correct answers thus far: ', totAns,...
    'Total percent correct thus far: ', percentRight...
    );
set(handles.overallScore, 'string', msg);
set(handles.clickInstrLabel, 'visible', 'on');
set(handles.overallScore, 'visible', 'on');

minStr = num2str(minuend);
ansStr = num2str(answer);
apText = sprintf('%s\n-3\n-----\n%s',...
    minStr, ansStr);
set(handles.apLabel, 'string', apText);
set(handles.apLabel, 'visible', 'on');


%All three timers timerfcn
function countDown(~, ~, handles, type)
%1: DR countdown
%2: TR countdown
%3: DA countdown
global DRtimer TRtimer DAtimer DRtimeleft TRtimeleft DAtimeleft;
switch type
    case 1
      DRtimeleft = DRtimeleft - 1;
      if DRtimeleft <= 0
          stop(DRtimer);
      end
    case 2
      TRtimeleft = TRtimeleft - 1;
      if TRtimeleft <= 0
          stop(TRtimer);
      end
    case 3
      DAtimeleft = DAtimeleft - 1;
      if DAtimeleft <= 0
          stop(DAtimer);
      end 
end
%%--End Timer Callbacks--%%

% --- Outputs from this function are returned to the command line.
function varargout = trialScreen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
global isIntro;

keyPressed = eventdata.Key;
switch keyPressed
    case 'space'
        if isIntro == 1
            moveToTest(handles);
        end
    case 'k'
        %This is just for debugging
        %will remove in the end
        goToBeginningOfTrial(handles);
end

%%--helpers--
function goToBeginningOfTrial(handles)
%User front end to return test screen to beginning of a trial
%TODO: a bunch of stuff goes away
global isIntro trialCount NT;

if trialCount == NT
   close;
   figure(endScreen);
   return;
end

isIntro = 1;
trialCount = trialCount + 1;
set(handles.trialLabel, 'string',...
    sprintf('Trial: %d of %d', trialCount, NT));
turnOffNonReadyLabels(handles);
set(handles.contLabel, 'visible', 'on');
set(handles.trialLabel, 'visible', 'on');

function moveToTest(handles)
%User begins the test
global isIntro DRtimer;
isIntro = 0;
set(handles.contLabel, 'visible', 'off');
set(handles.trialLabel, 'visible', 'off');

%Shows the stimulus
set(handles.rememberLabel, 'visible', 'on');
start(DRtimer);

function turnOffNonReadyLabels(handles)
%All labels not included in the ready page will be turned off here

%recall stim
set(handles.rememberLabel, 'visible', 'off');
set(handles.recallStimLabel, 'visible', 'off');

%ap
set(handles.clickInstrLabel, 'visible', 'off');
set(handles.apRes, 'visible', 'off');
set(handles.apLabel, 'visible', 'off');

%final recall
set(handles.enterRecall, 'visible', 'off');
set(handles.recall, 'visible', 'off');
set(handles.overallScore, 'visible', 'off');
set(handles.nextSpace, 'visible', 'off');


function recall_Callback(hObject, eventdata, handles)
% hObject    handle to recall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of recall as text
%        str2double(get(hObject,'String')) returns contents of recall as a double


% --- Executes during object creation, after setting all properties.
function recall_CreateFcn(hObject, eventdata, handles)
% hObject    handle to recall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

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

% Last Modified by GUIDE v2.5 10-Nov-2015 11:38:47

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
global inputs resultsFolder resFile;
global NR isCons DR TR DA NT;
global isIntro isAp isTypingRecall trialCount;
global DRtimer TRtimer DAtimer DRtimeleft TRtimeleft;
global corrStr totAns percentRight corrCount; %for the APs

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
isTypingRecall = 0;
trialCount = 1;
corrStr = 'N/A';
totAns = 0;
percentRight = 'N/A';
corrCount = zeros(6, 1);

%display the trialLabel
trialText = sprintf('Trial: %d of %d', trialCount, NT);
set(handles.trialLabel, 'string', trialText);

%%--User Logging--%%
%Logs the header for the experiment run
fn = inputs{1};
ln = inputs{2};
resFileName = sprintf('%s-%s-out.txt', fn, ln);
resFile = fullfile(resultsFolder, resFileName);

if ~exist(resFile, 'file')
   fid = fopen(resFile, 'wt+');
   fclose(fid);
end

fid = fopen(resFile, 'at+');    %appending results
fprintf(fid, 'Name %s %s\n', fn, ln);
fprintf(fid, '%s\n\n', datestr(now));    %timestamp
fprintf(fid, 'NR--Number of recall items %d\n', NR);
typeRecall = 'Consonants';
if isCons == 0
   typeRecall = 'Digits'; 
end
fprintf(fid, 'Type of recall item %s\n', typeRecall);
fprintf(fid, 'DR--Time of which recall stimulus is displayed (s) %f\n', DR);
fprintf(fid, 'TR--Total time of evaluating all arithmetic problems (s) %f\n', TR);
fprintf(fid, 'DA--Maximum time of which each arithmetic problem is displayed (s) %f\n', DA);
fprintf(fid, 'NT--Number of Trials %d\n', NT);
fprintf(fid, '\nTrial Results:\n');
fclose(fid);

%%--Timers--%%
DRtimer = timer;
DRtimer.period = 1; %counts down in seconds intervals
set(DRtimer,'ExecutionMode','fixedrate','StartDelay', 0);
set(DRtimer, 'StartFcn', {@showRecallStim, handles});
set(DRtimer, 'TimerFcn', {@countDown, 1});
set(DRtimer, 'StopFcn', {@startAp, handles});
DRtimeleft = DR;

TRtimer = timer;
TRtimer.period = 1; %counts down in seconds intervals
set(TRtimer,'ExecutionMode','fixedrate','StartDelay', 0);
set(TRtimer, 'StartFcn', {@enterApMode, handles});
set(TRtimer, 'TimerFcn', {@countDown, 2});
set(TRtimer, 'StopFcn', {@letUserTypeRecall, handles});
TRtimeleft = TR;

DAtimer = timer;
DAtimer.period = DA; %every DA seconds new AP
set(DAtimer,'ExecutionMode','fixedrate','StartDelay', DA);
set(DAtimer, 'TimerFcn', {@logApNoResponse, handles});

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
global DR DRtimeleft TRtimer;

DRtimeleft = DR;
set(handles.enterRecall, 'visible', 'off');
set(handles.recallStimLabel, 'visible', 'off');

start(TRtimer);

%TR Start
function enterApMode(~, ~, handles)
global isAp totalAp;
global DAtimer;

isAp = 1;
totalAp = 0;
showNextAp(handles);
start(DAtimer);

%TR Stop
function letUserTypeRecall(~, ~, handles)
global isAp DAtimer;
isAp = 0;
stop(DAtimer);
goToUserTypeRs(handles);

%DA Helper
function showNextAp(handles)
global corrStr totAns percentRight res;

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


%DA Timer Fcn
function logApNoResponse(~, ~, handles)
%If timed out
apResponse(2);
showNextAp(handles);


%Timerfcn for DR and TR
function countDown(~, ~, type)
%1: DR countdown
%2: TR countdown
%3: DA countdown
global DRtimer TRtimer DRtimeleft TRtimeleft;
switch type
    case 1
      DRtimeleft = DRtimeleft - 1;
      if DRtimeleft < 0
          stop(DRtimer);
      end
    case 2
      TRtimeleft = TRtimeleft - 1;
      if TRtimeleft < 0
          stop(TRtimer);
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
global isIntro isTypingRecall;
global isAp DAtimer;

keyPressed = eventdata.Key;
%disp(keyPressed);
switch keyPressed
    case 'space'
        if isIntro == 1
            moveToTest(handles);
        elseif isTypingRecall == 1
            logUserResponse();
            isTypingRecall = 0;
            isIntro = 1;
            goToBeginningOfTrial(handles);
        end
    case 'y'
        if isAp ~= 0
            apResponse(1);
            stop(DAtimer);
            showNextAp(handles);
            start(DAtimer);
        end
    case 'n'
        if isAp ~= 0
            apResponse(0);
            stop(DAtimer);
            showNextAp(handles);
            start(DAtimer);
        end
end

%%--helpers--%%
function logUserResponse()
global resFile NT trialCount recallStim userTyped;
global corrCount percentRight totalAp TR;
fid = fopen(resFile, 'at+');
if fid == -1
    msgbox('Error: cannot open results file!');
    return
end

if totalAp > 0
    avgTimePerAp = num2str(TR/totalAp);
else
    avgTimePerAp = 'N/A';
end

fprintf(fid, 'Trial %d out of %d\n\n', trialCount, NT);
fprintf(fid, 'Recall stimulus results:\n');
fprintf(fid, 'Actual %s\n', recallStim);
fprintf(fid, 'User typed %s\n', userTyped);
fprintf(fid, 'Arithmetic Problem Results:\n');
fprintf(fid, 'Number of "Correct" responses when actual answer is "Correct" %d\n', corrCount(1));
fprintf(fid, 'Number of "Incorrect" responses when actual answer is "Correct" %d\n', corrCount(2));
fprintf(fid, 'Number of "No response" responses when actual answer is "Correct" %d\n', corrCount(3));
fprintf(fid, 'Number of "Correct" responses when actual answer is "Incorrect" %d\n', corrCount(4));
fprintf(fid, 'Number of "Incorrect" responses when actual answer is "Incorrect" %d\n', corrCount(5));
fprintf(fid, 'Number of "No response" responses when actual answer is "Incorrect" %d\n', corrCount(6));
fprintf(fid, 'Percentage of responses correctly answered %d\n', percentRight);
fprintf(fid, 'Total number of arithmetic problems seen %d\n', totalAp);
fprintf(fid, 'Average time spent per arithmetic problem (s) %s\n', avgTimePerAp); 
fprintf(fid, '-----------\n\n');
fclose(fid);

function goToBeginningOfTrial(handles)
%User front end to return test screen to beginning of a trial
global isIntro trialCount NT isTypingRecall isAp;
global corrStr totAns percentRight;
global TR TRtimeleft DR DRtimeleft;

if trialCount == NT
   close;
   figure(endScreen);
   return;
end

%reset flags
isIntro = 1;
isAp = 0;
isTypingRecall = 0;
corrStr = 'N/A';
totAns = 0;
percentRight = 'N/A';

%Reset timers
TRtimeleft = TR;
DRtimeleft = DR;

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

function goToUserTypeRs(handles)
%Here the user is presented with window to type
%out the recall stimulus
global isTypingRecall isAp isIntro;
global totAns percentRight;

isTypingRecall = 1;
isIntro = 0;
isAp = 0;

%turn off all ap labels
set(handles.clickInstrLabel, 'visible', 'off');
set(handles.apRes, 'visible', 'off');
set(handles.apLabel, 'visible', 'off');

%turn on the recall stimulus labels
ovScoreText = sprintf('%s\n    %s: %d\n    %s: %s percent', ...
    'Your overall score on subtraction task', ...
    'Number of response correctly answered', totAns, ...
    'Percentage of correct answers', percentRight...
    );
set(handles.overallScore, 'string', ovScoreText);
set(handles.recall, 'string', '');  %clean the space to enter recall

set(handles.enterRecall, 'visible', 'on');
set(handles.recall, 'visible', 'on');
set(handles.overallScore, 'visible', 'on');
set(handles.nextSpace, 'visible', 'on');


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
global userTyped
userTyped = get(hObject, 'String');

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


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Ap Response:
function apResponse(responseType)
%responseTypes: 0--no, 1--yes, 2--no response
global res corrCount corrStr totAns totalAp percentRight;
totalAp = totalAp + 1;

switch responseType
    case 0
       %Response of No to AP
       if res == 0
          %'incorrect' response when actual = 'incorrect'
          corrStr = 'Correct';
          totAns = totAns + 1;
          corrCount(5) = corrCount(5) + 1;
       else
          corrStr = 'Incorrect';
          corrCount(2) = corrCount(2) + 1;
       end
    case 1
        %Response of Yes to AP
        if res == 1
          %'correct' response when actual = 'correct'
          corrStr = 'Correct';
          totAns = totAns + 1;
          corrCount(1) = corrCount(1) + 1;
       else
          corrStr = 'Incorrect';
          corrCount(4) = corrCount(4) + 1;
        end
    case 2
        %No response
        if res == 1
           corrCount(3) = corrCount(3) + 1;
        else
           corrCount(6) = corrCount(6) + 1; 
        end
        
        corrStr = 'Incorrect (No response given)';
end

percentRight = num2str(round((totAns/totalAp) * 100));

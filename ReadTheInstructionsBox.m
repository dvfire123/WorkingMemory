function varargout = ReadTheInstructionsBox(varargin)
% READTHEINSTRUCTIONSBOX MATLAB code for ReadTheInstructionsBox.fig
%      READTHEINSTRUCTIONSBOX, by itself, creates a new READTHEINSTRUCTIONSBOX or raises the existing
%      singleton*.
%
%      H = READTHEINSTRUCTIONSBOX returns the handle to a new READTHEINSTRUCTIONSBOX or the handle to
%      the existing singleton*.
%
%      READTHEINSTRUCTIONSBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in READTHEINSTRUCTIONSBOX.M with the given input arguments.
%
%      READTHEINSTRUCTIONSBOX('Property','Value',...) creates a new READTHEINSTRUCTIONSBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReadTheInstructionsBox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReadTheInstructionsBox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReadTheInstructionsBox

% Last Modified by GUIDE v2.5 06-Nov-2015 23:00:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReadTheInstructionsBox_OpeningFcn, ...
                   'gui_OutputFcn',  @ReadTheInstructionsBox_OutputFcn, ...
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


% --- Executes just before ReadTheInstructionsBox is made visible.
function ReadTheInstructionsBox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReadTheInstructionsBox (see VARARGIN)

msg = sprintf('%s\n\n%s\n%s\n%s\n%s\n\t\t\t%s\n\t\t\t%s\n\n%s\n%s\n%s\n%s\n\n%s\n%s', ...
    'You will now be presented with a list of items that you are required to remember.',...
    'After that you will be presented with a series of arithmetic subtraction problems.',...
    'About 50 percent of the problems will have the correct answer and the remaining ones',...
    'will have an incorrect answer.',...
    'After each subtraction problem:',...
    'click the Left mouse button if the solution given was Correct',...
    'click the Right mouse button if the solution given was Incorrect',...
    'In addition to remembering the original items, you also want to get as high a',...
    'score as possible on the arithmetic task.',...
    'To get a high score you must both get as many answers right as possible and try',...
    'as many problems as possible.',...
    'Responding as rapidly as possible means that you will be presented with more',...
    'subtraction problems, which in turn means that you can get a higher score.'...
    );

set(handles.instructions, 'string', msg);

% Choose default command line output for ReadTheInstructionsBox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReadTheInstructionsBox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReadTheInstructionsBox_OutputFcn(hObject, eventdata, handles) 
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
% determine the key that was pressed
keyPressed = eventdata.Key;
switch keyPressed
    case 'space'
        %continue to test
        %temp
        close;
end

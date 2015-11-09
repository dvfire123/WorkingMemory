function varargout = endScreen(varargin)
% ENDSCREEN MATLAB code for endScreen.fig
%      ENDSCREEN, by itself, creates a new ENDSCREEN or raises the existing
%      singleton*.
%
%      H = ENDSCREEN returns the handle to a new ENDSCREEN or the handle to
%      the existing singleton*.
%
%      ENDSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENDSCREEN.M with the given input arguments.
%
%      ENDSCREEN('Property','Value',...) creates a new ENDSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before endScreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to endScreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help endScreen

% Last Modified by GUIDE v2.5 09-Nov-2015 14:43:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @endScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @endScreen_OutputFcn, ...
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


% --- Executes just before endScreen is made visible.
function endScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to endScreen (see VARARGIN)

% Choose default command line output for endScreen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes endScreen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = endScreen_OutputFcn(hObject, eventdata, handles) 
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
key = eventdata.Key;
switch key
    case 'space'
        close;
        figure(openingScreen);
end

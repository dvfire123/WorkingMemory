function varargout = descriptionBox(varargin)
% DESCRIPTIONBOX MATLAB code for descriptionBox.fig
%      DESCRIPTIONBOX, by itself, creates a new DESCRIPTIONBOX or raises the existing
%      singleton*.
%
%      H = DESCRIPTIONBOX returns the handle to a new DESCRIPTIONBOX or the handle to
%      the existing singleton*.
%
%      DESCRIPTIONBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DESCRIPTIONBOX.M with the given input arguments.
%
%      DESCRIPTIONBOX('Property','Value',...) creates a new DESCRIPTIONBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before descriptionBox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to descriptionBox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help descriptionBox

% Last Modified by GUIDE v2.5 06-Nov-2015 10:05:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @descriptionBox_OpeningFcn, ...
                   'gui_OutputFcn',  @descriptionBox_OutputFcn, ...
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


% --- Executes just before descriptionBox is made visible.
function descriptionBox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to descriptionBox (see VARARGIN)
text = sprintf('%s\n%s\n%s\n%s\n%s', ...
    'In this experiment, participants are first shown', ...
    'a list of items, after which they are presented with a',...
    'series of mental arithmetic problems, at the end of which', ...
    'they are asked to recall as many items as possible from',...
    'the original list presented');

set(handles.blurbText, 'String', text);

% Choose default command line output for descriptionBox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes descriptionBox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = descriptionBox_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in okayButton.
function okayButton_Callback(hObject, eventdata, handles)
% hObject    handle to okayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;

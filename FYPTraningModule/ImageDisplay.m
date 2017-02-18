function varargout = ImageDisplay(varargin)
%ImageDisplay( 'parent', f, 'position', [0 0 0.4 0.7] );
%f=figure
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageDisplay_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageDisplay_OutputFcn, ...
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



% --- Executes just before ImageAnalysis is made visible.
function ImageDisplay_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
setappdata(0  , 'hIMaGui', gcf);
setappdata(gcf, 'i'      , 1);

% --- Outputs from this function are returned to the command line.
function varargout = ImageDisplay_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in LoadPics.
function LoadPics_Callback(hObject, eventdata, handles)

hIMaGui = getappdata(0, 'hIMaGui');
%imagefiles = dir('*.jpg');
imagefiles = dir('C:\Users\YASARA\Desktop\FYPTraningModule\testOutLeaf\*.jpg');

nfiles = length(imagefiles);    % Number of files found
%PathName='*.jpg';
PathName='C:\Users\YASARA\Desktop\FYPTraningModule\testOutLeaf\*.jpg';
if nfiles>0
for ii=1:nfiles
   FileName{ii} = imagefiles(ii).name;
end

%[FileName,PathName] = uigetfile({'*.jpg';'*.tif';'*.bmp'},'Select .mat files','MultiSelect','on');% Select multifiles or Single file.
if  iscell(FileName)
    k = max(size(FileName));
else
    k = 1;
    FileName={FileName};%Change String to string Array if select single file
end
setappdata(hIMaGui, 'PathName', PathName);
setappdata(hIMaGui, 'FileName', FileName);
setappdata(hIMaGui, 'k'       , k);

UpdateAxes;
end;



function UpdateAxes

hIMaGui = getappdata(0, 'hIMaGui');
PathName = getappdata(hIMaGui, 'PathName');
FileName = getappdata(hIMaGui, 'FileName');
i = getappdata(hIMaGui, 'i');
currentfilename = strcat('C:\Users\YASARA\Desktop\FYPTraningModule\testOutLeaf\', FileName{i});
IM = imread(currentfilename);
imshow(IM);
title(FileName{i});

function Next_Callback(hObject, eventdata, handles)
hIMaGui = getappdata(0, 'hIMaGui');
i = getappdata(hIMaGui, 'i');
k = getappdata(hIMaGui, 'k');
if i < k 
i = i + 1;
setappdata(hIMaGui, 'i', i);
UpdateAxes;
else
    message = 'This is the last picture.';
    disp(message);
end

function axes1_CreateFcn(hObject, eventdata, handles)

function Previous_Callback(hObject, eventdata, handles)

hIMaGui = getappdata(0, 'hIMaGui');
i = getappdata(hIMaGui, 'i');
if i > 1 
i = i - 1;
setappdata(hIMaGui, 'i', i);
UpdateAxes;
else
    message = 'This is the first picture.';
    disp(message);
end

function ImageDisplay_Callback(hObject, eventdata, handles)




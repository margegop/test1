function varargout = VirtualTrading_GUI(varargin)
% VIRTUALTRADING_GUI MATLAB code for VirtualTrading_GUI.fig
%      VIRTUALTRADING_GUI, by itself, creates a new VIRTUALTRADING_GUI or raises the existing
%      singleton*.
%
%      H = VIRTUALTRADING_GUI returns the handle to a new VIRTUALTRADING_GUI or the handle to
%      the existing singleton*.
%
%      VIRTUALTRADING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIRTUALTRADING_GUI.M with the given input arguments.
%
%      VIRTUALTRADING_GUI('Property','Value',...) creates a new VIRTUALTRADING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VirtualTrading_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VirtualTrading_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VirtualTrading_GUI

% Last Modified by GUIDE v2.5 08-Dec-2015 11:28:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VirtualTrading_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @VirtualTrading_GUI_OutputFcn, ...
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


% --- Executes just before VirtualTrading_GUI is made visible.
function VirtualTrading_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VirtualTrading_GUI (see VARARGIN)

% handles.numSPs = 0;
% handles.numRPs = 0;
% handles.numVNBs = 0;
% handles.sp_numSUs = 0;
% handles.rp_numSUs = 0;

% Choose default command line output for VirtualTrading_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes VirtualTrading_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VirtualTrading_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%global rp sp vnb rpSu spSU 
varargout{1} = handles.output;



function numRPs_Callback(hObject, eventdata, handles)
% hObject    handle to numRPs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numRPs as text
%        str2double(get(hObject,'String')) returns contents of numRPs as a double

numRPs = str2double(get(hObject, 'String'));
% handles.numRPs = numRPs;
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function numRPs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numRPs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numSPs_Callback(hObject, eventdata, handles)
% hObject    handle to numSPs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numSPs as text
%        str2double(get(hObject,'String')) returns contents of numSPs as a double

numSPs = str2double(get(hObject, 'String'));
% handles.numSPs = numSPs
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function numSPs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSPs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numVNBs_Callback(hObject, eventdata, handles)
% hObject    handle to numVNBs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numVNBs as text
%        str2double(get(hObject,'String')) returns contents of numVNBs as a double
numVNBs = str2double(get(hObject, 'String'));
% handles.numVNBs = numVNBs;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function numVNBs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numVNBs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rp_numSUs_Callback(hObject, eventdata, handles)
% hObject    handle to rp_numSUs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rp_numSUs as text
%        str2double(get(hObject,'String')) returns contents of rp_numSUs as a double
rp_numSUs = str2double(get(hObject,'String'));
%handles.rp_numSUs = rp_numSUs;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rp_numSUs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rp_numSUs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sp_numSUs_Callback(hObject, eventdata, handles)
% hObject    handle to sp_numSUs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sp_numSUs as text
%        str2double(get(hObject,'String')) returns contents of sp_numSUs as a double

sp_numSPs = str2double(get(hObject, 'String'));
% handles.sp_numSUs = sp_numSUs;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function sp_numSUs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sp_numSUs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in setup.
function setup_Callback(hObject, eventdata, handles)
% hObject    handle to setup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%[numSPs, numRPs, numVNBs, sp_numSUs, rp_numSUs]=test(a,b,c,d,e)

numSPs1 = str2double(get(handles.numSPs, 'String'));
handles.numSPs1 = numSPs1;
numRPs1 = str2double(get(handles.numRPs, 'String'));
handles.numRPs1 = numRPs1;
numVNBs1 = str2double(get(handles.numVNBs, 'String'));
handles.numVNBs1 = numVNBs1;
sp_numSUs1 = str2double(get(handles.sp_numSUs, 'String'));
handles.sp_numSUs1 = sp_numSUs1;
rp_numSUs1 = str2double(get(handles.rp_numSUs, 'String'));
handles.rp_numSUs1 = rp_numSUs1;

guidata(hObject, handles);

test


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% a = str2double(get(handles.numSPs, 'String'));
% b = str2double(get(handles.numRPs, 'String'));
% c = str2double(get(handles.numVNBs, 'String'));
% d = str2double(get(handles.sp_numSUs,'String'));
% e = str2double(get(handles.rp_numSUS, 'String'));
% 
VirtualTrading


% --- Executes on button press in showData.
function showData_Callback(hObject, eventdata, handles)
% hObject    handle to showData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.flag == 0
    plot(handles.current_data);
else
    plot(handles.current_data);
    hold on 
    plot(handles.current_data1);
    hold off
end



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

str = get(hObject, 'String');
val = get(hObject, 'Value');

switch str{val};
    case 'Offer per VNB'
        handles.current_data = handles.singleOffer;
        handles.flag = 0;
    case 'Demand per VNB'
        handles.current_data = handles.singleDemand;
        handles.flag = 0;
    case 'Aggregate Offer and Demand'
        handles.current_data = handles.offer;
        handles.current_data1 = handles.demand;
        handles.flag = 1;
end

guidata(hObject, handles)
        



% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = SAW(varargin)
% SAW MATLAB code for SAW.fig
%      SAW, by itself, creates a new SAW or raises the existing
%      singleton*.
%
%      H = SAW returns the handle to a new SAW or the handle to
%      the existing singleton*.
%
%      SAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW.M with the given input arguments.
%
%      SAW('Property','Value',...) creates a new SAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW

% Last Modified by GUIDE v2.5 26-Jun-2021 08:53:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_OutputFcn, ...
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


% --- Executes just before SAW is made visible.
function SAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW (see VARARGIN)

% Choose default command line output for SAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnload.
function btnload_Callback(hObject, eventdata, handles)
% hObject    handle to btnload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
data.Mydata = xlsread('DATA RUMAH.xlsx');
data.Mydata = [data.Mydata(:,3) data.Mydata(:,4) data.Mydata(:,5) data.Mydata(:,6) data.Mydata(:,7) data.Mydata(:,8)]; %ambil kolom kriteria
%data.Mydata = data.Mydata(1:50,:); %ambil data 1-50
set(handles.uitable1,'Data',data.Mydata); %tampilkan ketabel


% --- Executes on button press in btnproses.
function btnproses_Callback(hObject, eventdata, handles)
% hObject    handle to btnproses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data.Mydata = readtable('DATA RUMAH.xlsx');
nama = data.Mydata(:,2) %ambil nama rumah
data = [data.Mydata(:,3) data.Mydata(:,4) data.Mydata(:,5) data.Mydata(:,6) data.Mydata(:,7) data.Mydata(:,8)]; %ambil kolom kriteria

 
data = table2array(data);
nama = table2array(nama);

k = [0 1 1 1 1 1] %tentukan profit benefit
b = [30 20 23 10 7 10] %menentukan bobot
b=b./sum(b); %normalisasi bobot
disp(b)

[m,n]=size(data); %matriks m x n dengan ukuran sebanyak variabel x 

R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); 

for j=1:6
    if k(j)==1 %menghitung atribut keuntungan
        R(:,j)=data(:,j)./max(data(:,j));
    else      %menghitung atribut profit
        R(:,j)=min(data(:,j))./data(:,j);
    end
end

for i=1:m %proses perangkingan
    V(i)= sum(b.*R(i,:));
end

[vektorV, index] = maxk(V,20); %sort rangking

nama = nama(index); %mengurutkan nama rumah
vektorV = transpose(num2cell(vektorV)); %transpose matrik

set(handles.uitable2,'Data', [nama vektorV]); %tampil ketabel hasil





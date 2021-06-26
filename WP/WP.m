function varargout = WP(varargin)
% WP MATLAB code for WP.fig
%      WP, by itself, creates a new WP or raises the existing
%      singleton*.
%
%      H = WP returns the handle to a new WP or the handle to
%      the existing singleton*.
%
%      WP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WP.M with the given input arguments.
%
%      WP('Property','Value',...) creates a new WP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before WP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to WP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help WP

% Last Modified by GUIDE v2.5 26-Jun-2021 08:30:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @WP_OpeningFcn, ...
                   'gui_OutputFcn',  @WP_OutputFcn, ...
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


% --- Executes just before WP is made visible.
function WP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to WP (see VARARGIN)

% Choose default command line output for WP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes WP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = WP_OutputFcn(hObject, eventdata, handles) 
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
data.Mydata = xlsread('Real estate valuation data set');
data.Mydata = [data.Mydata(:,3) data.Mydata(:,4) data.Mydata(:,5) data.Mydata(:,8)]; %ambil kolom kriteria
data.Mydata = data.Mydata(1:50,:); %ambil data 1-50
set(handles.uitable,'Data',data.Mydata); %tampilkan ketabel
%disp(data.Mydata);


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data.Mydata = readtable('Real estate valuation data set.xlsx');
nama = data.Mydata(:,1)
data.Mydata = [data.Mydata(:,3) data.Mydata(:,4) data.Mydata(:,5) data.Mydata(:,8)];
data.Mydata = data.Mydata(1:50,:);
data.Mydata = table2array(data.Mydata);

nama = nama(1:50,:);
nama = table2array(nama);

%disp(data.Mydata)


k = [0 0 0 1] %kriteria benefit profit
b = [3 5 4 1] %set bobot
b=b./sum(b); %normalisasi bobot

[m,n]=size(data.Mydata); %matriks m x n dengan ukuran sebanyak variabel x 

R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); 

for j=1:n, %update bobot
 if k(j)==0, 
     b(j)=-1*b(j);
 end;
end;

for i=1:m,
 S(i)=prod(data.Mydata(i,:).^b);
end;

%perangkingan dengan menormalisasi nilai S
V= S/sum(S);
disp(V)


%pengecekan 5 nilai tertinggi lalu di outputkan
[vektorV, nama] = maxk(V,5); %sort rangking



nama = transpose(num2cell(nama));   %transpose matrik
vektorV = transpose(num2cell(vektorV)); %transpose matrik

hasil = [nama vektorV];
set(handles.uitable2,'Data', hasil);

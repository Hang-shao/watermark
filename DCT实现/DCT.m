function varargout = DCT(varargin)
% DCT MATLAB code for DCT.fig
%      DCT, by itself, creates a new DCT or raises the existing
%      singleton*.
%
%      H = DCT returns the handle to a new DCT or the handle to
%      the existing singleton*.
%
%      DCT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DCT.M with the given input arguments.
%
%      DCT('Property','Value',...) creates a new DCT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DCT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DCT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DCT

% Last Modified by GUIDE v2.5 31-May-2021 15:00:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DCT_OpeningFcn, ...
                   'gui_OutputFcn',  @DCT_OutputFcn, ...
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


% --- Executes just before DCT is made visible.
function DCT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DCT (see VARARGIN)

% Choose default command line output for DCT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DCT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DCT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in pushbutton3.??????????????????
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.bmp';'*.jpg';'*.*'},'????????????');%????????????????????????????????????????????????????????????
str=[pathname filename];%????????????????????????
[handles.I,handles.map]=imread(str);%????????????
zai=imread(str);
%zai=[handles.I,handles.map];
psnr_cover=double(zai);
guidata(hObject,handles);%???????????????????????????hObject,?????????????????????????????????handles??????
axes(handles.axes1);%????????????????????????axes1
imshow(zai,[]);%????????????


% --- Executes on button press in pushbutton4.??????????????????
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.bmp';'*.jpg';'*.*'},'????????????');%????????????????????????????????????????????????????????????
str=[pathname filename];%????????????????????????
[handles.I,handles.map]=imread(str);%????????????
%water=[handles.I,handles.map];
global water;
water=imread(str);
water=rgb2gray(water);
water=double(water)/255; 
water=ceil(water);
%guidata(hObject,handles);%???????????????????????????hObject,?????????????????????????????????handles??????
axes(handles.axes4);%????????????????????????axes4
imshow(water);%????????????
dimI=size(water);
global rm;
global cm;
rm=dimI(1);cm=dimI(2);


% --- Executes on button press in pushbutton5.????????????
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start_time=cputime;
global water;
global rm;
global cm;
cda0=blkproc(handles.I,[8,8],'dct2');
mark=water;
alpha=10;
global k1;
global k2;
k1=randn(1,8);
k2=randn(1,8);
[r,c]=size(handles.I);
cda1=cda0;   % cda1 = 256_256
for i=1:rm  % i=1:32
    for j=1:cm  % j=1:32
        x=(i-1)*8;y=(j-1)*8;
        if mark(i,j)==1
            k=k1;
        else
            k=k2;
        end
        cda1(x+1,y+8)=cda0(x+1,y+8)+alpha*k(1);
        cda1(x+2,y+7)=cda0(x+2,y+7)+alpha*k(2);
        cda1(x+3,y+6)=cda0(x+3,y+6)+alpha*k(3);
        cda1(x+4,y+5)=cda0(x+4,y+5)+alpha*k(4);
        cda1(x+5,y+4)=cda0(x+5,y+4)+alpha*k(5);
        cda1(x+6,y+3)=cda0(x+6,y+3)+alpha*k(6);
        cda1(x+7,y+2)=cda0(x+7,y+2)+alpha*k(7);
        cda1(x+8,y+1)=cda0(x+8,y+1)+alpha*k(8);
    end
end
global a1;
a1=blkproc(cda1,[8,8],'idct2');
a_1=uint8(a1);

axes(handles.axes5);%????????????????????????axes5s
imshow(a_1);%????????????
%imwrite(a_1,'?????????????????????.bmp','bmp');
%subplot(2,3,3),imshow(a1,[]),title('????????????????????????');
%disp('????????????????????????')
embed_time=cputime-start_time
set(handles.text13,'string',num2str(embed_time));
p0=a_1;

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global a1;

% %????????????
% J=imrotate(a1,30,'nearest','crop');
axes(handles.axes6);%????????????????????????axes5s
imshow(uint8(J));%????????????
imwrite(uint8(J),'rotate.bmp');

% --- Executes on button press in pushbutton7.??????
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start_time=cputime;
%global a1;
%end_pic=imread('gong.bmp');
%pix=getframe(handles.axes6);
%xuan=pix.cdata;
%imwrite(pix.cdata,'demo.bmp');
%pic=imread('demo.bmp');
%imshow(pix.cdata);
global k1;
global gong;
global k2;
global water;
dimI=size(water);

psnr_watermarked=double(gong);
dca1=blkproc(gong,[8,8],'dct2');
p=zeros(1,8);
for i=1:dimI(1) %???
    for j=1:dimI(2)  % j=1:32???
        x=(i-1)*8;y=(j-1)*8;
        p(1)=dca1(x+1,y+8);
        p(2)=dca1(x+2,y+7);
        p(3)=dca1(x+3,y+6);
        p(4)=dca1(x+4,y+5);
        p(5)=dca1(x+5,y+4);
        p(6)=dca1(x+6,y+3);
        p(7)=dca1(x+7,y+2);
        p(8)=dca1(x+8,y+1);
        if corr2(p,k1)>corr2(p,k2),warning off MATLAB:divideByZero;
            mark1(i,j)=1;
        else
            mark1(i,j)=0;
        end
    end
end
axes(handles.axes7);%????????????????????????axes5s
imshow(mark1);%????????????
embed_time=cputime-start_time;
set(handles.text14,'string',num2str(embed_time));

NC=nc(mark1,water)  %??????nc.m?????????
set(handles.text15,'string',num2str(NC));



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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

% --- Executes when selected object is changed in uibuttongroup2.???????????????
function uibuttongroup2_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global num;
% str=get(hObject,'tag');
% switch str
%     case 'radiobutton1'
%           num=1;
% 
%     case 'radiobutton2'
%           num=2;
% 
%     case 'radiobutton3'
%           num=3;
%     end

% --- Executes on button press in pushbutton10.???????????????
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num;
global a1;
global gong;
if(num==1)
    gong=a1;
    noise0=1*randn(size(gong));
    gong=uint8(gong+noise0);
elseif(num==2)
    gong=imnoise(uint8(a1), 'salt & pepper', 0.01);%???????????????0.01???????????????
elseif(num==4)
    gong=uint8(imrotate(uint8(a1),30,'nearest','crop'));
elseif(num==3)
    %???????????????????????????
    gong=a1;
    I_r= gong(:,:,1);
    I_r(1:128,1:128)=255;
    %??????????????????
    gong(:,:,1) = I_r;
    gong=uint8(gong);
end
axes(handles.axes6);%????????????????????????axes5s
imshow(gong);
%imwrite(uint8(gong),'gong.bmp');    


% --- Executes on button press in radiobutton4.?????????
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num;
num = 1;
% Hint: get(hObject,'Value') returns toggle state of radiobutton4



% --- Executes on button press in radiobutton2.????????????
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num;
num = 4;
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.??????
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num;
num = 3;
% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton5.????????????
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num;
num = 2;
% Hint: get(hObject,'Value') returns toggle state of radiobutton5

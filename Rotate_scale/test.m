function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 30-May-2021 21:40:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.打开
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile({'*.bmp';'*.jpg';'*.*'},'选择图片');%文件选择，这里可以选择可以打开的图片格式
str=[pathname filename];%被选择的文件路径
[handles.I,handles.map]=imread(str);%读取图片
in_image=[handles.I,handles.map];
guidata(hObject,handles);%图像串行化，保存在hObject,这样我整个页面都能取到handles的值
axes(handles.axes1);%把显示范围限定在axes1
imshow(in_image);%显示图片
% hObject    handle to wayone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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

%自定义旋转函数
function [newimage]=rotate(img,degree)
%获取图片信息 注意三通道获取完 即定义三个变量
[m,n,dep]=size(img);
%计算出旋转之后，形成一个大矩形的长宽 可以看效果图
rm=round(m*abs(cosd(degree))+n*abs(sind(degree)));
rn=round(m*abs(sind(degree))+n*abs(cosd(degree)));
%定义一个新矩阵，三通道的，存储新图片的信息
newimage=zeros(rm,rn,dep);
%坐标变换 分三步 
m1=[1,0,0;0,1,0;-0.5*rm,-0.5*rn,1];
m2=[cosd(degree),sind(degree),0;-sind(degree),cosd(degree),0;0,0,1];
m3=[1,0,0;0,1,0;0.5*m,0.5*n,1];
%利用循环，对每一个像素点进行变换
for i=1:rm
    for j=1:rn
        tem=[i j 1];
        tem=tem*m1*m2*m3;
        x=tem(1,1);
        y=tem(1,2);
        x=round(x);
        y=round(y);
        if(x>0&&x<=m)&&(y>0&&y<=n)
        newimage(i,j,:)=img(x,y,:);
        end
        end
        end

% --- Executes on button press in pushbutton2.旋转
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% in_image=[handles.I,handles.map];
% t=imread();
a=str2double(get(handles.edit1,'String'));
global t1;
t1=rotate(handles.I,a);
% guidata(hObject,handles);
axes(handles.axes2);
imshow(uint8(t1));%显示图片
%imwrite(uint8(t1),'roate_.bmp');

% --- Executes on button press in pushbutton5.旋转保存
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global t1;
[FileName,PathName] = uiputfile({'*.bmp','Bitmap(*.bmp)';'*.jpg','JPEG(*.jpg)';...
                                             '*.gif','GIF(*.gif)';...
                                             '*.*',  'All Files (*.*)'},...
                                             'Save Picture','Untitled');
if FileName==0
      disp('保存失败');
      return;
else
      %h=getframe(picture);%picture是GUI界面绘图的坐标系句柄
      imwrite(uint8(t1),[PathName,FileName]);
      %imwrite(uint8(t1),'roate_.bmp');
end 

% --- Executes on button press in pushbutton3.缩放
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=str2double(get(handles.edit1,'String'));
global output;
output=imresize(handles.I,a);
axes(handles.axes2);
imshow(output);%显示图片
%imwrite(output,'scale_.bmp');

% --- Executes on button press in pushbutton6.缩放保存
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global output;
[FileName,PathName] = uiputfile({'*.bmp','Bitmap(*.bmp)';'*.jpg','JPEG(*.jpg)';...
                                             '*.gif','GIF(*.gif)';...
                                             '*.*',  'All Files (*.*)'},...
                                             'Save Picture','Untitled');
if FileName==0
      disp('保存失败');
      return;
else
      %h=getframe(picture);%picture是GUI界面绘图的坐标系句柄
      imwrite(output,[PathName,FileName]);
      %imwrite(uint8(t1),'roate_.bmp');
end 
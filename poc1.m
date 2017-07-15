function varargout = poc1(varargin)
% POC1 MATLAB code for poc1.fig
%      POC1, by itself, creates a new POC1 or raises the existing
%      singleton*.
%
%      H = POC1 returns the handle to a new POC1 or the handle to
%      the existing singleton*.
%
%      POC1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POC1.M with the given input arguments.
%
%      POC1('Property','Value',...) creates a new POC1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before poc1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to poc1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help poc1

% Last Modified by GUIDE v2.5 19-Jun-2016 11:19:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @poc1_OpeningFcn, ...
                   'gui_OutputFcn',  @poc1_OutputFcn, ...
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


% --- Executes just before poc1 is made visible.
function poc1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to poc1 (see VARARGIN)

% Choose default command line output for poc1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes poc1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = poc1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
global pointer_pos; 
pointer_pos = [31.167 20.308 3.833 1.462];
%pointer_pos = get(handler.pointer,'position'); 

Im1=imread('circles.png');
%load network_model;
axes(handles.img_handler)
imshow(Im1);
pushbutton1_Callback(hObject, [], handles);
% global time_s;
% time_e = tic
% time_left = time_e - time_s
% set(handles.timeleft,'String',num2str(time_left));
load('test_data');
load('network');
Y_test = ones(size(X_test,1),1);
[p acc] = predictNN(net,X_test,Y_test);
for i =1:length(p)
    if p(i)==1
        upbutton_Callback(handles.upbutton, eventdata, handles);
    elseif p(i) ==2
        rightbutton_Callback(handles.upbutton, eventdata, handles);
    elseif p(i) == 3
        downbutton_Callback(handles.upbutton, eventdata, handles);
    elseif p(i) ==4
        leftbutton_Callback(handles.upbutton, eventdata, handles);
    end
    pause(0.5);
end
varargout{1} = handles.output;

    


% --- Executes on button press in pushbutton1.

function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[reference_letter,letters] = generate_rand_char();
try stop(handles.timex) ;  end % stoping the timer form a previous generation
try delet(handles.timex);  end
try stop(handles.countertimex) ;  end % stoping the timer form a previous generation
try delet(handles.countertimex);  end
set(handles.correct_letter,'String',reference_letter);
set(handles.leftbox,'String',letters(1));
set(handles.rightbox,'String',letters(2));
set(handles.upbox,'String',letters(3));
set(handles.downbox,'String',letters(4));

timeout_val = str2num(get(handles.time_num,'String'));
counter_val = str2num(get(handles.counterdown,'String'));

handles.reference_letter = reference_letter;
handles.timeout_val = timeout_val;
handles.counter_val = counter_val;

timeout_val = str2num(get(handles.time_num,'String'));
timeout_val = timeout_val-1; 

counter_val = str2num(get(handles.counterdown,'String'));
counter_val =counter_val+1; 


set(handles.counterdown,'String',num2str(counter_val));
set(handles.time_num,'String',num2str(timeout_val));

handles.countertimex = timer('TimerFcn',{@countertimer_handler,handles},'ExecutionMode','fixedRate','Period',1);
start(handles.countertimex);

handles.timex = timer('TimerFcn',{@timer_handler,handles},'ExecutionMode','fixedDelay','Period',10);
start(handles.timex);



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.


% --- Executes on button press in upbutton.
function upbutton_Callback(hObject, eventdata, handles)
% hObject    handle to upbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pointer_pos;
upbox_char = get(handles.upbox,'String');
downbox_char = get(handles.downbox,'String');
leftbox_char = get(handles.leftbox,'String');
rightbox_char = get(handles.rightbox,'String');
correct_val = str2num(get(handles.correct_trials,'String'));
wrong_val = str2num(get(handles.wrong_trials,'String'));



handles.reference_letter=get(handles.correct_letter,'String');
reference_letter = handles.reference_letter;

cu_position = get(handles.upbox,'Position');
cr_position = get(handles.rightbox,'Position');
cl_position = get(handles.leftbox,'Position');
cd_position = get(handles.downbox,'Position');

current_position = get(handles.pointer,'Position');
new_position = current_position + [0 0.8 0 0]; % increament y 10 units
set(handles.pointer,'Position',new_position);

d_u = sqrt((cu_position(1) - new_position(1))^2 +(cu_position(2) - new_position(2))^2);  
d_r = sqrt((cr_position(1) - new_position(1))^2 +(cr_position(2) - new_position(2))^2);
d_l= sqrt((cl_position(1) - new_position(1))^2 +(cl_position(2) - new_position(2))^2);
d_d = sqrt((cd_position(1) - new_position(1))^2 +(cd_position(2) - new_position(2))^2);

%d = distance(cu_position(1:2),new_position(1:2));

if d_u<= 1.5
if upbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end

    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);
%d = distance(cd_position(1:2),new_position(1:2));

elseif  d_d <= 1.5


if downbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end
    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);

elseif d_r<3
    if rightbox_char == reference_letter
        correct_val = correct_val+1;
        set(handles.correct_trials,'String',num2str(correct_val));
    else
        wrong_val = wrong_val +1;
        set(handles.wrong_trials,'String',num2str(wrong_val));
    end 

    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);

elseif d_l <3

if leftbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
    
end
    set(handles.pointer,'Position',pointer_pos);
    
try stop(handles.timex) ;  end % stoping the timer form a previous generation
try delet(handles.timex);  end

try stop(handles.countertimex) ;  end % stoping the timer form a previous generation
try delet(handles.countertimex);  end

    pushbutton1_Callback(hObject, [], handles);

end


% --- Executes on button press in rightbutton.
function rightbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rightbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pointer_pos;
upbox_char = get(handles.upbox,'String');
downbox_char = get(handles.downbox,'String');
leftbox_char = get(handles.leftbox,'String');
rightbox_char = get(handles.rightbox,'String');
correct_val = str2num(get(handles.correct_trials,'String'));
wrong_val = str2num(get(handles.wrong_trials,'String'));
handles.reference_letter=get(handles.correct_letter,'String');

reference_letter = handles.reference_letter;

cu_position = get(handles.upbox,'Position');
cr_position = get(handles.rightbox,'Position');
cl_position = get(handles.leftbox,'Position');
cd_position = get(handles.downbox,'Position');

current_position = get(handles.pointer,'Position');
new_position = current_position + [1 0 0 0]; % increament y 10 units
set(handles.pointer,'Position',new_position);

d_u = sqrt((cu_position(1) - new_position(1))^2 +(cu_position(2) - new_position(2))^2);  
d_r = sqrt((cr_position(1) - new_position(1))^2 +(cr_position(2) - new_position(2))^2);
d_l= sqrt((cl_position(1) - new_position(1))^2 +(cl_position(2) - new_position(2))^2);
d_d = sqrt((cd_position(1) - new_position(1))^2 +(cd_position(2) - new_position(2))^2);

%d = distance(cu_position(1:2),new_position(1:2));

if d_u<= 1.5
if upbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end

    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);
%d = distance(cd_position(1:2),new_position(1:2));

elseif  d_d <= 1.5


if downbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end
    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);

elseif d_r<3
    if rightbox_char == reference_letter
        correct_val = correct_val+1;
        set(handles.correct_trials,'String',num2str(correct_val));
    else
        wrong_val = wrong_val +1;
        set(handles.wrong_trials,'String',num2str(wrong_val));
    end 
    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);

elseif d_l <3

if leftbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
    
end

    set(handles.pointer,'Position',pointer_pos);
try stop(handles.timex) ;  end % stoping the timer form a previous generation
try delet(handles.timex);  end


try stop(handles.countertimex) ;  end % stoping the timer form a previous generation
try delet(handles.countertimex);  end

    pushbutton1_Callback(hObject, [], handles);

end


% --- Executes on button press in leftbutton.
function leftbutton_Callback(hObject, eventdata, handles)
% hObject    handle to leftbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pointer_pos;
upbox_char = get(handles.upbox,'String');
downbox_char = get(handles.downbox,'String');
leftbox_char = get(handles.leftbox,'String');
rightbox_char = get(handles.rightbox,'String');
correct_val = str2num(get(handles.correct_trials,'String'));
wrong_val = str2num(get(handles.wrong_trials,'String'));
handles.reference_letter=get(handles.correct_letter,'String');

reference_letter = handles.reference_letter;

cu_position = get(handles.upbox,'Position');
cr_position = get(handles.rightbox,'Position');
cl_position = get(handles.leftbox,'Position');
cd_position = get(handles.downbox,'Position');

current_position = get(handles.pointer,'Position');
new_position = current_position + [-1 0 0 0]; % increament y 10 units
set(handles.pointer,'Position',new_position);

d_u = sqrt((cu_position(1) - new_position(1))^2 +(cu_position(2) - new_position(2))^2);  
d_r = sqrt((cr_position(1) - new_position(1))^2 +(cr_position(2) - new_position(2))^2);
d_l= sqrt((cl_position(1) - new_position(1))^2 +(cl_position(2) - new_position(2))^2);
d_d = sqrt((cd_position(1) - new_position(1))^2 +(cd_position(2) - new_position(2))^2);

%d = distance(cu_position(1:2),new_position(1:2));

if d_u<= 1.5
if upbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end

    set(handles.pointer,'Position', pointer_pos);
pushbutton1_Callback(hObject, [], handles);
%d = distance(cd_position(1:2),new_position(1:2));

elseif  d_d <= 1.5


if downbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end
    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);
elseif d_r<3
    if rightbox_char == reference_letter
        correct_val = correct_val+1;
        set(handles.correct_trials,'String',num2str(correct_val));
    else
        wrong_val = wrong_val +1;
        set(handles.wrong_trials,'String',num2str(wrong_val));
    end 
    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);

elseif d_l <3

if leftbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
    
end

    set(handles.pointer,'Position', pointer_pos);
    try stop(handles.timex) ;  end % stoping the timer form a previous generation
try delet(handles.timex);  end


try stop(handles.countertimex) ;  end % stoping the timer form a previous generation
try delet(handles.countertimex);  end

pushbutton1_Callback(hObject, [], handles);

end

% --- Executes on button press in downbutton.
function downbutton_Callback(hObject, eventdata, handles)
% hObject    handle to downbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pointer_pos;
upbox_char = get(handles.upbox,'String');
downbox_char = get(handles.downbox,'String');
leftbox_char = get(handles.leftbox,'String');
rightbox_char = get(handles.rightbox,'String');
correct_val = str2num(get(handles.correct_trials,'String'));
wrong_val = str2num(get(handles.wrong_trials,'String'));
handles.reference_letter=get(handles.correct_letter,'String');

reference_letter = handles.reference_letter;

cu_position = get(handles.upbox,'Position');
cr_position = get(handles.rightbox,'Position');
cl_position = get(handles.leftbox,'Position');
cd_position = get(handles.downbox,'Position');

current_position = get(handles.pointer,'Position');
new_position = current_position + [0 -0.8 0 0]; % increament y 10 units
set(handles.pointer,'Position',new_position);

d_u = sqrt((cu_position(1) - new_position(1))^2 +(cu_position(2) - new_position(2))^2);  
d_r = sqrt((cr_position(1) - new_position(1))^2 +(cr_position(2) - new_position(2))^2);
d_l= sqrt((cl_position(1) - new_position(1))^2 +(cl_position(2) - new_position(2))^2);
d_d = sqrt((cd_position(1) - new_position(1))^2 +(cd_position(2) - new_position(2))^2);

%d = distance(cu_position(1:2),new_position(1:2));

if d_u<= 1.5
if upbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end

    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);
%d = distance(cd_position(1:2),new_position(1:2));

elseif  d_d <= 1.5


if downbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
end
    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);

elseif d_r<3
    if rightbox_char == reference_letter
        correct_val = correct_val+1;
        set(handles.correct_trials,'String',num2str(correct_val));
    else
        wrong_val = wrong_val +1;
        set(handles.wrong_trials,'String',num2str(wrong_val));
    end 
    set(handles.pointer,'Position',pointer_pos);
pushbutton1_Callback(hObject, [], handles);

elseif d_l <3

if leftbox_char == reference_letter
    correct_val = correct_val+1;
    set(handles.correct_trials,'String',num2str(correct_val));
else
    wrong_val = wrong_val +1;
    set(handles.wrong_trials,'String',num2str(wrong_val));
    
end

    set(handles.pointer,'Position', pointer_pos);
    try stop(handles.timex) ;  end % stoping the timer form a previous generation
try delet(handles.timex);  end


try stop(handles.countertimex) ;  end % stoping the timer form a previous generation
try delet(handles.countertimex);  end

pushbutton1_Callback(hObject, [], handles);

end



% --- Executes during object creation, after setting all properties.
function text11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function time_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function timer_handler(hObject, eventdata, handles)
timeout_val = str2num(get(handles.time_num,'String'));
timeout_val = timeout_val+1;
set(handles.time_num,'String',num2str(timeout_val));
set(handles.counterdown,'String',num2str(10));
global pointer_pos;
set(handles.pointer,'Position',pointer_pos);



function countertimer_handler(hObject, eventdata, handles)

counter_val = str2num(get(handles.counterdown,'String'));
if counter_val ==0
    set(handles.counterdown,'String',num2str(10));
else
counter_val = counter_val-1;

set(handles.counterdown,'String',num2str(counter_val));
end




% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current_position = get(handles.pointer,'Position');
new_position = current_position + [0 1 0 0] % increament y 10 units
set(handles.pointer,'Position',new_position);
%pushbutton1_Callback(handles);




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




% --- Executes during object creation, after setting all properties.
function img_handler_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img_handler (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate img_handler

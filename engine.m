%% Clearing the env.
clear all, clc;
%% Loading raw dataset
disp('Loading the dataset ...')
up_data = csvread('up.csv');
left_data = csvread('left.csv');
right_data = csvread('right.csv');
down_data = csvread('down.csv');

%% Dataset preparation and noise reduction 
disp('Filtering ...')
F=bpfilter
up=[]; left=[]; right=[]; down=[];
for i=1:100
    U=filter(F,up_data(i,:));
    up=[up;U];
    
    L=filter(F,left_data(i,:));
    left=[left;L];
    
    R=filter(F,right_data(i,:));
    right=[right;R];
    
    D=filter(F,down_data(i,:));
    down=[down;D];
end
up_data_f=up;  left_data_f=left; right_data_f=right; down_data_f=down;    

%% Features extraction (PCA or Wavelet)
disp('Feature extraction ...')
up_data_ff=compwaveletcoffs(up_data_f);
right_data_ff=compwaveletcoffs(right_data_f);
down_data_ff=compwaveletcoffs(down_data_f);
left_data_ff=compwaveletcoffs(left_data_f);


%% Flattening raw_data (optional step could be removed if not needed)
%   max_up_data = max(abs(up_data_ff),[],2);
%   max_right_data = max(abs(right_data_ff),[],2);
%  max_down_data = max(abs(down_data_ff),[],2);
%  max_left_data = max(abs(left_data_ff),[],2);
%  for i =(1:size(up_data_ff,1))
%      up_data_fff(i,:) = up_data_ff(i,:)/max_up_data(i);
%      right_data_fff(i,:) = right_data_ff(i,:)/max_right_data(i);
%      down_data_fff(i,:) = down_data_ff(i,:)/max_down_data(i);
%      left_data_fff(i,:) = left_data_ff(i,:)/max_left_data(i);
%  end


%% Labelling and Concatenating 
disp('Prepare for training ...')
up_data_ff(:,size(up_data_ff,2)+1) = int16(1);
right_data_ff(:,size(right_data_ff,2)+1) = int16(2);
down_data_ff(:,size(down_data_ff,2)+1) = int16(3);
left_data_ff(:,size(left_data_ff,2)+1) = int16(4);

%% Splitting to train_set and test_set
train_data = [up_data_ff([1:90],[1:17]);right_data_ff([1:90],[1:17]);down_data_ff([1:90],[1:17]);left_data_ff([1:90],[1:17])];
test_data = [up_data_ff([91:end],[1:17]);down_data_ff([91:end],[1:17]);down_data_ff([91:end],[1:17]);left_data_ff([91:end],[1:17])];

%% Preparation for classifier (NN or SVM) "split labels from samples"
X_train = train_data(:,[1:end-1]);
Y_train = train_data(:,end);

X_test = test_data(:,[1:end-1]);
Y_test = test_data(:,end);

%% Building NN classifier net
net = createNN(16,4,4)
% %Building SVM classifier
 %model= svmclassify(model,X_test,Y_test)

%% Training NN net
disp('Training NN ...')
[net,cost] = trainNN(net,X_train,Y_train,1,1)
% %Training svm
%model = mu(X_train,Y_train,'');

%% testing the trained net
disp('Testing ...')
[p,acc] = predictNN(net,X_test,Y_test);
acc
%accer = acc+30
% % acc of SVM
%[predicted_label, accuracy, decision_values/prob_estimates] = ovrpredict(X_test,Y_test, model);

%% Training the SVM
result = multisvm(X_train,Y_train,X_test);

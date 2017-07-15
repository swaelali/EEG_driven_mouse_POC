clear ; close all; clc
load('ex4data1.mat');
%% Building a net with createNN
% net = createNN(num_input_nodes, num_hidden_nodes, num_output_nodes);
network = createNN(400,25,10);
%% Training your net with trainNN
% [trained_net, cost] = trainNN(initial_net,training_data,training_labels,regulation parameters, max_iterations);
[network,cost] = trainNN(network,X,y,1,50);
%% Testing your trained_net with predictNN
% [predicted_labels, accuracy] = predictNN(trained_net, testing_data,correct_testing_labels);
[p,acc] = predictNN(network, X,y);
%% Display the accuracy
disp(acc); 


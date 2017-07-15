function [p,acc] = predictNN(network, X,y)
  m = size(X, 1);
  input_layer_size	= network.input_layer_size;
  hidden_layer_size	= network.hidden_layer_size;
	num_labels			= network.num_labels;
	nn_params	= network.params;
	p = zeros(size(X, 1), 1);

	Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
	Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));


	h1 = sigmoid([ones(m, 1) X] * Theta1');
	h2 = sigmoid([ones(m, 1) h1] * Theta2');
	[dummy, p] = max(h2, [], 2);
	acc =  mean(double(p == y)) * 100;

end

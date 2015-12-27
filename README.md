# 2neural_networks

### An implementation of a neural network machine learning algorithm.  

#### 

To clone the repo down to local machine, copy the following in terminal:
- $ git clone https://github.com/afg419/2neural_networks.git

#### Functionality:
Initialize a new neural network with a given number of inputs, outputs, and hidden layers.  This command creates the number of specified neurons per layer, and randomizes weight values between -1/10 and 1/10.
 - `net = NeuralNetwork.new(no_inputs, no_hidden_layers, no_neurons_per_hidden_layer, no_outputs)`

To train a neural network, you'll need a training set (the input output relationship you want the network to mimic).  The format for a training set is an array of input output hashes:
- `training_set = [{i: input, o: output}, ....]`

To train a neural network on the training set, initialize a Networktrainer:
- `trainer = NetworkTrainer.new(training_set, net, learning_rate, regularization_constant)`
- `trainer.train_network(no_training_iterations)`

Finally, to see the trained network in action:
- `net.forward_propogate(input)`

See the file test/network_trainer_test.rb and its trains_to_xor test for an example.

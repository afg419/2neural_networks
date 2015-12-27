require_relative 'neural_network'

class NetworkTrainer
  attr_reader :training_set, :network, :regularization_constant

  def initialize(training_set, neural_network, regularization_constant)
    @training_set = training_set #[{i: oijfoij, o: oijfoijf}, ... ]
    @network = neural_network
    @regularization_constant = regularization_constant
  end

  def train_network(n)
    n.times do
      training_set.each do |example|
        network.backward_propogate(example[:i],example[:o])
        network.contribute_new_weight_deltas
      end
      network.update_weights(training_set.length, regularization_constant)
    end
  end
end

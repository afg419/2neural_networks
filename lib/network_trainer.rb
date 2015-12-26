require_relative 'neural_network'

class NetworkTrainer
  attr_reader :training_set, :neural_network

  def initialize(training_set, neural_network)
    @training_set = training_set #[{input: [3,4,5], output: [5]}, ... ]
    @network = neural_network
  end
end

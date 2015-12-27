require 'minitest/autorun'
require_relative '../lib/network_trainer'

class NetworkTrainerTest < Minitest::Test

  def test_trains_to_xor
    nn = NeuralNetwork.new(2,1,4,1)
    training_set = [
      {i: [0,0], o: 0},
      {i: [0,1], o: 1},
      {i: [1,0], o: 1},
      {i: [1,1], o: 0}]

    training_set.each do |i_o|
      p nn.forward_propogate(i_o[:i])[0]
    end

    nt = NetworkTrainer.new(training_set, nn, 0.1, 0)
    nt.train_network(2000)

    training_set.each do |i_o|
      p out = nn.forward_propogate(i_o[:i])[0]
      assert (i_o[:o] - out) ** 2 < 10 **(-20)
    end
  end

end

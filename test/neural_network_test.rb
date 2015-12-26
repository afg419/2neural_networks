require 'minitest/autorun'
require_relative '../lib/neural_network'

class NeuralNetworkTest < Minitest::Test

  def test_exists
    assert NeuralNetwork
  end

  def test_initializes_with_the_stuff
    nn = NeuralNetwork.new(4,3,2,4, build: false)
    assert_equal 4, nn.input_size
    assert_equal 3, nn.number_of_hidden_layers
    assert_equal 2, nn.hidden_layer_size
    assert_equal 4, nn.output_size
    assert_equal [], nn.weights
  end

  def test_injects_inputs
    nn = NeuralNetwork.new(3,1,3,4)
    nn.inject_inputs([1,1,1])

    assert_equal [-1,1,1,1], nn.layers[0].map(&:value)
  end

  def test_assigns_outputs
    nn = NeuralNetwork.new(3,1,3,4)
    h1, h2, h3 = nn.layers[1][1..-1]
    o1, o2, o3, o4 = nn.layers[2]

    inputs = [1, 1, 1]

    nn.inject_inputs(inputs)

    h1.compute_output
    h2.compute_output
    h3.compute_output

    o1.compute_output
    o2.compute_output
    o3.compute_output
    o4.compute_output

    expected = [o1,o2,o3,o4].map(&:value)
    nn.reset_values
    computed = nn.forward_propogate(inputs)

    assert_equal expected, computed
  end

  def test_injects_errors
    nn = NeuralNetwork.new(3,2,3,4)
    nn.inject_errors([1,1,1],[1,1,1,1])

    assert nn.output_layer.all? {|x| x.error == x.value - 1}
  end

  def test_computes_errors
    nn = NeuralNetwork.new(3,4,2,4)
    nn.backward_propogate([1,1,1],[1,1,1,1])

    assert nn.input_layer.errors.all?{|x| x.nil?}
    nn.hidden_layers.each do |layer|
      layer.all?{|neuron| neuron.error.nil? if neuron.is_bias}
    end

    nn.hidden_layers.each do |layer|
      layer.all?{|neuron| neuron.value == -1 if neuron.is_bias}
    end
  end

end

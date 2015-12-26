require 'minitest/autorun'
require_relative '../lib/neuron'

class NeuronTest < Minitest::Test

  def test_exists
    assert Neuron
  end

  def test_initializes_with_inputs_and_weights
    n = Neuron.new(4)
    assert_equal [], n.weights_out
    assert_equal [], n.weights_in
    assert_equal 4, n.value
  end

  def test_sigmoid_function
    n = Neuron.new

    assert_equal 1/2.0, n.sigmoid(0)
    assert_equal 1/2.0, n.sigmoid(0.01).round(2)
    assert_equal 0, n.sigmoid(-100000).round(1)
    assert_equal 1, n.sigmoid(100000).round(1)
  end

  def test_computes_activation
    n = Neuron.new
    source_neurons = Array.new(3,0).map{|x| Neuron.new(rand(0.0..10.0))}

    i1, i2, i3 = source_neurons.map {|x| x.value}
    w1, w2, w3 = source_neurons.map {|x| Weight.new(x,n).value }

    computed = i1 * w1 + i2 * w2 + i3 * w3

    assert_equal computed, n.activation
  end

  def test_computes_output
    n = Neuron.new
    source_neurons = Array.new(3,0).map{|x| Neuron.new(rand(0.0..10.0))}

    i1, i2, i3 = source_neurons.map {|x| x.value}
    w1, w2, w3 = source_neurons.map {|x| Weight.new(x,n).value }

    computed = n.sigmoid(i1*w1 + i2*w2 + i3*w3)
    n.compute_output

    assert_equal [i1,i2,i3], source_neurons.map(&:value)
    assert_equal computed, n.value
  end

  def test_computes_pre_error
    n = Neuron.new
    target_neurons = Array.new(3,0).map{|x| Neuron.new}
    target_neurons.each {|neu| neu.error = rand(-1.0..1.0)}

    e1, e2, e3 = target_neurons.map {|x| x.error}
    w1, w2, w3 = target_neurons.map {|x| Weight.new(n,x).value }

    computed = (e1*w1 + e2*w2 + e3*w3)

    assert_equal computed, n.pre_error
  end

  def test_computes_error
    n = Neuron.new(2)
    target_neurons = Array.new(3,0).map{|x| Neuron.new}
    target_neurons.each {|neu| neu.error = rand(-1.0..1.0)}

    e1, e2, e3 = target_neurons.map {|x| x.error}
    w1, w2, w3 = target_neurons.map {|x| Weight.new(n,x).value }

    computed = (e1*w1 + e2*w2 + e3*w3)*(n.value)*(1-n.value)
    n.compute_error

    assert_equal computed, n.error
  end
end

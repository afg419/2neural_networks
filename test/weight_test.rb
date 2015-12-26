require 'minitest/autorun'
require_relative '../lib/weight'

class WeightTest < Minitest::Test

  def test_exists
    assert Weight
  end

  def test_initializes_with_the_stuff
    source = Neuron.new
    target = Neuron.new

    w = Weight.new(source,target)

    assert_equal source, w.source
    assert_equal target, w.target
    assert -1 <= w.value && w.value <= 1

    assert source.weights_out.include?(w)
    assert target.weights_in.include?(w)
  end

  def test_adds_delta
    i,e = [rand(-1.0..1.0), rand(-1.0..1.0)]
    source = Neuron.new(i)
    target = Neuron.new
    target.error = e
    w = Weight.new(source,target)

    assert_equal 0, w.modification_delta

    w.add_delta

    assert_equal i*e, w.modification_delta
  end

  def test_updates_weight
    # source = Neuron.new(1)
    # target = Neuron.new
    # target.error = 1
    # w = Weight.new(source,target)
    #
    # inits = Array.new(20,0).map{[rand(-1.0..1.0), rand(-1.0..1.0)]}
    #
    # inits.each do |i,e|
    #   source.value = i
    #   target.error = e
    #
    #
    # end
    #
    # source = Neuron.new(i)
    # target = Neuron.new
    # target.error = e
    #
    # assert_equal 0, w.modification_delta
    #
    # w.add_delta
    #
    #  assert_equal i*e, w.modification_delta
  end

end

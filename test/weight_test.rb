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

end

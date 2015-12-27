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

  def test_adds_many_deltas
    source, target = Neuron.new, Neuron.new
    w = Weight.new(source,target)
    current_weight = w.value


    i1, e1 = [rand(-1.0..1.0), rand(-1.0..1.0)]
    source.value = i1
    target.error = e1

    w.add_delta

    i2, e2 = [rand(-1.0..1.0), rand(-1.0..1.0)]
    source.value = i2
    target.error = e2

    w.add_delta

    i3, e3 = [rand(-1.0..1.0), rand(-1.0..1.0)]
    source.value = i3
    target.error = e3

    w.add_delta

    total_delta = i1*e1 + i2*e2 + i3*e3

    assert_equal total_delta, w.modification_delta
  end

end

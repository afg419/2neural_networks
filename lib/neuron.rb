require_relative 'weight'

class Neuron
  attr_accessor :value, :error
  attr_reader :weights_out, :weights_in

  def initialize(value = nil)
    @weights_out = []
    @weights_in = []
    @value = value
  end

  def activation
    weights_in.reduce(0) do |out, weight|
      out + weight.value * weight.source.value
    end
  end

  def sigmoid(x)
    1.0/(1+Math.exp(-x))
  end

  def compute_output
    @value = sigmoid(activation) if activation
  end
end

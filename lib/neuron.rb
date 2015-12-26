require_relative 'weight'

class Neuron
  attr_accessor :value, :error
  attr_reader :weights_out, :weights_in, :is_bias

  def initialize(value = nil, opt = {bias: false})
    @weights_out = []
    @weights_in = []
    @value = value
    @is_bias = opt[:bias]
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

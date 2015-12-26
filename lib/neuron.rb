require_relative 'weight'

class Neuron
  attr_accessor :value, :error, :modify_weights_by
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

  def pre_error
    weights_out.reduce(0) do |error, weight|
      error + weight.value * weight.target.error
    end
  end

  def compute_error
    @error = pre_error * value * (1 - value)
  end
end

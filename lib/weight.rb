require_relative 'neuron'

class Weight
  attr_accessor :value, :source, :target

  def initialize(n_in, n_out, value = rand(-1.0..1.0))
    @value = value
    @source = n_in
    @target = n_out
    n_in.weights_out << self
    n_out.weights_in << self
  end
end

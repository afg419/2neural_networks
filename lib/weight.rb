require_relative 'neuron'

class Weight
  attr_accessor :value, :source, :target, :modification_delta

  def initialize(n_in, n_out, value = rand(-1.0/10..1.0/10))
    @value = value
    @source = n_in
    @target = n_out
    @modification_delta = 0
    n_in.weights_out << self
    n_out.weights_in << self
  end

  def add_delta
    self.modification_delta += source.value * target.error
  end

  def update_value(example_count, regularization_constant)
    self.value -= (1.0/example_count) * (modification_delta +
    (source.is_bias ? 0 : regularization_constant * value))
  end
end

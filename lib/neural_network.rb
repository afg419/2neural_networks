require_relative 'neuron'
require_relative 'weight'
require_relative 'network_constructor'
require 'pry'

class NeuralNetwork

  include NetworkConstructor

  attr_reader :number_of_hidden_layers, :hidden_layer_size, :layers, :input_size, :output_size, :weights

  def initialize(inputs, number_of_hidden_layers, hidden_layer_size, outputs, opts = {build: true})
    @input_size = inputs
    @number_of_hidden_layers = number_of_hidden_layers
    @hidden_layer_size = hidden_layer_size
    @output_size = outputs
    @weights = []
    create_network if opts[:build]
  end

  def input_layer
    layers[0]
  end

  def output_layer
    layers[-1]
  end

  def hidden_layers
    layers[1..-2]
  end

  def inject_inputs(inputs)
    input_layer[1..-1].each_with_index do |neuron, i|
      neuron.value = inputs[i]
    end
  end

  def forward_propogate(inputs)
    inject_inputs(inputs)
    prop_layers = hidden_layers + [output_layer]

    prop_layers.each do |layer|
      layer.each do |neuron|
        neuron.compute_output unless neuron.is_bias
      end
    end
    output_layer.map(&:value)
  end

  def reset_values
    layers.each do |layer|
      layer.each do |neuron|
        neuron.value = nil unless neuron.is_bias
      end
    end
  end

  def visualize_weights
    weights.map{|w| "#{w.source.value} --#{w.value}--> #{w.target.value}"}
  end

  def inject_errors(inputs, expected_outputs)
    actual_outputs = forward_propogate(inputs)
    output_layer.each_with_index do |neuron, i|
      neuron.error = actual_outputs[i] - expected_outputs[i]
    end
  end

  def backward_propogate(inputs, expected_outputs)
    inject_errors(inputs, expected_outputs)

    hidden_layers.reverse.each do |layer|
      layer.each do |neuron|
        neuron.compute_error unless neuron.is_bias
      end
    end
  end
end

class Array
  def values
    self.map{|x| x.value}
  end

  def errors
    self.map{|x| x.error}
  end
end

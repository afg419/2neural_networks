require_relative 'neuron'
require_relative 'weight'
require_relative 'network_constructor'
require 'pry'

class NeuralNetwork

  include NetworkConstructor

  attr_reader :number_of_hidden_layers, :hidden_layer_size, :layers, :input_size, :output_size, :weights

  def initialize(inputs, number_of_hidden_layers, hidden_layer_size, outputs, build = false)
    @input_size = inputs
    @number_of_hidden_layers = number_of_hidden_layers
    @hidden_layer_size = hidden_layer_size
    @output_size = outputs
    @weights = []
    create_network if build
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
    input_layer.exclude_bias.each_with_index do |neuron, i|
      neuron.value = inputs[i]
    end
  end

  def forward_propogate(inputs)
    inject_inputs(inputs)

    hidden_layers.each do |layer|
      layer.exclude_bias.each do |neuron|
        neuron.compute_output
      end
    end

    output_layer.each do |neuron|
      neuron.compute_output
    end

    output_layer.map(&:value)
  end

  def reset_values
    biased_layers = [input_layer] + hidden_layers
    biased_layers.each do |layer|
      layer.exclude_bias.each do |neuron|
        neuron.value = nil
      end
    end

    output_layer.each do |neuron|
      neuron.value = nil
    end
  end

  def visualize_weights
    weights.map{|w| "#{w.source.value} -- #{w.value} --> #{w.target.value}"}
  end
end

class Array
  def exclude_bias
    self[1..-1]
  end
end

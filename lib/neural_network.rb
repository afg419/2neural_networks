require_relative 'neuron'
require_relative 'weight'
require 'pry'

class NeuralNetwork

  attr_reader :hidden_layers, :hidden_layer_size, :layers, :input_size, :output_size, :weights

  def initialize(inputs, hidden_layers, hidden_layer_size, outputs)
    @input_size = inputs
    @hidden_layers = hidden_layers
    @hidden_layer_size = hidden_layer_size
    @output_size = outputs
    @weights = []
  end

  def new_layer(size)
    Array.new(size, 0).map{|x| Neuron.new}
  end

  def visualize_weights
    weights.map{|w| "#{w.source.value} -- #{w.value} --> #{w.target.value}"}
  end

  def create_neurons
    hidden_neuron_layers = Array.new(hidden_layers, [])
    hidden_neuron_layers.map! do |layer|
      new_layer(hidden_layer_size)
    end
    @layers = [new_layer(input_size)] + hidden_neuron_layers + [new_layer(output_size)]
  end

  def create_weights
    layers.each_index do |i|
      add_weights_between(layers[i],layers[i+1])
      break if layers[i+1] == layers[-1]
    end
  end

  def create_biases
    layers.each_index do |i|
      bias = Neuron.new(-1)
      layers[i].unshift(bias)
      layers[i+1].each do |target_neuron|
        @weights << Weight.new(bias, target_neuron)
      end
      break if layers[i+1] == layers[-1]
    end
  end

  def add_weights_between(source_neuron_array, target_neuron_array)
    source_neuron_array.each do |source_neuron|
      target_neuron_array.each do |target_neuron|
        @weights << Weight.new(source_neuron,target_neuron)
      end
    end
  end

  def create_network
    create_neurons
    create_weights
    create_biases
  end

  def inject_inputs(inputs)
    inputs.each_index do |i|
      layers[0][i+1].value = inputs[i]
    end
  end

  def forward_propogate(inputs)
    inject_inputs(inputs)

    layers[1..-2].each do |layer|
      layer[1..-1].each do |neuron|
        neuron.compute_output
      end
    end

    layers[-1].each do |neuron|
      neuron.compute_output
    end

    layers[-1].map(&:value)
  end

  def reset_values
    layers.each do |layer|
      layer[1..-1].each do |neuron|
        neuron.value = nil
      end
    end
    layers[-1][0].value = nil
  end
end

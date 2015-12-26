module NetworkConstructor

  def new_layer(size)
    Array.new(size, 0).map{|x| Neuron.new}
  end

  def create_neurons
    hidden_neuron_layers = Array.new(number_of_hidden_layers, [])
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

  def add_weights_between(source_neuron_array, target_neuron_array)
    source_neuron_array.each do |source_neuron|
      target_neuron_array.each do |target_neuron|
        @weights << Weight.new(source_neuron,target_neuron)
      end
    end
  end

  def create_biases
    layers.each_index do |i|
      bias = Neuron.new(-1, bias: true)
      layers[i].unshift(bias)
      layers[i+1].each do |target_neuron|
        @weights << Weight.new(bias, target_neuron)
      end
      break if layers[i+1] == layers[-1]
    end
  end

  def create_network
    create_neurons
    create_weights
    create_biases
  end

end

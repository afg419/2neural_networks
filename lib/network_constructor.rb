class NetworkAdapter

  def initialize(neural_network)
    @net = neural_network
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
end

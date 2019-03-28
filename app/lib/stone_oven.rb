class StoneOven
  attr_reader :state, :temperature

  def initialize(temperature: 320, state: :on)
    @state = state
    @temperature = temperature
  end

  def bake(pizza)
    raise IOError.new("Oven is not hot enough") unless can_bake?

    Log.info "Baking the pizza"
    sleep 2
    Log.info "Pizza is now ready"
    pizza.new(state: 'baked')
  end

  def can_bake?
    state == :on && temperature > 300
  end
end

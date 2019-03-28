class PackingRobot
  attr_reader :state, :boxes

  def initialize(state: :off, boxes: 0)
    @state = state
    @boxes = boxes.to_i
  end

  def pack(pizza)
    raise IOError.new('Failure: taking bap or not enough boxes') unless can_pack?

    Log.info "Packing pizza ..."
    sleep 1
    Log.info "Pizza is now packed"

    pizza.new(state: 'packed')
  end

  def can_pack?
    state == :on && boxes > 0
  end
end

require 'dry/container'

module Containers
  class KitchenAppliances
    extend Dry::Container::Mixin

    register 'stone_oven' do
      StoneOven.new(temperature: 320, state: :on)
    end

    register 'old_oven' do
      StoneOven.new(temperature: 20, state: :off)
    end

    register 'packing_robot' do
      PackingRobot.new(boxes: 30, state: :on)
    end

    register 'old_packing_robot' do
      PackingRobot.new(boxes: 30, state: :off)
    end
  end
end

require 'dry/monads/result'

require_relative 'dry_response.rb'

module Functions
  # BaseClass for project functions
  class BaseDryFunction
    include Dry::Monads::Result::Mixin
    extend DryResponse

    attr_reader :event, :context

    def initialize(event, context)
      @event = event
      @context = context
    end

    def self.call(event, context = {}, enable_after_call: true)
      result = new(event, context).call

      dry_response(result) if enable_after_call
    rescue => e
      dry_response(e) # catches transaction exception
    end

    def call
      raise NotImplementedError.new('Must be implemented by the SubClass')
    end

    def after_call(response)
      dry_response response
    end
  end
end

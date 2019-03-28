require 'dry-initializer'
require 'dry-validation'
require 'dry/monads/result'
require 'dry/monads/try'
require 'dry/auto_inject'

Dry::Validation.load_extensions(:monads)

# Base class for all the service using Dry-rb
class BaseDryService
  extend Dry::Initializer
  include Dry::Monads::Result::Mixin

  def self.call(**args)
    validate(validator, args).bind do |schema|
      Dry::Monads::Try() do
        self.new(**schema.to_h).call
      end.to_result
    end
  end

  def self.validate(schema, args)
    raise ArgumentError.new("missing schema or args") if schema.nil? || args.nil?

    schema.call(args.to_h).to_monad
  rescue => e
    Dry::Monads::Failure(e)
  end

  def self.validator
    unless defined?(self::ArgumentsSchema)
      raise NotImplementedError.new("#{self.class.name} - doesnt have ArgumentSchema")
    end

    self::ArgumentsSchema
  end

  def call
    raise NotImplementedError
  end
end

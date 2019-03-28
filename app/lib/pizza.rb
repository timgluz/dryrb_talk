require 'dry-struct'

# example of Dry-Struct
# Types comes from lib/types.rb
class Pizza < Dry::Struct
  transform_keys(&:to_sym)

  attribute :name, Types::Strict::String
  attribute :state, Types::Strict::String
  attribute :size, Types::Coercible::Integer

  # list of sub-items
  attribute :toppings, Types::Strict::Array do
    attribute :name, Types::Strict::String
    attribute :quantity, Types::Strict::Integer
  end
end

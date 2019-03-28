module Services
  class CreatePizzaFlow
    include Dry::Transaction

    # not mandatory!
    # quickly check that input data makes sense
    # ps: Our Chef is a bit sensitive
    ArgumentsSchema = Dry::Validation.Schema do
      required(:size).filled(:number?)
      required(:toppings).filled(:array?)

      # hint: the Chef is from Napoli/Naples
      validate(naples_rule: [:toppings]) do |toppings|
        items = toppings.to_a

        items.keep_if {|item| item[:name] =~ /pineapple/i }.empty?
      end

      # just for demo, i recommend to use yaml file for that
      configure do
        def self.messages
          super.merge(
            en: { errors: {naples_rule: 'I cant do that, Steve.'}}
          )
        end
      end
    end

    # would probably land in future in the base_transaction class
    def self.call(**args)
      new.call(args)
    end

    step :validate_params
    step :prepare_pizza
    step :bake_pizza
    step :pack_pizza

    private

    def validate_params(order)
      Log.info "Validating params: #{order}"

      ArgumentsSchema.call(order).to_monad
    end

    def prepare_pizza(order)
      Log.info "Sending order to the Chef"

      Services::PreparePizza.(**order)
    end

    def bake_pizza(pizza)
      Log.info "Pizza goes now into the oven"

      Services::BakePizza.(pizza: pizza)
    end

    def pack_pizza(pizza)
      Log.info "Asking to pack the pizza"

      Services::PackPizza.(pizza: pizza)
    end
  end
end

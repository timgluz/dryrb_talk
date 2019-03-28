module Services
  class PreparePizza < BaseDryService
    option :size, proc(&:to_i)
    option :toppings

    # SubSchema
    ToppingsSchema = Dry::Validation.Schema do
      required(:name).filled(:str?)
      required(:quantity).filled(:int?)
    end

    ArgumentsSchema = Dry::Validation.Schema do
      required(:size).filled(:number?, gt?: 10, lteq?: 60)

      required(:toppings).each { schema(ToppingsSchema) }
    end

    def call
      # raise Error.new('Not enough ingredients.'))

      make_new_pizza
    end

    private

    def make_new_pizza
      Pizza.new(
        name: 'Rubylicious Pizza',
        state: 'unbaked',
        size: size,
        toppings: toppings
      )
    end
  end
end

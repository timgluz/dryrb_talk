module Services
  KitchenAppliances = Dry::AutoInject(Containers::KitchenAppliances)

  class BakePizza < BaseDryService
    include KitchenAppliances['stone_oven', 'old_oven']

    option :pizza

    ArgumentsSchema = Dry::Validation.Schema do
      required(:pizza).filled
    end

    def call
      #old_oven.bake(pizza)

      stone_oven.bake(pizza)
    end
  end
end

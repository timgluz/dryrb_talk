module Services
  class PackPizza < BaseDryService
    include KitchenAppliances['packing_robot', 'old_packing_robot']

    option :pizza

    ArgumentsSchema = Dry::Validation.Schema do
      required(:pizza).filled
    end

    def call
      # old_packing_robot.pack(pizza)

      packing_robot.pack(pizza)
    end
  end
end

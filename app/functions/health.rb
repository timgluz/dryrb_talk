module Functions
  # example function to expose heart beat
  class Health < BaseDryFunction
    def call
      Dry::Monads::Success(
        health: 'Feeling Good!'
      )
    end
  end
end

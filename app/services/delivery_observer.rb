module Services
  NOTIFIERS = Dry::AutoInject(Containers::NotifierContainer)

  class DeliveryObserver
    include NOTIFIERS['say_notifier']

    A_LAST_STEP_NAME = :pack_pizza

    def on_step_succeeded(event)
      return if event[:step_name] != A_LAST_STEP_NAME

      say_notifier.notify(message: "Yipikaye, pizza time!")
    end
  end
end

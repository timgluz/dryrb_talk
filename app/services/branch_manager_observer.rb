module Services

  NOTIFIERS = Dry::AutoInject(Containers::NotifierContainer)

  class BranchManagerObserver
    include NOTIFIERS['osx_notifier']

    ACTOR_TITLE = 'BranchManager'
    SUCCESS_MESSAGE = "Good job with %{step_name}!"
    FAILURE_MESSAGE = "You must do better than that!"

    def on_step_succeeded(event)
      osx_notifier.notify(message: SUCCESS_MESSAGE % event, title: ACTOR_TITLE)
    end

    def on_step_failed(event)
      msg = if event[:step_name] == :pack_pizza
              "OK. My Bad, i am sorry. Will order more boxes;"
            else
              FAILURE_MESSAGE
            end

      osx_notifier.notify(message: msg, title: ACTOR_TITLE)
    end
  end
end

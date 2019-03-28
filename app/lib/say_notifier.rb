class SayNotifier
  CMD = 'say'

  def notify(message:, **args)
    system(CMD, message.to_s)
  end
end

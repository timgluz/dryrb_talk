class OsxNotifier
  CMD = "osascript"
  SCRIPT_TEMPLATE = "display notification \"%{message}\" with title \"%{title}\""

  def notify(message:, title: 'Pizza Bot')
    system(CMD, '-e' , SCRIPT_TEMPLATE % {title: title, message: message})
  end
end

require './app'

OsxNotifier.new.notify(title: 'Test', message: '1-2-3, check-check')

SayNotifier.new.notify(message: 'Hello there!')

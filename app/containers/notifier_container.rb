require 'dry/container'

module Containers
  class NotifierContainer
    extend Dry::Container::Mixin

    register 'osx_notifier' do
      OsxNotifier.new
    end

    register 'say_notifier' do
      SayNotifier.new
    end
  end
end

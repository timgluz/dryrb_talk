require 'logger'
require 'forwardable'
require 'singleton'

class Log
  extend Forwardable
  include Singleton

  def initialize
    @logger = Logger.new(STDOUT)
    @error_logger = Logger.new(STDERR)
  end

  def self.method_missing(method_name, *args, &block)
    if respond_to_missing?(method_name)
      Log.instance.send(method_name, *args, &block)
    else
      super.send(method_name, *args, &block)
    end
  end

  def self.respond_to_missing?(name, *args)
    [
      :info, :info?, :debug, :debug?, :warn, :warn?, :unknown, :log,
      :error, :error?, :fatal, :fatal?, :unknown
    ].include?(name.to_sym)
  end

  def_delegators :@logger, :info, :info?, :debug, :debug?, :warn, :warn?, :log
  def_delegators :@error_logger, :error, :error?, :fatal, :fatal?, :unknown
end

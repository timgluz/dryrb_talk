require 'json'
require 'dry/transaction'

require 'config'
require 'zeitwerk'
require 'logger'

DEFAULT_ENV = 'development'

# initialize config
config_path = './config'
ruby_env = (ENV['RACK_ENV'] || DEFAULT_ENV)
Config.load_and_set_settings(Config.setting_files(config_path, ruby_env))

# load code
loader = Zeitwerk::Loader.new
loader.push_dir('./app/lib') # use it as root namespace
loader.push_dir('./app/models')
loader.push_dir('./app')
loader.setup # ready!

# load database settings
def connect_database
  if Settings.present? && Settings.db.to_h.size > 0
    Log.info "Connecting to database: #{Settings.db.host}"

    ActiveRecord::Base.logger = Log.instance
    ActiveRecord::Base.establish_connection(**Settings.db)
  elsif Settings.present? && Settings.db.to_h.size < 1
    error_message = "config/settings/#{ruby_env}.yml has no :db values specified"
    Log.error error_message

    raise IOError.new(error_message)
  else
    error_message "Missing database config for RACK_ENV=`#{ruby_env}` - add it into `config/settings` folder"
    Log.error error_message
    raise IOError.new(error_message)
  end
end

# -- routes
def health(event:, context:)
  Log.debug "Got event: #{event}"

  Functions::Health.call(event, context)
end

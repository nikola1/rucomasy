module RucomasyBase
  # Folders
  MODELS      = 'app/models'
  VIEWS       = 'app/views'
  CONTROLLERS = 'app/controllers'
  HELPERS     = 'app/helpers'

  PUBLIC      = 'webroot'
  FILES       = 'files'

  # Files
  SETTINGS    = 'config/sinatra.yml'

  def self.require_files_from(dirname)
    Dir[File.join File.dirname(__FILE__), dirname, '*.rb'].each do |file|
      require "#{file}"
    end
  end
end
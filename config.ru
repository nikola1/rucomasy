require 'data_mapper'
require 'sinatra/base'
require 'yaml'

module RucomasyStructure
  # Folders
  MODELS      = 'app/models'
  VIEWS       = 'app/views'
  CONTROLLERS = 'app/controllers'
  PUBLIC      = 'webroot'

  # Files
  SETTINGS    = 'config/sinatra.yml'

  def self.load(filename)
    load filename if filename =~ %r[\.rb\z]
  end
end

Dir[RucomasyStructure::CONTROLLERS].each { |file| RucomasyStructure.load file }
Dir[RucomasyStructure::MODELS].each      { |file| RucomasyStructure.load file }

class RucomasyWebApp < Sinatra::Base
  # Load controllers
  Object.constants.each do |c|
    const = Kernel.const_get(c)
      if c.to_s =~ /.+Controller\z/ && Class === const && const < Sinatra::Base
        use const
      end
  end

  # Load settings
  YAML.load(File.open RucomasyStructure::SETTINGS)[settings.environment.to_s].each do |k, v|
    set k.to_sym, v
  end rescue NoMethodError

  # Menual settings
  set :public_folder, RucomasyStructure::PUBLIC
  set :views, RucomasyStructure::VIEWS
end

run RucomasyWebApp
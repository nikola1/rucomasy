require 'data_mapper'
require 'sinatra/base'
require 'yaml'
require './core/rucomasy'

DataMapper::Logger.new(STDOUT, :debug)

DataMapper.setup(:default, "sqlite://#{File.absolute_path 'db/development.db'}")

module RucomasyStructure
  # Folders
  MODELS      = 'app/models'
  VIEWS       = 'app/views'
  CONTROLLERS = 'app/controllers'
  HELPERS     = 'app/helpers'

  PUBLIC      = 'webroot'
  FILES       = 'files'

  # Files
  SETTINGS    = 'config/sinatra.yml'
end

Dir[File.join RucomasyStructure::CONTROLLERS, '*.rb'].each do |file|
  require "./#{file}"
end

Dir[File.join RucomasyStructure::MODELS, '*.rb'].each do |file|
  require "./#{file}"
end

Dir[File.join RucomasyStructure::HELPERS, '*.rb'].each do |file|
  require "./#{file}"
end

DataMapper.auto_upgrade!
DataMapper.finalize

class RucomasyWebApp < Sinatra::Base
  # Load settings
  YAML.load(File.open RucomasyStructure::SETTINGS)[settings.environment.to_s].each do |k, v|
    set k.to_sym, v
  end rescue NoMethodError

  # Menual settings
  set :root, File.dirname(__FILE__)
  set :public_folder, RucomasyStructure::PUBLIC
  set :views, File.join(File.dirname(__FILE__), RucomasyStructure::VIEWS)
  set :files, File.join(File.dirname(__FILE__), RucomasyStructure::FILES)

  enable :sessions

  # Load helpers
  Object.constants.each do |c|
    const = Kernel.const_get(c)
      if c.to_s =~ /.+SHelper\z/ && Module === const
        helpers const
      end
  end
end

run RucomasyWebApp
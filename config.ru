require './rucomasy_base'
require 'data_mapper'
require 'sinatra/base'
require 'yaml'
require './core/rucomasy'

DataMapper::Logger.new(STDOUT, :debug)

DataMapper.setup(:default, "sqlite://#{File.absolute_path 'db/development.db'}")

RucomasyBase.require_files_from RucomasyBase::MODELS
RucomasyBase.require_files_from RucomasyBase::CONTROLLERS
RucomasyBase.require_files_from RucomasyBase::HELPERS


class RucomasyWebApp < Sinatra::Base
  # Load settings
  YAML.load(File.open RucomasyBase::SETTINGS)[settings.environment.to_s].each do |k, v|
    set k.to_sym, v
  end rescue NoMethodError

  # Menual settings
  set :root, File.dirname(__FILE__)
  set :public_folder, RucomasyBase::PUBLIC
  set :views, File.join(File.dirname(__FILE__), RucomasyBase::VIEWS)
  set :files, File.join(File.dirname(__FILE__), RucomasyBase::FILES)

  enable :sessions

  # Load helpers
  Object.constants.each do |c|
    const = Kernel.const_get(c)
      if c.to_s =~ /.+SHelper\z/ && Module === const
        helpers const
      end
  end
end

DataMapper.auto_upgrade!
DataMapper.finalize

run RucomasyWebApp
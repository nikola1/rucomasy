require './core/rucomasy'
require './db/data_mapper'
require 'sinatra/base'
require 'yaml'

Rucomasy::FileHelper.require_files_from Rucomasy::FileHelper::CONTROLLERS
Rucomasy::FileHelper.require_files_from Rucomasy::FileHelper::HELPERS

class RucomasyWebApp < Sinatra::Base
  # Load settings
  YAML.load(File.open Rucomasy::FileHelper::SETTINGS)[settings.environment.to_s].each do |k, v|
    set k.to_sym, v
  end rescue NoMethodError

  # Menual settings
  set :root, Rucomasy::FileHelper::PROJECT_DIR
  set :public_folder, Rucomasy::FileHelper::PUBLIC
  set :views, Rucomasy::FileHelper::VIEWS
  set :files, Rucomasy::FileHelper::FILES
  set :submissions, Rucomasy::FileHelper::SUBMISSIONS

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
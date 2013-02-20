require 'data_mapper'
require 'sinatra/base'
require 'yaml'

module RucomasyStructure
  CONTROLLERS = 'app/controllers/*.rb'
  MODELS      = 'app/models/*.rb'
  SETTINGS    = 'config/sinatra.yml'
end

Dir[RucomasyStructure::CONTROLLERS].each { |file| load file }
Dir[RucomasyStructure::MODELS].each      { |file| load file }

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
end

run RucomasyWebApp
require 'data_mapper'
require 'sinatra/base'

Dir['app/controllers/*.rb'].each { |file| load file }
Dir['app/models/*.rb'].each { |file| load file }

class RucomasyApp < Sinatra::Base
  Object.constants.each do |c|
    const = Kernel.const_get(c)
      if c.to_s =~ /.+Controller\z/ && Class === const && const < Sinatra::Base
        use const
      end
  end
end

run RucomasyApp
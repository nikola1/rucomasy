require 'data_mapper'

# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "sqlite://#{File.join File.dirname(__FILE__), 'development.db'}")

RucomasyBase.require_files_from RucomasyBase::MODELS

DataMapper.auto_upgrade!
DataMapper.finalize

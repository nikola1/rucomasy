require 'data_mapper'

# DataMapper::Logger.new(STDOUT, :debug)
DataMapper.setup(:default, "sqlite://#{Rucomasy::FileHelper::DB}/development.db}")

Rucomasy::FileHelper.require_files_from Rucomasy::FileHelper::MODELS

DataMapper.auto_upgrade!
DataMapper.finalize

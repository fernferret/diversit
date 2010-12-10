require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'models/User'
require 'models/Comment'
require 'models/Question'
require 'models/Answer'
require 'logger'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/diversit.sqlite")
DataMapper.finalize
DataMapper.auto_upgrade!
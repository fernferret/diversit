require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'dm-is-tree'
require 'models/User'
require 'models/Question'
require 'models/Response'
require 'logger'

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/diversit.sqlite")
DataMapper.finalize
#DataMapper.auto_upgrade!

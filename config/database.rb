require 'rubygems'
require 'dm-core'
require 'dm-migrations'
require 'dm-is-tree'
require 'models/User'
require 'models/Question'
require 'models/Response'
require 'logger'

DataMapper::Logger.new($stdout, :debug)
if RUBY_PLATFORM =~ /mac/
  DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/diversit.sqlite")
else
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/diversit.sqlite")
end
DataMapper.finalize
DataMapper.auto_upgrade!

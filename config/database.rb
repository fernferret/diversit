require 'models/User'
require 'models/Question'
require 'models/Choice'
require 'models/Response'

DataMapper::Logger.new($stdout, :debug)

if RUBY_PLATFORM =~ /mac/
  DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/diversit.sqlite")
else
  DataMapper.setup(:default, "sqlite://#{Dir.pwd}/diversit.sqlite")
end

DataMapper.finalize
DataMapper.auto_upgrade!

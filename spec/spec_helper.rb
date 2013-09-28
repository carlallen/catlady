require 'rspec'
#require 'debugger'
require 'catlady'

RSpec.configure do |config|
	ENV["CATLADY_YML"] = File.join(Pathname.new(__FILE__).dirname,"config/catlady.yml")
end
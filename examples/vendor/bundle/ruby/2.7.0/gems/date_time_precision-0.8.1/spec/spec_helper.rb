require 'rubygems'
require 'bundler/setup'

begin
  require 'pry'
rescue LoadError
end

Dir['./spec/support/**/*.rb'].map {|f| require f}

RSpec.configure do |c|
  c.color = true
end
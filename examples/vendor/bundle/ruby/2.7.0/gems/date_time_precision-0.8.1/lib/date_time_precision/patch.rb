require 'date_time_precision/lib'

require 'date_time_precision/format/nil'

DateTimePrecision::PATCH_VERSION = begin
  if defined?(JRUBY_VERSION) || (defined?(RUBY_ENGINE) and RUBY_ENGINE == 'rbx')
    #JRuby and Rubinius implement the Date/Time classes in pure Ruby, so they can use the 1.9.2 patch
    RUBY_VERSION >= '1.9' ? '1.9.2' : '1.8.7'
  elsif RUBY_VERSION > '2'
    # The 1.9.3 patch works in Ruby 2.0.0
    '1.9.3'
  else
    RUBY_VERSION
  end
end
      

Dir["#{File.dirname(__FILE__)}/patch/#{DateTimePrecision::PATCH_VERSION}/*.rb"].each {|f| require f }
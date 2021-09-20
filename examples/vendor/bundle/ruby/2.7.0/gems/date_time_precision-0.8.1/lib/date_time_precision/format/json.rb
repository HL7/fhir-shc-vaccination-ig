require 'date_time_precision/format/hash'

if defined?(ActiveSupport)
  require 'active_support/json/encoding'
  
  [Date, Time, DateTime].each do |klass|
    klass.class_eval do
      def as_json(*args)
        to_h
      end
      
      def to_json(opts = {})
        to_h.to_json(opts)
      end
    end
  end
end

module DateTimePrecision
  def as_json(*args)
    to_h
  end
  
  def to_json(opts = {})
    to_h.to_json(opts)
  end
end
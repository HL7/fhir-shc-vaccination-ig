require 'date_time_precision/lib'
require 'time'

class Time
  MAX_PRECISION =
      if DateTimePrecision::MICROSECONDS_SUPPORTED
        DateTimePrecision::USEC
      else
        DateTimePrecision::SEC
      end

  include DateTimePrecision
end
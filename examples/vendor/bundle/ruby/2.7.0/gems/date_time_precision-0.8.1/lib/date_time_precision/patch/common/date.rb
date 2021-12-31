require 'date_time_precision/lib'
require 'date'

class Date
  MAX_PRECISION = DateTimePrecision::DAY

  include DateTimePrecision
end
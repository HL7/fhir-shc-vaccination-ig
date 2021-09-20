require 'date_time_precision/lib'

class NilClass
  def precision
    DateTimePrecision::NONE
  end
end
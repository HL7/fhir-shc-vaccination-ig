require 'date_time_precision/lib'
require 'date'

class DateTime < Date
  MAX_PRECISION =
      if DateTimePrecision::MICROSECONDS_SUPPORTED
        DateTimePrecision::USEC
      else
        DateTimePrecision::SEC
      end

  include DateTimePrecision

  if method_defined?(:sec_fraction)
    alias_method :sec_frac?, :usec?
    alias_method :sec_fraction?, :usec?

    def usec
      (sec_fraction.to_f*1_000_000).to_i
    end
  end

  if method_defined?(:utc)
    alias_method :utc_orig, :utc
    def utc
      dt = utc_orig
      dt.precision = precision
      dt
    end
  else
    def utc
      self.to_time.utc.to_datetime
    end
  end
end
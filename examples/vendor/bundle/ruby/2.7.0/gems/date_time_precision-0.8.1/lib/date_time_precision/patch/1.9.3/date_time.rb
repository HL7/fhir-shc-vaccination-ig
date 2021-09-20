require 'date_time_precision/patch/common/date_time'

class DateTime < Date
  class << self
    alias_method :new_orig, :new
    def new(*args)
      precision = self.precision(args)
      d = new_orig(*normalize_new_args(args))
      d.precision = precision
      d.attributes_set(*args)
      d
    end
    
    alias_method :parse_orig, :parse
    def parse(str='-4712-01-01T00:00:00+00:00', now=self.now)
      comp = !block_given?
      elem = _parse(str, comp)
      precision = self.precision(elem)
      dt = parse_orig(str, now)
      dt.precision = precision
      dt
    end
    
    alias_method :civil_orig, :civil
    def civil(*args)
      orig_args = args.shift(Time::MAX_PRECISION)
      precision = self.precision(orig_args)
      time_args = normalize_new_args(orig_args)
      
      dt = civil_orig(*[time_args, args].flatten)
      dt.precision = precision
      dt.attributes_set(*orig_args)
      dt
    end
    
    alias_method :strptime_orig, :strptime
    def strptime(date, format='%F', start=Date::ITALY)
      elem = _strptime(date, format)
      precision = self.precision(elem)
      d = strptime_orig(date, format, start)
      d.precision = precision
      d
    end

    def utc(*args)
      Time.utc(*args).to_datetime
    end

    def local(*args)
      Time.local(*args).to_datetime
    end
  end
  
end
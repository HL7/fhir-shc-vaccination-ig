require 'date_time_precision/patch/common/date_time'

class DateTime < Date
  class << self
    def parse(str='-4712-01-01T00:00:00+00:00', comp=false, sg=DateTime::ITALY)
      elem = _parse(str, comp)
      precision = DateTimePrecision::precision(elem)
      dt = new_by_frags(elem, sg)
      dt.precision = precision
      dt
    end

    def civil(y=nil, m=nil, d=nil, h=nil, min=nil, s=nil, of=0, sg=DateTime::ITALY)
      time_args = [y,m,d,h,min,s]
      precision = self.precision(time_args)
      time_args = normalize_new_args(time_args)
    
      unless (jd = valid_civil?(time_args[0], time_args[1], time_args[2], sg)) && (fr = valid_time?(time_args[3], time_args[4], time_args[5]))
        raise ArgumentError, 'invalid date'
      end
      if String === of
        of = Rational(zone_to_diff(of) || 0, 86400)
      end
      dt = new!(jd_to_ajd(jd, fr, of), of, sg)
      dt.precision = precision
      dt.attributes_set(y,m,d,h,min,s)
      dt
    end

    alias_method :new, :civil

    def strptime(str='-4712-01-01', fmt='%F', sg=DateTime::ITALY)
      elem = _strptime(str, fmt)
      precision = DateTimePrecision::precision(elem)
      d = new_by_frags(elem, sg)
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
require 'date_time_precision/patch/1.8.7/date_time'

class DateTime < Date
  def self.civil(y=nil, m=nil, d=nil, h=nil, min=nil, s=nil, of=0, sg=ITALY)
    time_args = [y,m,d,h,min,s]
    precision = self.precision(time_args)
    time_args = normalize_new_args(time_args)
  
    unless (jd = _valid_civil?(time_args[0], time_args[1], time_args[2], sg)) && (fr = _valid_time?(time_args[3], time_args[4], time_args[5]))
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

  class << self; alias_method :new, :civil end
end
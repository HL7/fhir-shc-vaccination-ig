require 'date_time_precision/patch/1.8.7/date'

class Date
  def self.civil(y=nil, m=nil, d=nil, sg=ITALY)
    args = [y,m,d]
    precision = self.precision(args)

    args = normalize_new_args(args)
  
    unless jd = _valid_civil?(*[args, sg].flatten)
      raise ArgumentError, 'invalid date'
    end
  
    date = new!(jd_to_ajd(jd, 0, 0), 0, sg)
    date.precision = precision
    date.attributes_set(y,m,d)
    date
  end

  class << self; alias_method :new, :civil end
end
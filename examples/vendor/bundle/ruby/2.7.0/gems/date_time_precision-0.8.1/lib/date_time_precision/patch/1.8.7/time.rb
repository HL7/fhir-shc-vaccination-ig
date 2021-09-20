require 'date_time_precision/patch/common/time'
require 'time'

class Time
  class << self
    alias_method :mktime_orig, :mktime
    def mktime(*args)
      orig_args = args.shift(Time::MAX_PRECISION)
      precision = self.precision(orig_args)
      time_args = normalize_new_args(orig_args)
      
      t = mktime_orig(*[time_args, args].flatten)
      t.precision = precision
      t.attributes_set(orig_args)
      t
    end
    
    alias_method :make_time_orig, :make_time
    def make_time(*args)
      orig_args = args.shift(Time::MAX_PRECISION)
      precision = self.precision(orig_args)
      time_args = normalize_new_args(orig_args)
      
      t = make_time_orig(*[time_args, args].flatten)
      t.precision = precision
      t.attributes_set(orig_args)
      t
    end
    private :make_time
    
    alias_method :utc_without_prec, :utc
    def utc(*args)
      orig_args = args.shift(Time::MAX_PRECISION)
      precision = self.precision(orig_args)
      time_args = normalize_new_args(orig_args)
      
      t = utc_without_prec(*[time_args, args].flatten)
      t.precision = precision
      t.attributes_set(orig_args)
      t
    end
    alias_method :gm, :utc
    
    alias_method :local_without_prec, :local
    def local(*args)
      orig_args = args.shift(Time::MAX_PRECISION)
      precision = self.precision(orig_args)
      time_args = normalize_new_args(orig_args)
      
      t = local_without_prec(*[time_args, args].flatten)
      t.precision = precision
      t.attributes_set(orig_args)
      t
    end
  end
  
  alias_method :utc_without_prec, :utc
  def utc(*args)
    t = utc_without_prec(*args)
    t.precision = self.precision
    t
  end

  #def self.strptime(str='-4712-01-01', fmt='%F', sg=Date::ITALY)
  #  DateTime.strptime(str, fmt, sg).to_time
  #end
end
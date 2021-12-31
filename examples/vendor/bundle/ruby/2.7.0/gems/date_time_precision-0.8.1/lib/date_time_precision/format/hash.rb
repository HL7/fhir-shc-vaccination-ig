require 'date_time_precision/lib'

class Hash
  DATE_FORMATS = {
    :short => [:y, :m, :d, :h, :min, :s, :us],
    :long => [:year, :month, :day, :hour, :minute, :second, :micro_seconds],
    :ruby => [:year, :mon, :day, :hour, :min, :sec, :usec]
  }
  DATE_FORMATS[:default] = DATE_FORMATS[:ruby]
  
  def to_time
    Time.mktime(*date_time_args)
  end
  
  def to_datetime
    DateTime.new(*date_time_args.take(DateTime::SEC))
  end
  
  def to_date
    Date.new(*date_time_args.take(Date::MAX_PRECISION))
  end
  
  protected
  def date_time_args
    year = self[:year] || self[:y] || self[:yr] || self['year'] || self['y'] || self['yr']
    month = self[:mon] || self[:m] || self[:month] || self['mon'] || self['m'] || self['month']
    day = self[:mday] || self[:d] || self[:day] || self['mday'] || self['d'] || self['day']
    hour = self[:hour] || self[:h] || self[:hr] || self['hour'] || self['h'] || self['hr']
    minute = self[:min] || self[:minute] || self['min'] || self["minute"]
    second = self[:sec] || self[:s] || self[:second] || self['sec'] || self['s'] || self["second"]
    micro_second = self[:sec_frac] || self[:second_fraction] || self['sec_frac'] || self['second_fraction'] ||
      self[:usec] || self[:micro_second] || self['usec'] || self['micro_second']

    [year, month, day, hour, minute, second, micro_second]
  end
end

module DateTimePrecision
  def to_h(format = nil)
    keys = Hash::DATE_FORMATS[format || :default]
    
    Hash[keys.each_with_index.map do |key,i|
      attribute_name = Hash::DATE_FORMATS[:ruby][i]
      [key, self.send(attribute_name)] if self.send("#{attribute_name}?")
    end.compact]
  end
end

require 'date_time_precision/compat/virtus' if defined?(Virtus)
require 'date_time_precision/compat/coercible' if defined?(Coercible)

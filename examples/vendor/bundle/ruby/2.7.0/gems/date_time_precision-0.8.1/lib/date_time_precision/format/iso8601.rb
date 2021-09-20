module DateTimePrecision
  ISO8601_DATE_FRAGMENTS = %w(%0*d %02d %02d)
  ISO8601_TIME_FRAGMENTS = %w(%02d %02d %02d)
end

[Date, Time, DateTime].each do |klass|
  klass.class_eval do
    if method_defined?(:xmlschema)
      alias_method :xmlschema_without_precision, :xmlschema
    end
    
    def xmlschema(fraction_digits=0)
      iso8601(fraction_digits)
    end

    if method_defined?(:iso8601)
      alias_method :iso8601_original, :iso8601
    end

    def iso8601(fraction_digits=0)
      fraction_digits = fraction_digits.to_i
      precision = self.precision || 0
      format = ""
      if precision > DateTimePrecision::NONE
        # Add date part to format
        format << DateTimePrecision::ISO8601_DATE_FRAGMENTS.take([3,self.precision].min).join('-')
      end

      if precision > DateTimePrecision::DAY
        format << "T#{DateTimePrecision::ISO8601_TIME_FRAGMENTS.take(precision - 3).join(':')}"
      end

      output = sprintf(format, year < 0 ? 5 : 4, *self.fragments)

      # Fractional seconds
      if fraction_digits > 0 && usec? && usec > 0
        if fraction_digits <= 6
          output << '.' + sprintf('%06d', usec)[0, fraction_digits]
        else
          output << '.' + sprintf('%06d', usec) + '0' * (fraction_digits - 6)
        end
      end

      # Timezone
      if precision > DateTimePrecision::DAY
        if utc?
          output << 'Z'
        else
          off = utc_offset
          sign = off < 0 ? '-' : '+'
          output << sprintf('%s%02d:%02d', sign, *(off.abs / 60).divmod(60))
        end
      end
      
      output
    end
  end
end

Date.instance_eval do
  if method_defined? :_xmlschema
    def xmlschema(val)
      date = _xmlschema(val).to_date
      if date.precision == DateTimePrecision::NONE
        raise ArgumentError.new("invalid date")
      end
      date
    end
  else
    def xmlschema(val)
      Time.xmlschema(val).to_date
    end
  end

  if method_defined? :iso8601
    alias_method :iso8601_original, :iso8601
    def iso8601(val)
      date = iso8601_original(val)
    rescue
      xmlschema(val)
    end
  else
    def iso8601(val)
      xmlschema(val)
    end
  end
end

Time.instance_eval do
  def xmlschema(date)
    if /\A\s*
        (-?\d+)(?:-(\d\d)(?:-(\d\d)
        (?:T
        (\d\d)(?::(\d\d)(?::(\d\d)
        (\.\d+)?
        )?)?)?
        (Z|[+-]\d\d:\d\d)?
        )?)?
        \s*\z/ix =~ date
      year = $1 && $1.to_i
      mon = $2 && $2.to_i
      day = $3 && $3.to_i
      hour = $4 && $4.to_i
      min = $5 && $5.to_i
      sec = $6 && $6.to_i
      usec = nil
      if $7
        usec = Rational($7) * 1000000
      end
      if $8
        zone = $8
        year, mon, day, hour, min, sec =
          apply_offset(year, mon, day, hour, min, sec, zone_offset(zone))
        self.utc(year, mon, day, hour, min, sec, usec)
      else
        self.local(year, mon, day, hour, min, sec, usec)
      end
    else
      raise ArgumentError.new("invalid date: #{date.inspect}")
    end
  end

  def iso8601(date)
    xmlschema(date)
  end
end

DateTime.instance_eval do
  if method_defined? :_xmlschema
    def xmlschema(val)
      date = _xmlschema(val).to_datetime
      if date.precision == DateTimePrecision::NONE
        raise ArgumentError.new("invalid date")
      end
      date
    end
  else
    def xmlschema(val)
      Time.xmlschema(val).to_datetime
    end
  end

  if method_defined? :iso8601
    alias_method :iso8601_original, :iso8601
    def iso8601(val)
      date = iso8601_original(val)
    rescue
      xmlschema(val)
    end
  else
    def iso8601(val)
      xmlschema(val)
    end
  end
end
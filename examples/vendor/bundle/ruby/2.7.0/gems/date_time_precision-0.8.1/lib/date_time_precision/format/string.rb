require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/time/conversions'

Date::DATE_FORMATS[:long] = lambda do |date|
  case
    when date.precision.nil?, date.precision >= DateTimePrecision::DAY
      date.strftime("%B %e, %Y")
    when date.precision == DateTimePrecision::MONTH
      date.strftime("%B %Y")
    when date.precision == DateTimePrecision::YEAR
      date.strftime("%Y")
    when date.precision == DateTimePrecision::DECADE
      "#{date.decade}s"
    when date.precision == DateTimePrecision::CENTURY
      "#{date.century}s"
    when date.month? && date.day?
      date.strftime("%B %e")
    when date.month?
      date.strftime("%B")
    else
      ""
    end
end

Time::DATE_FORMATS[:long] = lambda do |time|
  case
    when time.precision.nil?, time.precision >= DateTimePrecision::MIN
      time.strftime("%B %d, %Y %H:%M")
    #when time.precision == DateTimePrecision::HOUR
    #  time.strftime("%B %d, %Y %H")
    when time.precision >= DateTimePrecision::DAY
      time.strftime("%B %d, %Y")
    when time.precision == DateTimePrecision::MONTH
      time.strftime("%B %Y")
    when time.precision == DateTimePrecision::YEAR
      time.strftime("%Y")
    when time.precision == DateTimePrecision::DECADE
      "#{time.decade}s"
    when time.precision == DateTimePrecision::CENTURY
      "#{time.century}s"
    when time.month? && time.day?
      time.strftime("%B %e")
    when time.month?
      time.strftime("%B")
    else
      ""
    end
end

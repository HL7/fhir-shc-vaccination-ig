require 'spec_helper'
require 'json'
require 'securerandom'
require 'active_support'

require 'date_time_precision'

require 'date_time_precision/format/json'

describe DateTimePrecision, 'Conversions' do  
  context 'when converting from Date to Time or DateTime' do
    it 'maintains precision' do
      d = Date.new(2005, 1)
      expect(d.precision).to eq(DateTimePrecision::MONTH)
      expect(d.to_date.precision).to eq(DateTimePrecision::MONTH)
      expect(d.to_datetime.precision).to eq(DateTimePrecision::MONTH)
    end
  end
  
  it 'loses precision when converting from DateTime or Time to Date' do
    t = Time::parse('2000-1-1 00:00:00 EST') # => Fri Dec 31 21:00:00 -0800 1999
    expect(t.precision).to eq(DateTimePrecision::SEC)
    expect(t.to_datetime.precision).to eq(DateTimePrecision::SEC)
    expect(t.to_date.precision).to eq(DateTimePrecision::DAY)
  end
  
  it 'converts a date to a hash' do
    date = Date.new(1999, 10)
    expect(date.as_json).to eq(date.to_h)
  end
  
  it 'retains precision when converting to and from JSON' do
    date = Date.new(1999, 10)
    expect(date.precision).to eq(DateTimePrecision::MONTH)
    json = ActiveSupport::JSON.encode(date)
    
    date_from_json = ActiveSupport::JSON.decode(json).to_date
    expect(date_from_json.precision).to eq(date.precision)
  end

  context 'when formatting as a string' do
    require 'date_time_precision/format/string'

    it 'takes precision into account for the :long format' do
      expect(Date.new(2000).to_s(:long)).to eq("2000")
      expect(Date.new(2000, 8).to_s(:long)).to eq("August 2000")
      expect(Date.new(2000, 3, 9).to_s(:long)).to eq("March  9, 2000")
      expect(Date.new(nil, 5, 13).to_s(:long)).to eq("May 13")
      expect(Date.new(nil, 6).to_s(:long)).to eq("June")

      expect(DateTime.new(1800).to_s(:long)).to eq("1800")
      expect(DateTime.new(1990, 8).to_s(:long)).to eq("August 1990")
      expect(DateTime.new(-50, 3, 9).to_s(:long)).to eq("March 09, -0050")
      expect(DateTime.new(2004, 7, 8, 10).to_s(:long)).to eq("July 08, 2004")
      expect(DateTime.new(2004, 7, 8, 10, 5).to_s(:long)).to eq("July 08, 2004 10:05")
      expect(DateTime.new(nil, 5, 13).to_s(:long)).to eq("May 13")
      expect(DateTime.new(nil, 6).to_s(:long)).to eq("June")

      expect(Time.mktime(1800).to_s(:long)).to eq("1800")
      expect(Time.mktime(1990, 8).to_s(:long)).to eq("August 1990")

      # Every Ruby seems to have a different idea about how to format this exactly
      expect(Time.mktime(-50, 3, 9).to_s(:long)).to match /^March 09, 0*\-0*50$/

      expect(Time.mktime(2004, 7, 8, 10).to_s(:long)).to eq("July 08, 2004")
      expect(Time.mktime(2004, 7, 8, 10, 5).to_s(:long)).to eq("July 08, 2004 10:05")

      expect(Time.mktime(nil, 5, 13).to_s(:long)).to eq("May 13")
      expect(Time.mktime(nil, 6).to_s(:long)).to eq("June")
    end

    it 'takes precision into account for decade and century' do
      decade_date = Date.new(1853)
      decade_date.precision = DateTimePrecision::DECADE
      expect(decade_date.to_s(:long)).to eq("1850s")

      century_date = Date.new(1853)
      century_date.precision = DateTimePrecision::CENTURY
      expect(century_date.to_s(:long)).to eq("1800s")

      decade_date_time = DateTime.new(1853)
      decade_date_time.precision = DateTimePrecision::DECADE
      expect(decade_date_time.to_s(:long)).to eq("1850s")

      century_date_time = DateTime.new(1853)
      century_date_time.precision = DateTimePrecision::CENTURY
      expect(century_date_time.to_s(:long)).to eq("1800s")

      decade_time = Time.mktime(1853)
      decade_time.precision = DateTimePrecision::DECADE
      expect(decade_time.to_s(:long)).to eq("1850s")

      century_time = Time.mktime(1853)
      century_time.precision = DateTimePrecision::CENTURY
      expect(century_time.to_s(:long)).to eq("1800s")
    end
  end

  context 'UTC' do
    it 'does not crash and burn when calling #utc' do
      expect { DateTime.now.utc }.to_not raise_error
    end

    it 'preserves precision when converting to UTC' do
      expect(DateTime.new(2000, 5).utc.precision).to eq DateTimePrecision::MONTH
    end
  end
end
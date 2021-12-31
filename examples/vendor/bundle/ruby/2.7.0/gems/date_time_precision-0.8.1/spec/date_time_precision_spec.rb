require 'spec_helper'
require 'date_time_precision'

describe DateTimePrecision do
  context 'Constructors' do
    it 'has no precision for unspecified date' do
      d = Date.new
      expect(d.precision).to eq(DateTimePrecision::NONE)
      expect(d.year?).to be false
    
      dt = DateTime.new
      expect(dt.precision).to eq(DateTimePrecision::NONE)
      expect(dt.year?).to be false
    end
  
    it 'has no precision for nil values' do
      expect(nil.precision).to eq(DateTimePrecision::NONE)
    end
  
    it 'has year precision when only year is supplied' do
      d = Date.new(1982)
      expect(d.precision).to eq(DateTimePrecision::YEAR)
      expect(d.year?).to be true
      expect(d.month?).to be false
      expect(d.day?).to be false
    end
  
    it 'has month precision when year and month are supplied' do
      d = Date.new(1982, 11)
      expect(d.precision).to eq(DateTimePrecision::MONTH)
      expect(d.year?).to be true
      expect(d.month?).to be true
      expect(d.day?).to be false
    end
  
    it 'has day precision when year, month, and day are passed in' do
      dt = DateTime.new(1987,10,19)
      expect(dt.precision).to eq(DateTimePrecision::DAY)
      expect(dt.year?).to be true
      expect(dt.month?).to be true
      expect(dt.day?).to be true
      expect(dt.hour?).to be false
    end
  
    it 'has hour precision' do
      dt = DateTime.new(1970, 1, 2, 3)
      expect(dt.precision).to eq(DateTimePrecision::HOUR)
      expect(dt.year?).to be true
      expect(dt.month?).to be true
      expect(dt.day?).to be true
      expect(dt.hour?).to be true
      expect(dt.min?).to be false
    end
    
    it 'tracks which attributes were explicitly set separately from precision' do
      [Date.new(nil, 11, 12), DateTime.new(nil, 10, 11, nil), Time.mktime(nil, 12, 13, nil, 14)].each do |d|
        expect(d.decade?).to be false
        expect(d.century?).to be false
        expect(d.year?).to be false
        expect(d.month?).to be true
        expect(d.day?).to be true
        expect(d.hour?).to be false
        expect(d.min?).to be true if d.is_a? Time
        expect(d.precision).to eq(DateTimePrecision::NONE)
      end
    end
  
    it 'has max precision for fully specified dates/times' do
      # Time.new is an alias for Time.now
      [Time.new, Time.now, DateTime.now, Date.today].each do |t|
        expect(t.precision).to eq(t.class::MAX_PRECISION)
      end
    end
    
    it 'accepts nil values in the constructor' do
      expect(Date.new(nil).precision).to eq(DateTimePrecision::NONE)
      expect(Date.new(2000, nil).precision).to eq(DateTimePrecision::YEAR)
      expect(DateTime.new(2000, 1, nil).precision).to eq(DateTimePrecision::MONTH)
      expect(Time.mktime(2000, 1, 1, nil, nil).precision).to eq(DateTimePrecision::DAY)
    end
  end
  
  context 'Time Zones' do
    it 'should retain precision when switching to UTC' do
      expect(Time.mktime(2000).utc.precision).to eq(DateTimePrecision::YEAR)
      expect(Time.mktime(2000).gmtime.precision).to eq(DateTimePrecision::YEAR)
    end
    
    it 'should track precision when creating a date, time, or datetime in UTC' do
      expect(Time.utc(1945, 10).precision).to eq(DateTimePrecision::MONTH)
      expect(Time.gm(1945, 10).precision).to eq(DateTimePrecision::MONTH)

      expect(Date.utc(1945, 10).precision).to eq(DateTimePrecision::MONTH)
      expect(DateTime.utc(1945, 10).precision).to eq(DateTimePrecision::MONTH)
    end
    
    it 'should track precision when creating a time in the local timezone' do
      expect(Time.local(2004, 5, 6).precision).to eq(DateTimePrecision::DAY)
    end
  end

  context 'Parsing' do
    it 'should have second/frac precision when parsing a timestamp' do
      t = Time::parse('2000-2-3 00:00:00 UTC')
      expect(t.precision).to eq(DateTimePrecision::SEC)
      expect(t.year).to eq(2000)
      expect(t.month).to eq(2)
      expect(t.day).to eq(3)
    end
  
    it 'should have minute precision when seconds are not in the timestamp' do
      dt = DateTime::parse('2000-1-1 00:00 EST') # => Sat, 01 Jan 2000 00:00:00 -0500
      expect(dt.precision).to eq(DateTimePrecision::MIN)
      expect(dt.year).to eq(2000)
      expect(dt.day).to eq(1)
    end
  
    it 'should have day precision wehn parsing into a Date object' do
      d = Date::parse('2000-1-1 00:00:00 EST') # => Sat, 01 Jan 2000
      expect(d.precision).to eq(DateTimePrecision::DAY)
    end
  
    it 'should have month precision when day is not in the parsed string' do
      t = Time::parse('January 2000 UTC').utc # => Sat Jan 01 00:00:00 -0800 2000
      expect(t.precision).to eq(DateTimePrecision::MONTH)
      expect(t.year).to eq(2000)
      expect(t.month).to eq(1)
    end
  end

  context 'strptime' do
    it 'should have day precision when day is specified in date string' do
      d = Date.strptime('02/09/1968', '%m/%d/%Y')
      expect(d.precision).to eq(DateTimePrecision::DAY)
    end
  
    it 'should have minute precision when extracting down to the minute' do
      dt = DateTime.strptime('2011-02-03 15:14:52','%Y-%m-%d %H:%M')
      expect(dt.precision).to eq(DateTimePrecision::MIN)
    end
  
    it 'should have second precision when extracting down to the second' do
      t = DateTime.strptime('2011-02-03 15:14:52','%Y-%m-%d %H:%M:%S')
      expect(t.precision).to eq(DateTimePrecision::SEC)
    end
  end

  context 'Addition' do
    it 'should default to max precision when adding or subtracting' do
      d = Date.new
      expect(d.precision).to eq(DateTimePrecision::NONE)
      d += 3
      expect(d.precision).to eq(Date::MAX_PRECISION)
      d -= 2
      expect(d.precision).to eq(Date::MAX_PRECISION)
    
      dt = DateTime.new
      expect(dt.precision).to eq(DateTimePrecision::NONE)
      dt += 3
      expect(dt.precision).to eq(DateTime::MAX_PRECISION)
      dt -= 2
      expect(dt.precision).to eq(DateTime::MAX_PRECISION)
    
      t = Time::parse('January 2000 UTC').utc
      expect(t.precision).to eq(DateTimePrecision::MONTH)
      t += 10
      expect(t.precision).to eq(Time::MAX_PRECISION)
      t -= 8
      expect(t.precision).to eq(Time::MAX_PRECISION)
    end
  end

 context 'Partial Matching' do
    it 'should match when differing only in day precision' do
      d1 = Date.new(2001,3,2)
      d2 = Date.new(2001,3)
      expect(d1.partial_match?(d2)).to be true
      expect(d2.partial_match?(d1)).to be true
    end
  end

  context 'Decades and Centuries' do
    it 'should have the proper precision when outputting decades or centuries' do
      no_date = Date.new
      full_date = Date.new(1853,10,10)
      century_date_time = DateTime.new(1853)
      century_date_time.precision = DateTimePrecision::CENTURY
      decade_time = Time.mktime(1853)
      decade_time.precision = DateTimePrecision::DECADE
      
      expect(full_date.decade).to eq(1850)
      expect(full_date.century).to eq(1800)

      expect(decade_time.decade).to eq(1850)
      expect(decade_time.century).to eq(1800)

      expect(century_date_time.decade).to eq(1850)
      expect(century_date_time.century).to eq(1800)

      expect(no_date.decade?).to be false
      expect(full_date.decade?).to be true
      expect(decade_time.decade?).to be true
      expect(century_date_time.decade?).to be false

      expect(no_date.century?).to be false
      expect(full_date.century?).to be true
      expect(decade_time.century?).to be true
      expect(century_date_time.century?).to be true
    end
    it 'properly handles negative years' do
      date_bce = Date.new(-531, 10, 5)
      expect(date_bce.decade).to eq(-530)
      expect(date_bce.century).to eq(-500)
    end

  end
end
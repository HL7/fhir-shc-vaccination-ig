require 'spec_helper'
require 'date_time_precision'

describe DateTimePrecision do
  
  context 'when formatting as' do
    let(:date) { Date.new(1989, 3, 11) }
    let(:datetime) { DateTime.new(1989, 3, 11, 8, 30, 15) }
    let(:time) do
      args = [1989, 3, 11, 8, 30, 15]
      args << 1 if DateTimePrecision::MICROSECONDS_SUPPORTED
      Time.mktime(*args)
    end
    
    context 'ISO 8601 or XSD' do
      require 'date_time_precision/format/iso8601'

      before(:all) do
        @table = [
          [[1989],                   "1989"],
          [[1990, 5],                "1990-05"],
          [[1800, 5, 6],             "1800-05-06"],
          [[1990, 5, 2, 12],         "1990-05-02T12Z"],
          [[1990, 5, 2, 12, 30],     "1990-05-02T12:30Z"],
          [[1990, 5, 2, 12, 30, 45], "1990-05-02T12:30:45Z"]
        ]
      end

      [:iso8601, :xmlschema].each do |format_method|
        it 'converts a date to and from ISO 8601' do
          expect(date.send(format_method)).to eq("1989-03-11")

          @table.take(3).each do |args, format_string|
            expect(Date.new(*args).send(format_method)).to eq(format_string)

            d = Date.send(format_method, format_string)
            expect(d).to eq(Date.new(*args))
            expect(d.precision).to eq(args.length)
          end
        end
        
        it 'converts a datetime to and from ISO 8601' do
          expect(datetime.send(format_method)).to eq("1989-03-11T08:30:15Z")
          
          @table.each do |args, format_string|
            expect(DateTime.new(*args).send(format_method)).to eq(format_string)

            d = DateTime.send(format_method, format_string)
            constructor = args.length > 3 ? :utc : :local
            expect(d).to eq(DateTime.send(constructor, *args))
            expect(d.precision).to eq(args.length)
          end
        end
        
        it 'converts a time to ISO 8601' do
          expect(Time.mktime(1900).send(format_method)).to eq("1900")

          @table.each do |args, format_string|
            expect(Time.utc(*args).send(format_method)).to eq(format_string)

            t = Time.send(format_method, format_string)
            constructor = args.length > 3 ? :utc : :local
            expect(t).to eq(Time.send(constructor, *args))
            expect(t.precision).to eq(args.length)
          end
        end
      end
    end
    
    context 'Hash' do
      require 'date_time_precision/format/hash'
    
      let(:date_hash) do
        {
          :year => 1989,
          :mon => 3,
          :day => 11
        }
      end
    
      let(:datetime_hash) do
        {
          :year => 1989,
          :mon => 3,
          :day => 11,
          :hour => 8,
          :min => 30,
          :sec => 15,
        }
      end
    
      let(:time_hash) do
        @time_hash = datetime_hash
        @time_hash.merge!(:usec => 1) if DateTimePrecision::MICROSECONDS_SUPPORTED
        @time_hash
      end
    
      context 'Converting to hash' do
        it 'should convert Date to a hash' do
          expect(date.to_h).to eq(date_hash)
        end
      
        it 'should convert DateTime to a hash' do
          expect(datetime.to_h).to eq(datetime_hash)
        end
      
        it 'should convert Time to a hash' do
          expect(time.to_h).to eq(time_hash)
        end
        
        it 'should skip year if not included' do
          expect(Date.new(nil, 8, 10).to_h).to eq({:mon => 8, :day => 10})
        end
      end
      
      context 'Converting to hash with format' do
        let(:short_date_hash) do
          {
            :y => 1989,
            :m => 3,
            :d => 11
          }
        end
        
        let(:long_date_hash) do
          {
            :year => 1989,
            :month => 3,
            :day => 11
          }
        end
        
        it 'should convert Date to a short hash' do
          expect(date.to_h(:short)).to eq(short_date_hash)
        end

        it 'should convert Date to a long hash' do
          expect(date.to_h(:long)).to eq(long_date_hash)
        end
      
        it 'should convert DateTime to a long hash' do
          expect(datetime.to_h(:long)).to eq({
            :year => 1989,
            :month => 3,
            :day => 11,
            :hour => 8,
            :minute => 30,
            :second => 15
          })
        end

        it 'should convert Time to a short hash' do
          hash = {
              :y => 1989,
              :m => 3,
              :d => 11,
              :h => 8,
              :min => 30,
              :s => 15
          }

          hash.merge!(:us => 1) if DateTimePrecision::MICROSECONDS_SUPPORTED

          expect(time.to_h(:short)).to eq(hash)
        end
      
        it 'should convert Time to a custom hash' do
          ::Hash::DATE_FORMATS[:custom] = [:year, :mon, :d, :h, :min, :s]
          
          expect(time.to_h(:custom)).to eq({
            :year => 1989,
            :mon => 3,
            :d => 11,
            :h => 8,
            :min => 30,
            :s => 15,
          })
        end
        
        it 'should convert to the default hash format' do
          ::Hash::DATE_FORMATS[:default] = ::Hash::DATE_FORMATS[:short]
          expect(date.to_h(:short)).to eq(short_date_hash)
          ::Hash::DATE_FORMATS[:default] = ::Hash::DATE_FORMATS[:ruby]
        end
        
        it 'should only include fields that were set' do
          expect(Date.new(nil, 3, 8).to_h).to eq({:mon => 3, :day => 8})
          expect(DateTime.new(nil, 5, 6, nil, 7).to_h).to eq({:mon => 5, :day => 6, :min => 7})
          expect(Time.mktime(nil, 1, nil, 9, nil, 10).to_h).to eq({:mon => 1, :hour => 9, :sec => 10})
        end
      end
  
      context 'Converting from hash' do
        it 'converts a hash to a Date' do
          expect(date_hash.to_date).to eq(date)
        end
    
        it 'converts a hash to a DateTime' do
          expect(datetime_hash.to_datetime).to eq(datetime)
        end
    
        it 'converts a hash to a Time' do
          expect(time_hash.to_time).to eq(time)
        end
      
        it 'accepts flexible keys' do
          expect({
            :y => 1989,
            :m => 3,
            :d => 11
          }.to_date).to eq(date)
        
          expect({
            :year => 1989,
            :month => 3,
            :day => 11
          }.to_date).to eq(date)
        end
        
        [:date, :datetime, :time].each do |klass|
          it "accepts month and day without year when converting to a #{klass}" do
            date = { :month => 5, :day => 18, :min => 48 }.send("to_#{klass}")
            expect(date.year?).to be false
            expect(date.month?).to be true
            expect(date.month).to eq(5)
            expect(date.day?).to be true
            expect(date.day).to eq(18)
            expect(date.hour?).to be false
            
            unless klass == :date
              expect(date.min?).to be true
              expect(date.min).to eq(48)
            end
          end
        end
      end
    end
  
    context 'JSON' do
      require 'date_time_precision/format/json'
      require 'json'
    
      it 'should convert a date to a JSON hash' do
        expect(date.as_json).to eq(date.to_h)
        expect(date.to_json).to eq(date.to_h.to_json)
      end
    
      it 'should convert a datetime to a JSON hash' do
        expect(datetime.as_json).to eq(datetime.to_h)
        expect(datetime.to_json).to eq(datetime.to_h.to_json)
      end
      
      it 'should convert a time to a JSON hash' do
        expect(time.as_json).to eq(time.to_h)
        expect(time.to_json).to eq(time.to_h.to_json)
      end
    end
    
  end
end

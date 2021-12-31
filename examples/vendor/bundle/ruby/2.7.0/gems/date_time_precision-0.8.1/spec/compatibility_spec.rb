require 'spec_helper'
require 'virtus'
require 'coercible'
require 'date_time_precision'
require 'date_time_precision/format/hash'

class VirtusModel
  include Virtus
  
  attribute :date, Date
  attribute :datetime, DateTime
  attribute :time, Time
end

describe DateTimePrecision do
  context 'compatibility' do
    
    let(:date_hash) { {:y => 1990} }
    let(:datetime_hash) { {'year' => 1800, 'mon' => 2} }
    let(:time_hash) { {:yr => 1950, 'm' => 5, :day => 19, :hr => 5} }
    
    context 'with Virtus' do
      require 'date_time_precision/compat/virtus'
      
      let(:model) { VirtusModel.new }
      before(:each) do
        model.date = date_hash
        model.datetime = datetime_hash
        model.time = time_hash
      end
      
      context 'when coercing a hash to a Date' do
        subject { model.date }
        
        it { is_expected.to be_a Date }

        describe '#year' do
          subject { super().year }
          it { is_expected.to eq(1990) }
        end

        describe '#precision' do
          subject { super().precision }
          it { is_expected.to eq(DateTimePrecision::YEAR) }
        end
      end
      
      context 'when coercing a hash to a DateTime' do
        subject { model.datetime }
        
        it { is_expected.to be_a DateTime }

        describe '#year' do
          subject { super().year }
          it { is_expected.to eq(1800) }
        end

        describe '#month' do
          subject { super().month }
          it { is_expected.to eq(2) }
        end

        describe '#precision' do
          subject { super().precision }
          it { is_expected.to eq(DateTimePrecision::MONTH) }
        end
      end
      
      context 'when coercing a hash to a Time' do
        subject { model.time }
        
        it { is_expected.to be_a Time }

        describe '#year' do
          subject { super().year }
          it { is_expected.to eq(1950) }
        end

        describe '#month' do
          subject { super().month }
          it { is_expected.to eq(5) }
        end

        describe '#day' do
          subject { super().day }
          it { is_expected.to eq(19) }
        end

        describe '#hour' do
          subject { super().hour }
          it { is_expected.to eq(5) }
        end

        describe '#precision' do
          subject { super().precision }
          it { is_expected.to eq(DateTimePrecision::HOUR) }
        end
      end
    end
    
    context 'with Coercible' do
      require 'date_time_precision/compat/coercible'
      
      let(:coercer) { Coercible::Coercer::Hash.new }
      
      context 'when coercing a hash to a Date' do
        subject { coercer.to_date(date_hash) }
        
        it { is_expected.to be_a Date }

        describe '#year' do
          subject { super().year }
          it { is_expected.to eq(1990) }
        end

        describe '#precision' do
          subject { super().precision }
          it { is_expected.to eq(DateTimePrecision::YEAR) }
        end
      end
      
      context 'when coercing a hash to a DateTime' do
        subject { coercer.to_datetime(datetime_hash) }
        
        it { is_expected.to be_a DateTime }

        describe '#year' do
          subject { super().year }
          it { is_expected.to eq(1800) }
        end

        describe '#month' do
          subject { super().month }
          it { is_expected.to eq(2) }
        end

        describe '#precision' do
          subject { super().precision }
          it { is_expected.to eq(DateTimePrecision::MONTH) }
        end
      end
      
      context 'when coercing a hash to a Time' do
        subject { coercer.to_time(time_hash) }
        
        it { is_expected.to be_a Time }

        describe '#year' do
          subject { super().year }
          it { is_expected.to eq(1950) }
        end

        describe '#month' do
          subject { super().month }
          it { is_expected.to eq(5) }
        end

        describe '#day' do
          subject { super().day }
          it { is_expected.to eq(19) }
        end

        describe '#hour' do
          subject { super().hour }
          it { is_expected.to eq(5) }
        end

        describe '#precision' do
          subject { super().precision }
          it { is_expected.to eq(DateTimePrecision::HOUR) }
        end
      end
    end
  end
end
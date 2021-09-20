if defined?(Virtus::Coercion::Hash)
  class Virtus::Coercion::Hash
    class << self
      def to_date(value)
        value.to_date
      end

      def to_datetime(value)
        value.to_datetime
      end

      def to_time(value)
        value.to_time
      end
    end
  end
end
module IceCubeEx
  module Validations
    module DailyCycleInterval
      attr_accessor :rule

      def cycle(cycle, repeat)
        @interval = 1
        @repeat   = normalize(repeat)
        @cycle    = normalize(cycle)

        unless @repeat < @cycle
          raise ArgumentError, 'cycle has to be a value higher than repeat'
        end

        @acceptable_cycle_percentage = ((@repeat.to_f / @cycle.to_f) * 100).to_i
        replace_validations_for \
          :interval, [Validation.new(@interval, @cycle, @repeat)]
        clobber_base_validations(:wday, :day)
        self
      end

      class Validation < IceCube::Validations::DailyInterval::Validation
        attr_reader :cycle, :repeat

        def initialize(interval, cycle, repeat)
          super(interval)
          @cycle    = cycle
          @repeat   = repeat
        end

        def build_s(builder)
          builder.base = "Every #{cycle} days, repeat #{repeat} times"
        end

        def build_hash(builder)
          builder[:interval] = interval
          builder[:cycle]    = cycle
          builder[:repeat]   = repeat
        end

        def build_ical(builder)
          builder['FREQ']   << 'DAILY_CYCLE (CUSTOM RULE)'
          builder['CYCLE']  << cycle
          builder['REPEAT'] << repeat
        end
      end

    private

      def normalize(arg)
        arg.to_i.tap do |val|
          unless val > 1
            raise ArgumentError, "'#{arg}' is not a valid argument. " \
                                 "Please pass an integer higher than 1."
          end
        end
      end
    end
  end
end
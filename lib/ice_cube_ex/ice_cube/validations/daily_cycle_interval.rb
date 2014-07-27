module IceCube
  module Validations
    module DailyCycleInterval
      attr_accessor :rule

      def cycle(cycle, repeat)
        @interval = 1
        @repeat   = repeat
        @cycle    = normalized_cycle(cycle)

        unless @repeat < @cycle
          raise ArgumentError, 'cycle has to be a value higher than repeat'
        end

        replace_validations_for(:interval, [Validation.new(@interval, @cycle, @repeat)])
        clobber_base_validations(:wday, :day)
        self
      end

      class Validation
        attr_reader :interval, :cycle, :repeat

        def initialize(interval, cycle, repeat)
          @interval = interval
          @cycle    = cycle
          @repeat   = repeat
        end

        def type
          :day
        end

        def dst_adjust?
          true
        end

        def validate(step_time, schedule)
          t0, t1 = schedule.start_time, step_time
          days = Date.new(t1.year, t1.month, t1.day) -
                 Date.new(t0.year, t0.month, t0.day)
          offset = (days % interval).nonzero?
          interval - offset if offset
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
          builder['FREQ']     << 'DAILY_CYCLE (CUSTOM RULE)'
          builder['CYCLE']    << cycle
          builder['REPEAT']   << repeat
        end
      end

    private

      def normalized_cycle(cycle)
        cycle.to_i.tap do |val|
          unless val > 1
            raise ArgumentError, "'#{cycle}' is not a valid input for cycle. " \
                                 "Please pass an integer higher than 1."
          end
        end
      end

      def normalized_repeat(repeat)
        repeat.to_i.tap do |val|
          unless val > 1
            raise ArgumentError, "'#{repeat}' is not a valid input for repeat. " \
                                 "Please pass an integer higher than 1."
          end
        end
      end
    end
  end
end
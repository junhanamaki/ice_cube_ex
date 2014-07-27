module IceCube
  module Validations
    module DailyCycleInterval
      attr_accessor :rule

      def interval(interval, cycle)
        @interval = normalized_interval(interval)
        @cycle    = normalized_cycle(cycle)

        unless @interval < @cycle
          raise ArgumentError, 'cycle has to be a value higher than interval'
        end

        replace_validations_for(:interval, [Validation.new(@interval, @cycle)])
        clobber_base_validations(:wday, :day)
        self
      end

      class Validation
        attr_reader :interval, :cycle

        def initialize(interval, cycle)
          @interval = interval
          @cycle    = cycle
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
          builder.base = "Every #{cycle} days, repeat #{interval} times"
        end

        def build_hash(builder)
          builder[:interval] = interval
          builder[:cycle]    = cycle
        end

        def build_ical(builder)
          builder['FREQ']     << 'DAILY_CYCLE (CUSTOM RULE)'
          builder['INTERVAL'] << interval
          builder['CYCLE']    << cycle
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
    end
  end
end
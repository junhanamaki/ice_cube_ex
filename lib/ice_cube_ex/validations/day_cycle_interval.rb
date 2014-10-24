module IceCubeEx
  module Validations
    module DayCycleInterval
      attr_accessor :rule

      def cycle(cycle, skip)
        @interval = 1
        @skip     = normalize(skip)
        @cycle    = normalize(cycle)

        unless @skip != @cycle
          raise ArgumentError, "cycle and skip can't have the same value"
        end

        @acceptable_cycle_percentage = ((@skip.to_f / @cycle.to_f) * 100).to_i
        replace_validations_for \
          :interval, [Validation.new(@interval, @cycle, @skip)]
        clobber_base_validations(:wday, :day)
        self
      end

      class Validation < IceCube::Validations::DailyInterval::Validation
        attr_reader :cycle, :skip

        def initialize(interval, cycle, skip)
          super(interval)
          @cycle    = cycle
          @skip   = skip
        end

        def build_s(builder)
          builder.base = "Every #{cycle} days, skip #{skip} times"
        end

        def build_hash(builder)
          builder[:interval] = interval
          builder[:cycle]    = cycle
          builder[:skip]     = skip
        end

        def build_ical(builder)
          builder['FREQ'] << 'DAY_CYCLE (CUSTOM RULE)'
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
module IceCubeEx
  module Validations
    module DayCycleInterval
      attr_accessor :rule

      def cycle(cycle, skip)
        @interval = 1
        @skip     = normalize(skip)
        @cycle    = normalize(cycle)

        unless @skip < @cycle
          raise ArgumentError, "we can't skip more days than the number of "   \
                               "days in the cycle, so skip has to be a value " \
                               "bellow cycle"
        end

        @acceptable_cycle_percentage = \
          (((@cycle - @skip).to_f / @cycle.to_f) * 100).to_i
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
          unless val > 0
            raise ArgumentError, "'#{arg}' is not a valid argument. " \
                                 "Please pass an integer higher than 0"
          end
        end
      end
    end
  end
end
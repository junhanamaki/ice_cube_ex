require 'ice_cube_ex/rules/daily_cycle_rule'

module IceCubeEx
  class Rule
    class << self
      # DailyCycle Rule
      def daily_cycle(interval, cycle)
        DailyCycleRule.new(interval, cycle)
      end
    end
  end
end
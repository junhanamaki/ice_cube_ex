require 'ice_cube_ex/rules/day_cycle_rule'

module IceCubeEx
  class Rule
    class << self
      # DayCycle Rule
      def day_cycle(interval, cycle)
        DayCycleRule.new(interval, cycle)
      end
    end
  end
end
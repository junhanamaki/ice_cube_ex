require 'ice_cube_ex/rules/day_cycle_rule'

module IceCubeEx
  class Rule
    class << self
      # DayCycle Rule
      def day_cycle(cycle, skip)
        DayCycleRule.new(cycle, skip)
      end
    end
  end
end
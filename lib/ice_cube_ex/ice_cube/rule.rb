require 'ice_cube_ex/ice_cube/rules/daily_cycle_rule'

module IceCube
  class Rule
    class << self
      # DailyCycle Rule
      def daily_cycle(interval, cycle)
        DailyCycleRule.new(interval, cycle)
      end
    end
  end
end
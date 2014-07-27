require 'ice_cube_ex/ice_cube/validations/daily_cycle_interval'

module IceCube
  class DailyCycleRule < ValidatedRule
    include Validations::DailyCycleInterval

    def initialize(interval, cycle)
      super
      interval(interval, cycle)
      schedule_lock(:hour, :min, :sec)
      reset
    end

    # Compute the next time after (or including) the specified time in respect
    # to the given schedule
    def next_time(time, schedule, closing_time)
      @time = time
      @schedule = schedule

      return nil unless find_acceptable_time_before(closing_time)

      @uses += 1 if @time
      @time
    end
  end
end
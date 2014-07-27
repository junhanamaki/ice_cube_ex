require 'ice_cube_ex/ice_cube/validations/daily_cycle_interval'

module IceCube
  class DailyCycleRule < ValidatedRule
    include Validations::DailyCycleInterval

    def initialize(cycle, repeat)
      super
      cycle(cycle, repeat)
      schedule_lock(:hour, :min, :sec)
      reset
    end

    #
    # cycle_start_time and why we start from one day before:
    #
    # given the following case:
    #
    #   Schedule start_time 2014-2-2, DailyCycleRule with cycle 4, repeat 2
    #
    # if we invoke schedule.next_occurrence(2014-2-1), first calculated
    # time will be 2014-2-2, which will give a day_count of 0, thus being lower
    # than cycle_percentage and being a valid value.
    # this by itself is not a problem, but it will ruin our cycle logic since
    # only for the first case it will repeat 3 times instead of 2, because
    # the following dates will be valid:
    #
    #   2014-2-2, 2014-2-3, 2014-2-4
    #
    # so to avoid this we start counting from start_time - 1.day
    def next_time(time, schedule, closing_time)
      @time = time
      @schedule = schedule
      cycle_start_time = schedule.start_time - 24 * 60 * 60

      return nil unless find_acceptable_time_before(closing_time)
      day_count = number_of_days_between(@time, cycle_start_time)
      acceptable_time_percentage = calculate_cycle_percentage(day_count)

      until acceptable_time_percentage <= @cycle_percentage
        @time += 1
        return nil unless find_acceptable_time_before(closing_time)
        day_count = number_of_days_between(@time, cycle_start_time)
        acceptable_time_percentage = calculate_cycle_percentage(day_count)
      end

      @uses += 1 if @time
      @time
    end

    def number_of_days_between(acceptable_time, initial_time)
      acceptable_time_date = get_date(acceptable_time)
      initial_time_date = get_date(initial_time)

      ((acceptable_time_date - initial_time_date) / (24 * 60 * 60)).to_i
    end

    def get_date(time)
      Time.new(time.year, time.month, time.day, 0, 0, 0, '+00:00')
    end

    def calculate_cycle_percentage(day_count)
      value = (day_count.to_f / @cycle.to_f)
      percentage = ((value - value.to_i) * 100).to_i
      percentage.zero? ? 100 : percentage
    end
  end
end
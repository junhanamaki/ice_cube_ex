# IceCubeEx

[![Gem Version](https://badge.fury.io/rb/ice_cube_ex.svg)](http://badge.fury.io/rb/ice_cube_ex)
[![build](https://travis-ci.org/junhanamaki/ice_cube_ex.svg?branch=master)](https://travis-ci.org/junhanamaki/ice_cube_ex)
[![Code Climate](https://codeclimate.com/github/junhanamaki/ice_cube_ex.png)](https://codeclimate.com/github/junhanamaki/ice_cube_ex)
[![Test Coverage](https://codeclimate.com/github/junhanamaki/ice_cube_ex/coverage.png)](https://codeclimate.com/github/junhanamaki/ice_cube_ex)
[![Dependency Status](https://gemnasium.com/junhanamaki/ice_cube_ex.svg)](https://gemnasium.com/junhanamaki/ice_cube_ex)

Extends gem [ice_cube](https://github.com/seejohnrun/ice_cube) to handle
custom rules, outside of the iCalendar spec.

## Installation

First require ice_cube, and then require ice_cube_ex, by adding the following
line to your application's Gemfile:

    gem 'ice_cube'
    gem 'ice_cube_ex'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ice_cube_ex

## Usage

ice_cube_ex has new rules that can be used with ice_cube's schedules:

### DayCycleRule

This rule allows to specify a cycle (in number of days), and the number of
repeat counting from the start of the cycle. For example, if we want to repeat
3 days, every 5 days, starting from 2015-1-1 we would do:

    schedule = IceCube::Schedule.new(Time.new(2015, 1, 1)) do |s|
      s.rrule IceCubeEx::Rule.day_cycle(5, 3)
    end

Now try calculating some next occurrences:

    occurrence_time = schedule.next_occurrence(Time.new(2014-12-30))
    # returns 2015-1-1

    occurrence_time = schedule.next_occurrence(occurrence_time)
    # returns 2015-1-2

    occurrence_time = schedule.next_occurrence(occurrence_time)
    # returns 2015-1-3

    occurrence_time = schedule.next_occurrence(occurrence_time)
    # returns 2015-1-6

    occurrence_time = schedule.next_occurrence(occurrence_time)
    # returns 2015-1-7

    occurrence_time = schedule.next_occurrence(occurrence_time)
    # returns 2015-1-8

You can also use count and until to limit your rule as you would normally do
with a regular ice_cube rule.

## Contributing

1. Fork it ( https://github.com/junhanamaki/ice_cube_ex/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

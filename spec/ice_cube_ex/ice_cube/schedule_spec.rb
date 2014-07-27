require 'spec_helper'

describe IceCube::Schedule do
  describe '.next_occurrence' do
    context 'given schedule starting at 4-2-2012 at 12 hours' do
      let(:start_time) do
        Time.new(2012, 2, 4, 12)
      end
      let(:schedule) do
        IceCube::Schedule.new(start_time) do |c|
          c.rrule rule
        end
      end

      context 'given rule of type DailyCycleRule initialized to ' \
              'every 4 days (cycle), ' \
              'repeat 2 days (repeat)' do
        let(:repeat) { 2 }
        let(:cycle)  { 4 }
        let(:rule)   { IceCube::DailyCycleRule.new(cycle, repeat) }

        context 'calculating from 3-2-2012' do
          let(:from) { Time.new(2012, 2, 3) }
          let(:first_occurrence)  { schedule.next_occurrence from }
          let(:second_occurrence) { schedule.next_occurrence first_occurrence }
          let(:third_occurrence)  { schedule.next_occurrence second_occurrence }
          let(:fourth_occurrence) { schedule.next_occurrence third_occurrence }

          it 'returns 4-2-2012 at 12am as first occurrence' do
            expect(first_occurrence).to eq(start_time)
          end

          it 'returns 5-2-2012 at 12am as second occurrence' do
            expect(second_occurrence).to eq(Time.new(2012, 2, 5, 12))
          end

          it 'returns 8-2-2012 at 12am as third occurrence', test: true do
            expect(third_occurrence).to eq(Time.new(2012, 2, 8, 12))
          end

          it 'returns 9-2-2012 at 12am as fourth occurrence' do
            expect(fourth_occurrence).to eq(Time.new(2012, 2, 9, 12))
          end
        end
      end
    end
  end
end
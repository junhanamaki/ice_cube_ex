require 'spec_helper'

describe IceCube::Rule do
  describe '.daily_cycle' do
    context 'every 5 days, ' \
            'repeat 3 days' do
      let(:cycle)  { 5 }
      let(:repeat) { 3 }
      before { @rule = IceCube::Rule.daily_cycle(cycle, repeat) }

      it 'returns an instance of DailyCycleRule' do
        expect(@rule.class).to eq(IceCube::DailyCycleRule)
      end
    end
  end
end
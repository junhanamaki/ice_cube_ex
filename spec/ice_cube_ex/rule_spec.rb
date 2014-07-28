require 'spec_helper'

describe IceCubeEx::Rule do
  describe '.day_cycle' do
    context 'every 5 days, ' \
            'repeat 3 days' do
      let(:cycle)  { 5 }
      let(:repeat) { 3 }
      before { @rule = IceCubeEx::Rule.day_cycle(cycle, repeat) }

      it 'returns an instance of DayCycleRule' do
        expect(@rule.class).to eq(IceCubeEx::DayCycleRule)
      end
    end
  end
end
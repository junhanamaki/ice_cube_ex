require 'spec_helper'

describe IceCubeEx::Rule do
  describe '.day_cycle' do
    context 'cycle 5 days, ' \
            'skip 3 days' do
      let(:cycle) { 5 }
      let(:skip)  { 3 }
      before { @rule = IceCubeEx::Rule.day_cycle(cycle, skip) }

      it 'returns an instance of DayCycleRule' do
        expect(@rule.class).to eq(IceCubeEx::DayCycleRule)
      end
    end
  end
end
require 'spec_helper'

describe IceCube::Rule do
  describe '#daily_cycle' do
    context 'given cycle argument bellow 2' do
      let(:interval) { 1 }
      let(:cycle)    { 0 }

      it 'raises error' do
        expect do
          IceCube::Rule.daily_cycle(interval, cycle)
        end.to raise_error
      end
    end

    context 'given cycle argument bellow interval' do
      let(:interval) { 10 }
      let(:cycle)    { 9 }

      it 'raises error' do
        expect do
          IceCube::Rule.daily_cycle(interval, cycle)
        end.to raise_error
      end
    end
  end
end
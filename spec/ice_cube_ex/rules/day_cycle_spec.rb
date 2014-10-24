require 'spec_helper'

describe IceCubeEx::DayCycleRule do
  describe '.new' do
    context 'given cycle argument bellow 2' do
      let(:cycle) { 0 }
      let(:skip)  { 1 }

      it 'raises error' do
        expect do
          IceCubeEx::DayCycleRule.new(cycle, skip)
        end.to raise_error
      end
    end

    context 'given cycle argument lower than skip' do
      let(:cycle) { 9 }
      let(:skip)  { 10 }

      it 'raises error' do
        expect do
          IceCubeEx::DayCycleRule.new(cycle, skip)
        end.to raise_error
      end
    end
  end
end
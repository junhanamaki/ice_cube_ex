require 'spec_helper'

describe IceCube::DailyCycleRule do
  describe '.new' do
    context 'given cycle argument bellow 2' do
      let(:cycle)  { 0 }
      let(:repeat) { 1 }

      it 'raises error' do
        expect do
          IceCube::DailyCycleRule.new(cycle, repeat)
        end.to raise_error
      end
    end

    context 'given cycle argument lower than repeat' do
      let(:cycle)  { 9 }
      let(:repeat) { 10 }

      it 'raises error' do
        expect do
          IceCube::DailyCycleRule.new(cycle, repeat)
        end.to raise_error
      end
    end
  end
end
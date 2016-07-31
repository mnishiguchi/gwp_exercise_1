require 'spec_helper'
require_relative '../lib/number_string'

describe NumberString do

  let(:two) { NumberString.new(2) }
  let(:four) { NumberString.new(4) }

  describe '+' do
    subject { two + four }

    it { expect(subject.value).to eq 6 }
    it { expect(subject.string).to eq '(2 + 4)' }
  end

  describe '-' do
    subject { two - four }

    it { expect(subject.value).to eq -2 }
    it { expect(subject.string).to eq '(2 - 4)' }
  end

  describe '*' do
    subject { two * four }

    it { expect(subject.value).to eq 8 }
    it { expect(subject.string).to eq '(2 * 4)' }
  end

  describe '/' do
    context 'evenly divisible' do
      subject { four / two }

      it { expect(subject.value).to eq 2 }
      it { expect(subject.string).to eq '(4 / 2)' }
    end

    context 'not evenly divisible' do
      subject { two / four }

      it { expect(subject.value).to eq 0 }
      it { expect(subject.string).to eq '(2 / 4)' }
    end
  end
end

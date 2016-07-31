require 'spec_helper'
require_relative '../lib/number_string'

describe NumberString do

  let(:two) { NumberString.new(2) }
  let(:four) { NumberString.new(4) }

  describe '+' do
    subject { two + four }

    it { expect(subject.string).to eq '(2 + 4)' }
    it { expect(subject.value).to eq 6 }
  end

  describe '-' do
    subject { two - four }

    it { expect(subject.string).to eq '(2 - 4)' }
    it { expect(subject.value).to eq -2 }
  end

  describe '*' do
    subject { two * four }

    it { expect(subject.string).to eq '(2 * 4)' }
    it { expect(subject.value).to eq 8 }
  end

  describe '/' do
    subject { four / two }

    it { expect(subject.string).to eq '(4 / 2)' }
    it { expect(subject.value).to eq 2 }
  end
end

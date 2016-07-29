require 'spec_helper'
require_relative '../lib/number_puzzle'

describe NumberPuzzle do

  describe '.solvable?' do
    subject { NumberPuzzle.solvable?([3, 3, 6, 6, 10, 50], 386) }

    it { is_expected.to eq true }
  end

  describe '.find_solution' do

    context 'when solvable' do
      subject { NumberPuzzle.find_solution([3, 3, 6, 6, 10, 50], 386) }

      it 'contains all the source numbers and the number to solve for' do
        [3, 3, 6, 6, 10, 50, 386].each do |number|
          is_expected.to include number.to_s
        end
      end
    end

    context 'when not solvable' do
      subject { NumberPuzzle.find_solution([3, 3, 6, 6, 10, 50], -999999) }

      it 'returns nil' do
        is_expected.to eq nil
      end
    end
  end

  # describe '.find_solution_pretty_formatting' do
  #   subject { NumberPuzzle.find_solution_pretty_formatting([3, 3, 6, 6, 10, 50], 386) }
  #   # TODO
  # end

  # describe '.find_all_solutions_pretty_formatting' do
  #   subject { NumberPuzzle.find_all_solutions_pretty_formatting([3, 3, 6, 6, 10, 50], 386) }
  #   # TODO
  # end
end

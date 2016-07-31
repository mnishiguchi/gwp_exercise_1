require 'spec_helper'
require_relative '../lib/solve_numbers'

describe SolveNumbers do

  describe '.solvable?' do
    subject { SolveNumbers.solvable?([3, 3, 6, 6, 10, 50], 386) }

    it { is_expected.to eq true }
  end

  describe '.find_solution' do

    context 'when solvable' do
      subject { SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386) }

      it 'contains all the source numbers and the number to solve for' do
        [3, 3, 6, 6, 10, 50, 386].each do |number|
          is_expected.to include number.to_s
        end
      end
    end

    # NOTE: This test takes 90 seconds due to exhausting all the list.
    context 'when not solvable' do
      subject { SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], -999999) }

      it 'returns false' do
        is_expected.to eq false
      end
    end
  end

  # describe '.find_solution_pretty_formatting' do
  #   subject { SolveNumbers.find_solution_pretty_formatting([3, 3, 6, 6, 10, 50], 386) }
  #   # TODO
  # end

  # describe '.find_all_solutions_pretty_formatting' do
  #   subject { SolveNumbers.find_all_solutions_pretty_formatting([3, 3, 6, 6, 10, 50], 386) }
  #   # TODO
  # end
end

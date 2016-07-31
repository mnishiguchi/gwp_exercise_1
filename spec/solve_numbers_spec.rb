require 'spec_helper'
require_relative '../lib/solve_numbers'

describe SolveNumbers do

  describe '.solvable?' do
    subject { SolveNumbers.solvable?([3, 3, 6, 6, 10, 50], 386) }

    it { is_expected.to eq true }
  end

  describe '.find_solution' do

    context 'when solvable' do

      context 'with the default format' do
        subject { SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386) }

        it 'contains all the source numbers and the number to solve for' do
          [3, 3, 6, 6, 10, 50, 386].each do |number|
            is_expected.to include number.to_s
          end
        end
      end

      context 'with the pretty format' do
        subject { SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386, pretty: true) }

        it "has an appropriate introduction" do
          is_expected.to include "Given the numbers [3, 3, 6, 6, 10, 50] and the target 386, one set of steps are:"
        end

        it 'contains all the source numbers and the number to solve for' do
          [3, 3, 6, 6, 10, 50, 386].each do |number|
            is_expected.to include number.to_s
          end
        end
      end
    end

    # NOTE: This test takes 90 seconds due to exhausting all the list.
    xcontext 'when not solvable' do
      subject { SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], -999999) }

      it 'returns false' do
        is_expected.to eq false
      end
    end
  end
end

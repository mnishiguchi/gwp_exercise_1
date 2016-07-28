require 'spec_helper'
require_relative '../lib/solvable'

describe Solvable do

  # describe '.solvable?' do
  #   subject { Solvable.solvable?([3, 3, 6, 6, 10, 50], 386) }
  #   it { is_expected.to eq true }
  #
  # end

  describe '.find_solution' do
    subject { Solvable.find_solution([3, 3, 6, 6, 10, 50], 386) }

    it 'contains all the source numbers' do
      [3, 3, 6, 6, 10, 50, 386].each do |number|
        is_expected.to include number.to_s
      end
    end
  end

  # describe '.find_solution_pretty_formatting' do
  #   subject { Solvable.find_solution_pretty_formatting([3, 3, 6, 6, 10, 50], 386) }
  #   # TODO
  # end

  # describe '.find_all_solutions_pretty_formatting' do
  #   subject { Solvable.find_all_solutions_pretty_formatting([3, 3, 6, 6, 10, 50], 386) }
  #   # TODO
  # end

end

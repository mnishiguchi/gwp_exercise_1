require_relative './number_string'
require 'awesome_print'

# This class provides utility methods to solve numbers for a number.
# Only elementary operators (+, -, *, /) are taken into consideration.
class SolveNumbers

  # Finds the calculation that makes ten using the given numbers.
  # Takes a list of integers.
  # Converts all the integers into NumberString objects.
  # Return true if at least one solution was found, else false.
  def self.solvable?(numbers, solve_for)
    numbers.map! { |number| NumberString.new(number) }
    calc_recursive_for_solvability(numbers, solve_for)
  end

  # Find a calculaton of a list of numbers that solves for the specified number.
  # Takes a list of integers.
  # Converts all the integers into NumberString objects.
  # Returns a string representaton of a calculaton.
  def self.find_solution(numbers, solve_for)
    numbers.map! { |number| NumberString.new(number) }
    calc_recursive_for_one(numbers, solve_for)
  end

  private

    # Performs all the possible calculations until a solution is found.
    # Takes an array of NumberString objects.
    # Return a solution as a string if a solution was found, else false.
    def self.calc_recursive_for_one(numbers, solve_for)

      # Base case: the element count is one.
      if numbers.length == 1
        if numbers.first.value == solve_for
          # ap numbers.first.string
          return "#{numbers.first.string} = #{numbers.first.value}"
        else
          return false
        end
      end

      solution = false

      # 1. Create the permutation list of the source numbers.
      # 2. For each, perform calculation with all four operators.
      # 3. Update the numbers (remove used numbers; add calculation result)
      # 4. Repeat recursively until the list has only one number.
      # 5. If a solution is already found, exit the loop.
      numbers.permutation(2).to_a.shuffle.each do |first, second|
        new_numbers = ""

        new_numbers = update_numbers(numbers, [first, second], [first + second])
        solution = calc_recursive_for_one(new_numbers, solve_for)
        break if solution

        new_numbers = update_numbers(numbers, [first, second], [first - second])
        solution = calc_recursive_for_one(new_numbers, solve_for)
        break if solution

        new_numbers = update_numbers(numbers, [first, second], [first * second])
        solution = calc_recursive_for_one(new_numbers, solve_for)
        break if solution

        if first.divisible(second)
          new_numbers = update_numbers(numbers, [first, second], [first / second])
          solution = calc_recursive_for_one(new_numbers, solve_for)
          break if solution
        end
      end

      return solution
    end


    # Performs all the possible calculations until a solution is found.
    # Takes an array of NumberString objects.
    # Return true if at least one solution was found, else false.
    def self.calc_recursive_for_solvability(numbers, solve_for)

      # Base case: the element count is one.
      return numbers.first.value == solve_for if numbers.length == 1

      solution_found = false

      # 1. Create the permutation list of the source numbers.
      # 2. For each, perform calculation with all four operators.
      # 3. Update the numbers (remove used numbers; add calculation result)
      # 4. Repeat recursively until the list has only one number.
      # 5. If a solution is already found, set the flag to true and exit the loop.
      numbers.permutation(2).to_a.each do |first, second|
        new_numbers = []

        new_numbers = update_numbers(numbers, [first, second], [first + second])
        if calc_recursive_for_solvability(new_numbers, solve_for)
          solution_found = true
          break
        end

        new_numbers = update_numbers(numbers, [first, second], [first - second])
        if calc_recursive_for_solvability(new_numbers, solve_for)
          solution_found = true
          break
        end

        new_numbers = update_numbers(numbers, [first, second], [first * second])
        if calc_recursive_for_solvability(new_numbers, solve_for)
          solution_found = true
          break
        end

        if first.divisible(second)
          new_numbers = update_numbers(numbers, [first, second], [first / second])
          if calc_recursive_for_solvability(new_numbers, solve_for)
            solution_found = true
            break
          end
        end
      end

      return solution_found
    end


    # Updates the number list by deleting and adding specified NumberString objects.
    # Returns an updated array of NumberString objects.
    def self.update_numbers(list, to_be_deleted=[], to_be_added=[])
      list = list.dup
      to_be_deleted.each { |n| list.delete(n) }
      to_be_added.each { |n| list << n }
      list
    end

end

# ap SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386)

# Using only elementary operators (+, -, *, /) on the source numbers,
# determine if an equation can be found.
class Solvable
  LARGE_NUMBERS         = [25, 50, 75, 100]
  DEFAULT_LARGE_NUMBERS = 1
  SMALL_NUMBERS         = (1..10).to_a
  DEFUALT_SMALL_NUMBERS = 5
  NUMBERS_TO_SOLVE_FOR  = (100..999).to_a

  OPERATORS = %w(+ - * /)

  def self.solvable?(numbers, number_to_solve_for)
    # validate_args(numbers, number_to_solve_for)
  end

  def self.find_solution(numbers, number_to_solve_for)
    solution = nil

    100000.times do
      result = try_to_solve(numbers, number_to_solve_for)
      p result[:string]

      solved = (result[:value] == number_to_solve_for)
      if solved
        solution = result[:string]
        break
      end
    end

    solution
  end

  # def self.find_solution_pretty_formatting(numbers = , number_to_solve_for = )
  #
  # end
  #
  # def self.find_all_solutions_pretty_formatting(numbers = , number_to_solve_for = )
  #
  # end

  private

    def self.try_to_solve(numbers, number_to_solve_for)
      calculation_strings = []
      number_list = numbers.dup

      until number_list.length == 1
        # Randomly take (and remove) two numbers from the list.
        num1 = number_list.delete_at(rand(number_list.length))
        num2 = number_list.delete_at(rand(number_list.length))

        # Then calculate with a randomly selected operator.
        op = random_op(divisible?(num1, num2))
        result = calculate(op, num1, num2)

        # Create and store the string representation of the calculation.
        calculation_strings << "#{num1} #{op} #{num2} = #{result}"

        # Push the result back to the list.
        number_list << result
      end

      { string: calculation_strings.join("\n"), value: number_list[0] }
    end

    # Performs calculation of two numbers using the specified operator.
    # Returns the result.
    def self.calculate(op, num1, num2)
      num1.send(op, num2)
    end

    # Returns true if num1 is devisble by num2.
    def self.divisible?(num1, num2)
      # Division is a valid operation if the remainder/modulus is zero.
      (num2 != 0) && (num1 % num2 == 0)
    end

    def self.random_op(divisible)
      ops = OPERATORS
      ops.delete("/") unless divisible
      ops.sample
    end

    # TODO
    def self.within_range?

    end

    # Raises an error if either argument is invalid.
    # def self.validate_args(numbers, number_to_solve_for)
    #   if numbers.nil? || numbers.size < 1
    #     raise RuntimeError
    #   elsif number_to_solve_for.nil?
    #     raise RuntimeError
    #   end
    # end
end

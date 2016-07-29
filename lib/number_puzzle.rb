require 'pry'

# Using only elementary operators (+, -, *, /) on the source numbers,
# determine if an equation can be found.
class NumberPuzzle

  # Returns true if the specified list of numbers can solve for the
  # specified number by calculating with only elementary operators (+, -, *, /).
  def self.solvable?(numbers, number_to_solve_for)

    # Create a list of the permutation of the source numbers and for each
    # perform calculation with all the patterns of using operators.
    numbers.permutation(numbers.length) do |nums|

      # Create a list of all the patterns of using operators.
      op_list = full_operator_patterns(numbers.length - 1)

      # Perform calculation by conceptually inserting operators
      # between source numbers.
      op_list.each do |ops|
        strings = []
        result = nums.reduce do |memo, number|
          # Perform calculation. Ignore the whole iteration
          # if calculation is invalid.
          calc = calculate(ops.pop, memo, number)
          break if calc.nil?

          # The resulting value becomes next accumulator.
          calc[:value]
        end

        # If the result matches the number to solve for, that means the
        # numbers passed-in as arguments are solvable.
        return true if result == number_to_solve_for
      end
    end
    false
  end

  # Find a calculaton of a list of numbers that solves for the specified number.
  # Returns a string representaton of a calculaton.
  def self.find_solution(numbers, number_to_solve_for)
    solution = nil

    100000.times do
      result = random_try_to_solve(numbers)

      solved = (result[:value] == number_to_solve_for)
      if solved
        solution = result[:string]
        break
      end
    end

    solution
  end

  private

    # Returns the string of a specified calculation.
    # E.g., "3 + 4 = 7"
    def self.equation_string(op, num1, num2)
      left = "#{num1} #{op} #{num2}"
      "#{left} = #{eval(left)}"
    end

    # Return an array of operator patterns of length n.
    def self.full_operator_patterns(n)
      ops = %w(+ - * /)

      # Create a list of same op * n.
      all_same_op = ops.map { |op| Array.new(n, op) }

      # Perform the permutation.
      permutation = []

      # Only support the length of 1..8
      if n > 8 || n < 1 then raise "n must be 1..8" end

      if n > 4
        # When the required size is greater than the length of the source array,
        # we need to perform permutation twice and combine the results.
        permutation_1 = ops.permutation(4).to_a
        permutation_2 = ops.permutation(n - 4).to_a
        permutation   = []

        # Combine the two permutaion results.
        permutation_1.each do |p1|
          permutation_2.each { |p2| permutation << (p1 + p2) }
        end
      else
        permutation = ops.permutation(n).to_a
      end

      # All same op + permutation = full list.
      all_same_op + permutation
    end

    # Takes an array of numbers and generate random equations by
    # combining the numbers with randomly selected operators.
    # Returns a hash of result and a string that demonstrates the
    # calculation process.
    def self.random_try_to_solve(numbers)
      calculation_strings = []
      number_list = numbers.dup

      until number_list.length == 1
        # Randomly take (and remove) two numbers from the list.
        num1 = number_list.delete_at(rand(number_list.length))
        num2 = number_list.delete_at(rand(number_list.length))

        # Then calculate with a randomly selected operator.
        op = random_op(divisible: (divisible?(num1, num2)))
        result = calculate(op, num1, num2)

        # Create and store the string representation of the calculation.
        calculation_strings << "#{result[:string]} = #{result[:value]}"

        # Push the result back to the list.
        number_list << result[:value]
      end

      { string: calculation_strings.join("\n"), value: number_list.first }
    end

    # Performs calculation of two numbers using the specified operator.
    # Returns the result as a hash of equation string and value.
    def self.calculate(op, num1, num2)
      # num1.send(op, num2)
      return if op == '/' && !divisible?(num1, num2)
      equation = equation_string(op, num1, num2)
      value = eval(equation)
      calc = { string: equation, value: value }
    end

    # Returns the result.
    def self.equation_string(op, num1, num2)
      "#{num1} #{op} #{num2}"
    end

    # Returns true if num1 is devisble by num2.
    def self.divisible?(num1, num2)
      # Division is a valid operation if the remainder/modulus is zero.
      num1 && num2 && (num2 != 0) && (num1 % num2 == 0)
    end

    # Returns a randomly selected operator. Rules out division if
    # the divisible: false is explicitly passed in as an option.
    def self.random_op(options = { divisible: true })
      ops = %w(+ - * /)
      ops.delete("/") unless options[:divisible]
      ops.sample
    end

    def self.build_equation_string(numbers, operators)
      return nil unless numbers.is_a?(Array) && operators.is_a?(Array) && numbers.size == operators.size + 1
      numbers.zip(operators).flatten.join(" ")
    end
end

puts NumberPuzzle.find_solution([3, 3, 6, 6, 10, 50], 386)

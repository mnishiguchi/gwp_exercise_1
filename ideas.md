# solve numbers for a number

---

## Idea 1

- Randomly take two numbers from the source list and randomly select operators.
- Repeat an arbitrary number of times (e.g., 10000.times)

#### Drawbacks
- No guarantee that it always find solutions correctly for solvable numbers.

```rb
def self.find_solution(numbers, number_to_solve_for)
  solution = nil

  10000.times do
    result = try_to_solve(numbers, number_to_solve_for)

    solved = (result[:value] == number_to_solve_for)
    if solved
      solution = result[:string]
      break
    end
  end

  solution
end

# ---
# ---

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
...
```

---

## Idea 2

- Make full use of permutation and obtain all the patterns.

#### Drawbacks
- This code only works when we perform calculation incrementally one after another.
- Does not take into consideration for the use of parentheses.

```
6 + 10 = 16
3 * 6 = 18    <= Multiplication
3 + 18 = 21
21 * 16 = 336 <= Multiplication
50 + 336 = 386
```

```rb
# Find a calculaton of a list of numbers that solves for the specified number.
# Returns a string representaton of a calculaton.
def self.find_solution(numbers, number_to_solve_for)

  # Create a list of equations.
  equations = []

  num_patterns = numbers.permutation(numbers.length).to_a
  num_patterns.each do |num_pattern|
    # Create a list of all the patterns of using operators.
    # The list length is one shorter than that of the source numbers.
    op_patterns = full_operator_patterns(numbers.length - 1)
    op_patterns.each do |op_pattern|
      equations << build_equation_string(num_pattern, op_pattern)
    end
  end

  # Create a list of results.
  results = equations.map { |equation| eval(equation) }

  # Check is the solution exists.
  solution_index = results.find_index(number_to_solve_for)

  return solution_index ? equations[solution_index] : []
end

# ---
# ---

# Return an array of operator patterns of length n.
def self.full_operator_patterns(n)
  ops = %w(+ - * /)

  # Create a list of same op * n.
  all_same_op = ops.map { |op| Array.new(n, op) }

  # Perform the permutation.
  permutation = []
  if n > 4
    # When the required size is greater than the length of the source array,
    # we need to perform permutation twice and combine the results.
    permutation_1 = ops.permutation(4).to_a
    permutation_2 = ops.permutation(n - 4).to_a
    permutation = []

    # Combine the two permutaion results.
    permutation_1.each do |p1|
      permutation_2.each do |p2|
        permutation << p1 + p2
      end
    end
    permutation
  else
    permutation = ops.permutation(n).to_a
  end

  # All same op + permutation = full list.
  all_same_op + permutation
end

...
```

# GWP Coding Excercise #1
Write code to return strings or print output as shown.

## Problem Description
The methods take in a number it is trying to solve for and a set of source numbers. Using only elementary operators (+, -, *, /) on the source numbers, determine if an equation can be found. Rules:
* Division is a valid operation if the remainder/modulus is zero.
* Source numbers, and the numbers formed in the intermediate steps from the elementary operators, can only be used once.
* Only `Solvable#solvable?` has to be [deterministic](https://en.wikipedia.org/wiki/Deterministic_algorithm). The rest, and the general purpose algorithm, can be non-deterministic.
<br />
* Default source numbers are one large and five small - defined in the ruby code.
* Default target is between 100 and 999.

Feel free to modify the given ruby code _or_ start from scratch using any language you wish. You can also give the given methods and variables better names. The methods are all related but ordered in approximate difficulty. You don't have to solve all of them. It can be solved in under 150 lines (using Ruby) and shouldn't take more than two hours (and can definitely be solved in less time). A good solution will:
* Demonstrate [Seperation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns).
* Show _high cohesion_ and _low coupling_ between methods.

GWP developers have written a solution you can see once you are finished, if interested. <br />
<br />
*Good luck!*<br />

### Ruby Code
```ruby
class Solvable
  LARGE_NUMBERS         = [25, 50, 75, 100]
  DEFAULT_LARGE_NUMBERS = 1
  SMALL_NUMBERS         = (1..10).to_a
  DEFUALT_SMALL_NUMBERS = 5
  NUMBERS_TO_SOLVE_FOR  = (100..999).to_a

  def solvable?(numbers = , number_to_solve_for = )

  end

  def find_solution(numbers = , number_to_solve_for = )

  end

  def find_solution_pretty_formatting(numbers = , number_to_solve_for = )

  end

  def find_all_solutions_pretty_formatting(numbers = , number_to_solve_for = )

  end
end
```
### Expected Input/Output
#### Solvable#solvable?
```ruby
>> Solvable.solvable?([3, 3, 6, 6, 10, 50], 386)
```
```shell
true
```

#### Solvable#find_solution
```ruby
>> Solvable.find_solution([3, 3, 6, 6, 10, 50], 386)
```
```shell
6 + 10 = 16
3 * 6 = 18
3 + 18 = 21
21 * 16 = 336
50 + 336 = 386
```

#### Solvable#find_solution_pretty_formatting
```ruby
>> Solvable.find_solution_pretty_formatting([3, 3, 6, 6, 10, 50], 386)
```
```shell
Given the numbers [3, 3, 6, 6, 10, 50] and the target 386, one set of steps are:
6 + 10 = 16
3 * 6 = 18
3 + 18 = 21
21 * 16 = 336
50 + 336 = 386
      Or
50 + ((3 + (3 * 6)) * (6 + 10)) = 386
```

#### Solvable#find_all_solutions_pretty_formatting
```ruby
>> Solvable.find_all_solutions_pretty_formatting([3, 3, 6, 6, 10, 50], 386)
```
```shell
Given the numbers [3, 3, 6, 6, 10, 50] and the target 386, the solutions are:
50 + ((3 + (3 * 6)) * (6 + 10)) = 386
((10 - 3) * (6 + 50)) - 6       = 386
                 .....               
10 + ((6 + (6 / 3)) * (50 - 3)) = 386
```

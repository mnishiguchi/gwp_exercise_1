# Solve numbers for a number

- Determines whether a given set of numbers can solve for the specified number by
performing basic arithmetic operations (+, -, *, /) using all the given numbers.
- Finds a solution if the the given set of numbers are solvable.
- Division is a valid operation if the remainder/modulus is zero.

---

## Get started

#### Clone this project

```
$ git clone git@github.com:mnishiguchi/solve_numbers_for_a_number.git
```

#### Install dependencies (for test)

Assuming Ruby and Bundler are installed on your machine.

```bash
$ bundle install
```

#### Run a [sample program](https://github.com/mnishiguchi/solve_numbers_for_a_number/blob/master/app.rb)

```bash
$ ruby app.rb
--------------------------------------------------------------------------------
Invoking `SolveNumbers.solvable?([3, 3, 6, 6, 10, 50], 386)`
................................................................................
true
--------------------------------------------------------------------------------
Invoking `SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386)`
................................................................................
3 + 6 = 9
50 - 9 = 41
3 - 41 = -38
10 * -38 = -380
6 - -380 = 386
--------------------------------------------------------------------------------
Invoking `SolveNumbers.find_solution_pretty_formatting([3, 3, 6, 6, 10, 50], 386)`
................................................................................
Given the numbers [3, 3, 6, 6, 10, 50] and the target 386, one set of steps are:
6 * 3 = 18
3 + 18 = 21
10 + 6 = 16
21 * 16 = 336
50 + 336 = 386
--- Or ---
(50 + ((3 + (6 * 3)) * (10 + 6))) = 386
```

#### Run [test](https://github.com/mnishiguchi/solve_numbers_for_a_number/tree/master/spec)

```bash
$ rspec
```

---

## About

#### File structure

```bash
$ tree
.
├── Gemfile
├── Gemfile.lock
├── README.md
├── app.rb # Sample program that demonstrates the program.
├── lib
│   ├── number_string.rb # A wrapper class for a number.
│   └── solve_numbers.rb # Logic to solve a number puzzle.
└── spec
    ├── number_string_spec.rb
    ├── solve_numbers_spec.rb
    └── spec_helper.rb
```

#### Classes
This program contains two classes for Seperation of Concerns.

- [NumberString](https://github.com/mnishiguchi/solve_numbers_for_a_number/blob/master/lib/number_string.rb)
  + A wrapper class for a number so that a number can remember the history of how it gets its current value as a string.
  + Overloads basic arithmetic operators (+ - * /).
  + Simply represents a number and its history of calculation.
  + Does not know about the puzzle.

- [SolveNumbers](https://github.com/mnishiguchi/solve_numbers_for_a_number/blob/master/lib/solve_numbers.rb)
  + Contains logic to solve a number puzzle.

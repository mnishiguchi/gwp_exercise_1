require_relative 'lib/solve_numbers'

puts "-" * 80
puts "Invoking `SolveNumbers.solvable?([3, 3, 6, 6, 10, 50], 386)`"
puts "." * 80
puts SolveNumbers.solvable?([3, 3, 6, 6, 10, 50], 386).inspect

puts "-" * 80
puts "Invoking `SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386)`"
puts "." * 80
puts SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386)

puts "-" * 80
puts "Invoking `SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386, pretty: true)`"
puts "." * 80
puts SolveNumbers.find_solution([3, 3, 6, 6, 10, 50], 386, pretty: true)

# This class is a wrapper of a number so that a number can hold its
# calculation history as an equation string as well as its value.
# We can use the four basic arithmetic operators (+. -, * and /)
# directly on an instance of this class.
class NumberString
  attr_accessor :value, :string

  def initialize(value=nil)
    unless value.nil?
      @value = value
      @string = value.to_s
    end
  end

  def +(other)
    result = NumberString.new
    result.value = @value + other.value
    result.string = "(#{@string} + #{other.string})"
    result
  end

  def -(other)
    result = NumberString.new
    result.value = @value - other.value
    result.string = "(#{@string} - #{other.string})"
    result
  end

  def *(other)
    result = NumberString.new
    result.value = @value * other.value
    result.string = "(#{@string} * #{other.string})"
    result
  end

  def /(other)
    result = NumberString.new
    result.value = @value / other.value
    result.string = "(#{@string} / #{other.string})"
    result
  end

  # Return true if the number is evenly divisible by the specified number.
  def divisible(other)
    (other.value != 0) && (@value % other.value == 0)
  end

  # Returns a string of calculation steps that were taken to get current value.
  def calculation_steps
    # Temporary storage of equations.
    list = []

    # Make a local copy of the string because we are doing destructive operations.
    str = String.new(@string)

    loop do
      # Obtain the list of calculations that have the highest precedence.
      # Exit the loop if none is found.
      scan_result = str.scan(/\(-?\d+ \D -?\d+\)/)
      break if scan_result.empty?

      # Perform the calculation of the first item on the list.
      left_hand_side = scan_result.first
      right_hand_side = eval(left_hand_side).to_s
      list << "#{left_hand_side} = #{right_hand_side}"

      # Update the string by replacing the performed calculation with its result.
      str = str.gsub(left_hand_side, right_hand_side)
    end
    list
  end

  # Returns source numbers as an array of integers.
  def source_numbers
    @string.scan(/-?\d+\b/).map(&:to_i).sort
  end

  # Converts an array of Integers into an array of NumberString objects.
  def self.convert!(numbers)
    numbers.map! { |number| NumberString.new(number) }
  end
end

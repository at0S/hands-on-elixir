defmodule FizzBuzz do 
  
  def main() do
    1..100
    |> Enum.map(&fizzbuzz/1)
    |> Enum.join(" ")
    |> IO.puts()
  end

  @spec fizzbuzz(integer) :: String.t()
  def fizzbuzz(number) do
    cond do 
      rem(number,3) == 0 and rem(number,5) == 0 -> "FizzBuzz"
      rem(number,3) == 0 -> "Fizz"
      rem(number,5) == 0 -> "Buzz"
      true -> to_string(number)
    end
  
  end

end

ExUnit.start()

defmodule FizzBuzzTest do
  use ExUnit.Case

  test "fizzbuzz" do
    assert FizzBuzz.fizzbuzz(1) == "1"
    assert FizzBuzz.fizzbuzz(3) == "Fizz"
    assert FizzBuzz.fizzbuzz(5) == "Buzz"
    assert FizzBuzz.fizzbuzz(15) == "FizzBuzz"
    assert FizzBuzz.fizzbuzz(99) == "Fizz"
  end
end

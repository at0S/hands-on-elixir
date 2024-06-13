defmodule GCD do

 def gcd(a, b) when a < 0, do: gcd(-a, b)
 def gcd(a, b) when b < 0, do: gcd(a, -b)
 def gcd(0, b), do: b
 def gcd(a, 0), do: a

 def gcd(a, b) do
   case rem(a, b) do
     0 -> b
     c -> gcd(b, c)
   end
 end

end


ExUnit.start()
defmodule GCDTest do
  use ExUnit.Case

  test "simple cases" do
    assert GCD.gcd(36, 63) == 9
    assert GCD.gcd(63, 36) == 9
  end
  
  test "negative arguments" do
    assert GCD.gcd(-5, 25) == 5
    assert GCD.gcd(5, -25) == 5
  end

  test "zero arguments" do
    assert GCD.gcd(0, 5) == 5
    assert GCD.gcd(5, 0) == 5
  end
end

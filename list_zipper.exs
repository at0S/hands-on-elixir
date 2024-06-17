defmodule ListZipper do

  def zip([], []), do: []

  def zip(left, right) do
    zip(left, right, [])
  end

  def zip([], right, acc), do: Enum.reverse(acc) ++ right
  def zip(left, [],  acc), do: Enum.reverse(acc) ++ left

  def zip(left,right,acc) do
    [head_left|tail_left] = left
    [head_right|tail_right] = right
    if head_left < head_right do
      acc = [head_left|acc]
      zip(tail_left, right, acc)
    else
      acc = [head_right|acc]
      zip(left, tail_right, acc)
    end
  end
end

ExUnit.start()

defmodule ListZipperTest do
  use ExUnit.Case

  test "simple case" do
    assert ListZipper.zip([1, 3, 5], [4, 11, 22]) == [1, 3, 4, 5, 11, 22]
  end

  test "empty list" do
    assert ListZipper.zip([], []) == []
  end

  test "variable length" do
    assert ListZipper.zip([1, 3, 5], [4, 11, 22, 33, 44]) == [1, 3, 4, 5, 11, 22, 33, 44]
  end

  test "unsorted list" do
    assert ListZipper.zip([5, 3, 1], [22, 11, 4]) == [1, 3, 4, 5, 11, 22]
  end

end

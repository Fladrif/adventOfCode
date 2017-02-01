defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "test sum" do
    assert Day1.sum(3, 6) == 9
  end
end

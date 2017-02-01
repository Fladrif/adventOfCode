defmodule Day2Test do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "Moving left" do
    assert move("1", "L") == "1"
    assert move("2", "L") == "1"
    assert move("3", "L") == "2"
    assert move("4", "L") == "4"
    assert move("5", "L") == "4"
    assert move("6", "L") == "5"
    assert move("7", "L") == "7"
    assert move("8", "L") == "7"
    assert move("9", "L") == "8"
  end

  test "Moving down" do
    assert move("1", "D") == "4"
    assert move("2", "D") == "5"
    assert move("3", "D") == "6"
    assert move("4", "D") == "7"
    assert move("5", "D") == "8"
    assert move("6", "D") == "9"
    assert move("7", "D") == "7"
    assert move("8", "D") == "8"
    assert move("9", "D") == "9"
  end

end

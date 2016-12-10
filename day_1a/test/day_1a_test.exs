defmodule Day1aTest do
  use ExUnit.Case
  doctest Day1a

  test "first test string" do
    assert Day1a.distance_in_blocks("R2, L3") == 5
  end

  test "second test string" do
    assert Day1a.distance_in_blocks("R2, R2, R2") == 2
  end

  test "third test string" do
    assert Day1a.distance_in_blocks("R5, L5, R5, R3") == 12
  end
end

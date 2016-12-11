defmodule Day1bTest do
  use ExUnit.Case
  doctest Day1b

  test "first test string" do
    assert Day1b.distance_of_first_double_visit("R8, R4, R4, R8") == 4
  end
end

defmodule Day1b do
  def distance_of_first_double_visit(str) do
    str
      |> treat_data
      # |> IO.inspect
      |> traverse_list
  end

  defp treat_data(str) do
    str
      |> String.strip
      |> String.split(", ")
      |> convert_pairs
  end

  defp convert_pairs(old_list, new_list \\ [])

  defp convert_pairs([<<hand_direction::bytes-size(1)>> <> length | tail], []) do
    cardinal_direction =
      case hand_direction do
        "L" ->
          "W"
        "R" ->
          "E"
      end
    convert_pairs(tail, List.duplicate(cardinal_direction, String.to_integer(length)))
  end

  defp convert_pairs([<<hand_direction::bytes-size(1)>> <> length | tail], converted_list = [previous_direction | _]) do
    cardinal_direction =
      case {hand_direction, previous_direction} do
        {"L", "N"} ->
          "W"
        {"L", "W"} ->
          "S"
        {"L", "S"} ->
          "E"
        {"L", "E"} ->
          "N"
        {"R", "N"} ->
          "E"
        {"R", "W"} ->
          "N"
        {"R", "S"} ->
          "W"
        {"R", "E"} ->
          "S"
      end
    convert_pairs(tail, List.flatten([List.duplicate(cardinal_direction, String.to_integer(length)) | converted_list]))
  end

  defp convert_pairs([], converted_list) do
    Enum.reverse(converted_list)
  end

  defp traverse_list(list, visited_list \\ [{0, 0}])

  defp traverse_list([next_direction | tail], visited_list = [{x, y} | _]) do
    {current_x, current_y} =
      case next_direction do
        "N" ->
          {x + 1, y}
        "E" ->
          {x, y + 1}
        "S" ->
          {x - 1, y}
        "W" ->
          {x, y - 1}
      end
    if {current_x, current_y} in visited_list do
      abs(current_x) + abs(current_y)
    else
      traverse_list(tail, [{current_x, current_y} | visited_list] |> List.flatten)
    end
  end

  defp traverse_list([], _visited_list) do
    nil
  end
end

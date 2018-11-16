defmodule Day1a do
  def distance_in_blocks(str) do
    str
    |> treat_data
    |> count_lengths
    |> calculate_distance
  end

  defp treat_data(str) do
    str
    |> String.strip()
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

    convert_pairs(tail, [{cardinal_direction, String.to_integer(length)}])
  end

  defp convert_pairs(
         [<<hand_direction::bytes-size(1)>> <> length | tail],
         converted_list = [{previous_direction, _} | _]
       ) do
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

    convert_pairs(tail, [{cardinal_direction, String.to_integer(length)} | converted_list])
  end

  defp convert_pairs([], converted_list) do
    Enum.reverse(converted_list)
  end

  defp count_lengths(list, pair \\ {0, 0})

  defp count_lengths([{direction, length} | tail], {x, y}) do
    {new_x, new_y} =
      case direction do
        "N" ->
          {x + length, y}

        "E" ->
          {x, y + length}

        "S" ->
          {x - length, y}

        "W" ->
          {x, y - length}
      end

    count_lengths(tail, {new_x, new_y})
  end

  defp count_lengths([], {x, y}) do
    {x, y}
  end

  defp calculate_distance({x, y}) do
    abs(x) + abs(y)
  end
end

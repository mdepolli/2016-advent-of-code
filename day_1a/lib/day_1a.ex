defmodule Day1a do
  def distance_in_blocks(str) do
    str
      |> treat_data
      # |> IO.inspect
      |> count_lengths({0, 0})
      |> calculate_distance
  end

  defp treat_data(str) do
    str
      |> String.strip
      |> String.split(", ")
      |> convert_pairs([])
  end

  defp convert_pairs(["L" <> length | tail], []) do
    convert_pairs(tail, [{"W", String.to_integer(length)}])
  end

  defp convert_pairs(["R" <> length | tail], []) do
    convert_pairs(tail, [{"E", String.to_integer(length)}])
  end

  defp convert_pairs(["L" <> length | tail], converted_list = [{"N", _} | _]) do
    convert_pairs(tail, [{"W", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs(["L" <> length | tail], converted_list = [{"W", _} | _]) do
    convert_pairs(tail, [{"S", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs(["L" <> length | tail], converted_list = [{"S", _} | _]) do
    convert_pairs(tail, [{"E", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs(["L" <> length | tail], converted_list = [{"E", _} | _]) do
    convert_pairs(tail, [{"N", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs(["R" <> length | tail], converted_list = [{"N", _} | _]) do
    convert_pairs(tail, [{"E", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs(["R" <> length | tail], converted_list = [{"W", _} | _]) do
    convert_pairs(tail, [{"N", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs(["R" <> length | tail], converted_list = [{"S", _} | _]) do
    convert_pairs(tail, [{"W", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs(["R" <> length | tail], converted_list = [{"E", _} | _]) do
    convert_pairs(tail, [{"S", String.to_integer(length)} | converted_list])
  end

  defp convert_pairs([], converted_list) do
    Enum.reverse(converted_list)
  end

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

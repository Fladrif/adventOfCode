defmodule Day1 do
  use Application

  defp print(content) do
    IO.inspect content
  end

  defp readFile(file) do
    {:ok, content} = File.read file
    content
  end

  defp parseString(string) do
    String.split(string, ", ")
  end

  defp inState?(map, [_head|coord]) do
    if (Map.has_key?(map, coord)) do
      true
    else
      false
    end
  end

  defp addState(map, [_head|coord], value) do
    Map.put(map, coord, value)
  end


  defp getDirFromValue(value) do
    String.slice(value, 0..0)
  end

  defp getDistFromValue(value) do
    {dist, _remainder} = 
      value
      |> String.slice(1..-1)
      |> Integer.parse
    dist
  end

  # Calculate block 
  defp calculate([head|tail]) do
    dir = getDirFromValue head
    dist = getDistFromValue head
    vector = [:north, {0, 0}]
      |> move(dir, dist)
    calculate tail, vector
  end

  defp calculate([head|tail], vector) when length(tail) > 0 do
    dir = getDirFromValue head
    dist = getDistFromValue head
    vector = vector
      |> move(dir, dist)
    calculate tail, vector
  end

  defp calculate([array], vector) do
    dir = getDirFromValue array
    dist = getDistFromValue array
    vector = vector 
      |> move(dir, dist)
    vector
  end

  # incremental move block
  defp trueMoveFirst(vector, dir, dist, map) do
    vector = move vector, dir, 0
    trueMove(vector, dir, dist, map)
  end

  defp trueMove(vector, dir, dist, map) when dist > 1 do
    vector = vector
      |> incMove()
    if (inState?(map, vector)) do
      {true, vector, map}
    else
      map = addState(map, vector, 1)
      trueMove(vector, dir, dist - 1, map)
    end
  end

  defp trueMove(vector, dir, dist, map) do
    vector = vector
      |> incMove()
    if (inState?(map, vector)) do
      {true, vector, map}
    else
      map = addState(map, vector, 1)
      {false, vector, map}
    end
  end

  # calculate incremental move block
  defp calculateTrueDestination([head|tail]) do
    dir = getDirFromValue head
    dist = getDistFromValue head
    {found, vector, map} = [:north, {0, 0}]
      |> trueMoveFirst(dir, dist, %{})
    if (found) do
      vector
    else
      calculateTrueDestination tail, vector, map
    end
  end

  defp calculateTrueDestination([head|tail], vector, map) when length(tail) > 0 do
    dir = getDirFromValue head
    dist = getDistFromValue head
    {found, vector, map} = vector
      |> trueMoveFirst(dir, dist, map)
    if (found) do
      vector
    else
      calculateTrueDestination tail, vector, map
    end
  end

  defp calculateTrueDestination([array], vector, map) do
    dir = getDirFromValue array
    dist = getDistFromValue array
    {found, vector, map} = vector
      |> trueMoveFirst(dir, dist, map)
    if (found) do
      vector
    else
      vector
    end
  end


  defp move([:north, {x, y}], "R", dist) do [:east, {x, y + dist}] end
  defp move([:north, {x, y}], "L", dist) do [:west, {x, y - dist}] end
  defp move([:east, {x, y}], "R", dist) do [:south, {x - dist, y}] end
  defp move([:east, {x, y}], "L", dist) do [:north, {x + dist, y}] end
  defp move([:south, {x, y}], "R", dist) do [:west, {x, y - dist}] end
  defp move([:south, {x, y}], "L", dist) do [:east, {x, y + dist}] end
  defp move([:west, {x, y}], "R", dist) do [:north, {x + dist, y}] end
  defp move([:west, {x, y}], "L", dist) do [:south, {x - dist, y}] end

  defp incMove([:north, {x, y}]) do [:north, {x + 1, y}] end
  defp incMove([:east, {x, y}]) do [:east, {x, y + 1}] end
  defp incMove([:south, {x, y}]) do [:south, {x - 1, y}] end
  defp incMove([:west, {x, y}]) do [:west, {x, y - 1}] end

  defp findDestination(file) do
    file
    |> readFile
    |> parseString
    |> calculate
    |> print
  end

  defp findTrueDestination(file) do
    file
    |> readFile
    |> parseString
    |> calculateTrueDestination
    |> print
  end
  
  def start(_type, file) do
    findTrueDestination file
  end
end

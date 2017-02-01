defmodule Day2 do
  defp readFile(file) do
    {:ok, content} = File.read file
    content
  end

  defp parseFile(file) do
    String.split(file, "\n", trim: true)
  end

  defp parseString(string) do
    String.split(string, "", trim: true)
  end

  defp print(stuff) do
    IO.inspect stuff
  end

  defp iterateLine([head|tail]) do
    current = "5"
    newCode = head
      |> parseString
      |> iterateNumber(current)
    code = Enum.join(["", newCode], "")
    iterateLine(tail, code)
  end

  defp iterateLine([head|tail], code) when length(tail) > 0 do
    prevCode = String.slice(code, -1..-1)
    print code
    print prevCode
    newCode = head
      |> parseString
      |> iterateNumber(prevCode)
    code = Enum.join([code, newCode], "")
    iterateLine(tail, code)
  end

  defp iterateLine([array], code) do
    prevCode = String.slice(code, -1..-1)
    print code
    print prevCode
    newCode = array
      |> parseString
      |> iterateNumber(prevCode)
    code = Enum.join([code, newCode], "")
    code
  end

  defp iterateNumber([head|tail], current) when length(tail) > 0 do
    current = current
      |> actualMove(head)
    iterateNumber tail, current
  end

  defp iterateNumber([array], current) do
    actualMove(current, array)
  end

  defp move(num, "L") do
    {num, _remainder} = Integer.parse(num)
    if (rem(num, 3) == 1) do
      Integer.to_string(num)
    else
      Integer.to_string(num - 1)
    end
  end

  defp move(num, "R") do
    {num, _remainder} = Integer.parse(num)
    if (rem(num, 3) == 0) do
      Integer.to_string(num)
    else
      Integer.to_string(num + 1)
    end
  end

  defp move(num, "U") do
    {num, _remainder} = Integer.parse(num)
    if (div(num - 1, 3) == 0) do
      Integer.to_string(num)
    else
      Integer.to_string(num - 3)
    end
  end

  defp actualMove("1", "U") do "1" end
  defp actualMove("1", "D") do "3" end
  defp actualMove("1", "L") do "1" end
  defp actualMove("1", "R") do "1" end

  defp actualMove("2", "U") do "2" end
  defp actualMove("2", "D") do "6" end
  defp actualMove("2", "L") do "2" end
  defp actualMove("2", "R") do "3" end

  defp actualMove("3", "U") do "1" end
  defp actualMove("3", "D") do "7" end
  defp actualMove("3", "L") do "2" end
  defp actualMove("3", "R") do "4" end

  defp actualMove("4", "U") do "4" end
  defp actualMove("4", "D") do "8" end
  defp actualMove("4", "L") do "3" end
  defp actualMove("4", "R") do "4" end

  defp actualMove("5", "U") do "5" end
  defp actualMove("5", "D") do "5" end
  defp actualMove("5", "L") do "5" end
  defp actualMove("5", "R") do "6" end

  defp actualMove("6", "U") do "2" end
  defp actualMove("6", "D") do "A" end
  defp actualMove("6", "L") do "5" end
  defp actualMove("6", "R") do "7" end

  defp actualMove("7", "U") do "3" end
  defp actualMove("7", "D") do "B" end
  defp actualMove("7", "L") do "6" end
  defp actualMove("7", "R") do "8" end

  defp actualMove("8", "U") do "4" end
  defp actualMove("8", "D") do "C" end
  defp actualMove("8", "L") do "7" end
  defp actualMove("8", "R") do "9" end

  defp actualMove("9", "U") do "9" end
  defp actualMove("9", "D") do "9" end
  defp actualMove("9", "L") do "8" end
  defp actualMove("9", "R") do "9" end

  defp actualMove("A", "U") do "6" end
  defp actualMove("A", "D") do "A" end
  defp actualMove("A", "L") do "A" end
  defp actualMove("A", "R") do "B" end

  defp actualMove("B", "U") do "7" end
  defp actualMove("B", "D") do "D" end
  defp actualMove("B", "L") do "A" end
  defp actualMove("B", "R") do "C" end

  defp actualMove("C", "U") do "8" end
  defp actualMove("C", "D") do "C" end
  defp actualMove("C", "L") do "B" end
  defp actualMove("C", "R") do "C" end

  defp actualMove("D", "U") do "B" end
  defp actualMove("D", "D") do "D" end
  defp actualMove("D", "L") do "D" end
  defp actualMove("D", "R") do "D" end


  defp move(num, "D") do
    {num, _remainder} = Integer.parse(num)
    if (div(num - 1, 3) == 2) do
      Integer.to_string(num)
    else
      Integer.to_string(num + 3)
    end
  end

  def start(_type, file) do
    file
    |> readFile
    |> parseFile
    |> iterateLine
    |> print
  end
end

defmodule Day1 do
  def test_a() do
    sample = File.read!("day1.csv") #with ! - give back the string if you don't find the file crash difference without !
    list = String.to_charlist(sample)
    to_rows(list)
    rows = to_rows(list)
    parse_rows(rows)
  end

  def to_rows([]) do [[]] end
  def to_rows([?\n | rest]) do #[?\n | rest] is used to match a list that starts with a newline
    [[] | to_rows(rest)]
  end

  def to_rows([char | rest]) do
    [first|rest] = to_rows(rest)
    [[char | first] | rest]
  end

  def parse_rows([]) do [] end
  def parse_rows([row|rest]) do
    [parse_rows(row) | parse_rows(rest)]
  end

  def parse_last(row) do
    parse_first(reverse(row))
  end

  def parse_first([char | rest]) do
    case char do
      ?0 -> 0
      ?1 -> 1
      ?9 -> 9
      _ -> parse_first (rest)
    end

  end

end

#no digit - crash

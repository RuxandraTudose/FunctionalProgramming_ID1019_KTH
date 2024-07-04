
defmodule Springs do
  def begin() do
    mem = Map.new()
    k = 2
    readfile(mem, k)
  end

  def readfile(mem, k) do
    {:ok, input} = File.read("input.txt")
    rows = String.split(input, "\n")
    descr = Enum.map(rows, fn row -> splitline(row, k)  end)
    {t, _} = :timer.tc(fn() ->
       result = Enum.map(descr, fn({springs_list, damaged_list }) -> explore(springs_list, damaged_list, mem)end) end)
    #list(result)
    #result
    IO.puts("Execution time: #{t} microseconds")

  end

  def list(result) do list(result, []) end
  def list([], acc) do acc end
  def list([h | t], acc) do {n, _} = h; list(t, acc++[n]) end

  def checkmemory(list, d,  mem) do
    case Map.get(mem, {list, d}) do
      :nil -> {answer, mem} = explore(list, d, mem)
              {answer, Map.put(mem,{list, d}, answer)}
      answer -> {answer, mem}
    end
  end

  def splitline(line, k) do
    [springs_info, damaged] = String.split(line, " ")
    {extend_s(description(String.to_charlist(springs_info)), k, []),
                extend_d(damaged_springs(String.split(damaged, ",")), k, [])}
  end


  def explore([], [], mem) do {1, mem} end
  def explore([], _, mem) do {0,mem} end
  def explore(_, [], mem) do {1, mem} end
  def explore([:op | t], d, mem) do checkmemory(t, d,mem) end
  def explore([:dam| t], [n |d], mem) do
    case damaged(t, n-1)   do
      {:ok, rest} -> checkmemory(rest, d, mem)
      :no -> {0, mem}
    end
  end
  def explore([:ukn | t], d, mem) do
    {ans1, mem} = checkmemory([:dam| t], d, mem)
    {ans2, mem} = checkmemory([:op | t], d,mem)
    {ans1 + ans2, mem}
  end


  def damaged([], 0) do {:ok, []} end
  def damaged([], n) do :no end
  def damaged([:dam | t], 0) do :no end
  def damaged([:dam | t], n) do damaged(t, n-1) end
  def damaged([:op | t], 0) do {:ok, t} end
  def damaged([:op | t], n) do :no end
  def damaged([:ukn | t], 0) do {:ok, [:op | t]} end
  def damaged([:ukn | t], n) do damaged([:dam | t], n) end


  def description(list) do description(list, []) end
  def description([], acc) do acc end
  def description(list, acc) do
    case hd(list) do
      63 -> description(tl(list), acc ++ [:ukn])
      46 -> description(tl(list), acc ++ [:op])
      35 -> description(tl(list), acc ++ [:dam])
    end
  end

  def damaged_springs(list) do damaged_springs(list, []) end
  def damaged_springs([], acc) do acc end
  def damaged_springs(list, acc) do
   {n, _} = Integer.parse(hd(list))
   damaged_springs(tl(list), acc ++ [n])
  end

  def extend_s(list, 0, acc) do acc end
  def extend_s(list, 1, acc) do extend_s(list, 0, acc ++ list) end
  def extend_s(list, n, acc) do
    extend_s(list, n - 1, acc ++ list ++ [:ukn])
  end

  def extend_d(list, 0, acc) do acc end
  def extend_d(list, n, acc) do
    extend_d(list, n-1, acc++list)
  end

end






  #damaged [:dam...] 0
  #[:op], 3
  # ukn  2 -> should be op

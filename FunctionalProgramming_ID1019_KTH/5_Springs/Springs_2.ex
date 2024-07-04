defmodule Spring1 do
  def readfile() do
    {:ok, input} = File.read("test.txt")
    row = String.split(input, "\n")
     Enum.map(row, fn element ->
      splitline(element)
    end)
    #Enum.sum(result)
  end

  def splitline(line) do
    [springs_info, damaged] = String.split(line," ")
    {s, d} = {description(String.to_charlist(springs_info)),
                damaged_springs(String.split(damaged, ","))}
    #match(check(s), d) #explore direct
    #explore(s, d, [])
    springs_list = extend_s(s,2,[])
    damaged_list = extend_d(d,2, [])

    explore(springs_list, damaged_list, [])

  end

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

  def check(s) do check(s, 0) end
  def check([], acc) do [] end
  def check([:dam], acc) do
    [acc + 1 | check([], acc + 1)]
  end
  def check([h], 0) do [] end
  def check([h], acc) do [acc | check([], acc)] end
  def check([h|t], acc) do
    case h do
      :dam -> check(t, acc + 1)
      _ -> case acc do
            0 -> check(t)
            _ -> [acc | check(t)]
           end
    end
  end

  def explore(s,d,acc) do explore(s,d,acc,0) end
  def explore([], d , acc, sum) do  sum + match(check(acc), d) end
  def explore([:op | t], d, acc, sum) do explore(t, d, acc ++ [:op], sum) end
  def explore([:dam| t], d, acc, sum) do explore(t, d, acc ++ [:dam], sum) end

  def explore([:ukn | t], d, acc, sum) do
    explore(t, d, acc ++ [:op], sum) + explore(t, d, acc ++ [:dam], sum)
  end

  def match(list, d) do
    case (list == d) do
      true -> 1
      false -> 0
    end
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

  def merge(h,t) do
    [h|t]
  end
end

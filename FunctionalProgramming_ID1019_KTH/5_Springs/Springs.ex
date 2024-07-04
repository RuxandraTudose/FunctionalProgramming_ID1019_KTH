defmodule Springs do

  def readfile() do
    File.stream!("test.txt")
    |> Stream.map(&String.strip/1)
    |> Stream.map(&splitline/1)
    |> Enum.to_list()
  end


  def splitline(line) do
    [springs_info, damaged] = String.split(line, " ")
    {s, d} = {description(String.to_charlist(springs_info)),
                damaged_springs(String.split(damaged, ","))}
    check(s)
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

  def match(list, d) do
    case (list == d) do
      true -> 1 #only one possibility - everything is correct
      false -> list #call method to explore further
    end
  end
end

"""
def check(s, acc) do
  case(hd(s)) do
             :


rewrite this as

def check( [h], acc) do
 :
end
def check([h|t], acc) do
case h do
     :
end

def check([h], acc) do
  case h do
    :dam -> [acc + 1 | check([], acc + 1)]
    _ -> check([], acc)
def check([h|t], acc) do
  case h do
    :dam -> check(t, acc + 1)
    _ -> case acc do
          0 -> check(t)
          _ -> [acc | check(t)]
end



def check(s, acc) do
  case(hd(s)) do
    :dam ->  case (tl(s)) do
              [] -> [acc + 1] ++ check(tl(s), acc)
               _ -> check(tl(s), acc + 1)
             end
    _ -> case acc do
          0 -> check(tl(s))
          _ -> [acc] ++ check(tl(s))
    end
  end
end

and,  appending a list of one known element top a list is best done like this

   [ acc+1 | check(t, acc) ]



"""

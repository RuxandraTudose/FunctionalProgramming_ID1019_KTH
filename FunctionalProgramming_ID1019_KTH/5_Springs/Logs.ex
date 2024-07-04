defmodule Logs do

  def cut(n, spec) do
    #{answer, _} = cut(n, spec, Map.new())
   # answer
   cut(n, spec, Map.new())

  end
#----------- add a memory
  def check(n, spec, mem) do
    case Map.get(mem, {n,spec}) do
      :nil -> {answer, mem} = cut(n,spec, mem)
              {answer, Map.put(mem,{n,spec}, answer)}
      answer -> {answer, mem}
    end
  end


  def cut(_, [], mem) do {0, mem}end
  def cut(n, spec, mem) do
    search(n, spec, [], mem)
  end

  def search(n, [s], left, mem) do
    {a, mem} = check(s, left, mem) #//Enum.reverse(left)
    {n + a, mem}
  end

  def search(n, [s|spec], left, mem) do
    {a1r, mem} =  check(n-s, Enum.map(spec, fn(x) -> x - s end), mem)
    {a1l, mem} = check(s,left, mem)
    {a2, mem} = search(n, spec, left ++ [s], mem)
    alt1 = n + a1r + a1l
    alt2 = a2
    if(alt1 < alt2) do
      {alt1,mem}
    else
      {alt2, mem}
    end
  end
end

#Map module

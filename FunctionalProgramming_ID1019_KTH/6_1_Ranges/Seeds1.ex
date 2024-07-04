defmodule Seeds do
  def begin() do
    str = File.read!("input.txt")
    {seeds, maps} = parse(str)
    [h | t] = location({seeds, maps})
    mini([h | t], h)
  end

  def parse(str) do
    [seeds | maps] = String.split(str, "\n\n") #["seeds: 79 14 55 13" | "seed-to-soil map:\n50 98 2\n52 50 48", ...]
    [_ | seeds] = String.split(seeds, " ") #keep just numbers: ["79","14","55","13"]
    seeds = Enum.map(seeds, fn(nr) -> {n, _} = Integer.parse(nr); n end) #take each no in the list adn apply Integer.parses; keep n only [79, 14,55,13]
    maps = Enum.map(maps, fn(map)->
      [_ | transf] = String.split(map, "\n")
      Enum.map(transf, fn(tr) -> list = String.split(tr, " ")
      [d, s, r]= Enum.map(list, fn(tr) -> {n, _} = Integer.parse(tr); n end)
      {:tr, d, s,r}
     end)
    end)
    {seeds, maps}
  end


  def location({seeds, maps}) do
  Enum.map(seeds, fn(seed) ->
    Enum.reduce(maps, seed, fn(map, nr) ->
      Enum.find_value(map, nr, fn({tr,d,s,r}) ->
        if((s <= nr) and (nr < (s + r))) do
          d + (nr - s) #parser does not like minus
        else
          :nil
        end
      end)
    end)
  end)
  end

  def mini([], n) do n end
  def mini([h | t], n) do
    if(h <= n) do
      mini(t, h)
    else
      mini(t, n)
    end
  end
end

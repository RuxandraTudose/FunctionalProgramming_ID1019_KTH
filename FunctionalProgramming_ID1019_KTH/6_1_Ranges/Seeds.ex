defmodule Seeds do
  def begin() do
    descr = String.split(File.read!("test.txt"), "\n\n")
    parse(descr)
    location()
  end
end

def parse(str) do
 [seeds | maps] = String.split(str, "\n\n")
[_ | seeds] = String.split(seeds, " ")
seeds = Enum.map(seeds, fn(nr) -> {n, _} = Integer.parse(nr); n end)
maps = Enum.map(maps, fn(map)->
 [_ | transf] = String.split(map, "\n")
 Enum.map(transf, fn(tr) ->

end)
 maps end)
{seeds, maps}
end


# [23,24,25,26,, .....32,33,34, 78,79,...]
#[{:rng, 23, 4}, {:rng}, 32, 3}, {:rng, 78, 81}]

def location({seeds, maps}) do #reunr list of locations maps is a list of maps reduce to a final value
  seeds = multiply(seeds) #79, 80, ...... run through seed s-> DONE
  Enum.map(seeds, fn(seed) ->
    Enum.reduce(maps, seed, fn(map, nr) ->
      Enum.find_value(map, nr, fn({tr,d,s,r}) ->
        if((s <= nr) and (nr < (s + r))) do
          d + (nr - s) #parser does not like minus
        else
          :nil
        end
    #  translate(map, nr)
      end)
    end)
  end)

end

def translate([], nr) do nr end
def translate([{:tr, d, s, r} | rest], nr) do
  if((s <= nr) and (nr < (s + r))) do
    d + (nr - s) #parser does not like minus
  else
    translate(rest, nr)
  end
end

#split on new line
#tuple seesds and maps

#{[seeds], list of maps}
#union of two sets and subtract this set

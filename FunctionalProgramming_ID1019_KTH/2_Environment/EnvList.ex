defmodule EnvList do
  def new() do [] end

  def add([], key, value) do [{key, value}] end
  def add([{key, _}|map], key, value) do  [{key,value}|map] end
  def add([ass | map], key, value) do [ass | add(map, key,value)] end

  def lookup([], _) do :nil end
  def lookup([{key,value}| map],key) do {key,value} end
  #alternative:
    #def lookup([{key,value} = ass | map], key) do ass end
  def lookup([ass | map], key) do lookup(map,key) end

  def remove([], _) do [] end
  def remove([{key,value} | map], key) do map end
  def remove([ass | map], key) do [ass |remove(map, key)] end #keep the first part fo the list otherwise you lose it

end

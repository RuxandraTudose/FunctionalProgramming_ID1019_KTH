defmodule EnvList do

  def new() do [] end
  def add(map, key, val) do [{key, val} | map] end

  def lookup([], _) do :no end
  def lookup([{key, val} |_], key) do {:ok, val} end
  def lookup([ _ | rest], key) do lookup(rest, key) end

  def remove([],_) do :no end
  def remove([{key, _} | rest ], key) do rest end
  def remove([ first | rest], key) do [first, remove(rest, key)] end


end




defmodule EnvTree do

  def new() do :nil end
  def add(nil, key, value) do
    #adding a key-value pair to an empty tree ..
    {:node, key, value, nil, nil}
    end
    def add({:node, key, _, left, right}, key, value) do
    #if the key is found we replace it ..
    {:node, key, value, left, right}
    end
    def add({:node, k, v, left, right}, key, value) when key < k do
    #return a tree that looks like the one we have
    {:node, k, v, add(left, key, value), right}
    end
    def add({:node, k, v, left, right}, key, value) do
    #same thing but instead update the right banch
    {:node, k, v, left, add(right, key, value)}
    end

  def lookup(nil, _) do :no end
  def lookup({:node, key, val, _, _}, key) do {:ok, val} end
  def lookup({:node, k, _, left, right}, key)
    when (k > key) do
      lookup(left, key)
    end
  def lookup({:node, k, _, left, right}, key) do
    lookup(right, key)
  end

def remove(nil, _) do nil end
def remove({:node, key, _, nil, right}, key) do right end
def remove({:node, key, _, left, nil}, key) do left end
def remove({:node, key, _, left, right}, key) do
{:node, keyToRemove, value, _, _} = leftmost(right)
{:node, keyToRemove, value, left, remove(right, keyToRemove)}
end
def remove({:node, k, v, left, right}, key) when key < k do
{:node, k, v, remove(left, key), right}
end
def remove({:node, k, v, left, right}, key) do
{:node, k, v, left, remove(right, key)}
end



def leftmost({:node, key, value, nil, right}) do {:node, key, value, nil, right} end
def leftmost({:node, k, v, left, right}) do
#{:node, _, _, l, _} = '
leftmost(left)
#'leftmost(l)
end

  def bench(n) do
    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]
    :io.format("# benchmark with ~w operations, time per operation in us\n", [n])
    :io.format("~6.s~12.s~12.s~12.s\n", ["n", "add", "lookup", "remove"])
    Enum.each(ls, fn (i) ->
      {i, tla, tll, tlr} = bench(i, n)
      :io.format("~6.w~12.2f~12.2f~12.2f\n", [i, tla/n, tll/n, tlr/n]) end)
    end


  def bench(i, n) do
  seq = Enum.map(1..i, fn(_) -> :rand.uniform(i) end)
  list = Enum.reduce(seq, EnvTree.new(), fn(e, list) ->
    EnvTree.add(list, e, :foo) end)
  seq = Enum.map(1..n, fn(_) -> :rand.uniform(i) end)
  {add, _} = :timer.tc(fn() -> Enum.each(seq, fn(e) ->
    EnvTree.add(list, e, :foo)
      end) end)

  {lookup, _} = :timer.tc(fn() ->
        Enum.each(seq, fn(e) ->
          EnvTree.lookup(list, e) end) end)
  {remove, _} = :timer.tc(fn() ->
        Enum.each(seq, fn(e) ->
          EnvTree.remove(list, e) end) end)
  {i, add, lookup, remove}
  end



end

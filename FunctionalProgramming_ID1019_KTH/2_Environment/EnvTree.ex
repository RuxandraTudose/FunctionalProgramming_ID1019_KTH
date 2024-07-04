defmodule EnvTree do
  def new() do :nil end

  def add(:nil, key, value) do {:node,key,value, :nil, :nil} end
  def add({:node, key,_,left, right}, key, value) do {:node, key, value, right, left} end #update old value ass to a given key
  def add({:node, k, v, left, right}, key, value) when key < k do
    {:node, k, v, add(left,key,value),right}
  end
  def add({:node, k, v, left, right}, key, value) when key > k do
    {:node, k, v, left, add(right,key,value)}
  end

  def lookup(:nil, _) do :no end #empty tree - regardless of what you are looking for - missing
  def lookup({:node, key, value, _, _}, key) do {key, value} end
  def lookup({:node, key, value, left, right}, k) when k < key do lookup(left, k) end
  def lookup({:node, key, value, left, right}, k) when k > key do lookup(right, k) end

  #Step 1: Identify the node you want to remove
  def remove(:nil,_) do :nil end
  def remove({:node, key, _, :nil, right},key) do right end #base case node with only right - keep that one
  def remove({:node, key, _, left,:nil},key) do left end #base ---------------------- left - keep that one
  def remove({:node, key, _, left, right},key) do #mathch the key on a node with both branhes
    {key, value, rest} = leftmost(right) #rest pune nodul #rest is a tree
    {:node, key, value, left, rest} #inlocuiesc in argument cu valorile obtinute mai sus pt nodul drept
  end

  #don't match the key cases - choose to go right or left depending on the key
  def remove({:node, k, v, left, right}, key) when key < k do {:node, k, v, remove(left, key), right} end
  def remove({:node, k, v, left, right}, key) do {:node, k, v, left, remove(right, key)} end

  #we know it's not an empty tree
  def leftmost({:node, key, value, nil, rest}) do {key, value, rest} end #basecase - easiest - left modt
  def leftmost({:node, k, v, left, right}) do
    {key, value, rest} = leftmost(left) #remaining tree after removing leftmost
    {key, value, {:node, k, v, rest, right}} #switch nodes - put key first, then k
  end
  #in recursion one step smaller so that I can reach a base case

end

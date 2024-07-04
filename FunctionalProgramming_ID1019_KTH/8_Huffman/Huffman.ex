defmodule Huffman do

  #Huffman compressing - I have to know what I am compressing - I need to know the table in jpeg, GIF, analyze the color frequency
  #Lempel - Ziv - Welch

  def sam() do
    'the quick brown fox jumps over the lazy dog
    this is a sample text that we will use when we build
    up a table we will only handle lower case letters and
    no punctuation symbols the frequency will of course not
    represent english but it is probably not that far off'
  end

  def sample() do
    'AAABC'
  end

  def readfile() do
    {:ok, input} = File.read("kallocain.txt")
    String.to_charlist(input)
  end

  #don't do the inefficient decoding
  def decode(encoded, tree) do decode(encoded, tree, tree) end
  def decode([], _, _) do []end
  def decode([0 | rest], {zero, _}, root) do
    decode(rest, zero, root)
  end

  def decode([1 | rest], {_, one}, root) do
    decode(rest, one, root)
  end

  def decode(encoded, char, root) do
    [char| decode(encoded, root)]
  end

  #encode a text
  def encode([], table) do [] end
  def encode([char | rest], table) do #maybe tail recursive
    case(Map.get(table, char)) do
      nil -> :io.forma("error could not encode ~w\n", [char])
      encode(rest, table)
      seq -> seq ++ encode(rest, table)
    end
  end

  #depth first traversal of the tree
  #create the encoding table
  def encode_table(tree) do
    encode_table(tree, [], %{})
  end

  def encode_table({zero, one}, path, table) do #tree = {zero, one}
    table = encode_table(zero, [0 | path], table)
    encode_table(one, [1 | path], table)
  end

  def encode_table(char, path, table) do #if it is not a tuple, it is a leaf = character
    Map.put(table, char, Enum.reverse(path)) #reverse we go from bottom to top
  end

  def huffman_tree(freq) do
    #sort list on the frequency Enum.sort(freq, fn) give a function to sort on freqs
    freq = Enum.sort(freq, fn({_, f1}, {_, f2}) -> f1 < f2 end)
    huffman(freq)
  end

  def huffman([{tree, _}]) do tree end
  def huffman([{tree1, f1}, {tree2, f2} | rest]) do
    node = {{tree1, tree2} , f1+f2}
    huffman(insert(node, rest))
  end

  def insert(node,[]) do [node] end
  def insert(node1, [node2 | rest] = nodes) do
    if(elem(node1, 1) <= elem(node2, 1)) do
      [node1 | nodes] #insert it as it is
    else
      [node2 | insert(node1, rest)] #put node2 as header and insert node1 upwards
    end
  end

  def freq(sample) do freq(sample, %{}) end
  def freq([], frq) do Map.to_list(frq) end # turn into list
  def freq([char | rest], frq) do
    case(Map.get(frq, char)) do #Map.get returns the value of the associated key in the map
      :nil -> freq(rest, Map.put(frq, char, 1))
      f -> freq(rest, Map.put(frq, char, f+1))
    end
  end
  #build the Huffman tree
  #take the two lowest freq characters - put them in the lower part

  def test() do
    sample = sample()
    freq = freq(sample)
    tree = huffman_tree(freq)
    etable = encode_table(tree)
    #etable
    #text = sample()
    en = encode(sample, etable)
    en
    #decode(en, tree)
  end

  def test1() do
    sample = readfile()
    freq = freq(sample)
    tree = huffman_tree(freq)
    etable = encode_table(tree)
    en = encode(sample, etable)
    #:timer.tc(fn() -> decode(en, tree)end)
    decode(en, tree)

  end
end

#:timer.tc(fn() -&gt; Huffman.test1()end) </pre>
#all characters encoded in UTF-8
#charlist form of strings
#text to charlist

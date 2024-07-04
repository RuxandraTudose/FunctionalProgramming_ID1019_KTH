defmodule Morse do

def decode(msg) do
  tree = tree()
  decode(msg, tree, tree)
end

#special case to eliminate final space in end
def decode([], root, root) do [] end
def decode([], {:node, char, _, _}, _) do [char] end

def decode([?- | rest], {:node, _, long, _}, root) do
  decode(rest, long, root)
end
def decode([?. | rest], {:node, _, _, short}, root) do
  decode(rest, short, root)
end
def decode([?\s | rest], {:node, ch, _, _}, root) do
  [ch | decode(rest, root , root)]
end


def encode(text) do
  tree = tree()
  table = encode_table(tree)
  encode(text, table)
end

#do a depth search in the tree
def encode_table(tree) do encode_table(tree, [], %{}) end
def encode_table(:nil, _, map) do map end #every time you reach an endpoint, return the map - the smallest tree I can encounter

#first case encounter a :na
def encode_table({:node, :na, long, short}, code, map) do #fina a not applicaple case - this is not a character - explore both branches
  map = encode_table(long, [?-| code], map) #update the map
  encode_table(short, [?.|code], map) #when you are done go on the short path
end

#second case encounter a character
def encode_table({:node, ch, long, short}, code, map) do
  map = Map.put(map, ch, Enum.reverse(code))
  map = encode_table(long, [?- | code], map)
  encode_table(short, [?. |code], map)
end

def encode([], _) do [] end
def encode([char | rest], table) do
  code = table[char]
  code ++ [?\s | encode(rest, table)] #not tail recursive
end



def tree do
  {:node, :na,
    {:node, 116,
      {:node, 109,
        {:node, 111,
          {:node, :na, {:node, 48, nil, nil}, {:node, 57, nil, nil}},
          {:node, :na, nil, {:node, 56, nil, {:node, 58, nil, nil}}}},
        {:node, 103,
          {:node, 113, nil, nil},
          {:node, 122,
            {:node, :na, {:node, 44, nil, nil}, nil},
            {:node, 55, nil, nil}}}},
      {:node, 110,
        {:node, 107, {:node, 121, nil, nil}, {:node, 99, nil, nil}},
        {:node, 100,
          {:node, 120, nil, nil},
          {:node, 98, nil, {:node, 54, {:node, 45, nil, nil}, nil}}}}},
    {:node, 101,
      {:node, 97,
        {:node, 119,
          {:node, 106,
            {:node, 49, {:node, 47, nil, nil}, {:node, 61, nil, nil}},
            nil},
          {:node, 112,
            {:node, :na, {:node, 37, nil, nil}, {:node, 64, nil, nil}},
            nil}},
        {:node, 114,
          {:node, :na, nil, {:node, :na, {:node, 46, nil, nil}, nil}},
          {:node, 108, nil, nil}}},
      {:node, 105,
        {:node, 117,
          {:node, 32,
            {:node, 50, nil, nil},
            {:node, :na, nil, {:node, 63, nil, nil}}},
          {:node, 102, nil, nil}},
        {:node, 115,
          {:node, 118, {:node, 51, nil, nil}, nil},
          {:node, 104, {:node, 52, nil, nil}, {:node, 53, nil, nil}}}}}}
end

end

#Step 1: Get a clear picture of a problem
#Step 2: Think of base cases
#Step 3: Don't forget about pattern matching
#Let recursion do its thing
#huffman trees characters in the end only
#in morse code it is trinary -> you need the pause to differentaite between different trees
#in morse you have letters every where
#append costs more it is in the end
#concatenation is less expensive
#a map can use anything as a key

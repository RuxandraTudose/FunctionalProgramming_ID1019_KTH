defmodule Lists do

@type functions() :: list_length([integer()]) :: integer()
                  | sum([integer()]) :: integer()
                  | prod([integer()]) :: integer()
                  | even([integer()]) :: [integer()]
                  | odd([integer()]) :: [integer()]
                  | list_div([integer()], integer()) :: [integer()]
                  | inc([integer()], integer()) :: [integer()]
                  | dec([integer()], integer()) :: [integer()]
                  | mul([integer()], integer()) [integer()]
                  | list_rem([integer()], integer()) :: [integer()]

  def list_length([]) do 0 end
  def list_length([h | t]) do
    1 + list_length(t)
  end

  def sum([]) do 0 end
  def sum([h | t]) do
    h + sum(t)
  end

  def prod([]) do 1 end #not very mathematically compliant but I need a base case
  def prod([h | t]) do
    h * prod(t)
  end

  def even([]) do [] end
  def even([h | t]) do
    case(rem(h,2)) do
      0 -> [h] ++ even(t) #initial mistake - h has to be a list to be appended
      1 -> even(t)
    end
  end

  def odd([]) do [] end
  def odd([h | t]) do
    case(rem(h,2)) do
      0 -> odd(t)
      1 -> [h] ++ odd(t)
    end
  end

  def list_div(_, 0) do :error_division_by_zero end #put this code line first
  def list_div([], _) do [] end
  def list_div([h | t],1) do [h | t] end
  def list_div([h | t], n) do
    case(rem(h,n)) do
      0 -> [h | list_div(t, n)]
      _ -> list_div(t,n)
    end
  end

  def inc([], _) do [] end
  def inc([h | t], 0) do [h | t] end
  def inc([h | t], n) do
    [h + n] ++ inc(t, n)
  end

  def dec([], _) do [] end
  def dec([h | t], 0) do [h | t] end
  def dec([h | t], n) do
    [h - n] ++ dec(t, n)
  end

  def mul([], _) do [] end
  def mul([h | t], 1) do [h | t] end
  def mul([h | t], n) do
    [h * n] ++ mul(t, n)
  end

  def list_rem(_, 0) do :error_division_by_zero end
  def list_rem([], _) do [] end
  def list_rem([h | t], n) do
    [rem(h,n)] ++ list_rem(t, n)
  end

end

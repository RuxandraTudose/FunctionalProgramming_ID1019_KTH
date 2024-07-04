defmodule Higher do
  @type functions() :: map([integer()], ( integer() -> integer())) :: [integer()]
  | reduce([integer()], integer(), (integer(), integer()() -> integer())) :: integer()
  | filter([integer()], (integer() -> boolean())) :: [integer()]


#--------------REDUCE----------------

  def sum (list) do
    reducer(list, 0, fn(x,partial_sum) -> x + partial_sum end)
  end

  def prod(list) do
    reducer(list, 1, fn(x,acc) -> x * acc end)
  end

  def list_length(list) do
    reducer(list, 0, fn(x, acc) -> 1 + acc end)
  end

  def sum_sq(list) do
    reducer(list, 0, fn(x, acc) -> x*x + acc end)
  end

  def reducer([], acc, _) do acc end
  def reducer([h | t], acc, op) do
    op.(h, reducer(t, acc, op))
  end

#--------------REDUCE: TAIL RECURSIVE----------------

  def sumtail(list) do sumtail(list, 0) end
  def sumtail([], y) do y end
  def sumtail([h|t], y) do
    sumtail(t, h + y)
  end

  def prodtail(list) do prodtail(list, 1) end
  def prodtail([], y) do y end
  def prodtail([h|t], y) do
    prodtail(t, h * y)
  end

  def sumt(list) do
    reducel(list, 0, fn(x,y) -> x + y end)
  end

  def prodt(list) do
    reducel(list, 1, fn(x,y) -> x * y end)
  end

  def list_lengtht(list) do
    reducel(list, 0, fn(x, acc) -> 1 + acc end)
  end

  def reducel([], acc, _) do acc end
  def reducel([h|t], acc, op) do
    reducel(t, op.(h,acc), op)
  end

#-----------------MAP-------------------------
  def inc(list, n) do
    map(list, fn(x) -> x + n end)
  end

  def dec(list, n) do
    map(list, fn(x) -> x - n end)
  end

  def mul(list, n) do
    map(list, fn(x) -> x * n end)
  end

  def list_rem(_, 0) do :error_division_by_zero end
  def list_rem(list, n) do
    map(list, fn(x) -> rem(x,n) end)
  end

  def map([],_) do [] end
  def map([h|t], op) do
    [op.(h)] ++ map(t,op)
  end

#----------------FILTER----------------------
  def even(list) do
    filter(list, fn(x) -> case(rem(x,2)) do 0 -> true; 1 -> false end end)
  end

  def odd(list) do
    filter(list, fn(x) -> case(rem(x,2)) do 0 -> false; 1 -> true end end)
  end

  def list_div(_, 0) do :error_division_by_zero end
  def list_div(list, n) do
    filter(list, fn(x) -> case(rem(x,n)) do 0 -> true; _ -> false end end)
  end

  def sum_square(list, n) do
    filter(list, fn(x) -> case(x < n) do true -> true; false -> false end end) |> sum_sq() #use pipe operator
    #alternative:
    #sum_sq(filter(list, fn(x) -> case(x < n) do true -> true; false -> false end end))
  end

  def filter([], _) do [] end
  def filter([h|t], op) do
    case(op.(h)) do
      true -> [h] ++ filter(t, op)
      false -> filter(t, op)
    end
  end

#----------------FILTER: TAIL RECURSIVE---------------------- //three parameters
 def evenl(list) do
  filterl(list, [], fn(x) -> case(rem(x,2)) do 0 -> true; 1 -> false end end)
 end

 def oddl(list) do
  filterl(list, [], fn(x) -> case(rem(x,2)) do 0 -> false; 1 -> true end end)
 end

 def list_divl(_, 0) do :error_division_by_zero end
 def list_divl(list, n) do
   filterl(list,[], fn(x) -> case(rem(x,n)) do 0 -> true; _ -> false end end)
 end

 def filterl([], lst, _) do lst end
 def filterl([h | t], lst, op) do
  case(op.(h)) do
    true -> filterl(t, lst ++ [h], op) #[h] ++ lst != lst ++ [h]
    false -> filterl(t,lst,op)
  end
 end


end

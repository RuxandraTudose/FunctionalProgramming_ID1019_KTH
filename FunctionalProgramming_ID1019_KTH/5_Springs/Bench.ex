defmodule Bench do
  def logs(n) do
    Enum.reduce(1..n,0, fn(n, p) ->  {t, _} = :timer.tc(fn() -> Logs.cut(n + 1, Enum.to_list(1..n))end)
    if(p != 0) do
      :io.format(" n = ~w\t ~w us  (~.2f)\n", [n,t,t/p])
      t
    else :io.format(" n = ~w\t ~w us\n", [n,t])
      t
    end
   end)
  end
end

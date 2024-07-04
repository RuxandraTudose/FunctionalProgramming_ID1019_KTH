defmodule Bench do
  def logs() do
    Enum.reduce(fn(p) ->  {t, _} = :timer.tc(fn() -> Springs_2.readfile()end)
    if(p != 0) do
      :io.format(" n = ~w\t ~w us  (~.2f)\n", [t,t/p])
      t
    else :io.format(" n = ~w\t ~w us\n", [t])
      t
    end
   end)
  end
end

defmodule Test do
  def proc() do
    receive do
      :hello ->
        :io.format("hi\n")
        proc()
      :gurka ->
        :io.format("yes a gurka\n")
         proc()
       strange ->
        :io.format("hmm, strange messages")
        :ok
    end
  end

  def calc(sum) do
    :io.format("sum is ", [sum])
    receive do
      {:add, x} ->
        :io.format("adding", [x])
        calc(sum + x)
      {:sub, x} ->
        :io.format("subtract", [x])
        calc(sum - x)
    end
  end
end

#tail recurisve is important here!!

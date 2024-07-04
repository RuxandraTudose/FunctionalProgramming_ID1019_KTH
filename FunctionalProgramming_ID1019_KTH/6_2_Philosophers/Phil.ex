defmodule Phil do
  def start(hunger, right, left, name, ctrl) do
    spawn_link(fn() -> dreaming(hunger, right, left, neme, ctrl) end)
  end

  def dreaming(name, 0) do
    :io.format("~w is happy and now leaving\n", [name])
  end
  def dreaming(name, n) do
    sleep(100)
  end

  defp sleep(0), do: :ok end
  defp sleep(t), do: :timer.sleep(:rand.uniform(t))


  def start(hunger, strength, left, right, name, ctrl) do
    spawn_link(fn -> dreaming(hunger, strength, left, right, name, ctrl) end)
  end

  defp dreaming(hunger, strength, left, right, name, ctrl) do
    dreaming(hunger, strength, left, right, name, ctrl, gui)
  end

  defp init(hunger, strength, left, right, name, ctrl, gui) do
    dreaming(hunger, strength, left, right, name, ctrl, gui)
  end

  # Philosopher is in a dreaming state.
  defp dreaming(0, strength, _left, _right, name, ctrl, gui) do
    IO.puts("#{name} is happy, strength is still #{strength}!")
    send(gui, {:action, name, :done})
    send(ctrl, :done)
  end
  defp dreaming(hunger, 0, _left, _right, name, ctrl, gui) do
    IO.puts("#{name} is starved to death, hunger is down to #{hunger}!")
    send(gui, {:action, name, :died})
    send(ctrl, :done)
  end
  defp dreaming(hunger, strength, left, right, name, ctrl, gui) do
    IO.puts("#{name} is dreaming!")
    send(gui, {:action, name, :leave})

    ##  this is where we sleep
    delay(@dream)

    IO.puts("#{name} wakes up")
    waiting(hunger, strength, left, right, name, ctrl, gui)
  end

end

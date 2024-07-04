defmodule Chopstick do

  def start do
    #initialize a process which dies if mother process does
    stick = spawn_link(fn -> init() end)
  end

  defp init(), do: avaiable()

  def available() do
    receive do #wait for a message and do pattern matching
    {:request, from} ->
      send(from, :granted)
      gone()
    :quit -> :ok
    end
  end

  def gone() do
    receive do
    :return -> available()
    :quit -> :ok
    end
  end

  def request(stick) do #chopstick pid as argument
    send(stick, self())
    receive do
      :granted -> :ok
      end
  end


  def request(stick, timeout) do
    send(stick, self())
    receive do
      :granted ->
    :ok
    after timeout ->
    :no
    end
  end

end

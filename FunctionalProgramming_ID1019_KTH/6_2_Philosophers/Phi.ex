defmodule Chop do
  def start() do
    spawn_link(fn() -> available() end)
  end

  def available() do
    :io.format("available\n")

    receive do
      {:request, from} ->
        :io.format("received request from ~w\n", [from])
        send(from, :granted)
        gone()
      :quit ->
        :io.format("ohhh nooo\n")
    end
  end

  def gone() do
    :io.format("gone\n")
    receive do #
      :return ->
        :io.format("received return\n")
      available()
      :quit ->
        #:io.format("oh no\n")
        :ok
    end
  end
end

#we are the process
#chopstick is a process
#it is a mutex
#left right the two chopsticks
#strength you give up one when you run out of solutions
#gui process
#strength equal to zero - die
#make a reference to the return message so that we don't mix up
#tag return messages with the same reference
#send request with the unique reference
#have a granted message with this reference use the hat operator
#wait(ref, time) if the ref is not the same ignore granted
#asynchronous message - transmitter and receiver not at the same time
#synchronous - meet at the same time
#-------- major change do it sycnhronously!
#send req then waitfor one of them
#if one req times out, I need to send a retunr for both of them
#show deadlock-free
#back to where we were
#take chopsticks in alphabetic order

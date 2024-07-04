defmodule Foo do

  def start() do
    receive do
      {:hello, x} ->
        IO.puts("wow #{x}")
        start() #recursive
    end
  end
end


"""
TERMINAL COMMANDS
pid = spawn(fn() -> Foo.start() end) //create a process
//now waiting for a message
order of evaluation matters

myPid = self() //my own prcess identifier
receive - indeterministic
message passing: unreliable FIFO
messages come in order not necessarilty consecutive but in order
message that does not match - leave it in queue -> move on to the next (execute)
take a look again at the message you left in queue -> now you can execute it!
every time start from the queue start!
Asynchronous: messages are sent and eventually (hopefully) delvered
implicit deferral!
"""

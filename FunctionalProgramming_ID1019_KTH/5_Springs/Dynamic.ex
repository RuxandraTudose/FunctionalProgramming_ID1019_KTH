defmodule Dynamic do

  def memory(material, time, hinge, latch) do
    mem = Memory.new()
    {solution, _} = search(material, time, hinge, latch, mem)
    solution
  end

  def check(material, time, hinge, latch, mem) do
    case Memory.lookup({material,time}, mem) do
    nil ->
      ## no previous solution found
      {solution, mem} = search(material, time, hinge, latch, mem)
      {solution, Memory.store({material,time}, solution, mem)}
    found ->
      {found, mem}
    end
  end

  def search(m, t, {hm, ht, hp} = h, {lm, lt, lp} = l, mem) when (m >= hm) and
                                                            (t >= ht) and
                                                            (m >= lm) and
                                                            (t >= lt) do
                                                              IO.puts("hello")

    #we have material and time to make either a hinge or a latch
    {hi, li, pi, mem} = check((m-hm), (t-ht), h, l, mem)
    {hj, lj, pj, mem} = check((m-lm), (t-lt), h, l, mem)


    #choose which alternative will give us max profit
    if((pi + hp) > (pj + lp)) do
      {(hi + 1), li, (pi + hp), mem} #make a hinge
    else
      {hj, (lj + 1), (pj + lp), mem} #make a latch
    end
  end

  def search(m, t, {hm, ht, hp} = h, {lm, lt, lp} = l, mem) when (m >= hm) and
                                                            (t >= ht) do
    #we have material only to do a hinge
    Io.puts("hi")
    {hn, ln, p, mem} = check((m-hm), (t-ht), h, l, mem)
    {hn + 1, ln, p + hp, mem}
  end

  def search(m, t, {hm, ht, hp} = h, {lm, lt, lp} = l, mem) when (m >= lm) and
                                                            (t >= lt) do
    #we have material only to do a latch
    IO.puts("hej")
    {hn, ln, p, mem} = check((m-lm), (t-lt), h, l, mem)
    {hn, ln + 1, p + lp, mem}
  end

  def search(_,_,_,_, mem) do
    #no material to either of them
    check(0,0,0,0, mem)
  end
end

#in the process of searching you also remember things

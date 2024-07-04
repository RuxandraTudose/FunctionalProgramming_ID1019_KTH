defmodule Cmplx do

  def new(r,i) do {r, i} end

  def add(a = {r1, i1},b = {r2, i2}) do #add({:cpx, x1,y1}
    {r1+r2, i1+i2}
  end

  def sqr(a = {r, i}) do
    case i do
      0 -> {r*r, 0}
      _ ->{r*r - i*i, 2*r*i}
    end
  end

  def abs(a = {r, i}) do
    :math.sqrt(r*r + i*i)
  end

end

  """
  test(m, _, _, _, _, m) do 0 end
  test  do
    zr2
    sum prod

    a2 < 4

  end

  def mandelbrot_cmplx({:cmpx, cr, ci}, m)
    zr = 0
    zi = 0
    test(0, zr, zi, cr, ci, m)
  end
 """
#no one outside this module knows how to deal with cmplx no
#add :cpx atom to identify number
#in java detect at compile time -> in elxir can't do that -> put atom - error cannot match in elixir (compiler doesn't detect)
#check abs module less than 4 - no root!
#take the C code and put it into the Erlang VM
#take C file - compile obj file -> send into the Erlang VM
#careful with parallel programming - do something sequentila and part parallel
#add process identifier- process crashes - lost forever

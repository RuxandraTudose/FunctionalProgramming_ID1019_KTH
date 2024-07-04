defmodule Brot do
  def mandelbrot(c,m) do
    z0 = Cmplx.new(0,0);
    test(0, z0, c, m)
  end

  def test(i, z0, c, 1) do #range
    if (Cmplx.abs(z0) > 2) do
      i
    else
      0
    end
  end
  def test(i, z0, c, m) do
    if (Cmplx.abs(z0) > 2) do
      i
    else
      test(i + 1, Cmplx.add(Cmplx.sqr(z0),c), c, m-1)
    end
  end
end


#dummy -> generate a zero
#waste time fetching things from memory - checking it is a tuple etc
#arithmetic calc - tidious
#in C it is in registers - Elixir - in memory

defmodule Mandel do

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
    Cmplx.new(x + k * (w - 1), y - k * (h - 1)) #pass on the function to pass on an image point in the complex plane
    end
    rows(width, height, trans, depth, [])
  end

  defp rows(_, 0, _, _, rows), do: rows #height reaches the end
  defp rows(w, h, tr, depth, rows) do #height no of rows start at 540 - generate a row w row start with 960 - up until zero
    row = row(w, h, tr, depth, []) #get ready to append colors
    rows(w, h - 1, tr, depth, [row | rows]) #accumulating parameter tail recursive - reverse? generate them fro upside down
  end

  #w and h x/y coordinates -> compls -> depth -> color conversion ->save color

  defp row(0, _, _, _, row), do: row #width reaches the end
  defp row(w, h, tr, depth, row) do
    c = tr.(w, h)
    res = Brot.mandelbrot(c, depth)
    color = Color.convert(res, depth)
    row(w - 1, h, tr, depth, [color | row]) # go pixel by pixel in a row
  end

#for each row calc pixel - potential for parallelism not too small calculations and not too many parallel things: 1K/2K/10K

"""

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
    Cmplx.new(x + k * (w - 1), y - k * (h - 1)) #pass on the function to pass on an image point in the complex plane
    end
    rows(width, height, trans, depth, []) #same height
    collect(height, [])
  end

  def collect(0, rows) do rows end
  def collect(h, rows) do
    receive do
      {:row, ^h, row} -> collect(h-1, [row|rows])
    end
  end

  def rows(w, h, tr, depth, ctrl) do
    spawn(fn() -> report(w, h, tr, depth, ctrl) end )
    rows(h-1)
  end
"""
end

defmodule IMAG do
  def demo() do
    small(-0.1, 0.7, 0.01)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width # do very little offset between pointa
    img = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", img)
  end

  def large(x0, y0, xn) do
    width = 1920
    height = 1080
    depth = 255
    k = (xn - x0) / width # do very little offset between pointa
    img = Mandel.mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", img)
  end
end

#:timer.tc(fn() -> Test.small() end)

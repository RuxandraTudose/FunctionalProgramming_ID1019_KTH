defmodule Derivative do

  @type literal() :: {:num, number()} #atom() and number() are standard in Elixir
  | {:var, atom()}

  @type expr() :: {:add, expr(), expr()}
  | {:mul, expr(), expr()}
  | literal()
  | {:exp, expr(), literal()}
  | {:ln, expr()}
  | {:sqrt, expr()}
  | {:sin, expr()}
  | {:cos, expr()}
  | {:div, expr(), expr()}
  | {:div, literal(), expr()}

  def test1() do
    e = {:add, {:mul, {:num,2}, {:var, :x}}, {:num, 4}}
    d = deriv(e, :x)
    s = simplify(d)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(s)}\n")
    pprint(s)
  end

  def test2() do
    f = {:add, {:mul, {:num,2}, {:exp, {:var, :x}, {:num, 2}}}, {:mul, {:num, 4}, {:var, :x}}}
    g = deriv(f, :x)
    h = simplify(g)
    IO.write("expression: #{pprint(f)}\n")
    #IO.write("derivative: #{pprint(g)}\n")
    #IO.write("simplified: #{pprint(h)}\n")
    pprint(h)
  end


  def test3() do
    e = {:add, {:add, {:mul, {:num, 3},{:exp, {:var,:x}, {:num, 2}}}, {:mul, {:num, 5}, {:var, :x}}}, {:num, 3}}
    d = deriv(e, :x)
    f = simplify(d)
    IO.write("expression: #{pprint(e)} \n")
    IO.write("derivative: #{pprint(d)} \n")
    IO.write("simplified: #{pprint(f)} \n")
    pprint(f)
  end

  def test4() do
    e = {:exp, {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 3}}, {:num, 4}}
    d = deriv(e, :x)
    f = simplify(d)
    IO.write("expression: #{pprint(e)} \n")
    IO.write("derivative: #{pprint(d)} \n")
    IO.write("simplified: #{pprint(f)} \n")
    pprint(f)
  end

  def test5() do
    e = {:ln, {:exp, {:add, {:mul, {:num, 5},{:var, :x}}, {:num, 3}}, {:num, 3}}}
    #e = {:ln, {:add, {:mul, {:num, 7}, {:exp, :x, {:num, 2}}, {:num, 3}}}}
    d = deriv(e, :x)
    f = simplify(d)
    IO.write("expression: #{pprint(e)} \n")
    IO.write("derivative: #{pprint(d)} \n")
    IO.write("simplified: #{pprint(f)} \n")
    pprint(f)
  end


  # !!!!!!!!!!
  def test6() do
    #e = {:sqrt, {:add,{:var, :x}, {:num, 3}}}
    e = {:sqrt, {:add,{:exp, {:var, :x},{:num, 2}}, {:num, 3}}}
    d = deriv(e, :x)
    #f = simplify(d)
    IO.write("expression: #{pprint(e)} \n")
    IO.write("derivative: #{pprint(d)} \n")
    #IO.write("simplified: #{pprint(f)} \n")
    #pprint(f)
  end

  def test7() do
    #e = {:sin, {:mul, {:num, 3}, {:var, :x}}}
    e = {:exp, {:sin, {:mul, {:num, 3}, {:var, :x}}}, {:num, 2}}
    d = deriv(e, :x)
    f = simplify(d)
    IO.write("expression: #{pprint(e)} \n")
    IO.write("derivative: #{pprint(d)} \n")
    IO.write("simplified: #{pprint(f)} \n")
    #pprint(f)
    simplify(d)
  end

  def test8() do
    e = {:div, {:num, 1}, {:sin, {:mul, {:num, 2}, {:var, :x}}}} #!!!!!!
    #e = {:div, {:num, 1}, {:ln, {:exp, {:mul, {:num, 2}, {:var, x}}, {:num, 2}}}}
    d = deriv(e, :x)
    f = simplify(d)
    IO.write("expression: #{pprint(e)} \n")
    IO.write("derivative: #{pprint(d)} \n")
    IO.write("simplified: #{pprint(f)} \n")
    pprint(f)
  end

  def test9() do
    e = {:sin, {:add, {:add, {:mul, {:num, 3}, {:exp, {:var, :x}, {:num, 2}}}, {:var,:x}}, {:num, 13}}}
    d = deriv(e, :x)
    f = simplify(d)
    IO.write("expression: #{pprint(e)} \n")
    IO.write("derivative: #{pprint(d)} \n")
    IO.write("simplified: #{pprint(f)} \n")
    pprint(f)
  end

  #{:mul, {:mul, {:num, 2}, {:sin, {:mul, {:num, 3}, {:var, :x}}}}, {:mul, {:cos, {:mul, {:num, 3}, {:var, :x}}}, {:num, 3}}}


  def deriv({:num, _},_) do {:num, 0} end #second parameter - what you derive over
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end
  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1, v), deriv(e2,v)}
  end

  def deriv({:mul, e1, e2}, v) do
    {:add ,
      {:mul, deriv(e1,v), e2},
      {:mul, deriv(e2,v), e1}}
  end

  def deriv({:exp, e, {:num, n}},v) do
    {:mul, {:mul, {:num, n}, {:exp, e, {:num, n-1}}}, deriv(e,v)}
  end

  def deriv({:ln, e},v) do
    {:div, deriv(e,v), e}
    #{:mul, {:exp, e, {:num, -1}}, deriv(e,v)} - gave up the alternative of negative power
  end

  def deriv({:sqrt, e}, v) do
    {:div, {deriv(e,v)}, {:mul, {:num, 2}, {:sqrt, e}}}
    #{:mul, {:mul, {:num, 2}, {:exp, e, {:exp, {:num, -2}, {:num, -1}}}}, deriv(e,v)}
  end

  def deriv({:sin, e},v) do
    {:mul, {:cos, e}, deriv(e,v)}
  end

  def deriv({:div, {:num, 1}, e}, v) do
    {:div, {:mul, {:num, -1}, deriv(e,v)}, {:exp, e, {:num, 2}}}
  end


  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1,e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({{:add, e1,e2}}) do "(#{pprint(e1)} + #{pprint(e2)})" end #!!!!!!!!!!!!!!!!!!!!
  def pprint({:mul, e1,e2}) do "(#{pprint(e1)} * #{pprint(e2)})" end
  def pprint({:exp, e1, e2}) do "(#{pprint(e1)}^(#{pprint(e2)}))" end
  def pprint({:ln, e}) do "ln(#{pprint(e)})" end
  def pprint({:sqrt, e}) do "sqrt(#{pprint(e)})" end
  def pprint({:sin, e}) do "sin(#{pprint(e)})" end
  def pprint({:cos, e}) do "cos(#{pprint(e)})" end
  def pprint({:div, e1, e2}) do "(#{pprint(e1)})/(#{pprint(e2)})" end

  def simplify({:num, n}) do {:num, n} end #can't simplify a number
  def simplify({:var, v}) do {:var, v} end #can't simplify a variable
  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1),simplify(e2))
  end

  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1),simplify(e2))
  end

  def simplify({:cos, e1}) do
      {:cos, simplify(e1)}
  end

  def simplify({:sin, e1}) do
    {:sin, simplify(e1)}
  end

  def simplify({:div, e1, e2}) do
    {:div, simplify(e1), simplify(e2)}
  end

  def simplify({:ln, e1}) do
    {:ln, simplify(e1)}
  end

  def simplify({:sqrt, e1}) do
    {:sqrt, simplify(e1)}
  end


  def simplify_add({:num, 0}, e1) do e1 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add({:num, e1}, {:num, e2}) do {:num, e1+e2} end
  def simplify_add(e1, e2) do {:add, e1,e2} end

  def simplify_mul({:num, 1}, e1) do e1 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num,0} end
  def simplify_mul({:num, e1}, {:num, e2}) do {:num, e1*e2} end

  def simplify_mul({:num, n1}, {:mul, {:num, n2}, e2}) do {:mul, {:num, n1*n2}, e2} end
  def simplify_mul({:num, n1}, {:mul, e1, {:num, n2}}) do {:mul, {:num, n1*n2}, e1} end
  def simplify_mul({:mul, {:num, n2}, e2}, {:num, n1}) do {:mul, {:num, n1*n2}, e2} end
  def simplify_mul({:mul, e1, {:num, n2}}, {:num, n1}) do {:mul, {:num, n1*n2}, e1} end
  def simplify_mul(e1, e2) do {:mul, e1,e2} end


  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1),simplify(e2))
  end

  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp({:num, 0}, _) do {:num, 0} end
  def simplify_exp({:num, 1}, _) do {:num, 1} end
  def simplify_exp({:num, e1}, {:num, e2}) do :math.pow(e1,e2) end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end

end

defmodule Evaluate do

  @type literal() :: {:num, number()}
    | {:var, atom()}
    | {:q, number(), number()}

  @type expr() :: {:add, expr(), expr()}
              | {:sub, expr(), expr()}
              | {:mul, expr(), expr()}
              | {:div, expr(), expr()}
              | literal()

  def create_env() do
    env = EnvList.new()
    env = EnvList.add(env, :x, {:q, 12, 4})
    env = EnvList.add(env, :y, {:num, 1})
    env = EnvList.add(env, :z, {:num, 7})
    env = EnvList.add(env, :w, {:num, 5})
   #eval({:add, {:num, 1}, {:q, 13, 4}}, env)
   #eval({:add, {:var, :x}, {:var, :y}}, env)
   #eval({:mul, {:num, 5},{:mul, {:var, :x}, {:var, :y}}}, env)
   #eval({:div, {:var, :x}, {:var, :y}}, env)
   eval({:add, {:add, {:div, {:num, 2}, {:var, :x}}, {:num, 3}}, {:q, 1,2}}, env)
   eval({:sub, {:var, :x}, {:num, 2}}, env)

  end

  def eval({:num, n}, _) do {:q, n, 1} end
  def eval({:q, a, b}, _) do {:q, a, b} end
  def eval({:var, v}, env) do
    case (EnvList.lookup(env, v)) do
      :nil -> :error
      {_, n} -> eval(n, env)
    end
  end


  def eval({:add, e1, e2}, env) do
    case(eval(e1, env)) do
      {:q, _, _} ->
        case(eval(e2, env)) do
          {:q, _, _} -> add(eval(e1, env), eval(e2, env))
          :error -> :error
        end
      :error -> :error
    end
  end

  def add({:q, a, b},{:q, c, d}) do
    simplify({:q, a*d + b*c, b*d})
  end

  def eval({:mul, e1, e2}, env) do
    case(eval(e1, env)) do
      {:q, _, _} ->
        case(eval(e2, env)) do
          {:q, _, _} -> mul(eval(e1, env), eval(e2, env))
          :error -> :error
        end
      :error -> :error
    end
  end

  def mul({:q, a, b},{:q, c, d}) do
    simplify({:q, a*c, b*d})
  end

  def eval({:sub, e1, e2}, env) do
    case(eval(e1, env)) do
      {:q, _, _} ->
        case(eval(e2, env)) do
          {:q, _, _} -> sub(eval(e1, env), eval(e2, env))
          :error -> :error
        end
      :error -> :error
    end
  end

  def sub({:q, a, b},{:q, c, d}) do
    simplify({:q, a*d - b*c, b*d})
  end

  def eval({:div, e1, e2}, env) do
    case(eval(e1, env)) do
      {:q, _, _} ->
        case(eval(e2, env)) do
          {:q, _, _} -> divide(eval(e1, env), eval(e2, env))
          :error -> :error
        end
      :error -> :error
    end
  end

  def divide({:q, a, b},{:q, c, d}) do
    simplify({:q, a*d, b*c})
  end


  def simplify({:q, n, d}) do
    gcd = Integer.gcd(n,d)
    {:q, div(n,gcd), div(d,gcd)}
  end

end

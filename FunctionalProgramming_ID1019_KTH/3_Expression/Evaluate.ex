defmodule Evaluate do

  @type literal() :: {:num, number()}
    | {:var, atom()}
    | {:q, number(), number()}

  @type expr() :: {:add, expr(), expr()}
              | {:sub, expr(), expr()}
              | {:mul, expr(), expr()}
              | {:div, expr(), expr()}
              |literal()

  def create_env() do
    env = EnvList.new()
    env = EnvList.add(env, :x, 12)
    env = EnvList.add(env, :y, 15)
  end

end

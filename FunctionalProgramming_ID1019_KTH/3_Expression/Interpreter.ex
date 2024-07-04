f = fn(x) -> {x, :b} end; f.(:a)

no patterns for fn(x) do it with a case statement


//cons, case, apply
 [{:match, {:var, :f}, ???}, {:apply, {:var, :f}, [:atm, :a]}]
 {:apply, expr(), [expr()]}

 ...... ; ......... ; {...} #sequence

 {:lambda, [:x], [:y], [{:cons, {:var, :x}, {:var, :y}}]} #second one variable identifier


y = 10
f = fn(x) -> y + x end make a choice put

closure - fct + environment where the function was created

def eval_expr ({:lambda, par, free, seq}, env) do
  {:closure, par, seq }
end

add all variables to the closure (parameters and arguments)
eval_args - add all list's elements
not the same number of args and

def add_all(_,_,_) do :error

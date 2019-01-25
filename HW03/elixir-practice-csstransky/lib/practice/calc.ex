defmodule Practice.Calc do

  def parse_float(text) do
    try do
      {num, _} = Float.parse(text)
      num
    rescue
      MatchError -> nil
    end
  end

  def tag_tokens(expr, list) when expr == [] do
    list
  end

  def tag_tokens(expr_list, list) do
    [head | tail] = expr_list
    if is_float(parse_float(head)) do
      tag_tokens(tail, list ++ [num: head])
    else 
      tag_tokens(tail, list ++ [op: head])
    end
  end

  def is_lower_operator(comp_op, stack_op) do
    # Maybe I could do something with ASCII values, or use a switch case, but
    # this quick boolean statement works (not for anything complicated though)
    (stack_op == "*" || stack_op == "/") && (comp_op == "+" || comp_op == "-")
  end

  def conv_postfix(expr_list, op_stack, postfix_list) when expr_list == [] do
    postfix_list ++ op_stack
  end
  
  def conv_postfix(expr_list, op_stack, postfix_list) do

    [head | tail] = expr_list
    head_key = elem(head, 0)
    head_value = elem(head, 1)

    cond do
      head_key == :op ->
        last_stack_op = List.last(op_stack)
        if is_lower_operator(head_value, last_stack_op) do
          conv_postfix(tail, [head_value], postfix_list ++ op_stack)
        else
          conv_postfix(tail, [head_value] ++ op_stack, postfix_list)
        end 

      head_key == :num ->
        conv_postfix(tail, op_stack, postfix_list ++ [head_value])

      true ->
        raise "One of the values entered was not a simple operator or number."
    end 
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    # TODO Actually get this calculator function working
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens([])  
    |> conv_postfix([],[])
    #|> hd
    #|> parse_float
    #|> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end
end

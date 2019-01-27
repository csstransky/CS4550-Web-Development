defmodule Practice.Calc do

  def parse_float(text) do
    try do
      {num, _} = Float.parse(text)
      num
    rescue
      MatchError -> nil
    end
  end

  def tag_tokens(expr) do
    tag_tokens(expr, [])
  end

  def tag_tokens(expr, list) when expr == [] do
    list
  end

  def tag_tokens(expr, list) do
    [head | tail] = expr
    if is_float(parse_float(head)) do
      tag_tokens(tail, list ++ [num: head])
    else 
      tag_tokens(tail, list ++ [op: head])
    end
  end

  def set_op_rank(operator) do
    # Possible to add the rest of PEMDAS here in the future too
    cond do
      operator == "*" || operator == "/" ->
        2
      operator == "+" || operator == "-" ->
        1
      true ->
        -1
    end
  end

  def is_lower_operator(comp_op, stack_op) do
    comp_op = set_op_rank(comp_op)
    stack_op = set_op_rank(stack_op)
    comp_op <= stack_op  
  end

  def conv_postfix(expr_list) do
    conv_postfix(expr_list, [], [])
  end

  def conv_postfix(expr_list, op_stack, postfix_list) when expr_list == [] do
    postfix_list ++ op_stack
  end
  
  def conv_postfix(expr_list, op_stack, postfix_list) do
 
    [expr_head | expr_tail] = expr_list
    expr_head_key = elem(expr_head, 0)
    expr_head_value = elem(expr_head, 1)

    cond do
      expr_head_key == :op ->
        op_head = List.first(op_stack)
        if is_lower_operator(expr_head_value, op_head) do 
          # Have to do this because Elixir can't handle empty lists doing "tl"
          if tl(op_stack) == nil do
            conv_postfix(expr_tail, [expr_head_value], postfix_list ++ [op_head])
          else
            conv_postfix(expr_tail, [expr_head_value] ++ tl(op_stack), postfix_list ++ [op_head])
          end
        else
          conv_postfix(expr_tail, [expr_head_value] ++ op_stack, postfix_list)
        end 

      expr_head_key == :num ->
        conv_postfix(expr_tail, op_stack, postfix_list ++ [expr_head_value])

      true ->
        raise "One of the values entered was not a simple operator or number."
    end 
  end

  def eval_postfix(post_list) do
    eval_postfix(post_list, [])
  end
 
  def eval_postfix(post_list, num_stack) when post_list == [] do
    hd(num_stack)
  end
 
  def eval_postfix(post_list, num_stack) do
    [post_head | post_tail] = post_list
    if is_float(parse_float(post_head)) do
      eval_postfix(post_tail, [parse_float(post_head)] ++ num_stack)
    else
      [num_head1 | num_tail1] = num_stack
      [num_head2 | num_tail2] = num_tail1
      eval_ans = eval(post_head, num_head2, num_head1)
      eval_postfix(post_tail, [eval_ans] ++ num_tail2)
    end
  end

  def eval(operator, num1, num2) do
    cond do
      operator == "+" ->
        num1 + num2
      operator == "-" ->
        num1 - num2
      operator == "*" ->
        num1 * num2
      operator == "/" ->
        num1 / num2  
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    # Provided function that'll take "1 + 2 * 3" into ["1", "+", "2", "*", "3"]
    |> String.split(~r/\s+/)
    # Creates tuples like: [num: "1", op: "+", num: "2", op: "*", num: "3"]
    |> tag_tokens
    # Converts into postfix for easy manipulation: ["1", "2", "3", "*", "+"]
    |> conv_postfix
    # Decided to just eval using postfix from here to get the answer: 7.0
    |> eval_postfix
  end
end

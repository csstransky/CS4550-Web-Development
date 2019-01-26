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

  def conv_postfix(expr_list) do
    conv_postfix(expr_list, [], [])
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

  def postfix_to_prefix(post_list) do
    postfix_to_prefix(post_list, [])
  end
  
  def postfix_to_prefix(post_list, pre_stack) when post_list == [] do
    List.flatten(pre_stack)
  end

  def postfix_to_prefix(post_list, pre_stack) do

    [post_head | post_tail] = post_list
    if is_float(parse_float(post_head)) do
      postfix_to_prefix(post_tail, [post_head] ++ pre_stack)
    else
      [pre_head1 | pre_tail1] = pre_stack
      [pre_head2 | pre_tail2] = pre_tail1
      temp_expr = [post_head] ++ [pre_head2] ++ [pre_head1]

      postfix_to_prefix(post_tail, [temp_expr] ++ pre_tail2) 
    end
  end

  def eval_prefix(pre_list) do
    eval_prefix(pre_list, [])
  end

  def eval_prefix(pre_list, num_stack) when pre_list == [] do
    IO.puts "Stick the LANDING"
    num_stack
  end

  def eval_prefix(pre_list, num_stack) do
    IO.puts "Stack it up my firend"
    IO.puts inspect(pre_list)
    IO.puts inspect(num_stack)
    [pre_head | pre_tail] = pre_list
    if is_float(parse_float(pre_head)) do
      IO.puts "I am number"
      IO.puts parse_float(pre_head)
      eval_prefix(pre_tail, [parse_float(pre_head)] ++ num_stack)
    else
      IO.puts "I am operator"
      IO.puts inspect(pre_head)
      [num_head1 | num_tail1] = num_stack
      [num_head2 | num_tail2] = num_tail1
      eval_ans = eval(pre_head, num_head1, num_head2)

      IO.puts inspect(num_head1)
      IO.puts inspect(num_head2)
      IO.puts inspect(eval_ans)
    
      postfix_to_prefix(pre_tail, [eval_ans] ++ num_tail2)       
    end
  end

  def eval_postfix(post_list) do
    eval_postfix(post_list, [])
  end
 
  def eval_postfix(post_list, num_stack) when post_list == [] do
    IO.puts inspect(num_stack)
    hd(num_stack)
  end
 
  def eval_postfix(post_list, num_stack) do
    IO.puts "Just fhjfck"
    IO.puts inspect(post_list)
    IO.puts inspect(num_stack)
    [post_head | post_tail] = post_list
    if is_float(parse_float(post_head)) do
      eval_postfix(post_tail, [parse_float(post_head)] ++ num_stack)
    else
      [num_head1 | num_tail1] = num_stack
      [num_head2 | num_tail2] = num_tail1
      eval_ans = eval(post_head, num_head2, num_head1)
      IO.puts "Anser right?"
      IO.puts eval_ans
      eval_postfix(post_tail, [eval_ans] ++ num_tail2)
    end
  end

  def eval(operator, num1, num2) do
    IO.puts "Eval"
    IO.puts num1
    IO.puts operator
    IO.puts num2
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
    # TODO Actually get this calculator function working
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> conv_postfix
    #|> eval_postfix
    #|> postfix_to_prefix
    #|> eval_prefix
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

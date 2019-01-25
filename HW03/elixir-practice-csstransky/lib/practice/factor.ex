defmodule Practice.Factor do
  def parse_integer(x) do
    {num, _} = Integer.parse(x)
    num
  end

  ### From this moment on, "d" will be the current divider to be tried

  # Returns the list once the divider has gotten so large, there are no more 
  # prime factors to be found.
  def divide(x, d, list) when x < d*d do
    list
  end

  # Found the last prime to be factored
  def divide(x, d, list) when x == d*d do
    [d | list]
  end

  # Found a prime factor, adds to list, then keeps looking
  def divide(x, d, list) when rem(x, d) == 0 do
    # rem and div are special Elixir functions that uses integer math
    divide(x, d + 1, [d, div(x, d) | list])
  end

  # No prime factor found, tries next divider
  def divide(x, d, list) do
    divide(x, d + 1, list)
  end

  def primes(x) do
    # TODO: Make it so you only prime the first number, so parse the "x", and
    # then only use the first element
    divide(x, 1, [])
    |> Enum.sort
  end
end

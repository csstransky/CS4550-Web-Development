defmodule Practice.Factor do
  def parse_integer(x) do
    {num, _} = Integer.parse(x)
    num
  end

  # Returns a list of prime factors for the given "x": 12 = [2, 2, 3]
  def primes(x) do
    # TODO: Make it so you only prime the first number, so parse the "x", and
    # then only use the first element
    primes(x, 2, [])
    |> Enum.sort
  end

  ### From this moment on, "d" will be the current divider to be tried

  # All prime factors have been found, returning the list
  def primes(x, d, list) when x < d*d do
    [x | list]
  end

  # Found a prime factor, adds to list, then keeps looking
  def primes(x, d, list) when rem(x, d) == 0 do
    # rem and div are special Elixir functions that uses integer math
    primes(div(x, d), d, [d | list])
  end

  # No primes factor found, trying next divider
  def primes(x, d, list) do
    primes(x, d + 1, list)
  end
end

defmodule Practice.Factor do

  def parse_integer(text) do
    try do
      if is_integer(text) do
        text
      else
        {num, _} = Integer.parse(text)
        num
      end
    rescue
      MatchError -> 0
    end
  end

  
  # Returns a list of prime factors for the given "x": 12 = [2, 2, 3]
  def primes(x) do
    x
    |> parse_integer
    |> primes(2,[])
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

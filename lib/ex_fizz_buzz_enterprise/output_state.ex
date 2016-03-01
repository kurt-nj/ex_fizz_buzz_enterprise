defmodule ExFizzBuzzEnterprise.OutputState do
  defstruct [fizz_mod: 3, buzz_mod: 5]
  
  def fizzing?(state, number) do
    rem(number, state.fizz_mod) == 0
  end
  
  def buzzing?(state, number) do
    rem(number, state.buzz_mod) == 0
  end
  
  def to_string(state, number) do
    cond do
      fizzing?(state, number) && buzzing?(state, number) -> "FIZZBUZZ"
      fizzing?(state, number) -> "FIZZ"
      buzzing?(state, number) -> "BUZZ"
      true -> Integer.to_string(number)
    end
  end
  
end
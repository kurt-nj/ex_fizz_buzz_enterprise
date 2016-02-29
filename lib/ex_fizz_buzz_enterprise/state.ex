defmodule ExFizzBuzzEnterprise.State do
  defstruct [:current_number, :fizz_mod, :buzz_mod]
  
  def fizzing?(state) do
    rem(state.current_number, state.fizz_mod) == 0
  end
  
  def buzzing?(state) do
    rem(state.current_number, state.buzz_mod) == 0
  end
  
  def to_string(state) do
    cond do
      fizzing?(state) && buzzing?(state) -> "FIZZBUZZ"
      fizzing?(state) -> "FIZZ"
      buzzing?(state) -> "BUZZ"
      true -> Integer.to_string(state.current_number)
    end
  end
  
  def iterate(state) do
    %ExFizzBuzzEnterprise.State {
      current_number: state.current_number+1, 
      fizz_mod: state.fizz_mod, buzz_mod: 
      state.buzz_mod }
  end
  
end
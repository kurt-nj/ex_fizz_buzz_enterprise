defmodule ExFizzBuzzEnterprise.Worker do
  use GenServer
  require Logger
    
  def start_link(start_value) do
    GenServer.start_link(__MODULE__, 
      %ExFizzBuzzEnterprise.State{
        current_number: start_value, 
        fizz_mod: 3, 
        buzz_mod: 5}, 
      name: __MODULE__)
  end
  
  def next do
    GenServer.call(__MODULE__, :next)
  end
  
  def handle_call(:next, _from, current_state) do
    Logger.info ExFizzBuzzEnterprise.State.to_string(current_state)
    {:reply, current_state.current_number, ExFizzBuzzEnterprise.State.iterate(current_state)}
  end
  
end
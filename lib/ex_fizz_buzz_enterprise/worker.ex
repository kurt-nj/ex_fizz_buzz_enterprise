defmodule ExFizzBuzzEnterprise.Worker do
  use GenServer
  require Logger
  
   @delay 500 # msec
    
  def start_link do
    Logger.debug "Worker Starting"
    
    GenServer.start_link(__MODULE__, 
      %ExFizzBuzzEnterprise.State{
        current_number: 0, 
        fizz_mod: 3, 
        buzz_mod: 5}, 
      name: __MODULE__)
  end
  
  def init(args) do
    Logger.debug "Worker Initializing"
    Process.send_after(self, :next, @delay)
    {:ok, args}
  end
  
  def next do
    GenServer.call(__MODULE__, :next)
  end
  
  def handle_info(:next, state) do
    Logger.info ExFizzBuzzEnterprise.State.to_string(state)
    Process.send_after(self, :execute, @delay)
    {:noreply, ExFizzBuzzEnterprise.State.iterate(state)}
  end
  
end
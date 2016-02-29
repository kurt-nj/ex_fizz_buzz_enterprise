defmodule ExFizzBuzzEnterprise.InputWorker do
  use GenServer
  require Logger
  
   @delay 500 # msec
    
  def start_link do
    Logger.debug "Input Worker Starting"
    
    GenServer.start_link(__MODULE__, 
      %ExFizzBuzzEnterprise.InputState{}, 
      name: __MODULE__)
  end
  
  def init(args) do
    Logger.debug "Input Worker Initializing"
    execute
    {:ok, args}
  end
  
  def execute do
    GenServer.cast(__MODULE__, :next)
  end
  
  def handle_cast(:next, state) do
    ExFizzBuzzEnterprise.OutputWorker.output(state.current_num)
    {:noreply, ExFizzBuzzEnterprise.InputState.iterate(state), @delay}
  end
  
  def handle_info(:timeout, state) do
    execute
    {:noreply, state}
  end
  
end
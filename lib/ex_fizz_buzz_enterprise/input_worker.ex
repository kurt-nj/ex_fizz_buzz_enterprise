defmodule ExFizzBuzzEnterprise.InputWorker do
  use GenServer
  require Logger
  
   @delay 400 # msec
    
  def start_link do
    Logger.debug "Input Worker Starting"
    
    GenServer.start_link(__MODULE__, 
      %ExFizzBuzzEnterprise.InputState{}, 
      name: __MODULE__)
  end
  
  def init(args) do
    Logger.debug "Input Worker Initializing"
    #execute
    {:ok, args}
  end
  
  def execute do
    GenServer.cast(__MODULE__, :next)
  end
  
  def update(state) do
    GenServer.call(__MODULE__, {:update, state})
  end
  
  def handle_call({:update, state}, _from, _old_state) do
    {:reply, state, state}
  end
  
  def handle_cast(:next, state) do
    ExFizzBuzzEnterprise.OutputWorker.output(state.current_num)
    {:noreply, ExFizzBuzzEnterprise.InputState.iterate(state), @delay}
  end
  
  def handle_info(:timeout, state) do
    # continue re-executing until we hit our end state
    if !ExFizzBuzzEnterprise.InputState.done?(state) do 
      execute
    end
    {:noreply, state}
  end
  
end
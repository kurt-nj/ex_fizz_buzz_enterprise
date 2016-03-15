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
  
  def start_sequence do
    GenServer.cast(__MODULE__, :iterate)
  end
  
  def reset(start_val, end_val) do
    GenServer.call(__MODULE__, { :reset, 
      %ExFizzBuzzEnterprise.InputState
      {
          start_num: start_val, 
          current_num: start_val, 
          end_num: end_val
      }})
  end
  
  def reset() do
    GenServer.call(__MODULE__, { :reset, 
      %ExFizzBuzzEnterprise.InputState{}})
  end
  
  def handle_call({:reset, state}, _from, _old_state) do
    {:reply, state, state}
  end
  
  def handle_cast(:iterate, state) do
    ExFizzBuzzEnterprise.OutputWorker.output(state.current_num)
    {:noreply, ExFizzBuzzEnterprise.InputState.iterate(state), @delay}
  end
  
  def handle_info(:timeout, state) do
    # continue re-executing until we hit our end state
    if !ExFizzBuzzEnterprise.InputState.done?(state) do 
      start_sequence
    end
    {:noreply, state}
  end
  
end
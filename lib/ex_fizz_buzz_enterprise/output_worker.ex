defmodule ExFizzBuzzEnterprise.OutputWorker do
  use GenServer
  require Logger
  
  def start_link do
    Logger.debug "Output Worker Starting"
    
    GenServer.start_link(__MODULE__, 
      %ExFizzBuzzEnterprise.OutputState{}, 
      name: __MODULE__)
  end
  
  def init(args) do
    Logger.debug "Output Worker Initializing"
    {:ok, args}
  end
  
  def output(number) do
    GenServer.call(__MODULE__, {:output, number})
  end
  
  def handle_call({:output, number}, _from, state) do
    
    # pipes because we can
    state
    |> ExFizzBuzzEnterprise.OutputState.to_string(number)
    |> Logger.info

    {:reply, number, state}
  end
  
end
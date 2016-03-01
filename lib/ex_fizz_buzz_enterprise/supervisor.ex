defmodule ExFizzBuzzEnterprise.Supervisor do
  use Supervisor
  require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    Logger.debug "Supervisor Initializing"
    
    children = [
      worker(ExFizzBuzzEnterprise.InputWorker, [], id: ExFizzBuzzEnterprise.InputWorker),
      worker(ExFizzBuzzEnterprise.OutputWorker, [], id: ExFizzBuzzEnterprise.OutputWorker),
      worker(__MODULE__, [], function: :run)  
    ]
    supervise(children, strategy: :one_for_one)
  end
  
  def run do
   { :ok, _ } = Plug.Adapters.Cowboy.http ExFizzBuzzEnterprise.Router, []
  end
  
end
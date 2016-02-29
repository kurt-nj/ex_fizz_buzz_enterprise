defmodule ExFizzBuzzEnterprise.Supervisor do
  use Supervisor
  require Logger

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    Logger.debug "Supervisor Initializing"
    
    children = [
      worker(ExFizzBuzzEnterprise.Worker, [], id: ExFizzBuzzEnterprise.Worker)
    ]
    supervise(children, strategy: :one_for_one)
  end
  
  
end
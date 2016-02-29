defmodule ExFizzBuzzEnterprise do
  use Application
  
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    children = [
      worker(ExFizzBuzzEnterprise.Worker, 0)
    ]
    opts = [strategy: :one_for_one, name: ExFizzBuzzEnterprise.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

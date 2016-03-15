defmodule ExFizzBuzzEnterprise do
  use Application
  require Logger
  
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    Logger.debug "Application Starting"
    ExFizzBuzzEnterprise.Supervisor.start_link
  end
  
end

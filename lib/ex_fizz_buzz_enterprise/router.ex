defmodule ExFizzBuzzEnterprise.Router do
  use Plug.Router
  
  if Mix.env == :dev do
    use Plug.Debugger
  end

  plug :match
  plug :dispatch

  # Root path
  get "/" do
    send_resp(conn, 200, "Welcome to FizzBuzz! Would you like to Fizz and/or Buzz today?")
  end
  
  get "/fizzbuzz" do
    ExFizzBuzzEnterprise.InputWorker.update(%ExFizzBuzzEnterprise.InputState{})
    ExFizzBuzzEnterprise.InputWorker.execute
    send_resp(conn, 200, "FizzBuzzing has commenced!")
  end
  
  get "/fizzbuzz/:start_val/:end_val" do
    ExFizzBuzzEnterprise.InputWorker.update(%ExFizzBuzzEnterprise.InputState{
      start_num: String.to_integer(start_val), 
      current_num: String.to_integer(start_val), 
      end_num: String.to_integer(end_val)})
    ExFizzBuzzEnterprise.InputWorker.execute
    send_resp(conn, 200, "FizzBuzzing between #{start_val} and #{end_val} has commenced!")
  end
end
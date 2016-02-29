defmodule ExFizzBuzzEnterprise.InputState do
  defstruct [start_num: 0, current_num: 0, end_num: 100]
  
  def done?(state) do
    state.current >= state.end
  end
  
  def iterate(state) do
    %ExFizzBuzzEnterprise.InputState {
      start_num: state.start_num,
      current_num: state.current_num+1, 
      end_num: state.end_num }
  end
  
end
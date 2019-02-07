defmodule Memory.GameServer do
  use GenServer

  # TODO: Create a gen server module along with supervisor
  # def start_link(name, game) do
  #   game = BackupAgent.get(name) || Game.reset()
  #   GenServer.start_link(__MODULE__, game, name)
  # end
  #
  # def push(name, item) do
  #   GenServer.call(reg(name), {:push, item})
  # end
  #
  # def init(state) do
  #   # Creates an even elem
  #   Process.send_after(self(), :next_even, 5_000)
  #   {:ok, state}
  # end
  #
  # def handle_call({:push, item}, _from, state) do
  #   {:reply,  :ok, [item | state]}
  # end
  ## I copied code from Nat's Stack 3 in Lecture Notes
end

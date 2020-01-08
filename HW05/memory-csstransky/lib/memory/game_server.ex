defmodule Memory.GameServer do
  use GenServer

  alias Memory.Game
  alias Memory.BackupAgent

  def reg(name) do
    {:via, Registry, {Memory.GameReg, name}}
  end

  def start(name) do
      spec = %{
        id: __MODULE__,
        start: {__MODULE__, :start_link, [name]},
        restart: :permanent,
        type: :worker,
      }
      Memory.GameSupervisor.start_child(spec)
    end

  def start_link(name) do
    game = BackupAgent.get(name) || Game.reset()
    GenServer.start_link(__MODULE__, game, name: reg(name))
  end

  def flip(name, index) do
    GenServer.call(reg(name), {:flip, name, index})
  end

  def flip_back(name, index) do
    GenServer.call(reg(name), {:flip_back, name, index})
  end

  def reset(name) do
    GenServer.call(reg(name), {:reset, name})
  end

  def init(game) do
    {:ok, game}
  end

  def handle_call({:flip, name, index}, _from, game) do
    game = Game.flip(game, index)
    BackupAgent.put(name, game)
    {:reply, game, game}
  end

  # TODO Change this back to panel_string if you nned to
  def handle_call({:flip_back, name, index}, _from, game) do
    game = Game.flip_back(game, index)
    BackupAgent.put(name, game)
    {:reply, game, game}
  end

  def handle_call({:reset, name}, _from, game) do
    game = Game.reset()
    BackupAgent.put(name, game)
    {:reply, game, game}
  end
  # I copied code from Nat's Stack 3 and hangman in Lecture Notes
end

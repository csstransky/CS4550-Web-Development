defmodule MemoryWeb.GamesChannel do                                          
  use MemoryWeb, :channel                                                  
                                                                       
  alias Memory.Game                                                          
  alias Memory.BackupAgent
                                                  
  def join("games:" <> name, payload, socket) do                              
    if authorized?(payload) do                                                
      game = BackupAgent.get(name) || Game.reset()
      socket = socket                                                         
      |> assign(:game, game)                                                   
      |> assign(:name, name)                                                   
      {:ok, %{"join" => name, "game" => game}, socket}       
    else                                                                       
      {:error, %{reason: "unauthorized"}}                                      
    end                                                                        
  end                                                                          
                                                                               
  def handle_in("flip", %{ "panel_index" => ll }, socket) do
    name = socket.assigns[:name]
    game = Game.flip(socket.assigns[:game], ll)                               
    socket = assign(socket, :game, game)                                       
    BackupAgent.put(name, game)
    {:reply, {:ok, %{"game" => game}}, socket}               
  end                                                                          
                                                                               
  # Add authorization logic here as required.                                  
  defp authorized?(_payload) do                                                
    true                                                                       
  end                                                                          
end                                                                            

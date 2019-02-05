defmodule Memory.Game do
  def flip(game, panel_index) do
    @moduledoc '''
		// When panel is clicked,
		//	if panel.hidden == true
		//		if compare_string == empty 
		//			panel.hidden = false
		//			compare_string = panel.value
		//
		//		else compare_string != empty
		//			show that panel
		//
		//			if compare_string != panel.value
		//				short delay (3 sec?)
		//				panel.hidden = true
		//				hide compare_string panel
		//
		//			compare_string = ""

    Process.send_after		
    '''
    panel = Enum.at(game.panel_list, panel_index)
    compare_string = game.compare_string

  Enum.map fn panel -> if panel.value == compare_string do
          Map.put(panel, :hidden, true)
      end
    if panel.hidden do
      if compare_string == "" do
        # panel.hidden = false
        new_list = List.update_at(panel_list, 1, 
          fn panel -> Map.put(panel, :hidden, false) end) 
        # state.compare_string = panel.value  
        Map.put(game, panel_list
        game
        |> Map.put(:score, 
      else
        if compare_string != panel.value do
          # panel.hidden = true
          panel_list
          |> List.update_at(panel_index,
            fn panel -> Map.put(panel, :hidden, true) end)
          |> new_list = Enum.map(panel_list, fn panel -> 
            if panel.value == compare_string do
              Map.put(panel, :hidden, true)
            else
              panel
            end 
          end)

          game
          |> Map.put(:score, game.score+1)
          |> Map.put(:compare_string, "")
          
          # istate.panel_list.findAll(value: compare_string).hidden = true
            # ^^^ will be %{value: compare_string, hidden: false}
          Enum.map(panel_list, fn panel -> if panel.value == compare_string do
            Map.put(panel, :hidden, true)
          end) end
          # state.compare_string = ""
        else
          # panel.hidden = false
          # state.compare_string = ""
        end
      end 
    end
  end 



  def reset do
    %{
      panel_list: starting_pair_list,
      compare_string: "",
      score: 0 
    }
  end

  def client_view do
    # Logic for viewing, Iguess?
  end

  def starting_pair_list do
    pairs = ~w{a a b b c c d d e e f f g g h h}
    |> Enum.shuffle(pairs)
    |> Enum.map(pairs, fn letter -> %{value: letter, hidden: true} end)
  end
end

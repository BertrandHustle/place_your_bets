player_state = {
	money = 1000
}
game_squares = {}
highlighted_square = nil
selected_square = nil

function _init()
	cls()
	init()  --init slots
	game_squares = {	
		gs1 = slots_square,
		gs2 = GameSquare:new({}, 1, 2, 64, {}, 0, 64, 'test2'),
		gs3 = GameSquare:new({}, 2, 1, 64, {}, 64, 0, 'test3'),
		gs4 = GameSquare:new({}, 2, 2, 64, {}, 64, 64, 'test4')
	}
	highlighted_square = game_squares.gs1
	-- create_deck()
    -- draw_hand(1, 1)
    -- render_buttons()
end

function _update()
	if selected_square do
		select_button(selected_square)
	end
	select_game(game_squares)
end

function _draw()
	cls()
	for _,gs in pairs(row) do
		gs:render()
		if (gs.name != highlighted_square.name) then
			gs.highlighted = false
		end
		if (selected_square and gs.name != selected_square.name) then
			gs.selected = false
		end
	end
end

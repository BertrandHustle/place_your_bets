player_state = {
	money = 1000
}

game_squares = {}
highlighted_square = nil
selected_square = nil
frames = 0

function _init()
	cls()
	-- gs1 = GameSquare:new({}, 1, 1, 64, {}, 0, 0, 'test')
	init()
	gs1 = slots_square
	gs2 = GameSquare:new({}, 1, 2, 64, {}, 0, 64, 'test2', 60)
	gs3 = GameSquare:new({}, 2, 1, 64, {}, 64, 0, 'test3', 60)
	gs4 = GameSquare:new({}, 2, 2, 64, {}, 64, 64, 'test4', 60)
	highlighted_square = gs1
	row1 = {gs1, gs2}
	row2 = {gs3, gs4}
	add(game_squares, row1)
	add(game_squares, row2)
	-- create_deck()
    -- draw_hand(1, 1)
    -- render_buttons()
end

function _update()
	if frames == 60 then
		tick = true
		frames = 0
	end

	for _,row in pairs(game_squares) do 
		for _,gs in pairs(row) do
			if gs.win_frames >= 20 then
				gs:cancel_win()
			end
			if (gs.name != highlighted_square.name) then
				gs.highlighted = false
			end
			if (selected_square and gs.name != selected_square.name) then
				gs.selected = false
			end
			if tick then
				gs.timer -= 1
			end
		end
	end

	if selected_square do
		select_button(selected_square)
	end
	select_game(game_squares)

	tick = false
	frames += 1
end

function _draw()
	cls()
	print(player_state.money, 2, 2)
	for _,row in pairs(game_squares) do 
		for _,gs in pairs(row) do
			gs:render()
		end
	end
end

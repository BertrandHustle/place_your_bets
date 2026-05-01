player = {
	money = 1000
}

game_squares = {}
highlighted_square = nil
selected_square = nil
frames = 0

function _init()
	cls()
	Slots:init()
	Turtle:init()
	gs3 = GameSquare:new({}, 2, 1, 64, {}, 64, 0, 'test3', 60)
	gs4 = GameSquare:new({}, 2, 2, 64, {}, 64, 64, 'test4', 60)
	highlighted_square = slots_square
	row1 = {slots_square, turtle_square}
	row2 = {gs3, gs4}
	add(game_squares, row1)
	add(game_squares, row2)
	-- create_deck()
    -- draw_hand(1, 1)
    -- render_buttons()
end

function _update()
	runtime = time()
	sec = runtime == runtime & -1  -- check if its a float vs int

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
			if sec then
				gs.timer -= 1
			end
		end
	end

	if selected_square do
		select_button(selected_square)
	end
	select_game(game_squares)

	frames += 1

	if sec do
	end
end

function _draw()
	cls()
	print(player.money, 2, 2)
	for _,row in pairs(game_squares) do 
		for _,gs in pairs(row) do
			gs:render()
		end
	end

	if sec and turtle_square.current_bet > 0 then
		for _,turtle in pairs(turtles) do
			turtle:step()
		end
	end
end

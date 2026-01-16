game_squares = {}
selected_square = nil

function _init()
	cls()
	gs1 = GameSquare:new({}, 1, 1, 64, {}, 0, 0, 'test')
	gs2 = GameSquare:new({}, 1, 2, 64, {}, 0, 64, 'test2')
	gs3 = GameSquare:new({}, 2, 1, 64, {}, 64, 0, 'test3')
	gs4 = GameSquare:new({}, 2, 2, 64, {}, 64, 64, 'test4')
	selected_square = gs1
	row1 = {gs1, gs2}
	row2 = {gs3, gs4}
	add(game_squares, row1)
	add(game_squares, row2)
	-- create_deck()
    -- draw_hand(1, 1)
    -- render_buttons()
end

function _update()
	select_game(game_squares)
end

function _draw()
	cls()
	for _,row in pairs(game_squares) do 
		for _,gs in pairs(row) do
			gs:render_border()
			if (gs.name != selected_square.name) then
				gs.selected = false
			end
		end
	end
end

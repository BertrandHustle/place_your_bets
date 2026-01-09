game_squares = {}

function _init()
	cls()
	gs1 = GameSquare:new({}, 64, {}, 0, 0, 'test')
	gs1.selected = true
	gs2 = GameSquare:new({}, 64, {}, 64, 64, 'test2')
	gs3 = GameSquare:new({}, 64, {}, 64, 0, 'test3')
	gs4 = GameSquare:new({}, 64, {}, 0, 64, 'test4')
	add(game_squares, gs1)
	add(game_squares, gs2)
	add(game_squares, gs3)
	add(game_squares, gs4)
	-- create_deck()
    -- draw_hand(1, 1)
    -- render_buttons()
end

function _update()
	-- move_cursor(poker_board)
end

function _draw()
	for k,gs in pairs(game_squares) do 
		gs:render_border(gs.selected)
	end
end

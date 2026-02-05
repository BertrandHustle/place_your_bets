function select_game(game_squares)
	x = highlighted_square.coord_x  --row
	y = highlighted_square.coord_y  --col
	if not (selected_square) then
		if btnp(0) then --left
			if(x-1 == 0) x = 1 else x -= 1
		elseif btnp(1) then --right
			if(x+1 > #game_squares) x = #game_squares else x += 1
		elseif btnp(2) then --up
			if(y-1 == 0) y = 1 else y -= 1
		elseif btnp(3) then --down
			if(y+1 > #game_squares) y = #game_squares else y += 1
		elseif btnp(4) then --select
			highlighted_square.selected = true
			selected_square = highlighted_square
		end
	elseif btnp(5) then --cancel
		highlighted_square.selected = false
		selected_square = nil
	end
	highlighted_square = game_squares[x][y]
	highlighted_square.highlighted = true
end


function select_button(selected_square)
	ix = 1
	len = #selected_square.buttons
	if btnp(0) or btnp(1) then
		if btnp(0) then --left
			if(ix-1 == 0) ix = len else ix -= 1
		elseif btnp(1) then --right
			if(ix+1 > len) ix = 1 else ix += 1
		selected_square.buttons[ix].highlighted = true
	end
	elseif btnp(4) then --select
		selected_square.buttons[ix].action()
	end
end
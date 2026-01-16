group_ix = 1
element_ix = 1


function select_game(game_squares)
	x = selected_square.coord_x  --row
	y = selected_square.coord_y  --col
	if btnp(0) then --left
		if(x-1 == 0) x = 1 else x -= 1
	elseif btnp(1) then --right
		if(x+1 == #game_squares) x = #game_squares else x += 1
    elseif btnp(2) then --up
		if(y-1 == 0) y = 1 else y -= 1
    elseif btnp(3) then --down
		if(y+1 == #game_squares) y = #game_squares else y += 1
	end
	-- selected_square.selected = false
	selected_square = game_squares[x][y]
	selected_square.selected = true
end


-- function move_cursor(element_groups)
--     group = element_groups[group_ix]

-- 	if btnp(0) then --left arrow
-- 		if element_ix == 1 then 
--             element_ix = #group
-- 		else 
-- 			element_ix -= 1
-- 		end
-- 	elseif btnp(1) then --right arrow
-- 		if element_ix == #group then 
--             element_ix = 1
-- 		else 
-- 			element_ix += 1
-- 		end
--     elseif btnp(2) then --up arrow
-- 		element_ix = 1  --TODO: make this calc middle of next group and start ix theres
-- 		if group_ix == 1 then 
--             group_ix = #element_groups
-- 		else 
-- 			group_ix -= 1
-- 		end
--         group = element_groups[group_ix]
--     elseif btnp(3) then --down arrow
-- 		element_ix = 1
-- 		if group_ix == #element_groups then 
--             group_ix = 1
-- 		else 
-- 			group_ix += 1
-- 		end
--         group = element_groups[group_ix]
-- 	end
--     selected_element = group[element_ix]
-- 	selected_element.highlighted = true
-- 	selected_element:render()
-- end


-- function select_poker_button()
-- 	if btnp(4) then  --O button
--         poker_buttons[current_position].action()
-- 	end
-- end
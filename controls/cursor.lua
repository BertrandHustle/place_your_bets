Button = {
    action = nil, 
    name = '', 
    sprite_val = 0, 
    x_coord = 0,
    y_coord = 0
}

highlight_sprite_val = 23


function Button:new(action, name, sprite_val, x_coord, y_coord)
    local obj = {action=action, name, sprite_val=sprite_val, x_coord=x_coord, y_coord=y_coord}
	return setmetatable(obj, {__index = self})
end

function Button:render()
    palt(0, false)
    spr(self.sprite_val, self.x_coord, self.y_coord)
    palt(0, true)


function move_cursor(element_groups)
    group_ix = 1
    element_ix = 1

    group = element_groups[group_ix]

	if btnp(0) then --left arrow
		if element_ix == 1 then 
            element_ix = #group
		else 
			element_ix -= 1
		end
	elseif btnp(1) then --right arrow
		if element_ix == #group then 
            element_ix = 1
		else 
			element_ix += 1
		end
	end
    elseif btnp(2) then --up arrow
		if group_ix == 1 then 
            group_ix = #element_groups
		else 
			group_ix -= 1
		end
        group = element_groups[group_ix]
	end
    elseif btnp(3) then --down arrow
		if group_ix == #element_groups then 
            group_ix = 1
		else 
			group_ix += 1
		end
        group = element_groups[group_ix]
	end
    selected_element = group[element_ix]
	spr(highlight_sprite_val, selected_element.x_coord, selected_element.y_coord)
end


function select_poker_button()
	if btnp(4) then  --O button
        poker_buttons[current_position].action()
	end
end
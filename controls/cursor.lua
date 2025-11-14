Button = {

}

poker_buttons = {
	add_card = {sprite_val = 20, x_coord = 1},
	remove_card = {sprite_val = 21, x_coord = 12},
	go = {sprite_val = 22, x_coord = 24},
	highlight = {sprite_val = 23, x_coord = nil}
}

function render_all_poker_buttons()
	for _, val in pairs(poker_buttons) do
		if val.x_coord then
			spr(val.sprite_val, val.x_coord, 20)
		end
	end
end

function rerender_poker_button(button_name)
	button = poker_buttons[button_name]
	spr(button.sprite_val, button.x_coord, 20)
end

current_position = 1

function highlight_poker_button()

	button_names = {'add_card', 'remove_card', 'go'}

	base_y_position = 20
	palt(0, false)
	rerender_poker_button(button_names[current_position])
	palt(0, true)
	if btnp(0) then --left arrow
		if current_position == 1 then 
			current_position = 3
		else 
			current_position -= 1 
		end
	elseif btnp(1) then --right arrow
		if current_position == 3 then 
			current_position = 1
		else 
			current_position += 1 
		end
	end
	button_name = button_names[current_position]
	spr(poker_buttons.highlight.sprite_val, poker_buttons[button_name].x_coord, base_y_position)
end

function select_poker_button()
	if btnp(4) then  --O button

	end
end
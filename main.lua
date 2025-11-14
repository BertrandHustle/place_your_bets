function _init()
	cls()
	create_deck()
	draw_hand(1, 1)
	render_all_poker_buttons()
end
function _update()
	highlight_poker_button()
end
function _draw()
	-- render_card()
end

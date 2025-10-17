suits = {'clubs', 'diamonds', 'hearts', 'spades'}
suit_mappings = {clubs=16, diamonds=17, hearts=18, spades=19}

function create_deck()
	deck = {}
	for i=1, #suits do
		for j=1, 13 do
			add(deck, {suit=suits[i], val=j})
		end
	end
	return deck
end

--[[
1,1  1,9   1,18
9,1  9,9   9,18
18,1 18,9 18,18
--]]

function draw_card(init_x, init_y)
  	local card = rnd(deck)
	spr(suit_mappings[card.suit], init_x, init_y)
	spr(card.val, init_x, init_y*8)
end

function draw_hand(init_x, init_y)
	for i=1,5 do
		draw_card(init_x, init_y)
		init_x += 9
	end
end

function _init()
	cls()
	create_deck()
	draw_hand(1, 1)
end
function _update()
	-- cls()
	-- update_ply1()
end
function _draw()
	-- draw_card()
end

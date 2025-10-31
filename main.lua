-- Poker --
suits = {'clubs', 'diamonds', 'hearts', 'spades'}
suit_mappings = {clubs=16, diamonds=17, hearts=18, spades=19}

Card = {
    suit = nil,
    value = nil,
}

function Card:new(suit, value)
	local obj = {suit=suit, value=value}
	return setmetatable(obj, {__index = self})
end

function Card:render_card(init_x, init_y)
	print(self.value, 50, 50)
	spr(suit_mappings[self.suit], init_x, init_y)
	spr(self.value, init_x, init_y*8)
end

hand = {}

function create_deck()
	deck = {}
	for i=1, #suits do
		for j=1, 13 do
			local card = Card:new(suits[i], j)
            add(deck, card)
		end
	end
	return deck
end

function draw_hand(init_x, init_y)
	for i=1,5 do
		local card = rnd(deck)
		card:render_card(init_x, init_y)
		add(hand, card)
		init_x += 9
	end
end
-- Poker --

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
	-- render_card()
end

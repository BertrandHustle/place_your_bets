suits = {'clubs', 'diamonds', 'hearts', 'spades'}
suit_mappings = {clubs=16, diamonds=17, hearts=18, spades=19}

Card = {
	highlighted = false,
    keep = false, 
    suit = '', 
    value = 0, 
    x = 0, 
    y = 0
}

poker_accept_button = Button:new(nil, 'go', 20, 1, 20)
poker_accept_button:render()
poker_buttons = {poker_accept_button}
hand = {}
poker_board = {hand, poker_buttons} --contains all selectable elements


function Card:new(suit, value)
	local obj = {suit=suit, value=value}
	return setmetatable(obj, {__index = self})
end


function Card:render(init_x, init_y)
	self.x = init_x
	self.y = init_y
	spr(suit_mappings[self.suit], self.x, self.y)
	spr(self.value, self.x, self.y*8)
	if self.highlighted then 
		highlight(suit_mappings[self.suit], self.x, self.y)
	end
end


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
	for ix=1,5 do
		if not hand[ix] or hand[ix] and hand[ix].keep then
			local card = rnd(deck)
			card:render(init_x, init_y)
			add(hand, card, ix)
			init_x += 9
		end
	end
end


function render_buttons()
	for k, pb in pairs(poker_buttons) do
		pb:render()
	end
end

-- poker hands

function pair()
	vals = {}
	for _, card in pairs(hand) do 
		for _, val in vals do 
			
		end
	end
end
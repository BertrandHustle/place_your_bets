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

function draw_card()
  	local card = rnd(deck)
  	for col=1, 3 do
    	for row=1, 5 do 
      		if (col == 3 and row == 1) or (col == 1 and row == 5) then
        		sprite_index = suit_mappings[card.suit]
				print(suit_mappings[card.suit])
	  		elseif col == 2 and row == 3 then 
				sprite_index = card.val
			else
				sprite_index = 0
			end
			spr(sprite_index, col*8, row*8)
		end
	end
end

function _init()
	cls()
	create_deck()
	draw_card()
end
function _update()
	-- cls()
	-- update_ply1()
end
function _draw()
	-- draw_card()
end

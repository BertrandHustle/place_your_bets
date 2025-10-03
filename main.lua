suits = {'clubs', 'diamonds', 'hearts', 'spades'}
suit_mappings = {clubs=15, diamonds=16, hearts=17, spades=18}

function create_deck()
	deck = {}
	for i=1, #suits do
		for j=1, 52 do
			add(deck, {suit=suits[i], val=j})
			print(deck[j]['suit'])
		end
	end
	return deck
end

function draw_card()
  	local card = rnd(deck)
  	local sprite_index = 0
  	for row=1, 5 do
    	for col=1, 3 do 
      		if (col == 1 and row == 1) or (col == 5 and row == 3) then
        		sprite_index = card['suit']
	  		elseif col == 2 and row == 3 then 
				sprite_index = card['val']
			end 
			spr(card.sprite_index, row, col)
		end
	end
end

function _init()
	deck = create_deck()
	card = draw_card()
	print(deck[0]['suit'])
	--print(card['suit'])
	--print(card['val'])
end
function _update()
	-- cls()
	-- update_ply1()
end
function _draw()
	-- draw_card()
end

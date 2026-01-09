GameSquare = {
    buttons = {},
    edge_length = 0,  --length of each edge of border
    game_pieces = {},
    init_x = 0,
    init_y = 0,
    name = ''
}


function GameSquare:new(buttons, edge_length, game_pieces, init_x, init_y, name)
	local obj = {buttons=buttons, edge_length=edge_length, game_pieces=game_pieces,init_x=init_x, init_y=init_y, name=name}
	return setmetatable(obj, {__index = self})
end


function GameSquare:render_border()
    x = self.init_x
    y = self.init_y
    e = self.edge_length - 1
    line(x, y, x, y+e, 5) -- left
    line(x, y, x+e, y, 5) -- top
    line(x+e, y, x+e, y+e, 5) -- right
    line(x, y+e, x+e, y+e, 5) -- bottom
end

GameSquare = {
    buttons = {},
    coord_x = 0,
    coord_y = 0,
    edge_length = 0,  --length of each edge of border
    game_pieces = {},
    init_x = 0,
    init_y = 0,
    name = '',
    selected = false
}


function GameSquare:new(buttons, coord_x, coord_y, edge_length, game_pieces, init_x, init_y, name)
	local obj = {
        buttons=buttons, 
        coord_x=coord_x,
        coord_y=coord_y,
        edge_length=edge_length, 
        game_pieces=game_pieces,
        init_x=init_x, 
        init_y=init_y, 
        name=name
    }
	return setmetatable(obj, {__index = self})
end


function GameSquare:render_border()
    x = self.init_x
    y = self.init_y
    e = self.edge_length - 1
    if(self.selected) color = 10 else color = 5
    line(x, y, x, y+e, color) -- left
    line(x, y, x+e, y, color) -- top
    line(x+e, y, x+e, y+e, color) -- right
    line(x, y+e, x+e, y+e, color) -- bottom
    print(self.name)
    print(self.selected, x, y)
    print(self.coord_x)
    print(self.coord_y)
end

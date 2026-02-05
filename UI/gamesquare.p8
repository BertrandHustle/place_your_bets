GameSquare = {
    buttons = {},
    coord_x = 0,
    coord_y = 0,
    edge_length = 0,  --length of each edge of border
    game_pieces = {},
    init_x = 0,
    init_y = 0,
    name = '',
    highlighted = false,
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
    if(self.selected) then 
        color = 7 
    elseif(self.highlighted) then 
        color = 10
    else 
        color = 5
    end
    print(color)
    line(x, y, x, y+e, color) -- left
    line(x, y, x+e, y, color) -- top
    line(x+e, y, x+e, y+e, color) -- right
    line(x, y+e, x+e, y+e, color) -- bottom
end


function GameSquare:render()
    self.render_border()
    for _, button in pairs(self.buttons) do
        button:render()
    end
    for _, piece in pairs(self.game_pieces) do
        piece:render()
    end
end
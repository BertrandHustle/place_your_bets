GameSquare = {
    buttons = {},
    current_bet = 0,
    timer = 0,
    time_limit = 0,
    selected_button_ix = 1,
    x_offset = 8,
    y_offset = 8,
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


function GameSquare:new(buttons, coord_x, coord_y, edge_length, game_pieces, init_x, init_y, name, time_limit)
	local obj = {
        buttons=buttons, 
        coord_x=coord_x,
        coord_y=coord_y,
        edge_length=edge_length, 
        game_pieces=game_pieces,
        init_x=init_x, 
        init_y=init_y, 
        name=name,
        timer=time_limit,
        time_limit=time_limit
    }
    for _, button in pairs(buttons) do
        button.gamesquare_name = name
    end
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
    line(x, y, x, y+e, color) -- left
    line(x, y, x+e, y, color) -- top
    line(x+e, y, x+e, y+e, color) -- right
    line(x, y+e, x+e, y+e, color) -- bottom
end


function GameSquare:render()
    x_offset = self.x_offset
    self:render_border()
    for _, button in pairs(self.buttons) do
        button:render(self.init_x + x_offset, self.init_y + self.edge_length - (button.h * 8) - self.y_offset)
        x_offset += self.x_offset + button.w + x_offset
    end
    for _, piece in pairs(self.game_pieces) do
        piece:render()
    end
    print(self.current_bet, self.init_x + self.edge_length - 6, self.init_y + 2)
    print(self.timer, self.init_x + self.edge_length - 6, self.init_y + 10)
end
GameSquare = {
    current_bet = 0,
    selected_button_ix = 1,
    x_offset = 8,
    y_offset = 8,
    highlighted = false,
    selected = false,
    win = false,
    win_frames = 0
}


function GameSquare:new(buttons, coord_x, coord_y, edge_length, game_pieces, init_x, init_y, name, time_limit)
	local obj = {
        buttons=buttons, 
        coord_x=coord_x,
        coord_y=coord_y,
        edge_length=edge_length,  --length of each edge of border
        game_pieces=game_pieces,
        init_x=init_x, 
        init_y=init_y, 
        name=name,
        timer=time_limit,
        time_limit=time_limit
    }
    for _, button in pairs(buttons) do
        button.parent = self
    end
	return setmetatable(obj, {__index = self})
end


function GameSquare:render_border()
    x = self.init_x
    y = self.init_y
    e = self.edge_length - 1
    if(self.win) then
        color = rnd(8) + 8
        self.win_frames += 1
    elseif(self.selected) then 
        color = 7 
    elseif(self.highlighted) then 
        color = 10
    else
        color = 5
    end
    rect(x, y, x+e, y+e, color)
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
    print(self.current_bet, self.init_x + self.edge_length - 9, self.init_y + 2)
    print(self.timer, self.init_x + self.edge_length - 9, self.init_y + 10)
end


function GameSquare:cancel_win()
    self.win = false
	self.win_frames = 0
end

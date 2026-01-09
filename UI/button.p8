Button = {
    action = nil,
    highlighted = false,
    name = '', 
    sprite_val = 0, 
	x = 0,
    y = 0
}


function Button:new(action, name, sprite_val, x, y)
    local obj = {action=action, name=name, sprite_val=sprite_val, x=x, y=y}
	return setmetatable(obj, {__index = self})
end


function Button:render()
    spr(self.sprite_val, self.x, self.y)
    if self.highlighted then
        highlight(suit_mappings[self.suit], self.x, self.y)
    end
end



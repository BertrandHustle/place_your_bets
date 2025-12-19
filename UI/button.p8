Button = {
    action = nil, 
    name = '', 
    sprite_val = 0, 
	x = 0,
    y = 0
}


function Button:new(action, name, sprite_val, x, y)
    local obj = {action=action, name, sprite_val=sprite_val, x, y=y}
	return setmetatable(obj, {__index = self})
end


function Button:render()
    spr(self.sprite_val, self.x, self.y)
end



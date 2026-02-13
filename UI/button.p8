Button = {
    action = nil,
    highlighted = false,
    name = '', 
    sprite_val = 0, 
	w = 0,
    h = 0
}


function Button:new(action, name, sprite_val, w, h)
    local obj = {action=action, name=name, sprite_val=sprite_val, w=w, h=h}
	return setmetatable(obj, {__index = self})
end


function Button:render(init_x, init_y)
    spr(self.sprite_val, init_x, init_y, self.w, self.h)
end



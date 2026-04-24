Button = {
    action = nil,
    highlighted = false,
    sprite_val = 0, 
    x = 0,
    y = 0,
	w = 0,
    h = 0,
}


function Button:new(action, sprite_val, x, y, w, h)
    local obj = {action=action, sprite_val=sprite_val, x=x, y=y, w=w, h=h}
	return setmetatable(obj, {__index = self})
end


function Button:render()
    spr(self.sprite_val, self.x, self.y, self.w, self.h)
    if self.highlighted do
        highlight(self.sprite_val, self.x, self.y, self.w, self.h)
    end
end

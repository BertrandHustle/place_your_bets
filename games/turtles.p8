Turtle = {
    back_leg = false,
    distance = 0,
    winner = false
}

turtles = {}

function Turtle:new(sprite_val, odds, speed)
	local obj = {sprite_val=sprite_val, odds=odds, speed=speed}
	return setmetatable(obj, {__index = self})
end


function Turtle:render()
    x = self.x + self.distance
    spr(self.sprite_val, x, self.y, 2, 2)
    top_h = self.y+12  --height of leg top
    leg_tops = {{x+3, top_h}, {x+5, top_h}, {x+8, top_h}, {x+10, top_h}}
    leg_color = sget(x+3, top_h)
    for _, leg in pairs(leg_tops) do
        if(self.back_leg) l=3 else l=2
        line(leg[0], leg[1], leg[0], l, leg_color)
        back_leg = not back_leg
    end
end


function Turtle:step()
    self.distance += self.speed
    self:render()
end


-- TODO: change this to use meta e.g. turtle.init?
function turtle_init() 
    y_offset = 8
    for _, spr_val in pairs(turtle_sprites) do
        add(turtles, Turtle:new(spr_val, rnd({1,2,3,4}), rnd({1,2,3,4})))
    end
    for _, turtle in pairs(turtles) do
        turtle.x = turtle_square.init_x 
        turtle.y = turtle_square.init_y + y_offset
        turtle:render()
        y_offset += 8
    end
end


function place_bet()
    turtle_square.current_bet += 10
    turtle_square.timer = turtle_square.time_limit
    player_state.money -= 10
end


turtle_sprites = {128, 130, 160, 162}

bet_button_sprites = {1,2,3,4}

turtle_square = GameSquare:new({}, 1, 2, 64, turtles, 0, 64, 'turtles', 60)
Turtle = {
    back_leg = false,
    bet_choice = false,
    finish_line = 0,
    winner = false
}

turtles = {}

function Turtle:new(sprite_val, odds, speed)
	local obj = {sprite_val=sprite_val, odds=odds, speed=speed}
	return setmetatable(obj, {__index = self})
end


function Turtle:render()
    spr(self.sprite_val, self.x, self.y, 2, 2)
    top_h = self.y+12  --height of leg top
    leg_tops = {{self.x+3, top_h}, {self.x+5, top_h}, {self.x+8, top_h}, {self.x+10, top_h}}
    leg_color = pget(self.x+3, top_h-1)
    for _, leg in pairs(leg_tops) do
        if(self.back_leg) len=3 else len=2
        line(leg[1], leg[2], leg[1], leg[2]+len, leg_color)
        sfx(0)
        self.back_leg = not self.back_leg
    end
    self.back_leg = not self.back_leg
    self.finish_line = turtle_square.init_x + 54
    spr(132, self.finish_line, self.y + 4) -- render finish line
end


function Turtle:step()
    self.x += self.speed
    self:render()
    if self.x == self.finish_line then
        self.winner = true
    end
end


-- TODO: change this to use meta e.g. turtle.init?
function turtle_init() 
    y_offset = 16
    for _, spr_val in pairs(turtle_sprites) do
        add(turtles, Turtle:new(spr_val, rnd({1,2,3,4}), rnd({1,2,3,4})))
    end
    for _, turtle in pairs(turtles) do
        turtle.x = turtle_square.init_x 
        turtle.y = turtle_square.init_y + y_offset
        y_offset += 8
    end
end


function place_bet()
    turtle_square.current_bet += 10
    turtle_square.timer = turtle_square.time_limit
    player_state.money -= 10
end


function payout()
    for _, turtle in turtles do
        if turtle.bet_choice and turtle.winner then
            player.money += turtle_square.current_bet * 4
        end
    end 
end


turtle_sprites = {128, 130, 160, 162}

gs_x = 0
gs_y = 64

turtle_buttons = {}
x_offset = 16
for i=1,4 do
    add(turtle_buttons, Button:new(place_bet, i, x_offset, gs_y + 10, 1, 1))
    x_offset += 8
end

turtle_square = GameSquare:new(turtle_buttons, 1, 2, 64, turtles, gs_x, gs_y, 60)
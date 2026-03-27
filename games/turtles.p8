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
    self.finish_line = turtle_square.init_x + 54
    spr(132, self.finish_line, self.y + 4) -- render finish line
    spr(self.sprite_val, self.x, self.y, 2, 2)
    if turtle_square.current_bet > 0 then
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
    end
end


function Turtle:step()
    self.x += self.speed
    self:render()
    if self.x + 12 >= self.finish_line then
        self.winner = true
    end
end


function Turtle:init() 
    y_offset = 15
    for _, spr_val in pairs(turtle_sprites) do
        add(turtles, Turtle:new(spr_val, rnd({1,2,3,4}), rnd({1,2,3,4})))
    end
    for _, turtle in pairs(turtles) do
        turtle.x = turtle_square.init_x 
        turtle.y = turtle_square.init_y + y_offset
        y_offset += 8
    end
end


function Turtle:place_bet()
    if turtle_square.current_bet < 1 then
        turtle_square.current_bet += 10
        turtle_square.timer = turtle_square.time_limit
        player_state.money -= 10
    end
end


function Turtle:payout(turtle)
    if turtle.bet_choice and turtle.winner then
        player.money += turtle_square.current_bet * 4
        sfx(0)
    else
        sfx(2)
    end
    turtle_square.current_bet = 0
end


turtle_sprites = {128, 130, 160, 162}

gs_x = 0
gs_y = 64

turtle_buttons = {}
x_offset = 16
for i=1,4 do
    add(turtle_buttons, Button:new(Turtle.place_bet, i, x_offset, gs_y + 10, 1, 1))
    x_offset += 8
end

turtle_square = GameSquare:new(turtle_buttons, 1, 2, 64, turtles, gs_x, gs_y, 'turtles', 60)
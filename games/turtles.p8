-- TODO: remove default values?
Turtle = {
    back_leg = false,
    bet_choice = false,
    finish_line = 0,
    winner = false
}

coord_x = 1
coord_y = 2
init_x = 0
init_y = 64
turtles = {}
turtle_sprites = {128, 130, 160, 162}

function Turtle:new(sprite_val, odds, speed)
	local obj = {sprite_val=sprite_val, odds=odds, speed=speed}
	return setmetatable(obj, {__index = self})
end


function Turtle:render()
    spr(132, self.finish_line, self.y + 4) -- render finish line
    spr(self.sprite_val, self.x, self.y, 2, 2)
    if turtle_square and turtle_square.current_bet > 0 then
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
    --self.x += self.speed * 2
    self.x += self.speed * 10
    if self.x + 12 >= self.finish_line and turtle_square.current_bet > 0 then
        self.winner = true
        self:payout()
    end
end


function Turtle:make_turtles()
    y_offset = 15
    local turtles = {}
    for _, spr_val in pairs(turtle_sprites) do
        add(turtles, Turtle:new(spr_val, rnd({1,2,3,4}), rnd({1,2,3,4})))
    end
    for _, turtle in pairs(turtles) do
        turtle.x = init_x 
        turtle.y = init_y + y_offset
        turtle.finish_line = init_x + 54
        y_offset += 8
        turtle:render()
    end
    return turtles
end


function Turtle:make_buttons()
    turtle_buttons = {}
    x_offset = 16
    for i=1,4 do
        add(turtle_buttons, Button:new(Turtle.place_bet, i, x_offset, init_y + 10, 1, 1))
        x_offset += 8
    end
    return turtle_buttons
end


function Turtle:init()
    turtles = Turtle:make_turtles()
    turtle_buttons = Turtle:make_buttons()
    turtle_square = GameSquare:new(turtle_buttons, coord_x, coord_y, 64, turtles, init_x, init_y, 'turtles', 60)
    return turtle_square
end


function Turtle:place_bet(turtle_num)
    if turtle_square.current_bet < 1 then
        turtles[turtle_num].bet_choice = true
        turtle_square.current_bet += 10
        turtle_square.timer = turtle_square.time_limit
        player.money -= 10
    end
end


function Turtle:payout()
    for _,turtle in pairs(turtles) do
        if turtle.bet_choice and turtle.winner then
            player.money += turtle_square.current_bet * 4
            turtle_square:set_win()
            turtle_square = Turtle:init()
            turtle_square:refresh_square()
            return
        end
    end
    sfx(2)
    turtle_square = Turtle:init()
    turtle_square:refresh_square()
end

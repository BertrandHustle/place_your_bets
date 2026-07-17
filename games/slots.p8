Slots = {
    facing_symbols = {},
    symbols = {
        common = {
            -- spr, val
            {23, 5},  --plum
            {24, 4},  --lemon
            {26, 3},  --orange
            {28, 1}   --cherry
        },
        uncommon = {
            {27, 50}  --diamond
        },
        rare = {
            {25, 100}  --seven
        }
    },
    num_reels = 3,
    reels = {},
    rows = 1,
    remaining_spins = 0,
    scoring_lines = 3,
    spin_seconds = 10
}

-- TODO: simplify these inits like this in other classes
Reel={}


function Reel:new(symbols, scoring_lines, x, y, height)
	local obj = {symbols=symbols, scoring_lines=scoring_lines, x=x, y=y, height=height}
	return setmetatable(obj, {__index = self})
end


function Reel:render()
    -- draw walls
    top = self.y
    bottom = self.y+24
    rect(self.x-4, top, self.x-4, bottom, 6)
    rect(self.x+4, top, self.x+4, bottom, 6)
    -- draw lines
    for _,sc_line in pairs(self.scoring_lines) do
        line(self.x-4, sc_line, self.x+4, sc_line)
    end
    for _,sym in pairs(self.symbols) do

        sx, sy = get_spr_coords(sym[1])

        top_of_symbol = sym[3]
        bottom_of_symbol = sym[3]+8

        top_clip = (bottom_of_symbol-top)
        bottom_clip = (bottom-top_of_symbol)+1

        dy = sym[3]

        if (top_of_symbol < bottom and bottom_of_symbol > top) then
            if (top_clip < 8) then
                sy += 8-top_clip
                sh = top_clip
                dy += 8-top_clip
            elseif (bottom_clip < 8) then
                sh = bottom_clip
            else
                sh = 8
            end

            sspr(sx, sy, 8, sh, self.x-4, dy)
        end
    end
end


function Slots:place_bet()
    slots_square.current_bet += 10
    slots_square.timer = slots_square.time_limit
    player.money -= 10
end


function Slots:payout()
    prev_symbol = nil
    for _, symbol in pairs(Slots.facing_symbols) do
        if prev_symbol and prev_symbol != symbol then
            return 0
        end
        prev_symbol = symbol
    end
    slots_square:set_win()
    winnings = Slots.payout() * Slots.facing_symbols[1][2]
    player.money += winnings
    slots_square.current_bet = 0 
    Slots.facing_symbols = {}
    Slots.spinning = false
end


function Slots:copy_symbol(sym)
    new_sym = {}
    for val in all(sym) do
        add(new_sym, val)
    end
    return new_sym
end


function Slots:build_reel(x, y, height)
    -- add scoring lines
    scoring_lines = {}
    sc_line_dist = (height)/(Slots.scoring_lines+1)
    line_y = y + sc_line_dist
    for i=1, Slots.scoring_lines, 1 do
        add(scoring_lines, line_y)
        line_y += sc_line_dist
    end
    -- add symbols
    symbols = {}
    y_inc = 0
    for i=1, 4 do 
        symbol = Slots:copy_symbol(rnd(Slots.symbols.common))
        symbol[3] = y + y_inc
        add(symbols, symbol)
        y_inc += 7
    end
    for i=1, 2 do 
        symbol = Slots:copy_symbol(rnd(Slots.symbols.uncommon))
        symbol[3] = y + y_inc
        add(symbols, symbol)
        y_inc += 7
    end
    symbol = Slots:copy_symbol(rnd(Slots.symbols.rare))
    symbol[3] = y + y_inc
    add(symbols, symbol)
    return Reel:new(symbols, scoring_lines, x, y, height)
end


function Slots:spin_reel()
    for _, reel in pairs(Slots.reels) do
        bottom = reel.y + 23
        for _, sym in pairs(reel.symbols) do
            if sym[3] > bottom + 7 + 18 + 2 then
                sym[3] = reel.y-8
            else
                sym[3] += 2
            end
        end
    end
    Slots.remaining_spins -= 1
end


-- function Slots:move_towards_scoring_line(reel)
--     if 
-- end


function Slots:init()
    x = 10
    y = 10
    height = 24
    for i=1, Slots.num_reels do
        add(Slots.reels, Slots:build_reel(x, y, height))
        x += 10
    end
end


function Slots:start_reels()
    if (slots_square.current_bet > 0) then
        Slots.remaining_spins = Slots.spin_seconds
    end
end

gs_x = 0
gs_y = 0

bet_button = Button:new(Slots.place_bet, 64, gs_x+10, gs_y+40, 2, 2)
spin_button = Button:new(Slots.start_reels, 66, gs_x+35, gs_y+40, 2, 2)

slots_square = GameSquare:new({bet_button, spin_button}, 1, 1, 64, Slots.reels, gs_x, gs_y, 'slots', 60)
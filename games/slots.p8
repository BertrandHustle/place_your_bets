Slots = {
    facing_symbols = {},
    symbols = {
        common = {
            -- spr, val, y
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
    closest_scline = nil,
    closest_sym = nil,
    num_reels = 3,
    reels = {},
    rows = 1,
    remaining_spins = 0,
    scoring_lines = 3,
    spin_seconds = 60,
    adjusting = false
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
    bottom = self.y+36
    rect(self.x-8, top, self.x-8, bottom, 6)
    rect(self.x+8, top, self.x+8, bottom, 6)
    -- draw lines
    for _,sc_line in pairs(self.scoring_lines) do
        line(self.x-6, sc_line, self.x+6, sc_line)
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
    sc_line_dist = (height+y-5)/(Slots.scoring_lines)
    line_y = y + sc_line_dist
    for i=1, Slots.scoring_lines, 1 do
        add(scoring_lines, line_y)
        line_y += sc_line_dist
    end
    -- add symbols

    symbols = {}
    for _,sym in pairs(Slots.symbols.common) do
        for i=1, 2 do
            add(symbols, Slots:copy_symbol(sym))
        end
    end
    for _,sym in pairs(Slots.symbols.uncommon) do
        for i=1, 3 do
            add(symbols, Slots:copy_symbol(sym))
        end
    end
    add(symbols, Slots:copy_symbol(Slots.symbols.rare[1]))

    input_syms = {}
    rnd_syms = {}
    for _,s in pairs(symbols) do
        add(input_syms, s)
    end
    y_inc = 0
    while(#input_syms>0) do
        sym = rnd(input_syms)
        sym[3] = y_inc
        add(rnd_syms, sym)
        del(input_syms, sym)
        y_inc += 10
    end
    return Reel:new(rnd_syms, scoring_lines, x, y, height)
end

function Slots:spin_reel()
    for _, reel in pairs(Slots.reels) do
        for _, sym in pairs(reel.symbols) do
            if sym[3] > #reel.symbols*10 then
                sym[3] = reel.y-7
            else
                sym[3] += 1
            end
            if Slots.remaining_spins == 1 then
                for _, scline in pairs(reel.scoring_lines) do
                    diff = abs(sym[3]-scline)
                    if self.closest_scline == nil or diff < abs(self.closest_sym-self.closest_scline) then
                        self.closest_scline = scline
                        self.closest_sym = sym[3]+4  -- we want the middle of the symbol
                    end
                end
                Slots.adjusting = true
            end
        end
    end
    pq(Slots.reels)
    Slots.remaining_spins -= 1
end


function Slots:adjust_reels()
    if self.closest_sym == self.closest_scline then
        self.adjusting = false
    else
        if self.closest_sym > self.closest_scline then
            for _, reel in pairs(Slots.reels) do
                for _, sym in pairs(reel.symbols) do
                    sym[3] -= 1
                end
                self.closest_sym -= 1
            end
        elseif self.closest_sym < self.closest_scline then
            for _, reel in pairs(Slots.reels) do
                for _, sym in pairs(reel.symbols) do
                    sym[3] += 1
                end
                self.closest_sym += 1
            end
        end
    end
    self.closest_sym = nil 
    self.closest_scline = nil
end


function Slots:init()
    x = 10
    y = 10
    height = 24
    for i=1, Slots.num_reels do
        add(Slots.reels, Slots:build_reel(x, y, height))
        x += 16
    end
end


function Slots:start_reels()
    if (slots_square.current_bet > 0) then
        Slots.remaining_spins = Slots.spin_seconds
        Slots.spinning = true
    end
end

gs_x = 0
gs_y = 0

bet_button = Button:new(Slots.place_bet, 15, gs_x+54, gs_y+18)
spin_button = Button:new(Slots.start_reels, 14, gs_x+54, gs_y+28)

slots_square = GameSquare:new({bet_button, spin_button}, 1, 1, 64, Slots.reels, gs_x, gs_y, 'slots', 60)
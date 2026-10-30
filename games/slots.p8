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
    low_y_sym = nil,  --lowest y value a symbol can be on a reel
    high_y_sym = nil,
    num_reels = 3,
    reels = {},
    rows = 1,
    remaining_spins = 0,
    num_sclines = 3,
    spin_seconds = 60,
    spin_speed = 3,
    adjusting = false
}

-- TODO: simplify these inits like this in other classes
Reel={}


function Reel:new(start_delay, symbols, scoring_lines, x, y, height)
	local obj = {start_delay=start_delay, symbols=symbols, scoring_lines=scoring_lines, x=x, y=y, height=height}
	return setmetatable(obj, {__index = self})
end


function Reel:render()
    -- draw walls
    top = self.y
    bottom = self.y+self.height
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
end


function Slots:copy_symbol(sym)
    new_sym = {}
    for val in all(sym) do
        add(new_sym, val)
    end
    return new_sym
end


function Slots:build_reel(x, y, height, delay)
    -- add scoring lines
    scoring_lines = {}
    sc_line_dist = height/Slots.num_sclines 
    line_y = y + sc_line_dist/2
    for i=1, Slots.num_sclines do
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
    med_sym = flr(#input_syms/2)
    y_inc = -(sc_line_dist * med_sym)
    low_y_sym = y_inc
    while(#input_syms>0) do
        sym = rnd(input_syms)
        sym[3] = y_inc - 4
        add(rnd_syms, sym)
        del(input_syms, sym)
        y_inc += sc_line_dist
    end
    high_y_sym = y_inc
    return Reel:new(delay, rnd_syms, scoring_lines, x, y, height)
end


function Slots:spin_reels()
    speed = Slots.spin_speed
    for ix, reel in pairs(Slots.reels) do
        if reel.start_delay <= 0 do
            for _, sym in pairs(reel.symbols) do
                sym[3] += speed
                if sym[3] > high_y_sym - 1 then
                    sym[3] = low_y_sym
                end
                if Slots.remaining_spins == 1 then
                    for _, scline in pairs(reel.scoring_lines) do
                        diff = abs(sym[3]-scline)
                        -- TODO: why is closest_sym not getting set first?
                        if reel.closest_scline == nil or diff < abs(reel.closest_sym-reel.closest_scline) then
                            reel.closest_scline = scline
                            reel.closest_sym = sym[3]+4  -- we want the middle of the symbol
                        end
                    end
                    Slots.adjusting = true
                end
            end
        else
            reel.start_delay -= 1
        end
    end
    Slots.remaining_spins -= 1
end


function Slots:adjust_reels()
    adjust = {}
    for _, reel in pairs(Slots.reels) do
        if reel.closest_sym == reel.closest_scline then
            add(adjusting, false)
        else
            add(adjusting, true)
            if reel.closest_sym > reel.closest_scline then
                for _, sym in pairs(reel.symbols) do
                    sym[3] -= 1
                end
                reel.closest_sym -= 1
            elseif reel.closest_sym < reel.closest_scline then
                for _, sym in pairs(reel.symbols) do
                    sym[3] += 1
                end 
                reel.closest_sym += 1
            end
        end
    end
    for _,val in pairs(adjust) do
        if val do
            return
        end
        self.adjusting = false
    end
end


function Slots:init()
    x = 10
    y = 10
    height = 36
    for i=1, Slots.num_reels do
        add(Slots.reels, Slots:build_reel(x, y, height, i))
        x += 16
    end
end


function Slots:start_reels()
    if (slots_square.current_bet > 0) then
        Slots.remaining_spins = Slots.spin_seconds
    end
end

gs_x = 0
gs_y = 0

bet_button = Button:new(Slots.place_bet, 15, gs_x+54, gs_y+18)
spin_button = Button:new(Slots.start_reels, 14, gs_x+54, gs_y+28)

slots_square = GameSquare:new({bet_button, spin_button}, 1, 1, 64, Slots.reels, gs_x, gs_y, 'slots', 60)
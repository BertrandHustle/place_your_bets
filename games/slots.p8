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
    spin_time = 5
}

Reel = {
    facing_symbol = nil,
    symbols = {},
    x = 0,
    y = 0
}

function Reel:new(symbols, x, y)
	local obj = {symbols=symbols, facing_symbol=rnd(symbols), x=x, y=y}
	return setmetatable(obj, {__index = self})
end

function Reel:render()
    spr(self.facing_symbol[1], self.x, self.y)
end


function Slots:place_bet()
    slots_square.current_bet += 10
    slots_square.timer = slots_square.time_limit
    player_state.money -= 10
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
    return slots_square.current_bet
end


function Slots:build_reel(x, y)
    symbols = {}
    for i=1, 15 do 
        symbol = rnd(Slots.symbols.common)
        add(symbols, symbol)
    end
    for i=1, 5 do 
        symbol = rnd(Slots.symbols.uncommon)
        add(symbols, symbol)
    end
    symbol = rnd(Slots.symbols.rare)
    add(symbols, symbol)
    return Reel:new(symbols, x, y)
end


function Slots:init()
    x = 10
    y = 10
    for i=1, Slots.num_reels do
        add(Slots.reels, Slots:build_reel(x, y))
        x += 10
    end
end


function Slots:roll_reels()
    if (slots_square.current_bet > 0) then
        for _, reel in pairs(Slots.reels) do
            reel.facing_symbol = rnd(reel.symbols)
            --reel.facing_symbol = Slots.symbols.rare[1]
            add(Slots.facing_symbols, reel.facing_symbol)
            reel:render()
        end
        winnings = Slots.payout() * Slots.facing_symbols[1][2]
        player_state.money += winnings
        slots_square.current_bet = 0 
        Slots.facing_symbols = {}
    end
end

gs_x = 0
gs_y = 0

bet_button = Button:new(Slots.place_bet, 64, gs_x+10, gs_y+40, 2, 2)
spin_button = Button:new(Slots.roll_reels, 66, gs_x+35, gs_y+40, 2, 2)

slots_square = GameSquare:new({bet_button, spin_button}, 1, 1, 64, Slots.reels, gs_x, gs_y, 'slots', 60)
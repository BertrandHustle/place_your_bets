slots = {
    facing_symbols = {},
    symbols = {
        common = {
            -- spr, val
            {23, 5},  --plum
            {24, 4},  --lemon
            {26, 3}  --orange
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


function place_bet() 
    slots_square.current_bet += 10
    pq(slots_square.time_limit)
    slots_square.timer = slots_square.time_limit
    player_state.money -= 10
end


function payout()
    prev_symbol = nil
    for _, symbol in pairs(slots.facing_symbols) do
        if prev_symbol and prev_symbol != symbol then
            return 0
        end
        prev_symbol = symbol
    end
    return slots_square.current_bet
end


function build_reel(x, y)
    symbols = {}
    for i=1, 7 do 
        symbol = rnd(slots.symbols.common)
        add(symbols, symbol)
    end
    for i=1, 2 do 
        symbol = rnd(slots.symbols.uncommon)
        add(symbols, symbol)
    end
    symbol = rnd(slots.symbols.rare)
    add(symbols, symbol)
    return Reel:new(symbols, x, y)
end


function init()
    x = 10
    y = 10
    for i=1, slots.num_reels do
        add(slots.reels, build_reel(x, y))
        x += 10
    end
end


function roll_reels()
    --for i=1, slots.spin_time do 
        for _, reel in pairs(slots.reels) do
            --reel.facing_symbol = rnd(reel.symbols)
            reel.facing_symbol = slots.symbols.rare[1]
            add(slots.facing_symbols, reel.facing_symbol)
            reel:render()
        end
        winnings = payout() * slots.facing_symbols[1][2]
        player_state.money += winnings
        slots_square.current_bet = 0
    --end
end

bet_button = Button:new(place_bet, 64, 2, 2)
spin_button = Button:new(roll_reels, 66, 2, 2)

slots_square = GameSquare:new({bet_button, spin_button}, 1, 1, 64, slots.reels, 0, 0, 'slots', 60)
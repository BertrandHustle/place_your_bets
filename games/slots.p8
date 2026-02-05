slots = {
    current_bet = 0,
    symbols = {
        common = {
            plum = {23, 5},  -- spr, val
            lemon = {24, 4},
            orange = {26, 3}
        },
        uncommon = {
            diamond = {27, 50}
        },
        rare = {
            seven = {25, 100}
        }
    },
    num_reels = 3,
    reels = {},
    rows = 3,
    spin_time = 5
}

reel = {
    symbols = {},
    facing_symbol = nil
}

function place_bet(bet) 
    slots.current_bet += bet
end


function build_reel()
    reel = {}
    for i=1, 7 do 
        symbol = rnd(slots.symbols.common)
        add(reel, symbol)
    end
    for i=1, 2 do 
        symbol = rnd(slots.symbols.uncommon)
        add(reel, symbol)
    end
    symbol = rnd(slots.symbols.rare)
    add(reel, symbol)
    return reel
end


function init()
    for i=1, slots.num_reels do
        add(slots.reels, build_reel())
    end
end


function roll_reels()
    for i=1, slots.spin_time do 
        for _, reel in pairs(slots.reels) do
            reel.facing_symbol = rnd(reel)
            spr(reel.facing_symbol[1])
        end
    end
end

bet_button = Button:new(place_bet, 'bet', 14, 80, 120)
spin_button = Button:new(roll_reels, 'spin', 15, 90, 120)

slots_square = GameSquare:new({bet_button, spin_button}, 1, 1, 64, slots.reels, 0, 0, 'slots')
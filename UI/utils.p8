function highlight(sprite_val, x, y)
    -- https://ko-fi.com/achiegamedev
    -- draw the button sprite at x and y with a 1 pixel outline
    outline = 7
    thickness = 1
    x_size = 1
    y_size = 1
    
    -- set color palette to outline
    for i=1,15 do
        pal(i, outline)
    end

    -- handle black outline transparency issues
    if outline == 0 then
        palt(0, false)
    end

    -- draw the sprite 9 times by 1-1 offsets
    -- in each direction. the created blob is 
    -- which is the sprite's outline 
    for i=-thickness,thickness do
        for j=-thickness,thickness do
            spr(sprite_val, x-i, y-j, 1, 1)
        end
    end

    -- reset black color transparency
    if outline == 0 then
        palt(0, true)
    end

    -- reset color palette, if you are using
    -- a custom palette reset to that
    pal()

    -- draw the original sprite in the middle
    -- which causes the outline effect
    spr(sprite_val, x, y, x_size, y_size)
end
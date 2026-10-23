sclines = [12,24,36,48]
speed = 3
syms = [-24,-12,0,12,24,36,48]
tracker = {x: [] for x in range(1,8)}

for spins in range(60):
    for ix, sym in enumerate(syms):
        syms[ix] += speed
        if sym > 47:
            syms[ix] = sclines[0] - 12*3
        tracker[ix+1].append(sym)

for ix,sym in enumerate(syms):
    if ix+1 < len(syms):
        if sym - syms[ix+1] != 10:
            print('FAIL')
            print(tracker)
            break
    print('SUCCESS')


# [-3,-2,-1,0,1,2,3]
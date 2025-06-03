import strutils

let 
    strdata = readFile("data").strip().splitLines()

var 
    empty:int
    pos:(int,int)
    sum = 0

for i in 0 ..< strdata.len:
    if strdata[i] == "":
        empty = i
        break
    
    for j in 0 ..< strdata[i].len:
        if strdata[i][j] == '@':
            pos = (i,j)

let instructions = join(strdata[empty+1 .. ^1])
var map = strdata[0 ..< empty]
for i in 0 ..< map.len:
    echo map[i]

for i in 0 ..< instructions.len:
    if instructions[i] == '<':
        var m = 1
        while map[pos[0]][pos[1]-m] != '.' and map[pos[0]][pos[1]-m] != '#':
            m += 1
        if map[pos[0]][pos[1]-m] == '#':
            continue
        
        for j in countdown(m,1):
            map[pos[0]][pos[1]-j] = map[pos[0]][pos[1]-j+1]
        map[pos[0]][pos[1]] = '.'
        pos = (pos[0], pos[1]-1)

    elif instructions[i] == '^':
        var m = 1
        while map[pos[0]-m][pos[1]] != '.' and map[pos[0]-m][pos[1]] != '#':
            m += 1
        if map[pos[0]-m][pos[1]] == '#':
            continue
        
        for j in countdown(m,1):
            map[pos[0]-j][pos[1]] = map[pos[0]-j+1][pos[1]]
        map[pos[0]][pos[1]] = '.'
        pos = (pos[0]-1, pos[1])

    elif instructions[i] == '>':
        var m = 1
        while map[pos[0]][pos[1]+m] != '.' and map[pos[0]][pos[1]+m] != '#':
            m += 1
        if map[pos[0]][pos[1]+m] == '#':
            continue
        
        for j in countdown(m,1):
            map[pos[0]][pos[1]+j] = map[pos[0]][pos[1]+j-1]
        map[pos[0]][pos[1]] = '.'
        pos = (pos[0], pos[1]+1)

    else:
        var m = 1
        while map[pos[0]+m][pos[1]] != '.' and map[pos[0]+m][pos[1]] != '#':
            m += 1
        if map[pos[0]+m][pos[1]] == '#':
            continue
        
        for j in countdown(m,1):
            map[pos[0]+j][pos[1]] = map[pos[0]+j-1][pos[1]]
        map[pos[0]][pos[1]] = '.'
        pos = (pos[0]+1, pos[1])

for i in 0 ..< map.len:
    for j in 0 ..< map[i].len:
        if map[i][j] == 'O':
            sum += 100*i+j

for i in 0 ..< map.len:
    echo map[i]

echo sum
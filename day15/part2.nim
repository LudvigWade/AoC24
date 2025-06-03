import strutils
import deques

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

let instructions = join(strdata[empty+1 .. ^1])
var map = newSeq[string](empty)
for i in 0 ..< empty:
    for j in 0 ..< strdata[i].len:
        if strdata[i][j] == '#':
            map[i].add("##")
        elif strdata[i][j] == 'O':
            map[i].add("[]")
        elif strdata[i][j] == '.':
            map[i].add("..")
        else:
            map[i].add("@.")
            pos = (i,map[i].len-2)

for i in 0 ..< map.len:
    echo map[i]

for i in 0 ..< instructions.len:
    var 
        next = initDeque[(int,int)]()
        pushable = true
        beingPushed = initDeque[(int,int)]()
    if instructions[i] == '<':
        next.addFirst((pos[0],pos[1]-1))
        while next.len != 0:
            let (x,y) = next.popFirst()
            if map[x][y] == '#':
                pushable = false
                break
            elif map[x][y] == ']':
                beingPushed.addLast((x,y))
                beingPushed.addLast((x,y-1))
                next.addLast((x,y-2))
        if not pushable:
            continue
        let len = beingPushed.len
        for j in 0 ..< len:
            let (x,y) = beingPushed.popLast()
            map[x][y-1] = map[x][y]
        map[pos[0]][pos[1]] = '.'
        map[pos[0]][pos[1]-1] = '@'
        pos = (pos[0], pos[1]-1)

    elif instructions[i] == '^':
        next.addFirst((pos[0]-1,pos[1]))
        while next.len != 0:
            let (x,y) = next.popFirst()
            if map[x][y] == '#':
                pushable = false
                break
            elif map[x][y] == '[':
                if not next.contains((x,y+1)) and not beingPushed.contains((x,y+1)):
                    next.addLast((x,y+1))
                next.addLast((x-1,y))
                beingPushed.addLast((x,y))
            elif map[x][y] == ']':
                if not next.contains((x,y-1)) and not beingPushed.contains((x,y-1)):
                    next.addLast((x,y-1))
                next.addLast((x-1,y))
                beingPushed.addLast((x,y))
        if not pushable:
            continue
        let len = beingPushed.len
        for j in 0 ..< len:
            let (x,y) = beingPushed.popLast()
            map[x-1][y] = map[x][y]
            map[x][y] = '.'
        map[pos[0]][pos[1]] = '.'
        map[pos[0]-1][pos[1]] = '@'
        pos = (pos[0]-1, pos[1])

    elif instructions[i] == '>':
        next.addFirst((pos[0],pos[1]+1))
        while next.len != 0:
            let (x,y) = next.popFirst()
            if map[x][y] == '#':
                pushable = false
                break
            elif map[x][y] == '[':
                beingPushed.addLast((x,y))
                beingPushed.addLast((x,y+1))
                next.addLast((x,y+2))
        if not pushable:
            continue
        let len = beingPushed.len
        for j in 0 ..< len:
            let (x,y) = beingPushed.popLast()
            map[x][y+1] = map[x][y]
        map[pos[0]][pos[1]] = '.'
        map[pos[0]][pos[1]+1] = '@'
        pos = (pos[0], pos[1]+1)

    else:
        next.addFirst((pos[0]+1,pos[1]))
        while next.len != 0:
            let (x,y) = next.popFirst()
            if map[x][y] == '#':
                pushable = false
                break
            elif map[x][y] == '[':
                if not next.contains((x,y+1)) and not beingPushed.contains((x,y+1)):
                    next.addLast((x,y+1))
                next.addLast((x+1,y))
                beingPushed.addLast((x,y))
            elif map[x][y] == ']':
                if not next.contains((x,y-1)) and not beingPushed.contains((x,y-1)):
                    next.addLast((x,y-1))
                next.addLast((x+1,y))
                beingPushed.addLast((x,y))
        if not pushable:
            continue
        let len = beingPushed.len
        for j in 0 ..< len:
            let (x,y) = beingPushed.popLast()
            map[x+1][y] = map[x][y]
            map[x][y] = '.'
        map[pos[0]][pos[1]] = '.'
        map[pos[0]+1][pos[1]] = '@'
        pos = (pos[0]+1, pos[1])

for i in 0 ..< map.len:
    for j in 0 ..< map[i].len:
        if map[i][j] == '[':
            sum += 100*i+j

for i in 0 ..< map.len:
    echo map[i]

echo sum
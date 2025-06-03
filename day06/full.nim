import strutils
import sets

let 
    strdata = readFile("data").strip() # "newline" starts at 132

var
    map = strdata.splitLines()
    guardloc:(int,int) = (strdata.find('^') div (map.len+2), strdata.find('^')%%(map.len+2))
    guarddir = 0 # 0 = North, 1 = East, 2 = South, 3 = West
    path = initHashSet[(int,int)]()
    visited = initHashSet[(int,int,int)]()
    repeat = false
    res = 0
path.incl(guardloc)

while guardloc[0] > 0 and guardloc[0] < map.len-1 and guardloc[1] > 0 and guardloc[1] < map.len-1:
    if guarddir == 0:
        if map[guardloc[0]-1][guardloc[1]] == '#':
            guarddir = 1
            continue
        guardloc = (guardloc[0]-1, guardloc[1])
    
    elif guarddir == 1:
        if map[guardloc[0]][guardloc[1]+1] == '#':
            guarddir = 2
            continue
        guardloc = (guardloc[0], guardloc[1]+1)
    
    elif guarddir == 2:
        if map[guardloc[0]+1][guardloc[1]] == '#':
            guarddir = 3
            continue
        guardloc = (guardloc[0]+1, guardloc[1])
    
    elif guarddir == 3:
        if map[guardloc[0]][guardloc[1]-1] == '#':
            guarddir = 0
            continue
        guardloc = (guardloc[0], guardloc[1]-1)
    
    path.incl(guardloc)

echo path.len()

for x,y in path.items:
    map = strdata.splitLines()
    guardloc = (strdata.find('^') div (map.len+2), strdata.find('^')%%(map.len+2))
    guarddir = 0 # 0 = North, 1 = East, 2 = South, 3 = West
    visited.clear()
    visited.incl((guardloc[0],guardloc[1],guarddir))
    repeat = false
    if x == guardloc[0] and y == guardloc[1]:
        continue
    else:
        map[x][y] = '#'
    while guardloc[0] > 0 and guardloc[0] < map.len-1 and guardloc[1] > 0 and guardloc[1] < map.len-1 and not repeat:
        if guarddir == 0:
            if map[guardloc[0]-1][guardloc[1]] == '#':
                guarddir = 1
            else:
                guardloc = (guardloc[0]-1, guardloc[1])
        
        elif guarddir == 1:
            if map[guardloc[0]][guardloc[1]+1] == '#':
                guarddir = 2
            else:
                guardloc = (guardloc[0], guardloc[1]+1)
        
        elif guarddir == 2:
            if map[guardloc[0]+1][guardloc[1]] == '#':
                guarddir = 3
            else:
                guardloc = (guardloc[0]+1, guardloc[1])
        
        elif guarddir == 3:
            if map[guardloc[0]][guardloc[1]-1] == '#':
                guarddir = 0
            else:
                guardloc = (guardloc[0], guardloc[1]-1)
        
        if visited.contains((guardloc[0],guardloc[1],guarddir)):
            repeat = true
        visited.incl((guardloc[0],guardloc[1],guarddir))
    if repeat:
        res += 1

echo res
import strutils
import sets

let 
    strdata = readFile("data").strip() # "newline" starts at 132

var
    map = strdata.splitLines()
    guardloc:(int,int) = (strdata.find('^') div 132, strdata.find('^')%%132)
    guarddir = 0 # 0 = North, 1 = East, 2 = South, 3 = West
    visited = initHashSet[(int,int,int)]()
    repeat = false
    res = 0
visited.incl((guardloc[0],guardloc[1],guarddir))

for i in 0 ..< map.len:
    for j in 0 ..< map[0].len:
        echo i, j
        map = strdata.splitLines()
        guardloc = (strdata.find('^') div 132, strdata.find('^')%%132)
        guarddir = 0 # 0 = North, 1 = East, 2 = South, 3 = West
        visited.clear()
        repeat = false
        if i == guardloc[0] and j == guardloc[1]:
            continue
        else:
            map[i][j] = '#'
        while guardloc[0] > 0 and guardloc[0] < 129 and guardloc[1] > 0 and guardloc[1] < 129 and not repeat:
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
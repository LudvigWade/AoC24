import strutils
import sequtils
import sets

let 
    strdata = readFile("data").strip() # "newline" starts at 132

var
    map = strdata.splitLines()
    guardloc:(int,int) = (strdata.find('^') div 132, strdata.find('^')%%132)
    guarddir = 0 # 0 = North, 1 = East, 2 = South, 3 = West
    visited = initHashSet[(int,int)]()
visited.incl(guardloc)

while guardloc[0] > 0 and guardloc[0] < 129 and guardloc[1] > 0 and guardloc[1] < 129:
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
    
    visited.incl(guardloc)

echo visited.len()

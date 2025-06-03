import strutils
import sequtils
import sets

let 
    strdata = readFile("data").strip().splitLines()

var
    fallen = newSeq[(int,int)]()
    size = 71 #Change for actual data
    start = (0,0)
    finish = (size-1,size-1)
    steps = 1024
    map:seq[seq[char]] = newSeq[seq[char]](size)
for i in 0 ..< map.len:
    map[i] = newSeq[char](size)
    for j in 0 ..< map[i].len:
        map[i][j] = '.'
for i in 0 ..< strdata.len:
    fallen.add((strdata[i].split(',')[0].parseInt(), strdata[i].split(',')[1].parseInt()))

for i in 0 ..< steps:
    let (x,y) = fallen[i]
    map[x][y] = '#'

var
    nextlist = newSeq[(int,int)]()
    visited = initHashSet[(int,int)]()
    currentlist = newSeq[(int,int)]()
    nbrofsteps = -1
currentlist.add(start)

while currentlist.len != 0 or nextlist.len != 0:
    nbrofsteps += 1
    for (x,y) in currentlist:
        if (x,y) == finish:
            currentlist.setLen(0)
            nextlist.setLen(0)
            break
        if x-1 >= 0 and map[x-1][y] != '#' and not visited.contains((x-1, y)):
            nextlist.add((x-1,y))
            visited.incl((x-1,y))
        if x+1 < map.len and map[x+1][y] != '#' and not visited.contains((x+1, y)):
            nextlist.add((x+1,y))
            visited.incl((x+1,y))
        if y-1 >= 0 and map[x][y-1] != '#' and not visited.contains((x, y-1)):
            nextlist.add((x,y-1))
            visited.incl((x,y-1))
        if y+1 < map[x].len and map[x][y+1] != '#' and not visited.contains((x,y+1)):
            nextlist.add((x,y+1))
            visited.incl((x,y+1))
    currentlist = nextlist
    nextlist.setLen(0)
echo nbrofsteps
    


        


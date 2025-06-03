import strutils
import sequtils

var 
    strdata = readFile("data").strip()
    map = strdata.splitLines()
    start:(int,int) = (strdata.find("S") div (map.len+2) , strdata.find("S") mod (map.len+2))
    finish:(int,int) = (strdata.find("E") div (map.len+2) , strdata.find("E") mod (map.len+2))
    path = newSeq[(int,int)]()
    visited = newSeq[(int,int)]()
    sum = 0

var current = start
visited.add(start)
while current != finish:
    path.add(current)
    if map[current[0]-1][current[1]] != '#' and not visited.contains((current[0]-1,current[1])):
        current = (current[0]-1,current[1])
        visited.add(current)
        continue
    elif map[current[0]+1][current[1]] != '#' and not visited.contains((current[0]+1,current[1])):
        current = (current[0]+1,current[1])
        visited.add(current)
        continue
    elif map[current[0]][current[1]-1] != '#' and not visited.contains((current[0],current[1]-1)):
        current = (current[0],current[1]-1)
        visited.add(current)
        continue
    elif map[current[0]][current[1]+1] != '#' and not visited.contains((current[0],current[1]+1)):
        current = (current[0],current[1]+1)
        visited.add(current)
        continue
path.add(finish)

let threshold = 100
var newpath = path
for i in 0 ..< newpath.len:
    let (x,y) = newpath[i]
    let jump = @[(x-2,y),(x+2,y),(x,y-2),(x,y+2)]
    newpath[i] = (0,0)
    for cheat in jump.items:
        if newpath.find(cheat)-i >= threshold+2:
            sum += 1

echo sum
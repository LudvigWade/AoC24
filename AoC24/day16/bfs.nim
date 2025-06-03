import strutils
import deques
import sets

var 
    strdata = readFile("data").strip()
    map = strdata.splitLines()
    start:(int,int) = (strdata.find("S") div (map.len+2) , strdata.find("S") mod (map.len+2))
    finish:(int,int) = (strdata.find("E") div (map.len+2) , strdata.find("E") mod (map.len+2))

echo start
echo finish

var
    visited = initHashSet[(int,int)]()
    next = initDeque[(int,int,(int,int))]()
    backtrack = newSeq[seq[(int,int)]](map.len)
    path = newSeq[(int,int)]()

for i in 0 ..< map.len:
    backtrack[i] = newSeq[(int,int)](map[i].len)

next.addFirst((start[0],start[1],start))
visited.incl(start)
while next.len != 0:
    let current = next.popFirst()
    backtrack[current[0]][current[1]] = current[2]
    if (current[0],current[1]) == finish:
        break
    if not visited.contains((current[0]-1,current[1])) and map[current[0]-1][current[1]] != '#': # North
        next.addLast((current[0]-1,current[1],(current[0],current[1])))
        visited.incl((current[0]-1,current[1]))
    if not visited.contains((current[0],current[1]+1)) and map[current[0]][current[1]+1] != '#': # East
        next.addLast((current[0],current[1]+1,(current[0],current[1])))
        visited.incl((current[0],current[1]+1))
    if not visited.contains((current[0]+1,current[1])) and map[current[0]+1][current[1]] != '#': # South
        next.addLast((current[0]+1,current[1],(current[0],current[1])))
        visited.incl((current[0]+1,current[1]))
    if not visited.contains((current[0],current[1]-1)) and map[current[0]][current[1]-1] != '#': # West
        next.addLast((current[0],current[1]-1,(current[0],current[1])))
        visited.incl((current[0],current[1]-1))

var current = finish
while current != start:
    path.add(current)
    if current != finish:
        strdata[current[0]*(map.len+2)+current[1]] = 'O'
    current = backtrack[current[0]][current[1]]
path.add(start)
echo strdata
echo path
        


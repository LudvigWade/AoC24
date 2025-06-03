import strutils
import heapqueue
import sets

type Node = tuple[x:int,y:int,w:int,dir:int]

proc `<`(a, b: Node): bool = a.w < b.w

proc `==`(a, b: Node): bool = a.x == b.x and a.y == b.y and a.dir == b.dir

var 
    strdata = readFile("testdata").strip()
    map = strdata.splitLines()
    start:(int,int) = (strdata.find("S") div (map.len+2) , strdata.find("S") mod (map.len+2))
    finish:(int,int) = (strdata.find("E") div (map.len+2) , strdata.find("E") mod (map.len+2))

echo start
echo finish

var
    next = initHeapQueue[Node]()
    res = newSeq[Node]()
    prev: Node
    visited = initHashSet[(int,int,int)]()

for i in 0 ..< map.len:
    for j in 0 ..< map[i].len:
        if map[i][j] != '#':
            for k in 0 ..< 4:
                next.push((i,j,high(int),k)) # N = 0, E = 1, S = 2, W = 3
            

next.del(next.find((start[0],start[1],0,1)))
next.push((start[0],start[1],0,1))

while next.len != 0:
    let current = next.pop()
    if visited.contains((current.x,current.y,current.dir)):
        continue
    visited.incl((current.x,current.y,current.dir))
    if current.w == high(int):
        var brokennodes = newSeq[Node]()
        for i in 0..<next.len:
            if next[i].w < high(int):
                brokennodes.add(next[i])
        if brokennodes.len == 0:
            break
        echo "bad implementation moment"
        break
    if finish == (current.x, current.y):
        res.add(current)
        continue
    var toAdd = newSeq[Node]()
    case current.dir:
        of 0:
            var cand = next.find((current.x-1,current.y,0,0)) # Go North
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x-1,current.y,current.w+1,0))

            cand = next.find((current.x,current.y,0,1)) # Turn East
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y+1,0,1)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,1))

            cand = next.find((current.x,current.y,0,3)) # Turn West
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y-1,0,3)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,3))

        of 1:
            var cand = next.find((current.x,current.y+1,0,1)) # Go East
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x,current.y+1,current.w+1,1))

            cand = next.find((current.x,current.y,0,0)) # Turn North
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x-1,current.y,0,0)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,0))

            cand = next.find((current.x,current.y,0,2)) # Turn South
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x+1,current.y,0,2)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,2))

        of 2:
            var cand = next.find((current.x+1,current.y,0,2)) # Go South
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x+1,current.y,current.w+1,2))

            cand = next.find((current.x,current.y,0,1)) # Turn East
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y+1,0,1)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,1))

            cand = next.find((current.x,current.y,0,3)) # Turn West
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y-1,0,3)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,3))

        of 3:
            var cand = next.find((current.x,current.y-1,0,3)) # Go West
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x,current.y-1,current.w+1,3))

            cand = next.find((current.x,current.y,0,0)) # Turn North
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x-1,current.y,0,0)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,0))

            cand = next.find((current.x,current.y,0,2)) # Turn South
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x+1,current.y,0,2)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,2))

        else:
            echo "broken code"
    for n in toAdd.items:
        next.push(n)
    if prev.w > current.w:
        echo "bad implementation of del"
        break
    prev = current

for (x,y,z) in visited.items:
    if finish == (x,y):
        continue
    strdata[x*(map.len+2)+y] = 'O'

echo strdata
echo res
import strutils
import heapqueue
import sets

type Node = tuple[x:int,y:int,w:int,dir:int]

proc `<`(a, b: Node): bool = a.w < b.w

proc `==`(a, b: Node): bool = a.x == b.x and a.y == b.y and a.dir == b.dir

proc `<`(a,b: tuple[val1:int,val2:int,val3:int]): bool = a.val3 < b.val3

var 
    strdata = readFile("data").strip()
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
    backtrack = newSeq[seq[seq[seq[(int,int,int)]]]](map.len)

for i in 0 ..< map.len:
    backtrack[i] = newSeq[seq[seq[(int,int,int)]]](map[i].len)
    for j in 0 ..< map[i].len:
        backtrack[i][j] = newSeq[seq[(int,int,int)]](4)
        for k in 0 ..< 4:
            backtrack[i][j][k] = newSeq[(int,int,int)]()

for i in 0 ..< map.len:
    for j in 0 ..< map[i].len:
        if map[i][j] != '#':
            for k in 0 ..< 4:
                next.push((i,j,high(int),k)) # N = 0, E = 1, S = 2, W = 3
            

next.del(next.find((start[0],start[1],0,1)))
next.push((start[0],start[1],0,1))

while next.len != 0:
    let current = next.pop()
    if res.len != 0 and current.w > res[0].w:
        break
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
            var repeat = false
            for (x,y,z) in backtrack[current.x][current.y][2]:
                if (x,y) == (current.x-1,current.y) and z < current.w:
                    repeat = true
                    break
            if repeat:
                continue
            var cand = next.find((current.x-1,current.y,0,0)) # Go North
            if current.x == 8 and current.y == 5:
                echo next[cand]
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x-1,current.y,current.w+1,0))
                backtrack[current.x-1][current.y][0].add((current.x,current.y,current.w+1))
                backtrack[current.x-1][current.y][1].add((current.x,current.y,current.w+1001))
                backtrack[current.x-1][current.y][3].add((current.x,current.y,current.w+1001))
            elif cand >= 0 and next[cand].w == current.w+1:
                backtrack[current.x-1][current.y][0].add((current.x,current.y,current.w+1))
                backtrack[current.x-1][current.y][1].add((current.x,current.y,current.w+1001))
                backtrack[current.x-1][current.y][3].add((current.x,current.y,current.w+1001))

            cand = next.find((current.x,current.y,0,1)) # Turn East
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y+1,0,1)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,1))

            cand = next.find((current.x,current.y,0,3)) # Turn West
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y-1,0,3)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,3))

        of 1:
            var repeat = false
            for (x,y,z) in backtrack[current.x][current.y][3]:
                if (x,y) == (current.x,current.y+1) and z < current.w:
                    repeat = true
                    break
            if repeat:
                continue
            var cand = next.find((current.x,current.y+1,0,1)) # Go East
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x,current.y+1,current.w+1,1))
                backtrack[current.x][current.y+1][1].add((current.x,current.y,current.w+1))
                backtrack[current.x][current.y+1][0].add((current.x,current.y,current.w+1001))
                backtrack[current.x][current.y+1][2].add((current.x,current.y,current.w+1001))
            elif cand >= 0 and next[cand].w == current.w+1:
                backtrack[current.x][current.y+1][1].add((current.x,current.y,current.w+1))
                backtrack[current.x][current.y+1][0].add((current.x,current.y,current.w+1001))
                backtrack[current.x][current.y+1][2].add((current.x,current.y,current.w+1001))

            cand = next.find((current.x,current.y,0,0)) # Turn North
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x-1,current.y,0,0)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,0))

            cand = next.find((current.x,current.y,0,2)) # Turn South
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x+1,current.y,0,2)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,2))

        of 2:
            var repeat = false
            for (x,y,z) in backtrack[current.x][current.y][0]:
                if (x,y) == (current.x+1,current.y) and z < current.w:
                    repeat = true
                    break
            if repeat:
                continue
            var cand = next.find((current.x+1,current.y,0,2)) # Go South
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x+1,current.y,current.w+1,2))
                backtrack[current.x+1][current.y][2].add((current.x,current.y,current.w+1))
                backtrack[current.x+1][current.y][1].add((current.x,current.y,current.w+1001))
                backtrack[current.x+1][current.y][3].add((current.x,current.y,current.w+1001))
            elif cand >= 0 and next[cand].w == current.w+1:
                backtrack[current.x+1][current.y][2].add((current.x,current.y,current.w+1))
                backtrack[current.x+1][current.y][1].add((current.x,current.y,current.w+1001))
                backtrack[current.x+1][current.y][3].add((current.x,current.y,current.w+1001))

            cand = next.find((current.x,current.y,0,1)) # Turn East
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y+1,0,1)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,1))

            cand = next.find((current.x,current.y,0,3)) # Turn West
            if cand >= 0 and next[cand].w > current.w+1000 and next.find((current.x,current.y-1,0,3)) >= 0:
                toAdd.add((current.x,current.y,current.w+1000,3))

        of 3:
            var repeat = false
            for (x,y,z) in backtrack[current.x][current.y][1]:
                if (x,y) == (current.x,current.y-1) and z < current.w:
                    repeat = true
                    break
            if repeat:
                continue
            var cand = next.find((current.x,current.y-1,0,3)) # Go West
            if cand >= 0 and next[cand].w > current.w+1:
                toAdd.add((current.x,current.y-1,current.w+1,3))
                backtrack[current.x][current.y-1][3].add((current.x,current.y,current.w+1))
                backtrack[current.x][current.y-1][0].add((current.x,current.y,current.w+1001))
                backtrack[current.x][current.y-1][2].add((current.x,current.y,current.w+1001))
            elif cand >= 0 and next[cand].w == current.w+1:
                backtrack[current.x][current.y-1][3].add((current.x,current.y,current.w+1))
                backtrack[current.x][current.y-1][0].add((current.x,current.y,current.w+1001))
                backtrack[current.x][current.y-1][2].add((current.x,current.y,current.w+1001))

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

var 
    findpath = newSeq[((int,int),(int,int))]()
    nbrinpath = 0
findpath.add((finish,(finish[0]-1,finish[1])))
findpath.add((finish,(finish[0],finish[1]-1)))

while findpath.len != 0:
    var prev:tuple[x:int,y:int]
    var curr:tuple[x:int,y:int]
    (prev,curr) = findpath.pop()
    var dir:int
    if curr.x-prev.x == -1:
        dir = 0
    elif curr.x-prev.x == 1:
        dir = 2
    elif curr.y-prev.y == 1:
        dir = 1
    else:
        dir = 3
    if strdata[prev.x*(map.len+2)+prev.y] != 'O':
        nbrinpath += 1
        strdata[prev.x*(map.len+2)+prev.y] = 'O'
    
    for (x,y,z) in backtrack[prev.x][prev.y][dir].items:
        if z == backtrack[prev.x][prev.y][dir].min()[2]:
            findpath.add(((x,y),(prev.x,prev.y)))

echo strdata
echo nbrinpath
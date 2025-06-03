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
    map:seq[seq[char]] = newSeq[seq[char]](size)
for i in 0 ..< map.len:
    map[i] = newSeq[char](size)
    for j in 0 ..< map[i].len:
        map[i][j] = '.'
for i in 0 ..< strdata.len:
    fallen.add((strdata[i].split(',')[0].parseInt(), strdata[i].split(',')[1].parseInt()))

var path = initHashSet[(int,int)]()

for i in 0 ..< fallen.len:
    let (x,y) = fallen[i]
    map[x][y] = '#'

    if path.len == 0 or path.contains((x,y)):
        var
            nextlist = newSeq[(int,int)]()
            visited = initHashSet[(int,int)]()
            currentlist = newSeq[(int,int)]()
            success = false
            
            backtrack = newSeq[seq[(int,int)]](map.len)
        for i in 0 ..< map.len:
            backtrack[i] = newSeq[(int,int)](map[i].len)

        currentlist.add(start)

        while currentlist.len != 0 or nextlist.len != 0:
            for (x,y) in currentlist:
                if (x,y) == finish:
                    success = true
                    currentlist.setLen(0)
                    nextlist.setLen(0)
                    break
                if x-1 >= 0 and map[x-1][y] != '#' and not visited.contains((x-1, y)):
                    nextlist.add((x-1,y))
                    backtrack[x-1][y] = (x,y)
                    visited.incl((x-1,y))
                if x+1 < map.len and map[x+1][y] != '#' and not visited.contains((x+1, y)):
                    nextlist.add((x+1,y))
                    backtrack[x+1][y] = (x,y)
                    visited.incl((x+1,y))
                if y-1 >= 0 and map[x][y-1] != '#' and not visited.contains((x, y-1)):
                    nextlist.add((x,y-1))
                    backtrack[x][y-1] = (x,y)
                    visited.incl((x,y-1))
                if y+1 < map[x].len and map[x][y+1] != '#' and not visited.contains((x,y+1)):
                    nextlist.add((x,y+1))
                    backtrack[x][y+1] = (x,y)
                    visited.incl((x,y+1))
            currentlist = nextlist
            nextlist.setLen(0)
        if success:
            var current = finish
            while current != start:
                path.incl(current)
                current = backtrack[current[0]][current[1]]
        else:
            echo fallen[i]
            break


        


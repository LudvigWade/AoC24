import strutils
import sets

let 
    strdata = readFile("data").strip().splitLines()

var
    regions = newSeq[HashSet[(int,int)]]()
    regionperimeter = newSeq[int]()
    visited = initHashSet[(int, int)]()
    sum = 0

for i in 0 ..< strdata.len:
    for j in 0 ..< strdata[i].len:
        if visited.contains((i, j)):
            continue
        regions.add(initHashSet[(int, int)]())
        var next = newSeq[(int, int)]()
        next.add((i, j))
        visited.incl((i, j))
        regions[^1].incl((i, j))
        while next.len > 0:
            let (x, y) = next.pop()
            if x-1 >= 0 and strdata[x-1][y] == strdata[x][y]:
                if not visited.contains((x-1, y)):
                    next.add((x-1, y))
                    visited.incl((x-1, y))
                    regions[^1].incl((x-1, y))
            if x+1 < strdata.len and strdata[x+1][y] == strdata[x][y]:
                if not visited.contains((x+1, y)):
                    next.add((x+1, y))
                    visited.incl((x+1, y))
                    regions[^1].incl((x+1, y))
            if y-1 >= 0 and strdata[x][y-1] == strdata[x][y]:
                if not visited.contains((x, y-1)):
                    next.add((x, y-1))
                    visited.incl((x, y-1))
                    regions[^1].incl((x, y-1))
            if y+1 < strdata.len and strdata[x][y+1] == strdata[x][y]:
                if not visited.contains((x, y+1)):
                    next.add((x, y+1))
                    visited.incl((x, y+1))
                    regions[^1].incl((x, y+1))
            
for i in 0 ..< regions.len:
    regionperimeter.add(0)
    for (x,y) in regions[i]:
        if not (y-1 >= 0 and regions[i].contains((x, y-1))):
            if x-1 >= 0 and y-1 >= 0 and regions[i].contains((x-1, y-1)):
                regionperimeter[i] += 1
            elif not (x-1 >= 0 and regions[i].contains((x-1, y))):
                regionperimeter[i] += 1

        if not (x-1 >= 0 and regions[i].contains((x-1, y))):
            if x-1 >= 0 and y+1 < strdata[x-1].len and regions[i].contains((x-1, y+1)):
                regionperimeter[i] += 1
            elif not (y+1 < strdata[x].len and regions[i].contains((x, y+1))):
                regionperimeter[i] += 1

        if not (x+1 < strdata.len and regions[i].contains((x+1, y))):
            if x+1 < strdata.len and y-1 >= 0 and regions[i].contains((x+1, y-1)):
                regionperimeter[i] += 1
            elif not (y-1 >= 0 and regions[i].contains((x, y-1))):
                regionperimeter[i] += 1

        if not (y+1 < strdata[x].len and regions[i].contains((x, y+1))):
            if x+1 < strdata.len and y+1 < strdata[x+1].len and regions[i].contains((x+1, y+1)):
                regionperimeter[i] += 1
            elif not (x+1 < strdata.len and regions[i].contains((x+1, y))):
                regionperimeter[i] += 1

for i in 0 ..< regions.len:
    sum += regions[i].len * regionperimeter[i]

echo sum
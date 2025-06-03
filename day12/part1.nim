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
        regionperimeter.add(0)
        var next = newSeq[(int, int)]()
        next.add((i, j))
        visited.incl((i, j))
        regions[^1].incl((i, j))
        while next.len > 0:
            let (x, y) = next.pop()
            var edges = 4
            if x-1 >= 0 and strdata[x-1][y] == strdata[x][y]:
                if not visited.contains((x-1, y)):
                    next.add((x-1, y))
                    visited.incl((x-1, y))
                    regions[^1].incl((x-1, y))
                edges -= 1
            if x+1 < strdata.len and strdata[x+1][y] == strdata[x][y]:
                if not visited.contains((x+1, y)):
                    next.add((x+1, y))
                    visited.incl((x+1, y))
                    regions[^1].incl((x+1, y))
                edges -= 1
            if y-1 >= 0 and strdata[x][y-1] == strdata[x][y]:
                if not visited.contains((x, y-1)):
                    next.add((x, y-1))
                    visited.incl((x, y-1))
                    regions[^1].incl((x, y-1))
                edges -= 1
            if y+1 < strdata.len and strdata[x][y+1] == strdata[x][y]:
                if not visited.contains((x, y+1)):
                    next.add((x, y+1))
                    visited.incl((x, y+1))
                    regions[^1].incl((x, y+1))
                edges -= 1
            regionperimeter[^1] += edges

for i in 0 ..< regions.len:
    sum += regions[i].len * regionperimeter[i]

echo sum
import strutils
import tables

let 
    strdata = readFile("data").strip()

var 
    linedata = strdata.splitLines()
    antennas = initTable[char, seq[(int,int)]]()
    sum = 0

for i in 0 ..< strdata.len:
    if strdata[i] != '.' and strdata[i] != '\r' and strdata[i] != '\n':
        if not antennas.hasKey(strdata[i]):
            antennas[strdata[i]] = @[]
        antennas[strdata[i]].add((i div (linedata.len+2), i%%(linedata.len+2)))

for k in antennas.keys:
    let locs = antennas[k]
    for i in 0 ..< locs.len:
        for j in 0 ..< locs.len:
            if i == j:
                continue
            if 2*locs[i][0]-locs[j][0] >= 0 and 2*locs[i][0]-locs[j][0] < linedata.len and 
            2*locs[i][1]-locs[j][1] >= 0 and 2*locs[i][1]-locs[j][1] < linedata[0].len and 
            linedata[2*locs[i][0]-locs[j][0]][2*locs[i][1]-locs[j][1]] != '#':
                linedata[2*locs[i][0]-locs[j][0]][2*locs[i][1]-locs[j][1]] = '#'
                sum += 1

echo sum
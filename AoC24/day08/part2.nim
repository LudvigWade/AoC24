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
        sum += 1 #Antennas are antinodes
        for j in 0 ..< locs.len:
            if i == j:
                continue
            var m = 1
            while locs[i][0] - m*(locs[j][0]-locs[i][0]) >= 0 and locs[i][0] - m*(locs[j][0]-locs[i][0]) < linedata.len and 
            locs[i][1] - m*(locs[j][1]-locs[i][1]) >= 0 and locs[i][1] - m*(locs[j][1]-locs[i][1]) < linedata[0].len:
                if linedata[locs[i][0] - m*(locs[j][0]-locs[i][0])][locs[i][1] - m*(locs[j][1]-locs[i][1])] == '.':
                    linedata[locs[i][0] - m*(locs[j][0]-locs[i][0])][locs[i][1] - m*(locs[j][1]-locs[i][1])] = '#'
                    sum += 1
                m += 1

echo sum

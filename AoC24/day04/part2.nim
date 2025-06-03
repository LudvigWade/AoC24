import strutils
import algorithm
import sequtils

let 
    strdata = readFile("data").strip().splitLines()

var xmas = 0

for i in 0 ..< strdata.len:
    for j in 0 ..< strdata[0].len:
        if strdata[i][j] == 'A':
            if i > 0 and j > 0 and i+1 < strdata.len and j+1 < strdata[0].len:
                if ((strdata[i-1][j-1] == 'M' and strdata[i+1][j+1] == 'S') or (strdata[i-1][j-1] == 'S' and strdata[i+1][j+1] == 'M')) and ((strdata[i+1][j-1] == 'M' and strdata[i-1][j+1] == 'S') or (strdata[i+1][j-1] == 'S' and strdata[i-1][j+1] == 'M')):
                    xmas += 1
        else:
            continue

echo xmas
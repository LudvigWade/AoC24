import strutils
import algorithm
import sequtils

let 
    strdata = readFile("data").strip().splitLines()

var xmas = 0

for i in 0 ..< strdata.len:
    for j in 0 ..< strdata[0].len:
        if strdata[i][j] == 'X':
            if i-2 > 0 and j-2 > 0: 
                if strdata[i-1][j-1] == 'M':
                    if strdata[i-2][j-2] == 'A':
                        if strdata[i-3][j-3] == 'S':
                            xmas += 1
            if i-2 > 0: 
                if strdata[i-1][j] == 'M':
                    if strdata[i-2][j] == 'A':
                        if strdata[i-3][j] == 'S':
                            xmas += 1
            if i-2 > 0 and j+3 < strdata[0].len: 
                if strdata[i-1][j+1] == 'M':
                    if strdata[i-2][j+2] == 'A':
                        if strdata[i-3][j+3] == 'S':
                            xmas += 1

            if j-2 > 0: 
                if strdata[i][j-1] == 'M':
                    if strdata[i][j-2] == 'A':
                        if strdata[i][j-3] == 'S':
                            xmas += 1
            if j+3 < strdata[0].len: 
                if strdata[i][j+1] == 'M':
                    if strdata[i][j+2] == 'A':
                        if strdata[i][j+3] == 'S':
                            xmas += 1

            if i+3 < strdata.len and j-2 > 0: 
                if strdata[i+1][j-1] == 'M':
                    if strdata[i+2][j-2] == 'A':
                        if strdata[i+3][j-3] == 'S':
                            xmas += 1
            if i+3 < strdata.len: 
                if strdata[i+1][j] == 'M':
                    if strdata[i+2][j] == 'A':
                        if strdata[i+3][j] == 'S':
                            xmas += 1
            if i+3 < strdata.len and j+3 < strdata[0].len: 
                if strdata[i+1][j+1] == 'M':
                    if strdata[i+2][j+2] == 'A':
                        if strdata[i+3][j+3] == 'S':
                            xmas += 1
        else:
            continue

echo xmas
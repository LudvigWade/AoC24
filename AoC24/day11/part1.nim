import strutils
import sequtils

let 
    strdata = readFile("data").strip()

var nbrs = strdata.split(' ').map(parseInt)

for i in 0 ..< 25:
    var j = 0
    while j < nbrs.len:
        if nbrs[j] == 0:
            nbrs[j] = 1
        elif ($nbrs[j]).len%%2 == 0:
            nbrs.insert(parseInt(($nbrs[j])[($nbrs[j]).len div 2 .. ^1]), j+1)
            nbrs[j] = parseInt(($nbrs[j])[0 ..< ($nbrs[j]).len div 2])
            j += 1
        else:
            nbrs[j] *= 2024
        j += 1

echo nbrs.len
import strutils
import sequtils
import tables

let 
    strdata = readFile("data").strip()

var 
    nbrs = strdata.split(' ').map(parseInt)
    currentnbrs = initTable[int, int]()
    nextnbrs = initTable[int, int]()
    sum = 0
for i in nbrs:
    currentnbrs[i] = 1

for i in 0 ..< 75:
    for k in currentnbrs.keys:
        if k == 0:
            if nextnbrs.hasKeyOrPut(1, currentnbrs[k]):
                nextnbrs[1] += currentnbrs[k]
        elif ($k).len%%2 == 0:
            if nextnbrs.hasKeyOrPut(parseInt(($k)[($k).len div 2 .. ^1]), currentnbrs[k]):
                nextnbrs[parseInt(($k)[($k).len div 2 .. ^1])] += currentnbrs[k]
            if nextnbrs.hasKeyOrPut(parseInt(($k)[0 ..< ($k).len div 2]), currentnbrs[k]):
                nextnbrs[parseInt(($k)[0 ..< ($k).len div 2])] += currentnbrs[k]
        else:
            if nextnbrs.hasKeyOrPut(k*2024, currentnbrs[k]):
                nextnbrs[k*2024] += currentnbrs[k]
    currentnbrs = nextnbrs
    nextnbrs.clear()

for k in currentnbrs.keys:
    sum += currentnbrs[k]

echo sum
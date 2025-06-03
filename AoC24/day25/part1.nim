import strutils
import sequtils

let 
    strdata = readFile("data").strip().splitLines()
    data = strdata.distribute((strdata.len+1) div 8, false)

var
    keys:seq[seq[int]]
    locks:seq[seq[int]]
    pairs:int = 0

for kl in data.items:
    if kl[0][0] == '.':
        var tempkey = newSeq[int]()
        for i in 0 ..< 5:
            for j in countdown(5, 0):
                if kl[j][i] == '.':
                    tempkey.add(5-j)
                    break
        keys.add(tempkey)
    else:
        var templock = newSeq[int]()
        for i in 0 ..< 5:
            for j in countup(1, 6):
                if kl[j][i] == '.':
                    templock.add(j-1)
                    break
        locks.add(templock)

for lock in locks.items:
    for key in keys.items:
        for i in 0 ..< 5:
            if lock[i] + key[i] > 5:
                pairs -= i
                break
            pairs += 1
        
echo pairs div 5
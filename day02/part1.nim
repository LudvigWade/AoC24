import strutils
import sequtils

let 
    strdata = readFile("data").strip().splitLines()

var
    nbrofsafe = 0

for i in 0 ..< strdata.len:
    let active = strdata[i].split(' ').map(parseInt)
    var
        increasing = true
        safe = true
    

    if active[0] > active[1]:
        increasing = false
    
    for j in 0 ..< active.len-1:
        if increasing:
            if active[j] > active[j+1] or abs(active[j]-active[j+1])>3 or abs(active[j]-active[j+1])<1:
                safe = false
                break
        else:
            if active[j] < active[j+1] or abs(active[j]-active[j+1])>3 or abs(active[j]-active[j+1])<1:
                safe = false
                break
    
    if safe:
        nbrofsafe += 1

echo nbrofsafe
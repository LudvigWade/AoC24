import strutils
import sets
import deques

let strdata = readFile("data").strip().splitLines()
var 
    starts = initHashSet[(int,int)]()
    sum = 0

for i in 0 ..< strdata.len:
    for j in 0 ..< strdata[i].len:
        if strdata[i][j] == '0':
            starts.incl((i,j))
for x,y in starts.items:
    var 
        ind = 1
        next = initDeque[(int,int)]()
    next.addFirst((x,y))
    while next.len != 0:
        let (i,j) = next.popFirst()
        if parseInt($strdata[i][j]) == ind:
            ind += 1
        if ind == 10:
            next.addFirst((i,j))
            break
        if i > 0:
            if parseInt($strdata[i-1][j]) == ind:
                next.addLast((i-1,j))
        if i < strdata.len-1:
            if parseInt($strdata[i+1][j]) == ind:
                next.addLast((i+1,j))
        if j > 0:
            if parseInt($strdata[i][j-1]) == ind:
                next.addLast((i,j-1))
        if j < strdata[i].len-1:
            if parseInt($strdata[i][j+1]) == ind:
                next.addLast((i,j+1))
    sum += next.len

echo sum


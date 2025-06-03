import strutils

let 
    strdata = readFile("data").strip()
var
    list = newSeq[int]()
    sum = 0

for i in 0 ..< strdata.len:
    let k:int = parseInt($strdata[i])

    if i %% 2 == 1:
        for j in 0 ..< k:
            list.add(-1)
    else:
        for j in 0 ..< k:
            list.add(i div 2)

var i = 0
while i < list.len:
    if list[list.len-1] == -1:
        discard list.pop()
        continue

    if list[i] == -1:
        list[i] = list.pop()
    i += 1

for i in 0 ..< list.len:
    sum += list[i]*i


echo sum
    

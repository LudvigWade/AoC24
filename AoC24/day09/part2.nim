import strutils

let 
    strdata = readFile("data").strip()
var
    list = newSeq[int]()
    sum = 0

for i in 0 ..< strdata.len:
    let k:int = parseInt($strdata[i])

    if i %% 2 == 1:
        list.add(-1)
        list.add(k)
    else:
        list.add(i div 2)
        list.add(k)

if list[list.len-2] != -1:
    list.add(-1)
    list.add(0)

var id = (strdata.len-1) div 2
var i = (strdata.len-1) div 2
while list[4*i] != 0:
    if list[4*i] == id:
        id -= 1
        for j in 0 ..< 4*i:
            if list[j] == -1 and list[4*i+1] <= list[j+1]:
                list[j+1] = list[j+1]-list[4*i+1]
                list[4*i-1] += list[4*i+1]+list[4*i+3]
                list.insert(list[4*i+1],j)
                list.insert(list[4*i+1],j)
                list.insert(0,j)
                list.insert(-1,j)
                for k in 0 ..< 4:
                    list.delete(4*i+4)
                i += 1
                break
    i -= 1
var pos = 0
for i in 0 ..< list.len div 2:
    if list[2*i] != -1:
        for j in 0 ..< list[2*i+1]:
            sum += list[2*i]*(pos+j)
    pos += list[2*i+1]

echo sum
    

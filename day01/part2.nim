import strutils

let 
    strdata = readFile("data").strip().splitLines()

var
    list1: seq[int] = @[]
    list2: array[100000, int]
    similarity: int = 0

for i in 0 ..< strdata.len:
    let temp = strdata[i].split(' ')
    list1.add(parseInt(temp[0]))
    list2[parseInt(temp[^1])] += 1


for i in 0 ..< list1.len:
    similarity += list1[i]*list2[list1[i]]
echo similarity
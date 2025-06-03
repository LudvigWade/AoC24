import strutils
import algorithm

let 
    strdata = readFile("data").strip().splitLines()

var
    list1: seq[int] = @[]
    list2: seq[int] = @[]
    sum: int = 0

for i in 0 ..< strdata.len:
    let temp = strdata[i].split(' ')
    list1.add(parseInt(temp[0]))
    list2.add(parseInt(temp[^1]))

sort(list1)
sort(list2)

for i in 0 ..< list1.len:
    sum += abs(list1[i]-list2[i])
echo sum
import strutils
import tables

proc exists(key: string): int

let 
    strdata = readFile("data").strip().splitLines()
    options = strdata[0].split(", ")

var 
    sum1,sum2:int
    possibilities = initTable[string,int]()

for i in 2 ..< strdata.len:
    let temp = exists(strdata[i])
    if temp > 0:
        sum1 += 1
        sum2 += temp

echo sum1
echo sum2

proc exists(key: string): int =
    if possibilities.hasKey(key):
        return possibilities[key]
    else:
        var sum = 0
        if key == "":
            sum = 1
        for opt in options.items:
            if key.startsWith(opt):
                sum += exists(key[opt.len .. ^1])
        possibilities[key] = sum
        return sum

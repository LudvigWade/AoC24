import strutils
import tables

proc exists(key: string): int

let 
    strdata = readFile("data").strip().splitLines()
    options = strdata[0].split(", ")

var 
    sumposs = 0
    possibilities = initTable[string,int]()

for i in 2 ..< strdata.len:
    sumposs += exists(strdata[i])

echo sumposs

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

import strutils
import math

let 
    strdata = readFile("data").strip().splitLines()

var sum = 0

for i in 0 ..< strdata.len:
    let 
        nbrs = strdata[i].split(seps = {':', ' '})
        target = parseInt(nbrs[0])
    var
        operations = 0
        wrong = false
    while wrong == false:
        let operation = operations.toBin(nbrs.len-3)
        var current = parseInt(nbrs[2])
        for j in 0 ..< operation.len:
            if operation[j] == '0':
                current += parseInt(nbrs[j+3])
            else:
                current *= parseInt(nbrs[j+3])
            if current > target:
                break
        if current == target:
            break
        operations += 1
        if operations == 2^(nbrs.len-3):
            wrong = true
            break
    if wrong == false:
        sum += target

echo sum
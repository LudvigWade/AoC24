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
        var current = parseInt(nbrs[2])
        var operation = operations
        for j in 0 ..< nbrs.len-3:
            if operation%%3 == 0:
                current += parseInt(nbrs[j+3])
            elif operation%%3 == 1:
                current *= parseInt(nbrs[j+3])
            else:
                current = parseInt($current & nbrs[j+3])
            operation = operation div 3
            if current > target:
                break
        if current == target:
            break
        operations += 1
        if operations == 3^(nbrs.len-3):
            wrong = true
            break
    if wrong == false:
        sum += target

echo sum
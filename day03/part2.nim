import strutils
import algorithm
import sequtils
import re

let 
    strdata = readFile("data").strip()
    mullist = findAll(strdata, re"mul\([0-9]+,[0-9]+\)|do\(\)|don't\(\)")

var 
    result = 0
    doing = true

for i in 0 ..< mullist.len:
    let nbrs = findAll(mullist[i], re"[0-9]+")
    echo nbrs
    if nbrs.len == 0:
        if mullist[i].len == 4:
            doing = true
        else:
            doing = false
    elif doing:
        result += parseInt(nbrs[0])*parseInt(nbrs[1])

echo result
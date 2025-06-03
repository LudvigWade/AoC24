import strutils
import re

let 
    strdata = readFile("data").strip()
    mullist = findAll(strdata, re"mul\([0-9]+,[0-9]+\)")

var result = 0

for i in 0 ..< mullist.len:
    let nbrs = findAll(mullist[i], re"[0-9]+")
    result += parseInt(nbrs[0])*parseInt(nbrs[1])

echo result
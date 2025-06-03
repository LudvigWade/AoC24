import strutils
import sequtils
import tables
import algorithm
import random

proc findValue(str:string): int

let 
    strdata = readFile("testdata4").strip().splitLines()
    gates = strdata[strdata.find("")+1 ..< strdata.len]

var
    connections = initTable[string, (string, string, string)]()
    startvalues = initTable[string, int]()
    values = initTable[(string, string, string), int]()
    wires = newSeq[string]()
    xoutputs = newSeq[string]()
    youtputs = newSeq[string]()
    zoutputs = newSeq[string]()
    xres = ""
    yres = ""
    zres = ""


for i in 0 ..< strdata.find(""):
    let temp = strdata[i].split(": ")
    startvalues[temp[0][0 .. 2]] = temp[1].parseInt()
    if temp[0][0] == 'x':
        xoutputs.add(temp[0])
    elif temp[0][0] == 'y':
        youtputs.add(temp[0])


for i in 0 ..< gates.len:
    let temp = gates[i].split(' ')
    if temp[4][0] == 'z':
        zoutputs.add(temp[4])
    connections[temp[4]] = (temp[0], temp[2], temp[1])






xoutputs.sort()
youtputs.sort()
zoutputs.sort()
for x in xoutputs:
    xres.add($startvalues[x])
for y in youtputs:
    yres.add($startvalues[y])
for z in zoutputs:
    zres.add($findValue(z))
xres.reverse()
yres.reverse()
zres.reverse()
echo zres
echo (parseBinInt(xres) + parseBinInt(yres)).toBin(46)

proc findValue(str:string): int =
    if startvalues.hasKey(str):
        return startvalues[str]
    let wire = connections[str]
    if values.hasKey(wire):
        return values[wire]
    else:
        if wire[2] == "AND":
            return findValue(wire[0]) and findValue(wire[1])
        elif wire[2] == "XOR":
            return findValue(wire[0]) xor findValue(wire[1])
        else:
            return findValue(wire[0]) or findValue(wire[1])

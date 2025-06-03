import strutils
import sequtils
import tables
import algorithm

proc findValue(str:string): int

let 
    strdata = readFile("data").strip().splitLines()
    gates = strdata[strdata.find("")+1 ..< strdata.len]

var
    connections = initTable[string, (string, string, string)]()
    startvalues = initTable[string, int]()
    values = initTable[(string, string, string), int]()
    outputs = newSeq[string]()
    res = ""

for i in 0 ..< strdata.find(""):
    let temp = strdata[i].split(": ")
    startvalues[temp[0][0 .. 2]] = temp[1].parseInt()

for i in 0 ..< gates.len:
    let temp = gates[i].split(' ')
    if temp[4][0] == 'z':
        outputs.add(temp[4])
    connections[temp[4]] = (temp[0], temp[2], temp[1])

outputs.sort()
for z in outputs:
    res.add($findValue(z))
res.reverse()
echo parseBinInt(res)

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

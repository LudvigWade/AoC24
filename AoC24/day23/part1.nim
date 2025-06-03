import strutils
import sequtils
import sets
import tables

let 
    strdata = readFile("data").strip().splitLines()

type Connection = tuple[names:HashSet[string], containsT:bool]

var 
    tracker = initTable[string, seq[Connection]]()
    allcons = initHashSet[Connection]()
    sum = 0

for i in 0 ..< strdata.len:
    echo i
    let pairs = strdata[i].split('-')
    if tracker.hasKey(pairs[0]) and tracker.hasKey(pairs[1]):
        var toAdd = initHashSet[Connection]()
        for c1 in tracker[pairs[0]]:
            for c2 in tracker[pairs[1]]:
                if c1.names.len != c2.names.len:
                    continue
                var samec = true
                for n1 in c1.names.items:
                    if n1 == pairs[0]:
                        continue
                    if not c2.names.contains(n1):
                        samec = false
                        break
                if samec:
                    let con: Connection = (c1.names+c2.names, c1.containsT or c2.containsT)
                    toAdd.incl(con)
        for c in toAdd.items:
            allcons.incl(c)
            for name in c.names.items:
                tracker[name].add(c)
    var con:Connection = (initHashSet[string](), false)
    for p in pairs:
        con[0].incl(p)
        if p[0] == 't':
            con[1] = true
    for p in pairs:
        if not tracker.hasKey(p):
            tracker[p] = newSeq[Connection]()
        tracker[p].add(con)
    allcons.incl(con)

for c in allcons.items:
    if c.containsT and c.names.len == 3:
        sum += 1
echo sum
    



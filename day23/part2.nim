import strutils
import sequtils
import sets
import tables

let 
    strdata = readFile("testdata").strip().splitLines()

var 
    tracker = initTable[string, HashSet[string]]()
    names = initHashSet[string]()
    sum = 0

for i in 0 ..< strdata.len:
    let pairs = strdata[i].split('-')
    if not tracker.hasKey(pairs[0]):
        names.incl(pairs[0])
        tracker[pairs[0]] = initHashSet[string]()
        tracker[pairs[0]].incl(pairs[0])
    tracker[pairs[0]].incl(pairs[1])
    if not tracker.hasKey(pairs[1]):
        names.incl(pairs[1])
        tracker[pairs[1]] = initHashSet[string]()
        tracker[pairs[1]].incl(pairs[1])
    tracker[pairs[1]].incl(pairs[0])

while names.len > 0:
    var notcon = false
    let name = names.pop()
    for n in tracker[name].items:
        names.excl(n)
        if tracker[name] != tracker[n]:
            notcon = true
            break
    if not notcon and tracker[name].len > sum:
        sum = tracker[name].len


echo tracker
echo sum
    



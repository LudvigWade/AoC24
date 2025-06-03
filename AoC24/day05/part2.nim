import strutils
import sequtils


let 
    strdata = readFile("data").strip().splitLines()
var
    rules: array[100, seq[int]]
    updateindex = -1
    correctupdates = newSeq[int]()
    sum = 0

for i in 0 ..< strdata.len:
    if strdata[i].len == 0:
        updateindex = i+1
        break
    else:
        let nbrs = strdata[i].split('|').map(parseInt)
        rules[nbrs[0]].add(nbrs[1])

for i in updateindex ..< strdata.len:
    var 
        visitedpages = newSeq[int]()
        correct = true
        ready = false
    var pages:seq[int] = strdata[i].split(',').map(parseInt)
    while not ready:
        ready = true
        for j in 0 ..< pages.len:
            for k in rules[pages[j]]:
                if visitedpages.contains(k):
                    correct = false
                    ready = false
                    pages[pages.find(k)] = pages[j]
                    pages[j] = k
                    break
            visitedpages.add(pages[j])
        visitedpages.setLen(0)
        

    if not correct:
        correctupdates.add(pages[((pages.len-1)/2).int])

for i in 0 ..< correctupdates.len:
    sum += correctupdates[i]

echo sum
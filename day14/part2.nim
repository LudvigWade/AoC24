import strutils
import sequtils
import math
import sets

let 
    strdata = readFile("data").strip().splitLines()
    width = 101
    height = 103

type
    Robot = tuple[position: (int,int), velocity: (int,int)]

var
    robots = newSeq[Robot]()
    entropy = newSeq[int](10403)

for i in 0 ..< strdata.len:
    let data = strdata[i].split({'=',',',' '}).filter(proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9', '-'})).map(parseInt)
    var 
        bot:Robot = ((data[0],data[1]),(data[2],data[3]))
    robots.add(bot)
    

for i in 0 ..< 10403:
    for j in 0 ..< robots.len:
        for k in 0 ..< robots.len:
            entropy[i] += abs(robots[j].position[0]-robots[k].position[0]) + abs(robots[j].position[1]-robots[k].position[1])
    for j in 0 ..< robots.len:
        robots[j].position[0] = ((robots[j].position[0]+robots[j].velocity[0]) mod width + width) mod width
        robots[j].position[1] = ((robots[j].position[1]+robots[j].velocity[1]) mod height + height) mod height
    

let min = minIndex(entropy)
echo min

var
    tree: array[103, string]
for j in 0 ..< tree.len:
    for k in 0 ..< 101:
        tree[j].add('.')
    
for j in 0 ..< robots.len:
    robots[j].position[0] = ((robots[j].position[0]+(min)*robots[j].velocity[0]) mod width + width) mod width
    robots[j].position[1] = ((robots[j].position[1]+(min)*robots[j].velocity[1]) mod height + height) mod height
    tree[robots[j].position[1]][robots[j].position[0]] = '*'
for j in 0 ..< tree.len:
    echo tree[j]
    

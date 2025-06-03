import strutils

var 
    strdata = readFile("data").strip()
    map = strdata.splitLines()
    start:(int,int) = (strdata.find("S") div (map.len+2) , strdata.find("S") mod (map.len+2))
    finish:(int,int) = (strdata.find("E") div (map.len+2) , strdata.find("E") mod (map.len+2))
    path = newSeq[(int,int)]()
    visited = newSeq[(int,int)]()
    sum = 0

var current = start
visited.add(start)
while current != finish:
    path.add(current)
    if map[current[0]-1][current[1]] != '#' and not visited.contains((current[0]-1,current[1])):
        current = (current[0]-1,current[1])
        visited.add(current)
        continue
    elif map[current[0]+1][current[1]] != '#' and not visited.contains((current[0]+1,current[1])):
        current = (current[0]+1,current[1])
        visited.add(current)
        continue
    elif map[current[0]][current[1]-1] != '#' and not visited.contains((current[0],current[1]-1)):
        current = (current[0],current[1]-1)
        visited.add(current)
        continue
    elif map[current[0]][current[1]+1] != '#' and not visited.contains((current[0],current[1]+1)):
        current = (current[0],current[1]+1)
        visited.add(current)
        continue
path.add(finish)

let threshold = 100
echo path.len-threshold
for i in 0 ..< path.len-threshold:
    echo i
    visited.setLen(0)
    var 
        currentlist = newSeq[(int,int)]()
        next = newSeq[(int,int)]()
        steps = 0
    visited.add(path[i])
    currentlist.add(path[i])
    while currentlist.len != 0 and steps < 20:
        steps += 1
        for current in currentlist.items:
            if current[0] > 0 and not visited.contains((current[0]-1,current[1])):
                if map[current[0]-1][current[1]] != '#':
                    if path.find((current[0]-1,current[1]))-i >= threshold + steps:
                        sum += 1
                next.add((current[0]-1,current[1]))
                visited.add((current[0]-1,current[1]))
            if current[0]+1 < map.len and not visited.contains((current[0]+1,current[1])):
                if map[current[0]+1][current[1]] != '#':
                    if path.find((current[0]+1,current[1]))-i >= threshold + steps:
                        sum += 1
                next.add((current[0]+1,current[1]))
                visited.add((current[0]+1,current[1]))
            if current[1] > 0 and not visited.contains((current[0],current[1]-1)):
                if map[current[0]][current[1]-1] != '#':
                    if path.find((current[0],current[1]-1))-i >= threshold + steps:
                        sum += 1
                next.add((current[0],current[1]-1))
                visited.add((current[0],current[1]-1))
            if current[1]+1 < map[current[0]].len and not visited.contains((current[0],current[1]+1)):
                if map[current[0]][current[1]+1] != '#':
                    if path.find((current[0],current[1]+1))-i >= threshold + steps:
                        sum += 1
                next.add((current[0],current[1]+1))
                visited.add((current[0],current[1]+1))
        currentlist = next

echo sum
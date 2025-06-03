import strutils
import sequtils
import sets

let 
    strdata = readFile("data").strip().splitLines()
    width = 101
    height = 103

type
    Robot = tuple[position: (int,int), velocity: (int,int)]

var
    topleft = 0
    topright = 0
    bottomleft = 0
    bottomright = 0
    robots = initHashSet[Robot]()

for i in 0 ..< strdata.len:
    let data = strdata[i].split({'=',',',' '}).filter(proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9', '-'})).map(parseInt)
    robots.incl(((((data[0]+100*data[2]) mod width + width) mod width,((data[1]+100*data[3]) mod height + height) mod height),(data[2],data[3])))


for bot in robots.items:
    if bot.position[0] < width div 2 and bot.position[1] < height div 2:
        topleft += 1
    elif bot.position[0] < width div 2 and bot.position[1] > height div 2:
        bottomleft += 1
    elif bot.position[0] > width div 2 and bot.position[1] < height div 2:
        topright += 1
    elif bot.position[0] > width div 2 and bot.position[1] > height div 2:
        bottomright += 1

echo topleft*topright*bottomleft*bottomright

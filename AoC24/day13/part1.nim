import strutils
import math

let 
    strdata = readFile("data").strip().splitLines()
var
    sum:int = 0


for i in 0 ..< (strdata.len+1) div 4:
    var 
        ax,ay,bx,by,x,y:int
        A,B:float
    let buttonA = strdata[4*i].split(seps = {'+', ','})
    let buttonB = strdata[4*i+1].split(seps = {'+', ','})
    let prize = strdata[4*i+2].split(seps = {'=', ','})
    ax = buttonA[1].parseInt()
    ay = buttonA[3].parseInt()
    bx = buttonB[1].parseInt()
    by = buttonB[3].parseInt()
    x = prize[1].parseInt()
    y = prize[3].parseInt()
    A = (by*x-bx*y)/(ax*by-ay*bx)
    B = (-ay*x+ax*y)/(ax*by-ay*bx)
    echo A
    echo B
    if A-round(A) == 0 and B-round(B) == 0:
        sum += int(A*3 + B)

echo sum
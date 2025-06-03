import strutils
import math
import sequtils

let 
    strdata = readFile("data").strip().splitLines()
var
    sum1:int = 0
    sum2:int = 0


for i in 0 ..< (strdata.len+1) div 4:
    var 
        x1,y1,x2,y2:int
        a1,b1,a2,b2:float
    let buttonA = filter(strdata[4*i].split(seps = {'+', ','}), proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9'})).map(parseInt)
    let buttonB = filter(strdata[4*i+1].split(seps = {'+', ','}), proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9'})).map(parseInt)
    let prize = filter(strdata[4*i+2].split(seps = {'=', ','}), proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9'})).map(parseInt)
    x1 = prize[0]
    y1 = prize[1]
    x2 = prize[0]+int(10000000000000)
    y2 = prize[1]+int(10000000000000)
    a1 = (buttonB[1]*x1-buttonB[0]*y1)/(buttonA[0]*buttonB[1]-buttonA[1]*buttonB[0])
    b1 = (-buttonA[1]*x1+buttonA[0]*y1)/(buttonA[0]*buttonB[1]-buttonA[1]*buttonB[0])
    a2 = (buttonB[1]*x2-buttonB[0]*y2)/(buttonA[0]*buttonB[1]-buttonA[1]*buttonB[0])
    b2 = (-buttonA[1]*x2+buttonA[0]*y2)/(buttonA[0]*buttonB[1]-buttonA[1]*buttonB[0])
    if a1-round(a1) == 0 and b1-round(b1) == 0:
        sum1 += int(a1*3 + b1)
    if a2-round(a2) == 0 and b2-round(b2) == 0:
        sum2 += int(a2*3 + b2)

echo sum1
echo sum2
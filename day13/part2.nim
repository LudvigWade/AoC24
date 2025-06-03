import strutils
import math
import sequtils

let 
    strdata = readFile("data").strip().splitLines()
var
    sum:int = 0


for i in 0 ..< (strdata.len+1) div 4:
    var 
        x,y:int
        a,b:float
    let buttonA = filter(strdata[4*i].split(seps = {'+', ','}), proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9'})).map(parseInt)
    let buttonB = filter(strdata[4*i+1].split(seps = {'+', ','}), proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9'})).map(parseInt)
    let prize = filter(strdata[4*i+2].split(seps = {'=', ','}), proc(x:string): bool = allCharsInSet(x, {'0', '1', '2', '3', '4', '5', '6' ,'7', '8', '9'})).map(parseInt)
    x = prize[0]+int(10000000000000)
    y = prize[1]+int(10000000000000)
    a = (buttonB[1]*x-buttonB[0]*y)/(buttonA[0]*buttonB[1]-buttonA[1]*buttonB[0])
    b = (-buttonA[1]*x+buttonA[0]*y)/(buttonA[0]*buttonB[1]-buttonA[1]*buttonB[0])
    if a-round(a) == 0 and b-round(b) == 0:
        sum += int(a*3 + b)

echo sum
import strutils
import sequtils
import math

let
    strdata = readFile("data").strip().splitLines()
    ops = strdata[4].split({' ',','})[1 .. ^1].map(parseInt)

var
    regA = strdata[0].split(": ")[1].parseInt()
    regB = strdata[1].split(": ")[1].parseInt()
    regC = strdata[2].split(": ")[1].parseInt()
    combo:seq[int] = @[0,1,2,3,regA,regB,regC]
    instpointer = 0
    output = ""

while instpointer < ops.len:
    let 
        inst = ops[instpointer]
        oper = ops[instpointer+1]
    
    if inst == 0:
        regA = regA div (2^(combo[oper]))
        combo[4] = regA
    elif inst == 1:
        regB = regB xor oper
        combo[5] = regB
    elif inst == 2:
        regB = combo[oper] mod 8
        combo[5] = regB
    elif inst == 3:
        if regA != 0:
            instpointer = oper
            continue
    elif inst == 4:
        regB = regB xor regC
        combo[5] = regB
    elif inst == 5:
        output.add($(combo[oper] mod 8))
        output.add(",")
    elif inst == 6:
        regB = regA div (2^(combo[oper]))
        combo[5] = regB
    elif inst == 7:
        regC = regA div (2^(combo[oper]))
        combo[6] = regC
    else:
        echo "error"
    instpointer += 2
echo output.strip(chars = {','})


import strutils
import sequtils
import math

let
    strdata = readFile("data").strip().splitLines()
    ops = strdata[4].split({' ',','})[1 .. ^1].map(parseInt)
    check = strdata[4].split(' ')[1].strip() 
    # regB = regA mod 8, regB xor 1(+- 1), regC = regA / 2^regB, regB = regB xor 5
    # regA = regA / 8, regB = regB xor regC, out: regB mod 8 = 2
    # regB = regA mod 8, regB xor 1, regC = regA / 2^regB, regB = regB xor 5
    # regA = regA / 8, regB = regB xor regC, out: regB mod 8 = 4
    # 
    # 0  1 2  3  4  5  6  7
    # 1 -1 1 -1  1 -1  1 -1
    # 5  3 5  3 -3 -5 -3 -5
    # 4  4 4  4 -4 -4 -4 -4
    # 4  5 6  7  0  1  2  3

echo check
var i = int(164516454365621) #164 - 165
while true:
    var
        regA = i
        output = ""

    while regA != 0:
        
        output.add($((((regA+4) mod 8) xor (regA div 2^((regA mod 8) xor 1))) mod 8))
        output.add(",")
        regA = regA div 8

    if i mod 500000 == 0:
        echo $i & ": " & output.strip(chars = {','})
    if output.strip(chars = {','}) == check:
        echo $i & ": " & output.strip(chars = {','})
        break
    i += int(1)

import strutils

let 
    strdata = readFile("data").strip().splitLines()

var sum = 0

for i in 0 ..< strdata.len:
    echo i
    var 
        nbr:int = strdata[i].parseInt()
        tempnbr:int = nbr
    for j in 0 ..< 2000:
        tempnbr = nbr * 64
        nbr = nbr xor tempnbr
        nbr = nbr mod 16777216
        tempnbr = nbr div 32
        nbr = nbr xor tempnbr
        nbr = nbr mod 16777216
        tempnbr = nbr * 2048
        nbr = nbr xor tempnbr
        nbr = nbr mod 16777216
    sum += nbr
echo sum

import strutils
import tables

let 
    strdata = readFile("data").strip().splitLines()

var 
    sum = 0
    changelist = newSeq[seq[int]](strdata.len)
    pricelist = newSeq[seq[int]](strdata.len)
    pricefinder = initTable[(int,int,int,int),int]()

for i in 0 ..< strdata.len:
    var 
        nbr:int = strdata[i].parseInt()
        tempnbr:int = nbr
        prevprice = nbr mod 10
        foundseq = initTable[(int,int,int,int),bool]()
    changelist[i] = newSeq[int](2000)
    pricelist[i] = newSeq[int](2001)
    pricelist[i][0] = nbr mod 10
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
        pricelist[i][j+1] = (nbr mod 10)
        changelist[i][j] = (nbr mod 10 - prevprice)
        prevprice = nbr mod 10
        if j > 3:
            if not foundseq.hasKey((changelist[i][j-3],changelist[i][j-2],changelist[i][j-1],changelist[i][j])):
                foundseq[(changelist[i][j-3],changelist[i][j-2],changelist[i][j-1],changelist[i][j])] = true
                if pricefinder.hasKeyOrPut((changelist[i][j-3],changelist[i][j-2],changelist[i][j-1],changelist[i][j]),pricelist[i][j+1]):
                    pricefinder[(changelist[i][j-3],changelist[i][j-2],changelist[i][j-1],changelist[i][j])] += pricelist[i][j+1]
            
for k in pricefinder.values:
    if k > sum:
        sum = k

echo sum 

import strutils
import tables

proc solver(key: string): void

let 
    strdata = readFile("data").strip().splitLines()
    length = 26

var
    keypadnum = (2,3)
    keypaddir = (2,0)
    sum = 0
    memo = initTable[string, seq[string]]()

let # 0 -> (1,3) etc, A -> (2,3)
    numconv = {'0': (1,3),'1': (0,2),'2': (1,2),'3': (2,2),'4': (0,1),'5': (1,1),'6': (2,1),'7': (0,0),'8': (1,0),'9': (2,0),'A': (2,3)}.newTable
    dirconv = {'<': (0,1), '^': (1,0), '>': (2,1), 'v': (1,1), 'A': (2,0)}.newTable

for i in 0 ..< strdata.len:
    var 
        inst = ""
        nbrs = newSeq[Table[string, int]](length)
    for j in 0 ..< strdata[i].len:
        let 
            startpos = keypadnum
            endpos = numconv[strdata[i][j]]
            move = (endpos[0]-startpos[0],endpos[1]-startpos[1])
        keypadnum = endpos
        if move[0] < 0 and move[1] < 0:
            if not (startpos[1] == 3 and abs(move[0]) == startpos[0]):
                for k in 0 ..< abs(move[0]):
                    inst.add('<')
                for k in 0 ..< abs(move[1]):
                    inst.add('^')
            else:
                for k in 0 ..< abs(move[1]):
                    inst.add('^')
                for k in 0 ..< abs(move[0]):
                    inst.add('<')
        elif move[0] < 0:
            for k in 0 ..< abs(move[0]):
                inst.add('<')
            for k in 0 ..< move[1]:
                inst.add('v')
        else:
            if move[1] < 0:
                for k in 0 ..< abs(move[1]):
                    inst.add('^')
                for k in 0 ..< move[0]:
                    inst.add('>')  
            else:
                if startpos[0] == 0 and move[1] + startpos[1] > 2:
                    for k in 0 ..< move[0]:
                        inst.add('>')  
                    for k in 0 ..< move[1]:
                        inst.add('v')
                else:
                    for k in 0 ..< move[1]:
                        inst.add('v')
                    for k in 0 ..< move[0]:
                        inst.add('>')  
        inst.add('A')
    solver(inst)

    var temp = inst.split('A')[0 ..< ^1]
    for a in 0 ..< temp.len:
        temp[a].add('A')
        if not nbrs[0].hasKey(temp[a]):
            nbrs[0][temp[a]] = 1
        else:
            nbrs[0][temp[a]] += 1
    
    for a in 1 ..< length:
        for val in nbrs[a-1].keys:
            for res in memo[val]:
                if not nbrs[a].hasKey(res):
                    nbrs[a][res] = nbrs[a-1][val]
                else:
                    nbrs[a][res] += nbrs[a-1][val]

    var len = 0
    for (str,nbr) in nbrs[length-1].pairs:
        len += str.len*nbr

    echo "$1: $2 = $3" % [strdata[i], $len, $(len * strdata[i][0 ..< 3].parseInt())]
    sum += len * strdata[i][0 ..< 3].parseInt()
echo sum
    
proc solver(key: string): void = 
    var tempseq = key.split('A')[0 ..< ^1]
    for a in 0 ..< tempseq.len:
        tempseq[a].add('A')
        if not memo.hasKey(tempseq[a]):
            var instruc = ""
            keypaddir = (2,0)
            for j in 0 ..< tempseq[a].len:
                let
                    startpos = keypaddir
                    endpos = dirconv[tempseq[a][j]]
                    move = (endpos[0]-startpos[0],endpos[1]-startpos[1])
                keypaddir = endpos
                if move[0] < 0 and move[1] < 0:
                    for k in 0 ..< abs(move[0]):
                        instruc.add('<')
                    for k in 0 ..< abs(move[1]):
                        instruc.add('^')
                elif move[0] < 0:
                    if startpos[1] == 0 and abs(move[0]) >= startpos[0]:
                        for k in 0 ..< move[1]:
                            instruc.add('v')
                        for k in 0 ..< abs(move[0]):
                            instruc.add('<')
                    else:
                        for k in 0 ..< abs(move[0]):
                            instruc.add('<')
                        for k in 0 ..< move[1]:
                            instruc.add('v')
                else:
                    if move[1] < 0:
                        if startpos == (0,1):
                            for k in 0 ..< move[0]:
                                instruc.add('>')
                            for k in 0 ..< abs(move[1]):
                                instruc.add('^')
                        else:
                            for k in 0 ..< abs(move[1]):
                                instruc.add('^')
                            for k in 0 ..< move[0]:
                                instruc.add('>')
                    else:
                        for k in 0 ..< move[1]:
                            instruc.add('v')
                        for k in 0 ..< move[0]:
                            instruc.add('>')
                instruc.add('A')
            var tempseq2 = instruc.split('A')[0 ..< ^1]
            for b in 0 ..< tempseq2.len:
                tempseq2[b].add('A')
            memo[tempseq[a]] = tempseq2
            for b in 0 ..< tempseq2.len:
                solver(tempseq2[b])
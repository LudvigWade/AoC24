import strutils
import tables

let 
    strdata = readFile("testdata").strip().splitLines()

var
    keypad1 = (2,3)
    keypad2 = (2,0)
    keypad3 = (2,0)
    sum = 0

let # 0 -> (1,3) etc, A -> (2,3)
    numconv = {'0': (1,3),'1': (0,2),'2': (1,2),'3': (2,2),'4': (0,1),'5': (1,1),'6': (2,1),'7': (0,0),'8': (1,0),'9': (2,0),'A': (2,3)}.newTable
    dirconv = {'<': (0,1), '^': (1,0), '>': (2,1), 'v': (1,1), 'A': (2,0)}.newTable

for i in 0 ..< strdata.len:
    var inst1 = ""
    var inst2 = ""
    var inst3 = ""
    for j in 0 ..< strdata[i].len:
        let 
            startpos = keypad1
            endpos = numconv[strdata[i][j]]
            move = (endpos[0]-startpos[0],endpos[1]-startpos[1])
        keypad1 = endpos
        if move[0] < 0 and move[1] < 0:
            if not (startpos[1] == 3 and abs(move[0]) == startpos[0]):
                for k in 0 ..< abs(move[0]):
                    inst1.add('<')
                for k in 0 ..< abs(move[1]):
                    inst1.add('^')
            else:
                for k in 0 ..< abs(move[1]):
                    inst1.add('^')
                for k in 0 ..< abs(move[0]):
                    inst1.add('<')
        elif move[0] < 0:
            for k in 0 ..< abs(move[0]):
                inst1.add('<')
            for k in 0 ..< move[1]:
                inst1.add('v')
        else:
            if move[1] < 0:
                for k in 0 ..< abs(move[1]):
                    inst1.add('^')
                for k in 0 ..< move[0]:
                    inst1.add('>')  
            else:
                if startpos[0] == 0 and move[1] + startpos[1] > 2:
                    for k in 0 ..< move[0]:
                        inst1.add('>')  
                    for k in 0 ..< move[1]:
                        inst1.add('v')
                else:
                    for k in 0 ..< move[1]:
                        inst1.add('v')
                    for k in 0 ..< move[0]:
                        inst1.add('>')  
        inst1.add('A')
    for j in 0 ..< inst1.len:
        let
            startpos = keypad2
            endpos = dirconv[inst1[j]]
            move = (endpos[0]-startpos[0],endpos[1]-startpos[1])
        keypad2 = endpos
        if move[0] < 0 and move[1] < 0:
            for k in 0 ..< abs(move[0]):
                inst2.add('<')
            for k in 0 ..< abs(move[1]):
                inst2.add('^')
        elif move[0] < 0:
            for k in 0 ..< move[1]:
                inst2.add('v')
            for k in 0 ..< abs(move[0]):
                inst2.add('<')
        else:
            for k in 0 ..< move[0]:
                inst2.add('>')
            if move[1] < 0:
                for k in 0 ..< abs(move[1]):
                    inst2.add('^')
            else:
                for k in 0 ..< move[1]:
                    inst2.add('v')
        inst2.add('A')
    for j in 0 ..< inst2.len:
        let
            startpos = keypad3
            endpos = dirconv[inst2[j]]
            move = (endpos[0]-startpos[0],endpos[1]-startpos[1])
        keypad3 = endpos
        if move[0] < 0 and move[1] < 0:
            for k in 0 ..< abs(move[1]):
                inst3.add('^')
            for k in 0 ..< abs(move[0]):
                inst3.add('<')
        elif move[0] < 0:
            for k in 0 ..< move[1]:
                inst3.add('v')
            for k in 0 ..< abs(move[0]):
                inst3.add('<')
        else:
            for k in 0 ..< move[0]:
                inst3.add('>')
            if move[1] < 0:
                for k in 0 ..< abs(move[1]):
                    inst3.add('^')
            else:
                for k in 0 ..< move[1]:
                    inst3.add('v')
        inst3.add('A')
    echo "$1: $2; $3" % [strdata[i], $inst3.len, inst3]
    sum += inst3.len * strdata[i][0 ..< 3].parseInt()
echo sum
    





        
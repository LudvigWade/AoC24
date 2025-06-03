import strutils
import sequtils

let 
    strdata = readFile("data").strip().splitLines()

var
    nbrofsafe = 0

for i in 0 ..< strdata.len:
    let active = strdata[i].split(' ').map(parseInt)
    echo active
    var
        safeinc = true
        safedec = true
        errorinc = -1
        errordec = -1
    

    
    for j in 0 ..< active.len-1:
        if safeinc:
            if errorinc != j:
                if active[j] > active[j+1] or abs(active[j]-active[j+1])>3 or abs(active[j]-active[j+1])<1:
                    if errorinc != -1:
                        safeinc = false
                    if j+2 < active.len:
                        if active[j] < active[j+2] and abs(active[j]-active[j+2])<4 and abs(active[j]-active[j+2])>0:
                            errorinc = j+1
                        elif j == 0:
                            errorinc = 0
                        elif active[j-1] < active[j+1] and abs(active[j-1]-active[j+1])<4 and abs(active[j-1]-active[j+1])>0:
                            errorinc = j
                        else:
                            safeinc = false
        if safedec:
            if errordec != j:
                if active[j] < active[j+1] or abs(active[j]-active[j+1])>3 or abs(active[j]-active[j+1])<1:
                    if errordec != -1:
                        safedec = false
                    if j+2 < active.len:
                        if active[j] > active[j+2] and abs(active[j]-active[j+2])<4 and abs(active[j]-active[j+2])>0:
                            errordec = j+1
                        elif j == 0:
                            errordec = 0
                        elif active[j-1] > active[j+1] and abs(active[j-1]-active[j+1])<4 and abs(active[j-1]-active[j+1])>0:
                            errordec = j
                        else:
                            safedec = false
    echo safeinc,safedec
    if safeinc or safedec:
        nbrofsafe += 1

echo nbrofsafe
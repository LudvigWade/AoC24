import strutils
import sequtils
import sets
import tables

let 
    strdata = readFile("data").strip().splitLines()
import strutils
import securehash
import times
import os
import threadpool

type
 BruteHolder = object of RootObj
  best: int
  total: int
  base: string

var baseString: string = "default"
var threadNum = 1

if paramCount() != 2:
 echo("Usage :\n\t./nim-bruteforce <prefix> <number of threads>")
 quit()

baseString = paramStr(1)
threadNum = parseInt(paramStr(2))

proc countLeading(input: string,target: char): int =
 var cur_chr = 0

 while input[cur_chr] == target:
  cur_chr += 1
 
 return cur_chr

proc hashPerSec(interval: float,count: int): int =
 return cast[int](cast[float](count)/interval)

proc bruteForce(start: int,increment: int,holder: ptr BruteHolder) {.thread.} =
 var best = -1
 var index = start
 var c: int = 0

 var startTime: float = epochTime()
 var timeDiff: float

 while true:
  c = countLeading($secureHash(holder.base & $index),'0')

  if c > holder.best:
   holder.best = c
   timeDiff = cast[float](epochTime() - startTime)
   stdout.write($secureHash(holder.base & $index) & "(" & $holder.best & ") " & holder.base & $index)
   stdout.write(" " & $hashPerSec(timeDiff,holder.total) & " H/s\n")
 
  index += increment
  holder.total += 1

var holder: BruteHolder
holder.base = baseString
holder.best = 0
holder.total = 0

for i in 0..threadNum-1:
 spawn bruteForce(i,threadNum,addr holder)
sync()

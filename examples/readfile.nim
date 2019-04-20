## Usage
## =====
##
## .. code-block:: bash
##
##    $ nim c -r examples/readfile.nim examples/data/glider_gun.txt
##    $ nim c -r examples/readfile.nim examples/data/blinker.txt

import gameoflife
from os import sleep, commandLineParams
from strutils import split, parseUint
from sequtils import mapIt

let args = commandLineParams()
if args.len < 1:
  stderr.writeLine """Need 1 argument.
Set data file.

Usage example:
    $ nim c -r examples/readfile.nim examples/data/glider_gun.txt"""
  quit 1

let data = readFile(args[0])
var board = data.split("\n").mapIt(it.mapIt(it.`$`.parseUInt.uint8)).Board

while true:
  board.nextStep()
  board.print
  echo "-----------------------------------"
  sleep(100)
import gameoflife
from sequtils import mapIt

proc nextStep(b: seq[seq[cuint]]): Board {.exportc.} =
  var board = b.mapIt(it.mapIt(it.uint8)).Board
  gameoflife.nextStep(board)
  return board

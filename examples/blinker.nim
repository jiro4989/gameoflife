import gameoflife
from os import sleep

var board: Board = @[
  @[dead, dead, dead, dead, dead],
  @[dead, dead, dead, dead, dead],
  @[dead, live, live, live, dead],
  @[dead, dead, dead, dead, dead],
  @[dead, dead, dead, dead, dead],
]

while true:
  board.nextStep()
  board.print
  echo "-----------------------------------"
  sleep(100)
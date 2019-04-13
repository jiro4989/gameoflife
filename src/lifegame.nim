## This module provides functions for Lifegame.
##
## Basic usage
## ===========
##
## Blinker example is here.
##
## .. code-block:: nim
## 
##    import lifegame
##    from os import sleep
## 
##    var board: Board = @[
##      @[dead, dead, dead, dead, dead],
##      @[dead, dead, dead, dead, dead],
##      @[dead, live, live, live, dead],
##      @[dead, dead, dead, dead, dead],
##      @[dead, dead, dead, dead, dead],
##    ]
## 
##    while true:
##      board.nextStep()
##      board.print
##      echo "-----------------------------------"
##      sleep(100)
##
## See also:
## * `Conway's Game of Life <https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life>`_

from sequtils import filterIt

type
  CellStatus* = enum
    live, dead
  Board* = seq[seq[CellStatus]]

proc getNeighbourCells*(board: Board, x, y: int): seq[CellStatus] =
  ## Returns neighbour cells. Not included x, y cell.
  runnableExamples:
    let board = @[
      @[live, dead, live, live],
      @[dead, live, live, live],
      @[live, live, live, dead],
      @[live, live, live, dead],
    ]
    doAssert board.getNeighbourCells(x = 0, y = 0) == @[dead, dead, live]
  for y2 in y-1..y+1:
    if y2 < 0 or board.len <= y2:
      continue
    for x2 in x-1..x+1:
      if x2 < 0 or board[y2].len <= x2:
        continue
      if x == x2 and y == y2:
        continue
      result.add board[y2][x2]

proc isReproduction*(self: CellStatus, livingCellCount: int): bool =
  ## Returns cell is reproduction.
  ## Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  runnableExamples:
    doAssert dead.isReproduction(2) == false
    doAssert dead.isReproduction(3)
  if self != CellStatus.dead:
    return false
  result = livingCellCount == 3

proc isGeneration*(self: CellStatus, livingCellCount: int): bool =
  ## Returns cell is generation.
  ## Any live cell with two or three live neighbours lives on to the next generation.
  runnableExamples:
    doAssert live.isGeneration(1) == false
    doAssert live.isGeneration(2)
    doAssert live.isGeneration(3)
  if self != CellStatus.live:
    return false
  result = case livingCellCount
           of 2, 3: true
           else: false

proc isUnderpopulation*(self: CellStatus, livingCellCount: int): bool =
  ## Returns cell is underpopulation.
  ## Any live cell with fewer than two live neighbours dies, as if by underpopulation.
  runnableExamples:
    doAssert live.isUnderpopulation(0)
    doAssert live.isUnderpopulation(1)
    doAssert live.isUnderpopulation(2) == false
  if self != CellStatus.live:
    return false
  result = livingCellCount <= 1

proc isOverpopulation*(self: CellStatus, livingCellCount: int): bool =
  ## Returns cell is overpopulation.
  ## Any live cell with more than three live neighbours dies, as if by overpopulation.
  runnableExamples:
    doAssert live.isOverpopulation(3) == false
    doAssert live.isOverpopulation(4)
    doAssert live.isOverpopulation(5)
  if self != CellStatus.live:
    return false
  result = 4 <= livingCellCount

proc nextStep*(board: var Board) =
  ## Check all cells and update `board`.
  runnableExamples:
    var board: Board = @[
      @[dead, dead, dead, dead, dead],
      @[dead, dead, dead, dead, dead],
      @[dead, live, live, live, dead],
      @[dead, dead, dead, dead, dead],
      @[dead, dead, dead, dead, dead],
    ]
    board.nextStep
    doAssert board == @[
      @[dead, dead, dead, dead, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, dead, dead, dead],
    ]
  var newBoard: Board = @[]
  for y, row in board:
    var newRow: seq[CellStatus]
    for x, cell in row:
      let c = board.getNeighbourCells(x=x, y=y).filterIt(it == live).len
      if cell == dead:
        if cell.isReproduction(c):
          newRow.add live
        else:
          newRow.add dead
        continue

      if cell.isGeneration(c):
        newRow.add live
      elif cell.isUnderpopulation(c):
        newRow.add dead
      elif cell.isOverpopulation(c):
        newRow.add dead
      else:
        raise
    newBoard.add newRow
  # 結果をboardに上書き
  board = newBoard

proc print*(board: Board) =
  ## Print board to stdout.
  runnableExamples:
    var board: Board = @[
      @[dead, dead, dead, dead, dead],
      @[dead, dead, dead, dead, dead],
      @[dead, live, live, live, dead],
      @[dead, dead, dead, dead, dead],
      @[dead, dead, dead, dead, dead],
    ]
    board.print
    ## Output:
    ## |D|D|D|D|D|
    ## |D|D|D|D|D|
    ## |D|L|L|L|D|
    ## |D|D|D|D|D|
    ## |D|D|D|D|D|
  for row in board:
    var s = "|"
    for cell in row:
      let c = case cell
              of live: "L"
              else: "D"
      s.add c & "|"
    echo s

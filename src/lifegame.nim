from sequtils import filterIt

type
  CellStatus* = enum
    live, dead
  Board* = seq[seq[CellStatus]]

proc getNeighbourCells*(board: Board, x, y: int): seq[CellStatus] =
  ## 隣接するセルの取得
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
  ## 誕生
  if self != CellStatus.dead:
    return false
  result = livingCellCount == 3

proc isGeneration*(self: CellStatus, livingCellCount: int): bool =
  ## 生存
  if self != CellStatus.live:
    return false
  result = case livingCellCount
           of 2, 3: true
           else: false

proc isUnderpopulation*(self: CellStatus, livingCellCount: int): bool =
  ## 過疎
  if self != CellStatus.live:
    return false
  result = livingCellCount <= 1

proc isOverpopulation*(self: CellStatus, livingCellCount: int): bool =
  ## 過密
  if self != CellStatus.live:
    return false
  result = 4 <= livingCellCount

proc nextStep*(board: var Board) =
  # 全部のセルに対してチェックし、新しいboardとする
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
  for row in board:
    var s = "|"
    for cell in row:
      let c = case cell
              of live: "L"
              else: "D"
      s.add c & "|"
    echo s

when isMainModule:
  when false:
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
      sleep(1000)
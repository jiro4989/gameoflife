import unittest
import gameoflife

suite "getNeighbourCells":
  let board = @[
    @[live, dead, live, live],
    @[dead, live, live, live],
    @[live, live, live, dead],
    @[live, live, live, dead],
  ]
  test "left-top":
    check board.getNeighbourCells(x = 0, y = 0) == @[dead, dead, live]
  test "center":
    check board.getNeighbourCells(x = 1, y = 1) == @[live, dead, live,
                                                     dead,       live,
                                                     live, live, live]
  test "right-buttom":
    check board.getNeighbourCells(x = 3, y = 3) == @[live, dead, live]

suite "isReproduction":
  test "normal":
    check dead.isReproduction(3) == true
    check dead.isReproduction(2) == false
    check dead.isReproduction(1) == false
    check live.isReproduction(3) == false
    check live.isReproduction(2) == false
    check live.isReproduction(1) == false

suite "isGeneration":
  test "normal":
    check live.isGeneration(1) == false
    check live.isGeneration(2) == true
    check live.isGeneration(3) == true
    check live.isGeneration(4) == false
    check dead.isGeneration(1) == false
    check dead.isGeneration(2) == false
    check dead.isGeneration(3) == false
    check dead.isGeneration(4) == false

suite "isUnderpopulation":
  test "normal":
    check live.isUnderpopulation(0) == true
    check live.isUnderpopulation(1) == true
    check live.isUnderpopulation(2) == false
    check dead.isUnderpopulation(0) == false
    check dead.isUnderpopulation(1) == false
    check dead.isUnderpopulation(2) == false

suite "isOverpopulation":
  test "normal":
    check live.isOverpopulation(3) == false
    check live.isOverpopulation(4) == true
    check live.isOverpopulation(5) == true
    check dead.isOverpopulation(3) == false
    check dead.isOverpopulation(4) == false
    check dead.isOverpopulation(5) == false

suite "nextStep":
  test "固定物体 ブロック":
    var board: Board = @[
      @[dead, dead, dead, dead],
      @[dead, live, live, dead],
      @[dead, live, live, dead],
      @[dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead],
      @[dead, live, live, dead],
      @[dead, live, live, dead],
      @[dead, dead, dead, dead],
    ]
  test "固定物体 蜂の巣":
    var board: Board = @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, live, dead, dead, live, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, live, dead, dead, live, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
  test "固定物体 ボート":
    var board: Board = @[
      @[dead, dead, dead, dead, dead],
      @[dead, live, live, dead, dead],
      @[dead, live, dead, live, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead, dead],
      @[dead, live, live, dead, dead],
      @[dead, live, dead, live, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, dead, dead, dead],
    ]
  test "固定物体 池":
    var board: Board = @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, live, dead, dead, live, dead],
      @[dead, live, dead, dead, live, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, live, dead, dead, live, dead],
      @[dead, live, dead, dead, live, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
  test "振動子 ブリンカー":
    var board: Board = @[
      @[dead, dead, dead, dead, dead],
      @[dead, dead, dead, dead, dead],
      @[dead, live, live, live, dead],
      @[dead, dead, dead, dead, dead],
      @[dead, dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, live, dead, dead],
      @[dead, dead, dead, dead, dead],
    ]
  test "振動子 ヒキガエル":
    var board: Board = @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, live, dead, dead, dead, dead],
      @[dead, dead, dead, dead, live, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, live, dead, dead, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, dead, live, live, dead, dead],
      @[dead, dead, dead, live, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
  test "振動子 ビーコン":
    var board: Board = @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, live, live, dead, dead, dead],
      @[dead, live, dead, dead, dead, dead],
      @[dead, dead, dead, dead, live, dead],
      @[dead, dead, dead, live, live, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, live, live, dead, dead, dead],
      @[dead, live, live, dead, dead, dead],
      @[dead, dead, dead, live, live, dead],
      @[dead, dead, dead, live, live, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
  test "振動子 時計":
    var board: Board = @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, live, dead, dead, dead],
      @[dead, dead, live, dead, live, dead],
      @[dead, live, dead, live, dead, dead],
      @[dead, dead, dead, live, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
    board.nextStep
    check board == @[
      @[dead, dead, dead, dead, dead, dead],
      @[dead, dead, dead, live, dead, dead],
      @[dead, live, live, dead, dead, dead],
      @[dead, dead, dead, live, live, dead],
      @[dead, dead, live, dead, dead, dead],
      @[dead, dead, dead, dead, dead, dead],
    ]
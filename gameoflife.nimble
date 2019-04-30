# Package

version       = "1.0.0"
author        = "jiro4989"
description   = "gameoflife is library for Game of Life."
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["gameoflife"]

# Dependencies

requires "nim >= 0.19.4"

task docs, "Generate document":
  exec "nimble doc src/gameoflife.nim -o:docs/gameoflife.html"

task examples, "Build examples (not execute)":
  for d in ["blinker", "glider", "read_file"]:
    withDir "examples/" & d:
      exec "nim c main.nim"
      exec "echo ---------"

task ci, "Run CI tasks":
  exec "nimble test"
  exec "nimble docs"
  exec "nimble examples"

task buildjs, "Build JS library":
  exec "nimble js -o:docs/js/libjs.js src/libjs.nim"
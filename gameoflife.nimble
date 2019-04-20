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

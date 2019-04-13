# Package

version       = "0.1.0"
author        = "jiro4989"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["lifegame"]

# Dependencies

requires "nim >= 0.19.4"

task docs, "Generate document":
  exec "nimble doc src/lifegame.nim -o:doc/html/lifegame.html"


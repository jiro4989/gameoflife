# Package

version       = "0.1.0"
author        = "jiro4989"
description   = "gameoflife is library for Game of Life."
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["gameoflife"]

# Dependencies

requires "nim >= 0.19.4"

task docs, "Generate document":
  exec "nimble doc src/gameoflife.nim -o:doc/html/gameoflife.html"

task ghpages, "Update gh-pages":
  exec "git checkout gh-pages"
  exec "git merge master"
  exec "git push"
  exec "git checkout master"

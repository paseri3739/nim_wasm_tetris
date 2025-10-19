# Nim と Emscripten で WebAssemblyを作って Canvasに出力するサンプル01
# This code is a rewrite in Nim of an example written in C by Tim Hutton.
# https://github.com/timhutton/sdl-canvas-wasm
import sdl2

when defined(emscripten):
  proc emscripten_set_main_loop(
    fun: proc() {.cdecl.}, fps, simulate_infinite_loop: cint
  ) {.header: "<emscripten.h>".}

  proc emscripten_cancel_main_loop() {.header: "<emscripten.h>".}

#######################################
# main loop
#######################################
var
  is_first = true
  window: sdl2.WindowPtr = nil
  renderer: sdl2.RendererPtr = nil
  iteration: int = 0

proc mailoop() {.cdecl.} =
  if is_first:
    is_first = false
    discard createWindowAndRenderer(255, 255, 0, window, renderer)

  renderer.setDrawColor(255, 0, 0, 255)
  renderer.clear()

  renderer.setDrawColor(0, 0, 255, 255)
  var r: sdl2.Rect =
    (x: cint((iteration mod (255 + 50)) - 50), y: cint(50), w: cint(50), h: cint(50))
  renderer.fillRect(r)

  renderer.present

  inc(iteration)

#######################################
# main
#######################################
init(INIT_VIDEO)

const
  simulate_infinite_loop = 1
  fps = -1

when defined(emscripten):
  # Emscriptenの場合は、main loopを登録して終了
  echo "Starting main loop with Emscripten..."
  emscripten_set_main_loop(mailoop, fps, simulate_infinite_loop)

if (renderer != nil):
  renderer.destroy
if (window != nil):
  window.destroyWindow

sdl2.quit()

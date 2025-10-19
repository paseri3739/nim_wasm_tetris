when defined(emscripten):
  --dynlibOverride:
    SDL2
  --gc:
    none
  --cc:
    clang
  --clang.exe:
    emcc
  --clang.linkerexe:
    emcc
  --clang.options.linker:
    ""
  --cpu:
    i386
  --os:
    linux
  --passC:
    "-O3"
  --passL:
    "-s WASM=1 -s NO_EXIT_RUNTIME=1 -s EXPORTED_RUNTIME_METHODS=ccall -s USE_SDL=2"

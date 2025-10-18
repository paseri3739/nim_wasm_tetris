import sdl2

when isMainModule:
  ## SDL2 を初期化（ビデオサブシステムのみ）
  if SDL_Init(SDL_INIT_VIDEO) != 0:
    quit "SDL_Init failed: " & $SDL_GetError()

  ## ウィンドウ作成
  let window = SDL_CreateWindow(
    "Hello SDL2 (Nim)", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 640, 480,
    SDL_WINDOW_SHOWN,
  )
  if window.isNil:
    SDL_Quit()
    quit "SDL_CreateWindow failed: " & $SDL_GetError()

  ## レンダラ作成（ハードウェア+VSync）
  let renderer = SDL_CreateRenderer(
    window, -1, SDL_RENDERER_ACCELERATED or SDL_RENDERER_PRESENTVSYNC
  )
  if renderer.isNil:
    SDL_DestroyWindow(window)
    SDL_Quit()
    quit "SDL_CreateRenderer failed: " & $SDL_GetError()

  var running = true
  var e: SDL_Event

  ## メインループ
  while running:
    ## イベント処理
    while SDL_PollEvent(addr e) != 0:
      case e.type
      of SDL_QUIT:
        running = false
      of SDL_KEYDOWN:
        ## ESCで終了
        if e.key.keysym.scancode == SDL_SCANCODE_ESCAPE:
          running = false
      else:
        discard

    ## 背景黒でクリア
    discard SDL_SetRenderDrawColor(renderer, 0'u8, 0'u8, 0'u8, 255'u8)
    discard SDL_RenderClear(renderer)

    ## 白い矩形を描画
    discard SDL_SetRenderDrawColor(renderer, 255'u8, 255'u8, 255'u8, 255'u8)
    var rect = SDL_Rect(x: 220, y: 140, w: 200, h: 200)
    discard SDL_RenderFillRect(renderer, addr rect)

    ## 画面に反映
    SDL_RenderPresent(renderer)

  ## 後始末
  SDL_DestroyRenderer(renderer)
  SDL_DestroyWindow(window)
  SDL_Quit()

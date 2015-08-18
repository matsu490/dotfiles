"===========================================================
" For Mac OS X
"===========================================================
if has('mac')
    set columns=100			"ウィンドウの幅
    set lines=52			"ウィンドウの高さ
    colorscheme solarized	"カラースキーマ設定
    set encoding=utf-8		"utf-8表示
    set guifont=Ricty\ Discord\ Regular\ for\ Powerline:h14
endif

"===========================================================
" For Unix
"===========================================================
if has('unix')
    set columns=100			"ウィンドウの幅
    set lines=52			"ウィンドウの高さ
    colorscheme solarized	"カラースキーマ設定
    set encoding=utf-8		"utf-8表示

endif

"===========================================================
" For windows 32bit or 64bit
"===========================================================
if has('win32') || has('win64')
    set columns=100			"ウィンドウの幅
    set lines=52			"ウィンドウの高さ
    colorscheme solarized	"カラースキーマ設定
    set encoding=utf-8		"utf-8表示
endif

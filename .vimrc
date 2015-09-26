"------------------------------------------------
" NeoBundle
"------------------------------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
" from original repos on github
NeoBundle 'tpope/vim-rails.git'
NeoBundle 'msanders/snipmate.vim.git'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'groenewege/vim-less'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'derekwyatt/vim-scala'

"
" ctrlp: ファイル検索
"
NeoBundle 'kien/ctrlp.vim'
" ag入ってたらagで検索させる
" ついでにキャッシュファイルからの検索もさせない
if executable('ag')
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
endif
" ワーキングパスモード設定
let g:ctrlp_working_path_mode = 'w'

" from vim-scripts repos
NeoBundle 'quickrun.vim'
NeoBundle 'JavaScript-syntax'
NeoBundle 'Markdown'
NeoBundle 'Zenburn'
NeoBundle 'Align'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"--------------------
" base
"--------------------
set nocompatible " viとの互換性をとらない(vimの独自拡張機能を使う為)
imap <F11> <nop> "インサートモードでのF11を無効化
set pastetoggle=<F11> "ノーマルモードでF11を押すとペーストモード切り替え

"--------------------
" edit
"--------------------
set showmatch       "対応する括弧にカーソル移動
set matchtime=1     "showmatchの表示時間
set showcmd         "入力中のコマンドをステータスに表示
set wildmenu        "コマンドライン補完を拡張モード
set backspace=indent,eol,start " バックスペースキーの影響範囲を指定

"--------------------
" indent
"--------------------
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype less setlocal ts=2 sts=2 sw=2

"--------------------
" search
"--------------------
set hlsearch    " 検索結果をハイライトする
set wrapscan    " 検索後、先頭に戻る
set ignorecase  " 検索時に大文字小文字を区別しない
set smartcase   " ただし、検索クエリに大文字が含まれる場合は区別する
set noincsearch " インクリメンタルサーチ
set history=100

"--------------------
" split
"--------------------
set splitbelow "新しいウィンドウを下に開く
set splitright "新しいウィンドウを右に開く

"--------------------
" status line
"--------------------
set laststatus=2
set statusline=%n\:%y%F\ \<%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\>'}%m%r%=<%l/%L:%p%%>
                
"--------------------
" design
"--------------------
colorscheme hybrid
set title  " タイトルバーを表示する
set number " 行番号を表示する
set ruler  " ルーラ（画面右下の行情報）を表示する

"--------------------
" syntax highlight
"--------------------
syntax on
" autocmd [group_name] event_name filepattern [nested] handler
autocmd BufNewFile,BufRead *.json set ft=javascript " .json as javascript
autocmd BufNewFile,BufRead *.as set ft=javascript " .as as javascript
autocmd BufNewFile,BufRead *.class set ft=php       " .class as php
autocmd BufNewFile,BufRead *.ctp set filetype=php   " .ctp as php
autocmd BufNewFile,BufRead *.hbs set filetype=html   " .hbs as html
autocmd BufNewFile,BufRead *.erb set filetype=html   " .erb as html
source $VIMRUNTIME/macros/matchit.vim               " matchit
let php_sql_query=1                                 " sql in php

"--------------------
" cursor highlight
"--------------------
set cursorline
hi CursorLine cterm=none ctermfg=234 ctermbg=LightBlue
hi Visual guibg=Blue ctermbg=Blue

"--------------------
" key map
"--------------------
" It doesn't record in the list of YankRing.
" http://d.hatena.ne.jp/yano3/20090526/1243350033
nnoremap x "_x

"--------------------
" charcode
"--------------------
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

"--------------------
" vendor
"--------------------
" nerdtree
" http://kokukuma.blogspot.jp/2011/12/vim-essential-plugin-nerdtree.html
let file_name = expand("%")
if has('vim_starting') &&  file_name == ""
    autocmd VimEnter * NERDTree ./
endif

" align
let g:Align_xstrlen=3

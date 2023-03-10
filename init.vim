augroup VimRc
  autocmd!
augroup END

" {{{ set options
set cmdheight=1
set wildmenu
set fileencodings=utf-8,cp932
set fileformats=unix,dos
set ignorecase
set smartcase
set noswapfile
set termguicolors
set helplang=ja,en
set expandtab
set tabstop=2
set shiftwidth=2
" }}}

" {{{ define custom key-bindings
nmap <A-,> <Cmd>edit $MYVIMRC<CR>
nmap <space>e <Cmd>exec printf('%s %s', g:FilerCommand, expand('%')->fnamemodify(':p:h'))<CR>
nnoremap K <Nop>
autocmd VimRc FileType vim,help nnoremap <buffer> K K
nnoremap <expr> a strlen(line('.')) ==# 0 ? '"_cc' : 'a'
nnoremap <expr> i strlen(line('.')) ==# 0 ? '"_cc' : 'i'
" }}}

" {{{ define custom environement variables
let $HYPERRC = expand('$APPDATA\Hyper\.hyper.js')
let $ALACRITTYRC = expand('$APPDATA\alacritty\alacritty.yml')
" }}}

filetype plugin indent on
syntax enable

colorscheme habamax
hi normal guibg=none
hi linenr guibg=none
hi nontext guibg=none
hi specialchar guibg=none

" {{{ setup plugins

" {{{ configure builtin plugins
" {{{ netrw
" tree style
let g:netrw_liststyle = 3
let g:netrw_usetab = 1

autocmd VimRc VimEnter * ++once let g:FilerCommand = get(g:, 'FilerCommand', 'Explore')
" }}}
" {{{ matchit
let g:loaded_matchit = 1
" }}}
" {{{ matchparen
let g:loaded_matchparen = 1
" }}}
" }}}

" {{{ load vim-plug
const s:plugDir = stdpath('data') .. '\plugged\vim-plug'
if &rtp !~# '/vim-plug'
  exec printf('set rtp^=%s', s:plugDir)
  runtime plug.vim
endif
function! s:CloneAndSourceVimPlug() abort
  call system(['git', 'clone', 'https://github.com/junegunn/vim-plug.git', s:plugDir])
  exec printf('helptags %s\doc', s:plugDir)
  " runtime plug.vim だとなんか動かない
  exec printf('source %s', s:plugDir .. '\plug.vim')
endfunction
function! s:RetryUndefinedFunc(prepare, callback = v:null) abort
  if a:prepare isnot# v:null
    call call(a:prepare, [])
  endif
  call call(expand('<amatch>'), [])
  if a:callback isnot# v:null
    call call(a:callback, [])
  endif
endfunction
autocmd VimRc FuncUndefined plug#* ++once call <SID>RetryUndefinedFunc(function('<SID>CloneAndSourceVimPlug'))
" }}}

" {{{ install user plugins
function! s:RegisterUserPlugins() abort
  call plug#begin()
  Plug 'junegunn/vim-plug'
  Plug 'cohama/lexima.vim'
  Plug 'machakann/vim-sandwich'
  Plug 'uga-rosa/ccc.nvim'
  Plug 'hrsh7th/vim-eft'
  Plug 'vim-jp/syntax-vim-ex', #{ for: 'vim' }
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'kana/vim-operator-user'
  Plug 'tyru/caw.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'andymass/vim-matchup'
  Plug 'haya14busa/vim-asterisk'
  Plug 'machakann/vim-highlightedyank'
  Plug 'lambdalisue/fern.vim'
  call plug#end()
endfunction
" }}}

" {{{ configure user plugins
function! s:ConfigureUserPlugins() abort
  " {{{ lexima.vim
  let g:lexima_accept_pum_with_enter = 1
  let g:LeximaUserRules = [
        \ #{ char: '<TAB>', at: "\\%#'",   leave: "'" },
        \ #{ char: '<TAB>', at: '\%#"',    leave: '"' },
        \ #{ char: '<TAB>', at: '\%#\s*]', leave: ']' },
        \ #{ char: '<TAB>', at: '\%#\s*)', leave: ')' },
        \ #{ char: '<TAB>', at: '\%#\s*)', leave: ')' },
        \ #{ char: '<TAB>', at: '\%#\s*}', leave: '}' },
        \]
  call map(g:LeximaUserRules, { _, rule -> lexima#add_rule(rule) })
  " }}}

  " {{{ vim-sandwich
  nmap s <Nop>
  xmap s <Nop>
  " }}}

  " {{{ vim-eft
  let g:eft_ignorecase = v:true
  nmap ; <Plug>(eft-repeat)
  xmap ; <Plug>(eft-repeat)

  map f <Plug>(eft-f)
  map F <Plug>(eft-F)

  map t <Plug>(eft-t)
  map T <Plug>(eft-T)
  " }}}

  " {{{ vim-matchup
  autocmd VimRc VimEnter * ++once iunmap <C-g>%
  let g:matchup_matchparen_enabled = 0
  " }}}

  " {{{ vim-asterisk
  map * <Plug>(asterisk-z*)
  map g* <Plug>(asterisk-gz*)
  map # <Plug>(asterisk-z#)
  map g# <Plug>(asterisk-gz#)
  " }}}

  " {{{ vim-highlightedyank
  let g:highlightedyank_highlight_duration = 200
  " }}}

  " {{{ fern.vim
  let g:FilerCommand = 'Fern'
  " }}}

  " ccc.nvim
  lua require('plugin-configurations.ccc-nvim')

  " nvim-cmp
  lua require('plugin-configurations.nvim-cmp')

  " telescope.nvim
  lua require('plugin-configurations.telescope-nvim')
endfunction
" }}}

function! s:SetupUserPlugins() abort
  call s:RegisterUserPlugins()
  call s:ConfigureUserPlugins()
endfunction

if executable('git') && !v:vim_did_enter
  call s:SetupUserPlugins()
endif
" }}}

" vim:ft=vim expandtab tabstop=2 shiftwidth=2 foldenable foldmethod=marker foldlevel=0:

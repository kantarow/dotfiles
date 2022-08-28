filetype plugin indent on
set autoindent
set number
set expandtab
set tabstop=2
set softtabstop=2
set backspace=2
set belloff=all
colorscheme murphy

inoremap jj <ESC>
nnoremap T :NERDTree<CR>
nnoremap <C-l> gt

function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  call minpac#add('preservim/nerdtree')
  call minpac#add('tpope/vim-haml')
  call minpac#add('joshdick/onedark.vim')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('dense-analysis/ale')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('iberianpig/tig-explorer.vim')
  call minpac#add('airblade/vim-gitgutter')
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('thinca/vim-quickrun')
  call minpac#add('cohama/lexima.vim')
endfunction

packadd! onedark.vim

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" aleでrubocopを実行する
let g:ale_linters = {
\   'ruby': ['rubocop'],
\   'rust': ['rls'],
\}
let g:ale_linters_explicit = 1
let g:airline#extensions#ale#enabled = 1

syntax on
colorscheme onedark

" vim-quickrunの設定
if !exists("g:quickrun_config")
  let g:quickrun_config={}
endif

let g:quickrun_config = {
  \  "_" : {
  \    "outputter": "popup",
  \  }
  \}

augroup rust_quickrun
  au!
  autocmd BufNewFile,BufRead *.rs let g:quickrun_config.rust = {'exec' : 'cargo run'}
augroup END


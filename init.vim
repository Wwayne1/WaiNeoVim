  
" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @wayne


" ====================
" ====== bugs  =======
" ====================
"
" 执行:source $MYVIMRC<CR> 时coc的reference会实化
" html文件运行有问题


" ====================
" === Editor Setup ===
" ====================


" ===
" === System
" ===
"set clipboard=unnamed
let &t_ut=''
set autochdir
set mouse=a           "使用鼠标
set encoding=utf-8

"nvim默认位置
cd /Users/wayne/code

" ===
" === Editor behavior
" ===
syntax on
set number
set relativenumber
set cursorline        "高亮当前行
set tabstop=4         "缩进长度
set shiftwidth=4
set softtabstop=4
set list              "显示行尾空格
set listchars=tab:\|\ ,trail:▫
set scrolloff=4       "滚轮滚动行数
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set backspace=indent,eol,start
set foldmethod=indent "根据缩进折叠代码
set foldlevel=99
set wrap              "自动换行
set showcmd
set wildmenu
set autochdir

"再次启动nvim时保存上次推出前的undotree
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif


"Cursor save
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Compile function
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term time ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term time python3 %
	elseif &filetype == 'html'
		exec "!google-chrome % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run %
	endif
endfunc


"按<F2>自动生成代码设置
if !exists("*SetTitlea")
map <F2> :call SetTitlea()<CR>
func SetTitlea()
let l = 0
let l = l + 1 | call setline(l,'/*************************************************')
let l = l + 1 | call setline(l,' *Author*        :wayne')
let l = l + 1 | call setline(l,' *Description*   :       ')
let l = l + 1 | call setline(l,' *Created Time*  : '.strftime('%c'))
let l = l + 1 | call setline(l,'')
"let l = l + 1 | call setline(l,'**Problem**:')
"let l = l + 1 | call setline(l,'**Analyse**:')
"let l = l + 1 | call setline(l,'**Get**:')
"let l = l + 1 | call setline(l,'**Code**:')
let l = l + 1 | call setline(l,'**************************************************/')
let l = l + 1 | call setline(l,'')

"acm配置
"let l = l + 1 | call setline(l,'#include <cstdio>')
"let l = l + 1 | call setline(l,'#include <cstring>')
"let l = l + 1 | call setline(l,'#include <iostream>')
"let l = l + 1 | call setline(l,'#include <algorithm>')
"let l = l + 1 | call setline(l,'#include <vector>')
"let l = l + 1 | call setline(l,'#include <queue>')
"let l = l + 1 | call setline(l,'#include <set>')
"let l = l + 1 | call setline(l,'#include <map>')
"let l = l + 1 | call setline(l,'#include <string>')
"let l = l + 1 | call setline(l,'#include <cmath>')
"let l = l + 1 | call setline(l,'#include <cstdlib>')
"let l = l + 1 | call setline(l,'#include <ctime>')
"let l = l + 1 | call setline(l,'#include <stack>')
"let l = l + 1 | call setline(l,'using namespace std;')
"let l = l + 1 | call setline(l,'typedef pair<int, int> PII;')
"let l = l + 1 | call setline(l,'typedef long long LL;')
"let l = l + 1 | call setline(l,'typedef unsigned long long ULL;')
"let l = l + 1 | call setline(l,'')
"let l = l + 1 | call setline(l,'int main()')
"let l = l + 1 | call setline(l,'{')
"let l = l + 1 | call setline(l,'    return 0;')
"let l = l + 1 | call setline(l,'}')
endfunc
endif


"完成时间
if !exists("*FinishT")
map<F1> : call FinishT()<CR>
func FinishT()
let l = 5 | call setline(l,' * Ended  Time*  : '.strftime('%c'))
endfunc
endif




" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>
let mapleader=" "

" Open Startify
noremap <LEADER>st :Startify<CR>

" 快速上下移动
noremap K 5k
noremap J 5j

" Save & quit
noremap Q :q<CR>
noremap S :w<CR>

"实时刷新vimrc
noremap R :source $MYVIMRC<CR> 

"search
noremap <LEADER><CR> :nohlsearch<CR>

" make Y to copy till the end of the line
nnoremap Y y$

" Copy to system clipboard
vnoremap Y "+y

" Indentation
nnoremap < <<
nnoremap > >>

" Folding  暂时没搞懂
noremap <silent> <LEADER>o za

" ===
" === Window management    分屏
" ===
" Disabling the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sl :set splitright<CR>:vsplit<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>

" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>l <C-w>l
noremap <LEADER>h <C-w>h
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j

" Resize splits with arrow keys   
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Rotate screens
noremap srh <C-w>b<C-w>K
noremap srv <C-w>b<C-w>H

" ===
" === Tab management   标签
" ===
" Create a new tab with tk
noremap tk :tabe<CR>
" Move around tabs with tn and ti
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>

" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/snippets.vim
" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell


" ===
" === Other useful stuff
" ===

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:sp<CR>:term<CR>

" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

"Plug 'theniceboy/eleline.vim'
Plug 'vim-airline/vim-airline'
Plug 'luochen1990/rainbow'
"Plug 'bling/vim-bufferline'
Plug 'ryanoasis/vim-devicons'

" colors
Plug 'connorholyday/vim-snazzy'
"Plug 'ajmwagar/vim-deus'

" Taglist
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Code Editing
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter' " in <leader>c<space> to comment a block
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'jiangmiao/auto-pairs'

" Genreal Highlighter
Plug 'jaxbot/semantic-highlight.vim'
"Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Error checking
"Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}

" Auto Complete
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }

" Formatter
"Plug 'Chiel92/vim-autoformat'

" Mini Vim-APP
Plug 'mhinz/vim-startify'

call plug#end()

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


"connorholyday/vim-snazzy
let g:SnazzyTransparent = 1  "背景透明化
color snazzy

" ===
" === vim-airline
" ===
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#hunks#enabled=1

" ===
" === semantic-highlight.
" ===
:nnoremap <Leader>s :SemanticHighlightToggle<cr>

" ===
" === rainbow
" ===
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ===
" === NERDTree
" ===
noremap ff :NERDTreeToggle<CR>

" ===
" === NERDTree-Git
" ===
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
"let g:NERDTreeShowIgnoredStatus = 1

" ===
" === Undotree
" ===
noremap U :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1

" ===
" === Ultisnips
" ===
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" ===
" === Taglist
" ===
map <silent> T :TagbarOpenAutoClose<CR>

" ===
" === Esaymotion
" ===
"nmap ss <Plug>(easymotion-s2)
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1
map ' <Plug>(easymotion-bd-f)
nmap ' <Plug>(easymotion-bd-f)

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
			\ 'mkit': {},
			\ 'katex': {},
			\ 'uml': {},
			\ 'maid': {},
			\ 'disable_sync_scroll': 0,
			\ 'sync_scroll_type': 'middle',
			\ 'hide_yaml_meta': 1
			\ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" ===
" === ycm
" ===
"let g:ycm_autoclose_preview_window_after_completion=0
"let g:ycm_autoclose_preview_window_after_insertion=1
"let g:ycm_use_clangd = 0

" ==
" == GitGutter
" ==
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>

" ===
" === coc
" ===
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
" color for coc-diagnostic
hi link CocErrorSign Error
hi link CocWarningSign ALEWarningSign
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]	=~ '\s'
endfunction
inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<Tab>" :
			\ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use D to show documentation in preview window
nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold 搞不懂干嘛的
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word 重命名（同时更改所有引用）
nmap <leader>rn <Plug>(coc-rename)

" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>

" ===
" === FZF
" ===
noremap <C-p> :FZF<CR>
noremap <C-f> :Ag<CR>
noremap <C-h> :MRU<CR>
noremap <C-t> :BTags<CR>
noremap <C-l> :LinesWithPreview<CR>
noremap <C-w> :Buffers<CR>
noremap <C-m> :Marks<CR>
noremap q; :History:<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noruler
  \| autocmd BufLeave <buffer> set laststatus=2 ruler

command! -bang -nargs=* Buffers
  \ call fzf#vim#buffers(
  \   '',
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:0%', '?'),
  \   <bang>0)


"查找当前文件某行
command! -bang -nargs=* LinesWithPreview
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --color=always --smart-case . '.fnameescape(expand('%')), 1,
    \   fzf#vim#with_preview({}, 'up:50%', '?'),
    \   1)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(
  \   '',
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)


command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())

command! -bang BTags
  \ call fzf#vim#buffer_tags('', {
  \     'down': '40%',
  \     'options': '--with-nth 1 
  \                 --reverse 
  \                 --prompt "> " 
  \                 --preview-window="70%" 
  \                 --preview "
  \                     tail -n +\$(echo {3} | tr -d \";\\\"\") {2} |
  \                     head -n 16"'
  \ })

" ===
" === AutoFormat
" ===
"nnoremap \f :Autoformat<CR>

" ===
" === fzf-quickfix
" ===
"nnoremap <c-q> :Quickfix!<CR>

" ===================== End of Plugin Settings =====================


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif

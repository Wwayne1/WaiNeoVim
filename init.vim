
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
"cd /Users/wayne/code/golang/src

" ===
" === Editor behavior
" ===
syntax on
set number
set relativenumber
set cursorline
set hidden
set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
set colorcolumn=100
set updatetime=100
set virtualedit=block


"Cursor save
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" Compile function
noremap r :call CompileRun()<CR>
func! CompileRun()
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
		:term go run .
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
noremap ; : 

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Open Startify
noremap <LEADER>st :Startify<CR>

nnoremap U <C-r>

" 快速上下移动
noremap K 5k
noremap J 5j

" backspace blank
imap <LEADER><BS> <C-W><C-W>

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
nnoremap <C-s> ggvG"+y

" Indentation
nnoremap < <<
nnoremap > >>

" Folding  折叠
noremap <silent> <LEADER>o za

" Open up lazygit
noremap \g :Git 
noremap <c-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>

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
noremap <LEADER>/ :set splitright<CR>:vsplit<CR>:term<CR>

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" Press ` to change case (instead of ~)
noremap ` ~

" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

Plug 'theniceboy/eleline.vim'
Plug 'ojroques/vim-scrollstatus'
"Plug 'vim-airline/vim-airline'
Plug 'luochen1990/rainbow'
Plug 'bling/vim-bufferline'
Plug 'ryanoasis/vim-devicons'
Plug 'mg979/vim-xtabline'
Plug 'RRethy/vim-illuminate'

" colors
"Plug 'connorholyday/vim-snazzy'
Plug 'bpietravalle/vim-bolt'
Plug 'ajmwagar/vim-deus'

" input method
Plug 'lyokha/vim-xkbswitch'

" Taglist
Plug 'liuchengxu/vista.vim'
"Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }

" Undo Tree
Plug 'mbbill/undotree'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'cohama/agit.vim'

" Code Editing
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter' " in <leader>c<space> to comment a block
"Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'machakann/vim-sandwich' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite
Plug 'mg979/vim-visual-multi'
Plug 'junegunn/goyo.vim'
Plug 'elzr/vim-json'

" Genreal Highlighter
Plug 'jaxbot/semantic-highlight.vim'
"Plug 'chrisbra/Colorizer' " Show colors with :ColorHighlight

" File navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'pechorin/any-jump.vim'

" Error checking
"Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}

" Auto Complete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Snippets
Plug 'honza/vim-snippets'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install_sync() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }

" Formatter
"Plug 'Chiel92/vim-autoformat'

" Mini Vim-APP
Plug 'hardcoreplayers/dashboard-nvim'
Plug 'itchyny/calendar.vim'
"Plug 'mhinz/vim-startify'

" golang
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" for fun
Plug 'johngrib/vim-game-snake'

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

" ===
" === Dress up my vim
" ===
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set lazyredraw
color deus
hi NonText ctermfg=gray guifg=grey10

"connorholyday/vim-snazzy
"let g:SnazzyTransparent = 1  "背景透明化
"color snazzy

" ===================== Start of Plugin Settings =====================



"" ===
" === vim-airline
" ===
"let g:airline#extensions#branch#enabled=1
"let g:airline#extensions#hunks#enabled=1

" ===
" === vim-eleline
" ===
let g:airline_powerline_fonts = 0

" ===
" === vim-startify
" ===
let g:startify_custom_header = [
   \ '',
   \ '                                                              ⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠞⠉⢉⣭⣿⣿⠿⣳⣤⠴⠖⠛⣛⣿⣿⡷⠖⣶⣤⡀⠀⠀⠀   ',
   \ '                                                               ⠀⠀⠀⠀⠀⠀⠀⣼⠁⢀⣶⢻⡟⠿⠋⣴⠿⢻⣧⡴⠟⠋⠿⠛⠠⠾⢛⣵⣿⠀⠀⠀⠀  ',
   \ '                                                               ⣼⣿⡿⢶⣄⠀⢀⡇⢀⡿⠁⠈⠀⠀⣀⣉⣀⠘⣿⠀⠀⣀⣀⠀⠀⠀⠛⡹⠋⠀⠀⠀⠀  ',
   \ '                                                               ⣭⣤⡈⢑⣼⣻⣿⣧⡌⠁⠀⢀⣴⠟⠋⠉⠉⠛⣿⣴⠟⠋⠙⠻⣦⡰⣞⠁⢀⣤⣦⣤⠀  ',
   \ '                                                               ⠀⠀⣰⢫⣾⠋⣽⠟⠑⠛⢠⡟⠁⠀⠀⠀⠀⠀⠈⢻⡄⠀⠀⠀⠘⣷⡈⠻⣍⠤⢤⣌⣀  ',
   \ '                                                               ⢀⡞⣡⡌⠁⠀⠀⠀⠀⢀⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢿⡀⠀⠀⠀⠸⣇⠀⢾⣷⢤⣬⣉  ',
   \ '                                                               ⡞⣼⣿⣤⣄⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠸⣿⣇⠈⠻  ',
   \ '                                                               ⢰⣿⡿⢹⠃⠀⣠⠤⠶⣼⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⣿⠀⠀⣿⠛⡄⠀  ',
   \ '                                                               ⠈⠉⠁⠀⠀⠀⡟⡀⠀⠈⡗⠲⠶⠦⢤⣤⣤⣄⣀⣀⣸⣧⣤⣤⠤⠤⣿⣀⡀⠉⣼⡇⠀  ',
   \ '                                                               ⣿⣴⣴⡆⠀⠀⠻⣄⠀⠀⠡⠀⠀⠀⠈⠛⠋⠀⠀⠀⡈⠀⠻⠟⠀⢀⠋⠉⠙⢷⡿⡇⠀  ',
   \ '                                                               ⣻⡿⠏⠁⠀⠀⢠⡟⠀⠀⠀⠣⡀⠀⠀⠀⠀⠀⢀⣄⠀⠀⠀⠀⢀⠈⠀⢀⣀⡾⣴⠃⠀  ',
   \ '                                                               ⢿⠛⠀⠀⠀⠀⢸⠁⠀⠀⠀⠀⠈⠢⠄⣀⠠⠼⣁⠀⡱⠤⠤⠐⠁⠀⠀⣸⠋⢻⡟⠀⠀  ',
   \ '                                                               ⠈⢧⣀⣤⣶⡄⠘⣆⠀⠀⠀⠀⠀⠀⠀⢀⣤⠖⠛⠻⣄⠀⠀⠀⢀⣠⡾⠋⢀⡞⠀⠀⠀  ',
   \ '                                                               ⠀⠀⠻⣿⣿⡇⠀⠈⠓⢦⣤⣤⣤⡤⠞⠉⠀⠀⠀⠀⠈⠛⠒⠚⢩⡅⣠⡴⠋⠀⠀⠀⠀  ',
   \ '                                                               ⠀⠀⠀⠈⠻⢧⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⣻⠿⠋⠀⠀⠀⠀⠀⠀  ',
   \ '                                                               ⠀⠀⠀⠀⠀⠀⠉⠓⠶⣤⣄⣀⡀⠀⠀⠀⠀⠀⢀⣀⣠⡴⠖⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀  ',
   \ '                                                                                                  ',
   \ '',
   \ ]

" ===
" === semantic-highlight.
" ===
:nnoremap <LEADER>sh :SemanticHighlightToggle<cr>

" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl


" ===
" === rainbow
" ===
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>

" ===
" === suda.vim
" ===
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%

" ===
" === vim-visual-multi
" ===
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
noremap \\ :Calendar -view=clock -position=here<CR>


" ===
" === vim-xkbswitch
" ===
let g:XkbSwitchEnabled = 1

" ===
" === Undotree
" ===
nnoremap <C-r> :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1


" ===
" === Vista.vim
" ===
" need to delete macos own ctags and instal universal-ctags
noremap <silent> T :Vista!!<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
function! NearestMethodOrFunction() abort
	return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

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
" === goyo
" ===
map <LEADER>gy :Goyo<CR>

" ===
" === Ultisnips
" ===
"let g:tex_flavor =  "latex
"let g:UltiSnipsExpandTrigger="<c-k>"
"let g:UltiSnipsJumpForwardTrigger="<c-k>"
"let g:UltiSnipsJumpBackwardTrigger="<c-j>"
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
"silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>
"" Solve extreme insert-mode lag on macOS (by disabling autotrigger)
"augroup ultisnips_no_auto_expansion
    "au!
    "au VimEnter * au! UltiSnips_AutoTrigger
"augroup END

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

" ==
" == GitGutter
" ==
let g:gitgutter_signs = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
"autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>
nnoremap <LEADER>u :GitGutterUndoHunk<CR>

" ===
" === Agit
" ===
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1

" ===
" === coc
" ===
let g:coc_global_extensions = ['coc-css', 'coc-vimlsp', 'coc-pyright', 'coc-python', 'coc-html', 'coc-git', 'coc-gitignore', 
			\ 'coc-lists', 'coc-tsserver','coc-json','coc-yank', 'coc-explorer', 'coc-translator', 'coc-snippets']

" color for coc-diagnostic
hi link CocErrorSign Error
hi link CocWarningSign ALEWarningSign

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap ff :CocCommand explorer<CR>

" Open up coc-commands
nnoremap <c-c> :CocCommand<CR>

" show the yank history
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>

" Use F to show documentation in preview window
nnoremap <silent> F :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <LEADER>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <LEADER>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Remap for rename current word 
nmap <LEADER>rn <Plug>(coc-rename)

" coc-translator
nmap ts <Plug>(coc-translator-p)

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'wayne'

"解决coc.nvim大文件卡死状况
let g:trigger_size = 0.5 * 1048576

augroup hugefile
  autocmd!
  autocmd BufReadPre *
        \ let size = getfsize(expand('<afile>')) |
        \ if (size > g:trigger_size) |
        \   echohl WarningMsg | echomsg 'WARNING: altering options for this huge file!' | echohl None |
        \   exec 'CocDisable' |
        \ else |
        \   exec 'CocEnable' |
        \ endif |
        \ unlet size
augroup END

" ===
" === vim-table-mode
" ===
noremap <LEADER>tm :TableModeToggle<CR>

" ===
" === vim-go
" ===
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
"let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0

"自动import 
let g:go_fmt_command = "goimports"

" ===
" === FZF
" ===
noremap <C-p> :FZF<CR>
noremap <C-f> :Ag<CR>
noremap <C-h> :MRU<CR>
noremap <C-t> :BTags<CR>
noremap <C-l> :LinesWithPreview<CR>
noremap <C-w> :Buffers<CR>
"noremap <C-m> :Marks<CR>
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
" === any-jump
" ===
"nnoremap <leader>d :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9

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

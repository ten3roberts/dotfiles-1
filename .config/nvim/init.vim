""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           plug                                    "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-plug"{{{
call plug#begin('~/.config/nvim/plugged')
Plug 'bronson/vim-trailing-whitespace'
" Plug 'flazz/vim-colorschemes'
Plug 'machakann/vim-highlightedyank'
Plug 'posva/vim-vue'

"lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/diagnostic-nvim'

"fuzzy
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'itchyny/lightline.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'preservim/nerdtree'
call plug#end()
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           default                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"default"{{{
" General configuration
set nu
set rnu                                  "line number
set hidden                               "allow buffer to change w/o saving
set lazyredraw                           "dont execute while running macros
set termguicolors
set history=1000                         "remember last thousand commands
set showmatch                            "show matching bracket
set hlsearch                             "highlight the search results
set incsearch                            "highlight search results as you type
set splitbelow
set splitright
autocmd Filetype tex set conceallevel=1
let g:tex_conceal='abdmg'
set backspace=indent,eol,start
set ruler
set colorcolumn=80
syntax enable
syntax on                                "syntax highlighting
set encoding=utf-8
set numberwidth=4
set nrformats+=alpha
set autoread                             "autoread file if it is changed in buffer
"prgram specific
set expandtab
set autoindent
set autochdir                            "autochange directory on the basis of what file you are editing
set undodir=~/.config/nvim/vimdid
" set clipboard^=unnamed                   "add system clipboard support
" set clipboard^=unnamedplus
set wildmenu                             "command line completion
set cursorline
set path+=**
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd FileType vim set fdm=marker                           "folding files
filetype indent on
filetype plugin on
let g:indentLine_enabled = 0
autocmd FileType html let g:indentLine_enabled=0

if has("nvim")
        set inccommand=nosplit                   "live find and replace
endif

"}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           maping                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
map Q <nop>
nnoremap <silent> Q :cclose<CR>:lclose<CR>
nnoremap <leader>W :wq<cr>
if has('nvim')
        "normal mode in terminal
        tnoremap <C-n> <C-\><C-n>
endif

"make it easier to edit and quit files
":Q also quits vim
command! Q q
":E also acts as edit
command! E e
":Wq also writes and quits
command! Wq wq
":x also writes and quits
command! Wq x

autocmd Filetype tex map <silent> <leader>gk :silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-R>=line('.')<CR> "%:p:r.pdf" "%:p" <CR>
autocmd Filetype tex map <silent> <leader>gl :silent !/Applications/Skim.app/Contents/SharedSupport/displayline <C-R>=line('.')<CR> "main.pdf" "%:p" <CR>

"quit help file like man pages
autocmd Filetype help nmap <silent><buffer> q :q<CR>
autocmd Filetype help wincmd K
autocmd FileType tex nnoremap <F5> :silent VimtexCompile<CR>
autocmd FileType tex inoremap <F5> <esc>:silent VimtexCompile<CR>
"quit netrw with an additional leader key
autocmd Filetype netrw nmap <silent><buffer> <leader>q :q<CR>
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>

autocmd Filetype tex :inoreabbrev <buffer> %t \%
autocmd Filetype tex :inoreabbrev <buffer> $t \$
autocmd Filetype tex :inoreabbrev <buffer> &t \&
autocmd Filetype tex :inoreabbrev <buffer> {t \{
autocmd Filetype tex :inoreabbrev <buffer> }t \}


nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
"""""""""""""""""""
"markdown specific"
"""""""""""""""""""
" autocmd Filetype markdown onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
"""""""""""""""""""""""
"python specific      "
"""""""""""""""""""""""
"easily write statements
autocmd Filetype python :inoreabbrev <buffer> iff if:<left>
autocmd Filetype python :inoreabbrev <buffer> eliff elif:<left>
autocmd Filetype python :inoreabbrev <buffer> forr for:<left>
autocmd Filetype python :inoreabbrev <buffer> classs class:<left>
autocmd Filetype python :inoreabbrev <buffer> deff def:<left>
autocmd Filetype python nnoremap <leader>rr :silent !tmux send-keys -t 1 "python"" "% "C-m"<cr>
autocmd Filetype python nnoremap <leader>cl :silent !tmux send-keys -t 1 "C-l"<cr>
autocmd Filetype python set tabstop=4
autocmd Filetype python set softtabstop=4
autocmd Filetype python set shiftwidth=4
"get into the statement body after it is complete
autocmd Filetype python inoremap <C-b> <esc>Ao
"automatically format current file according to pep8 standard, python autopep8
"required
autocmd Filetype python nnoremap <leader><C-s> :w!<cr>:%!autopep8 %<cr>:w<cr>:%!isort -d %<cr>:w<cr>


autocmd Filetype tex,html,vue set tabstop=2
autocmd Filetype tex,html,vue set softtabstop=2
autocmd Filetype tex,html,vue set shiftwidth=2

"""""""""""""""""""""""""""
"javascript and c specific"
"""""""""""""""""""""""""""
"
"easily write statements
autocmd Filetype javascript,cpp,c :inoreabbrev <buffer> iff if ()<left>
autocmd Filetype javascript,cpp,c :inoreabbrev <buffer> forr for ()<left>
autocmd Filetype javascript,cpp,c :inoreabbrev <buffer> clog console.log()<left>
autocmd Filetype javascript,cpp,c :inoreabbrev <buffer> elseif else if ()<left>
autocmd Filetype javascript :inoreabbrev <buffer> func function
" autocmd Filetype javascript,c,cpp,python inoremap <C-n> ()<left>
autocmd Filetype javascript nnoremap <leader>rr :silent !tmux send-keys -t 1 "node"" "% "C-m"<cr>
autocmd Filetype javascript nnoremap <leader>cl :silent !tmux send-keys -t 1 "C-l"<cr>
"get inside statement body with curly braces already defined
autocmd Filetype javascript,cpp,c inoremap <C-b> <esc>A {<esc>o<esc>o}<esc>ki<tab>

autocmd Filetype tex,javascript,cpp,c,html set tabstop=2
autocmd Filetype tex,javascript,cpp,c,html set softtabstop=2
autocmd Filetype tex,javascript,cpp,c,html set shiftwidth=2
"format c and cpp files
autocmd Filetype c,cpp nnoremap <leader><C-s> :w!<cr>:%!clang-format %<cr>:w<cr>
autocmd Filetype javascript nnoremap <leader><C-s> :w!<cr>:%!prettier %<cr>:w<cr>
autocmd Filetype cpp nnoremap <leader>cc :silent !tmux send-keys -t 1 "g++"" "% "C-m"<cr>
autocmd Filetype cpp nnoremap <leader>cl :silent !tmux send-keys -t 1 "C-l"<cr>
autocmd Filetype cpp nnoremap <leader>rr :silent !tmux send-keys -t 1 "./a.out" "C-m"<cr>
"make json pretty
autocmd Filetype json nnoremap <leader><C-s> :w!<cr>:%!python -m json.tool %<cr>:w<cr>


""""""""
"buffer"
""""""""
"
"easily switch between buffer
nnoremap <silent>]b :bn<cr>
nnoremap <silent>[b :bp<cr>
nnoremap <silent><C-q> :wq<cr>

"insert a html bare snippet
nnoremap ,htm :-1r $HOME/.config/nvim/snippets/base.html<cr>5j2f<i

nnoremap ,py :-1r $HOME/.config/nvim/snippets/main.py<cr>o

"make space as the leader key
let mapleader = "\<Space>"
let maplocalleader = ","
"change vim window quickly by leader hjkl
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
"indent all lines of the file
nnoremap <leader>ia gg=G<C-o>
"keep selecting the text after indenting in visual mode
"clear highlighting
nnoremap <silent><leader>ch :noh<CR>
"treat a long line like multiline if it appears in two line
nnoremap j gj
nnoremap k gk
"open a new tab
nnoremap <leader>to :<C-u>tabnew<cr>
" move tab right
noremap <silent><A-Left>  :-tabmove<cr>
noremap <silent><A-Right> :+tabmove<cr>
"close a tab
nnoremap <leader>t{ :<C-u>tabclose<cr>
"maximize a window that is focused
nnoremap <leader>z :wincmd _<cr>:wincmd \|<cr>
"minimize the maximized window
nnoremap <leader>Z :wincmd =<cr>
"FZF
nnoremap <C-p> :Files<cr>
nnoremap <leader><C-p> :Buffers<cr>
"left explorer
nmap <leader>e :NERDTreeCWD<cr>
"open a file explorer
nmap <leader>o :NERDTreeToggle<cr>
"resize vimsplits with hjkl
nmap <leader>rh <C-w>5>
nmap <leader>rj <C-w>3-
nmap <leader>rk <C-w>3+
nmap <leader>rl <C-w>5<
"copy all the content of the file
nmap <leader>ya gg0VG"*y
"delete all content of the file
nmap <leader>da gg0VG"*d
nmap <leader>dj m`jdd``
nmap <leader>dk m`kdd``
"edit init.vim in a new tab
nmap <leader>vi :tabe $MYVIMRC<cr>
"source the init.vim file
nmap <silent><leader>so :source $MYVIMRC<cr>
vnoremap < <gv
vnoremap > >gv
"move a visual block up or down a line
vnoremap <silent><leader>k :move-2<CR>gv=gv
vnoremap <silent><leader>j :move'>+<CR>gv=gv
vnoremap <leader>y "*y
"operator to change on next.previous structures
onoremap in( :<C-u>normal! f(vi(<cr>
onoremap in" :<C-u>normal! f"vi"<cr>
onoremap in' :<C-u>normal! f'vi'<cr>
onoremap ip( :<C-u>normal! F)vi(<cr>
onoremap ip" :<C-u>normal! F"vi"<cr>
onoremap ip' :<C-u>normal! F'vi'<cr>
"split vertical or horizontal and move cursor to the new split
map <leader>sh :split<cr>
map <leader>sv :vsplit<cr>
"Ctrl-s writes to the file
nmap <C-s> :w<cr>
imap <C-s> <Esc>:w<cr>
nnoremap <leader>aj m`o<esc>``
nnoremap <leader>ak m`O<esc>``
"remove the mapping from the arrow keys
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
" navigation in command line
cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

" Command line history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           vim-set                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"{{{
"""""""""""""""""""
"built into neovim"
"""""""""""""""""""
lua <<EOF
local on_attach_vim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end

require'nvim_lsp'.clangd.setup{on_attach=on_attach_vim}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
    use_languagetree = false,
  },
  indent = {
    enable = true
  }
}

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- DevIcon will be appended to `name`
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    name = "Zsh"
  }
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    -- Example:
    shorten_path = true, -- currently the default value is true
    mappings = {
      i = {
        ["<c-x>"] = false,
        ["<c-h>"] = actions.goto_file_selection_split,
        ["<c-o>"] = actions.goto_file_selection_tabedit,
        ["<c-q>"] = actions.close,
      },
    },
  }
}
EOF


" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <silent> <leader>dn :NextDiagnosticCycle<CR>
nnoremap <silent> <leader>dp :PrevDiagnosticCycle<CR>
nnoremap <silent> <leader>do :OpenDiagnostic<CR>

nnoremap <silent> <leader>gr <cmd>lua require'telescope.builtin'.lsp_references{ shorten_path = true }<CR>
nnoremap <silent> <leader>tl <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <silent> <leader>tq <cmd>lua require('telescope.builtin').quickfix()<cr>

imap <silent> <c-n> <Plug>(completion_trigger)
nnoremap <c-p> :lua require'telescope.builtin'.git_files{}<CR>
nnoremap <leader><c-p> <cmd>lua require'telescope.builtin'.find_files()<CR>
nnoremap ,<c-p> <cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ winblend = 20 }))<CR>


let g:completion_enable_snippet = 'UltiSnips'
let g:completion_sorting = "length"
let g:space_before_virtual_text = 10
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_insert_delay = 1

call sign_define("LspDiagnosticsErrorSign", {"text" : "🔺", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "⚠️ ", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticInformationSign", {"text" : "ℹ️", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})

let g:completion_trigger_keyword_length = 3
let g:completion_timer_cycle = 200

augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
augroup end

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c


colorscheme gruvbox

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" let g:gruvbox_contrast_dark="soft"
set background=dark
let g:highlightedyank_highlight_duration = 200
let g:snips_author="krishbin"
let g:vimtex_compiler_progname = 'nvr'

let g:UltiSnipsExpandTrigger = "<c-y>"
let g:UltiSnipsJumpForwardTrigger="<c-e>"
let g:UltiSnipsJumpBackwardTrigger="<c-y>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsSnippetDirectories=["Ultisnips", "~/.config/nvim/plugged/vim-snippets/UltiSnips"]
let g:UltiSnipsSnippetsDir=["Ultisnips", "~/.config/nvim/plugged/vim-snippets/UltiSnips"]
let g:tex_flavor = "latex"
let g:vimtex_view_method = 'skim'

autocmd BufRead,BufNewFile *.md,gitcommit,tex setlocal spell


let g:lightline = {
                        \ 'colorscheme': 'gruvbox',
                        \ 'active': {
                        \   'left': [ [ 'mode', 'paste' ],
                        \             [ 'gitbranch' ],[ 'readonly', 'absolutepath', 'modified' ] ],
                        \ 'right': [ ['lineinfo'],
                        \            [ 'percent' ],
                        \            [ 'filetype', 'fileencoding'] ] },
                        \ 'component_function': {
                        \   'gitbranch': 'FugitiveHead',
                        \ },
                        \ 'component_type': {
                        \ 'tabs': 'tabsel',
                        \   'readonly': 'error',
                        \ 'close': ''
                        \ }
                        \ }


let g:lightline.enable = {
                        \ 'statusline': 1,
                        \ 'tabline': 1
                        \ }


let g:python3_host_prog="/usr/local/bin/python3"
let g:gruvbox_color_column="bg3"
let g:vimtex_enabled=1
let g:vimtex_fold_enabled=1
let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_winsize=15

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           statusline                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{
function! GitBranch()
        return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
        let l:branchname = GitBranch()
        return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction


"set statusline=
"set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
"set statusline+=\ %f
"set statusline+=\ %y
"set statusline+=\ %m

"set statusline+=%=
"set statusline+=%#PmenuSel#
"set statusline+=\ [%{&fileencoding?&fileencoding:&encoding}]
"set statusline+=\ %c
"set statusline+=\ %p%%
"set statusline+=\ %l:%L
"set statusline+=\
"}}}

execute pathogen#infect()
syntax on
syntax enable
set encoding=utf-8
set fileencodings=utf-8
set autoindent
set smartindent
set smarttab
set expandtab
set nowrap
set number
set relativenumber
set scrolloff=6
set cursorline
set noerrorbells
set visualbell
set t_vb=
set noswapfile
set nobackup
set ignorecase
set smartcase
set incsearch
set hlsearch
set textwidth=80
set colorcolumn=80
set mouse=a
set signcolumn=yes
let mapleader = " "

" language specific tab spacing
augroup FiletypeSettings
  autocmd!
  " Python: 4 spaces, use expandtab
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
  " HTML, JSON, YAML, CSS, JSX: 2 spaces, use expandtab
  autocmd BufNewFile,BufRead *.html,*.json,*.yml,*.yaml,*.sql,*.css,*.jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent
  " Rust, Java: 4 spaces, use expandtab
  autocmd BufNewFile,BufRead *.rs,*.java setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab smartindent
  " JavaScript, TypeScript, TSX: 2 spaces, use expandtab
  autocmd BufNewFile,BufRead *.js,*.ts,*.tsx setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab smartindent
  " Go: 4 spaces, do NOT expand tabs
  autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
  " Makefiles: i have no clude
  autocmd BufNewFile,BufRead Makefile setlocal noexpandtab tabstop=8 softtabstop=0 shiftwidth=8
augroup END

" color scheme
if (has("termguicolors"))
    set termguicolors
endif
let ayucolor="dark"
colorscheme ayu
let g:lightline = {'colorscheme': 'ayu'}

" translucent vim background on everyting including special chars and status
" lines
highlight Normal ctermbg=NONE guibg=NONE
highlight NonText ctermbg=NONE guibg=NONE
highlight StatusLine ctermbg=NONE guibg=NONE
highlight StatusLineNC ctermbg=NONE guibg=NONE
" Remaps
" clear highlights after a file string search with "/" with enter
nnoremap <CR> :noh<CR><CR>:<backspace>
" S global search and replace
noremap S :%s//g<Left><Left>
" write and source vimrc
nmap <Leader>, :w<CR>:so %<CR>
"open file explorer
nmap <Leader><Leader> :Ex<CR>
"move selected lines up
vmap J :m '>+1<CR>gv=gv
"move selected lines down
vmap K :m '<-2<CR>gv=gv
" join lines without moving cursor
nnoremap J mzJ`z
" go to previous search so if you clear your search you can go right back 
" navigation purpose search for method or variable name and navigate from there
" and return
nnoremap N Nzzzv
" scroll half a page up and center cursor same for scroll down
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
"always shows status line in every pane
set laststatus=2
"lsp stuff
highlight CocErrorHighlight ctermfg=red guifg=red cterm=underline gui=underline
highlight CocErrorSign ctermfg=red guifg=red cterm=underline gui=underline
highlight CocErrorVirtualText ctermfg=red guifg=red cterm=underline gui=underline
" Trigger completion manually with Ctrl-Space
inoremap <silent><expr> <c-@> coc#refresh()
" jumps to the definition of the symbol
nmap <silent> gd <Plug>(coc-definition)
" shows references to symbol
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" rename symbol
nmap <leader>rn <Plug>(coc-rename)
autocmd ColorScheme *
    \ hi CocUnusedHighlight cterm=underline gui=underline guifg=#808080
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
"servers
" Define an autocommand group to handle the installation
augroup CoCInstall
  autocmd!
  autocmd VimEnter * call CocInstallServers()
augroup END
" Function to check if a specific CoC server is installed
function! IsCocServerInstalled(server)
  let extensions_dir = expand('~/.config/coc/extensions/node_modules/')
  return isdirectory(extensions_dir . '/' . a:server)
endfunction

function! CocInstallServers()
  let servers = ['coc-tsserver', 'coc-json', 'coc-pyright', 'coc-html', 'coc-css', 'coc-sh', 'coc-docker', 'coc-java', 'coc-markdownlint']
  for server in servers
    if !IsCocServerInstalled(server)
      execute 'CocInstall ' . server
    endif
  endfor
endfunction

" Basic fzf.vim configuration
let g:fzf_command_prefix = 'Fzf'

" Default fzf layout
let g:fzf_layout = { 'down': '~40%' }

" Key mappings for fzf.vim
nnoremap <leader>ff :FzfFiles<CR>
nnoremap <leader>fb :FzfBuffers<CR>
nnoremap <leader>h :FzfHistory<CR>
nnoremap <leader>fs :FzfRg<CR>
nnoremap <leader>fg :FzfGFiles?<CR>
nnoremap <leader>fG :FzfGFiles<CR>
" comments
nmap <leader>c <Plug>CommentaryLine
vmap <leader>c <Plug>Commentary
" undotree
nnoremap <leader> u :UndotreeToggle<cr>
